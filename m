Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B154037ED56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386404AbhELUVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1384103AbhELT4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 15:56:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB53C613F7;
        Wed, 12 May 2021 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620849342;
        bh=262+PIF/9A36VsCFqlkhq//BsN04UF0+U0v6HG31+Wo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=WEB3NSzIGZ1hY7qqH6Z9As3Y5wCiVwfxNKRRS/2CC0NbdHbt5Qgc02KzG15EMIxHx
         GRryYhagx0GqTVe35P4CWN/aFNbhJOcLv5Yxgs2TB4g/MMgelXLUXiw+5EwqeavSN6
         C1MpfPrTlXnYi4xDQtTxE+kO+JPXyDOjavVr6Sg8yNi5a8lr3RJSaOFMbgZLr1uxD2
         G3ZV5addJoy64YD+onajVSGgt0Xgg+EFe5W32nhaFq/UBHEuA3pK5v5HIMfnLvPbVR
         /a6LBUXd2mPFZKaLUDxuzPCWaR4pV3xtWBWh3N7EiyErgBxFKvaliGdztPXF4OazjN
         eMMkMG3PUlnMw==
Date:   Wed, 12 May 2021 12:55:40 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] xen/arm64: do not set SWIOTLB_NO_FORCE when swiotlb
 is required
In-Reply-To: <20210512072645.GA22396@lst.de>
Message-ID: <alpine.DEB.2.21.2105121255290.5018@sstabellini-ThinkPad-T480s>
References: <20210511174142.12742-1-sstabellini@kernel.org> <20210512072645.GA22396@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021, Christoph Hellwig wrote:
> > -int xen_swiotlb_detect(void)
> > -{
> > -	if (!xen_domain())
> > -		return 0;
> > -	if (xen_feature(XENFEAT_direct_mapped))
> > -		return 1;
> > -	/* legacy case */
> > -	if (!xen_feature(XENFEAT_not_direct_mapped) && xen_initial_domain())
> > -		return 1;
> > -	return 0;
> > -}
> 
> I think this move should be a separate prep patch.

Sure, I can do that
