Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7785B33CA5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 01:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhCPAeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 20:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhCPAeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 20:34:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25B3564EE2;
        Tue, 16 Mar 2021 00:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615854842;
        bh=DwO2abTrTPCBV+RWz5NIUo7YvPd35VK+3GPjS72Pk2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGGl+0vdncBll66DBxDxVWfhi8VZEKl2Hsx6U1GEcS/g+imWRE8u5iSCvACHvy8K3
         +y4W/0cBVg8kM4IBqSvqtDYwTpwT9hMeFvWxRdod8HA0MwV93WoMWIDTeKlu5uc6jC
         IpyqIwqfQT67QKOIe+Kb4bHcKYnI2WU1Y5yUWDMXazEBd2ctHQiNnjoSB5vxEg4ucU
         13ece8s49dFXct+CynmfjXr/xJwCc1lrDzIzAsXMLNn9jeCcNGFJIFIjYY0nS7Gwya
         a+4AoIPMv/GSTQ+4UwYMbaLqR5dF4ytYnIe4jVMbpIq/g1/SFC0FIBDXF1U/RJjwZ7
         RN+U+EsMNNarg==
Date:   Tue, 16 Mar 2021 08:33:57 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Sanket Parmar <sparmar@cadence.com>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kishon@ti.com" <kishon@ti.com>
Subject: Re: [PATCH 2/2] usb: cdns3: Optimize DMA request buffer allocation
Message-ID: <20210316003357.GC15335@b29397-desktop>
References: <1615267180-9289-1-git-send-email-sparmar@cadence.com>
 <1615267180-9289-2-git-send-email-sparmar@cadence.com>
 <20210314051048.GA30122@b29397-desktop>
 <BY5PR07MB81194FB5A32CE9D6B793FF30B06C9@BY5PR07MB8119.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR07MB81194FB5A32CE9D6B793FF30B06C9@BY5PR07MB8119.namprd07.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-15 15:51:04, Sanket Parmar wrote:
> > > +
> > >  	priv_req->flags |= REQUEST_UNALIGNED;
> > >  	trace_cdns3_prepare_aligned_request(priv_req);
> > >
> > > @@ -3088,11 +3113,11 @@ static void cdns3_gadget_exit(struct cdns
> > *cdns)
> > >  		struct cdns3_aligned_buf *buf;
> > >
> > >  		buf = cdns3_next_align_buf(&priv_dev->aligned_buf_list);
> > > -		dma_free_coherent(priv_dev->sysdev, buf->size,
> > > -				  buf->buf,
> > > -				  buf->dma);
> > > +		dma_unmap_single(priv_dev->sysdev, buf->dma, buf->size,
> > > +			buf->dir);
> > 
> > It only needs to DMA unmap after DMA has completed, this buf will not be
> > used, otherwise, the kfree below will cause issue.
> 
> This part is not clear.  Aligned DMA buffer is allocated and mapped in cdns3_prepare_aligned_request_buf()
> and put into aligned_buf_list. While unloading the gadget, We need to undo the same if aligned_buf_list is not
> empty.  Am I missing something here? 

My point is this unmap operation is useless since there is no user for
aligned buf, and it calls kfree afterwards. You could also keep it as it has
no harm.

> 
> Also, I will post v2 of this patch which uses dma_*_noncoherent APIs suggested by Christoph Hellwig.

-- 

Thanks,
Peter Chen

