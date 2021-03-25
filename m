Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9D34954E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhCYPW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhCYPW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:22:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C43FF61A17;
        Thu, 25 Mar 2021 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616685746;
        bh=gI+ya7eVajNSjdsRxoTQswbctEeD7muAW0SsciqCFJw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BjDbHAnf+ZH6ofUCPJ9exF0jNcwKBBBHrHIQAPvF5kdPgoXNKHzjj7wrTfu3L+wP9
         RILZe3PiWcCap8Nx2I+0ogCf+E7C/cwTNMmBhbfGqFU6Z0He3KEJw02uyzZhtuhZs+
         AED9Ik1gEedkxmoXnDM9ketYwyumb3VSit0LDwQHgR0nWvQW5vS5PfsBGYcRb95iuG
         Q5oOgcAXWmSEk+kdKw3vbZQzS/dR5VA/FGW/BwcUQ/o9GYALBRJ+gVU+YRyKjj78ay
         k8zuhwDAPTmLWMUnShljMBiOLmaogVXiXrENdu/Rljmahm9uGbKD+4E3PyrFg50YB7
         M2jfsmbkbU5lQ==
Date:   Thu, 25 Mar 2021 08:22:25 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, sstabellini@kernel.org,
        linux@armlinux.org.uk, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ARM: xen/mm.c: A mundane typo fix
In-Reply-To: <e3980acb-e6d7-645a-3be0-79cea6f2fd8e@infradead.org>
Message-ID: <alpine.DEB.2.21.2103250822120.439@sstabellini-ThinkPad-T480s>
References: <20210325043526.16289-1-unixbhaskar@gmail.com> <e3980acb-e6d7-645a-3be0-79cea6f2fd8e@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Randy Dunlap wrote:
> On 3/24/21 9:35 PM, Bhaskar Chowdhury wrote:
> > s/acrros/across/
> > 
> > Plus some words need prural version...so did it.(page->pages)
> > 
> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> > ---
> >  Changes from V1:
> >   Randy's findings incorporated.
> > 
> >  arch/arm/xen/mm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> > index 467fa225c3d0..8596dd32dcd5 100644
> > --- a/arch/arm/xen/mm.c
> > +++ b/arch/arm/xen/mm.c
> > @@ -105,8 +105,8 @@ bool xen_arch_need_swiotlb(struct device *dev,
> >  	 *	- The Linux page refers to foreign memory
> >  	 *	- The device doesn't support coherent DMA request
> >  	 *
> > -	 * The Linux page may be spanned acrros multiple Xen page, although
> > -	 * it's not possible to have a mix of local and foreign Xen page.
> > +	 * The Linux page may be spanned across multiple Xen pages, although
> > +	 * it's not possible to have a mix of local and foreign Xen pages.
> >  	 * Furthermore, range_straddles_page_boundary is already checking
> >  	 * if buffer is physically contiguous in the host RAM.
> >  	 *
> > --
> 
> 
> -- 
> ~Randy
> 
