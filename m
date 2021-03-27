Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDF834B36F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 01:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhC0A4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 20:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231202AbhC0Azq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 20:55:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B456619F2;
        Sat, 27 Mar 2021 00:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616806545;
        bh=lo6lYnIDJUd1GsaAadMr5D9x6+TV2fWoKmvUvRWPbJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSakcLdgmxrQZHQqKWvJPxVUYENmn35UzQeR7TWvz/K0QsZZjYjihRYuqObd1F8ob
         vLj12q7PKS+blkO2ftwgIu+UKVRBY+36dtZy78vMMHmqvikCQ3j6uww+kKaH5p4j1l
         syHNppSel7HEKJ7YVr4yd0QAtetkcNNFFUfS/ZQRrGpxfXytnbko/GEc1nwhaBhAbo
         K38NNLLEAU6daudPx/KvIxVF6FaLtRPCpMX+bZ234eg8ktoqiDt/azigoRQuo5SL+w
         x94YEPTAKz7YoVwjJ5ieGdRCqrXzcKz5emaQkC+E3aFj6sw0P8EoVnd07bsO3C2LdO
         ZlQNrLHNdNiVw==
Date:   Sat, 27 Mar 2021 08:55:39 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     Wang Qing <wangqing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdns3: delete repeated clear operations
Message-ID: <20210327005539.GC28870@b29397-desktop>
References: <1615603303-14518-1-git-send-email-wangqing@vivo.com>
 <BYAPR07MB5381E439E54E87C91086BA07DD659@BYAPR07MB5381.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB5381E439E54E87C91086BA07DD659@BYAPR07MB5381.namprd07.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-22 07:19:46, Pawel Laszczak wrote:
> Hi Peter,
> 
> Can you add this patch to for-usb-next branch.
> 

Feel free add your ACK base on this patch.

Peter
> Thanks.
> 
> >
> >
> >dma_alloc_coherent already zeroes out memory, so memset is not needed.
> >
> >Signed-off-by: Wang Qing <wangqing@vivo.com>
> 
> Reviewed-by: Pawel Laszczak <pawell@cadence.com>
> 
> >---
> > drivers/usb/cdns3/cdnsp-mem.c | 1 -
> > 1 file changed, 1 deletion(-)
> >
> >diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
> >index 7a84e92..1d1b9a4
> >--- a/drivers/usb/cdns3/cdnsp-mem.c
> >+++ b/drivers/usb/cdns3/cdnsp-mem.c
> >@@ -1231,7 +1231,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
> > 	if (!pdev->dcbaa)
> > 		return -ENOMEM;
> >
> >-	memset(pdev->dcbaa, 0, sizeof(*pdev->dcbaa));
> > 	pdev->dcbaa->dma = dma;
> >
> > 	cdnsp_write_64(dma, &pdev->op_regs->dcbaa_ptr);
> >--
> >2.7.4
> 
> Regards,
> Pawel Laszczak

-- 

Thanks,
Peter Chen

