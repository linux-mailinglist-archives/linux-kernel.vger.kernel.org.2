Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F3C34814A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbhCXTL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:32888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237738AbhCXTLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:11:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D565361A17;
        Wed, 24 Mar 2021 19:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616613094;
        bh=dgMYdzjGstqyJTgn4iNkiVn6WwtSS/vzrce0N9MVCIA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=s+1KonQi/HxRdY9BH380c5qSw+4yfBNi00WS9WVl7W7UiS7MOoOTSs8RGFPY1u+1L
         CX+JKmVGywbw/xrL21gfKU5DxdEA1TBXH8XEs/1GixAIegYlu4zjKerqesGyCkqv08
         7L+hbVE8fh2M0bqqKPStJLIvUjyGVRl1rXVvDL4g6mChkVMZjjd/6GqLd9UZR9om+v
         T7pcMgDj4BZq32cBvO202aLGa4UXzHstcauJdcX0t2BHQv5dtUf3giZpsszunKbwDS
         9KO9UMlhfjhI/0boT2b5qzgdFOXibilxQXnAGYuWcO/e5SE/oUEeiZOucOXqGO+YmP
         hcFq52bXLQ8qg==
Date:   Wed, 24 Mar 2021 12:11:33 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux@armlinux.org.uk, xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH] ARM: xen/mm.c: A mundane typo fix
In-Reply-To: <5e1b573a-6dc7-7f28-28ae-c509e6782fbf@infradead.org>
Message-ID: <alpine.DEB.2.21.2103241203140.439@sstabellini-ThinkPad-T480s>
References: <20210324133036.17665-1-unixbhaskar@gmail.com> <alpine.DEB.2.21.2103241154320.439@sstabellini-ThinkPad-T480s> <5e1b573a-6dc7-7f28-28ae-c509e6782fbf@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Randy Dunlap wrote:
> On 3/24/21 11:55 AM, Stefano Stabellini wrote:
> > On Wed, 24 Mar 2021, Bhaskar Chowdhury wrote:
> >> s/acrros/across/
> >>
> >> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> > 
> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> > 
> > 
> 
> Hi,
> It seems to me like some of those "page" should be "pages".

Yes, good point actually


> >> ---
> >>  arch/arm/xen/mm.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> >> index 467fa225c3d0..be7c942c74bf 100644
> >> --- a/arch/arm/xen/mm.c
> >> +++ b/arch/arm/xen/mm.c
> >> @@ -105,7 +105,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
> >>  	 *	- The Linux page refers to foreign memory
> >>  	 *	- The device doesn't support coherent DMA request
> >>  	 *
> >> -	 * The Linux page may be spanned acrros multiple Xen page, although>> +	 * The Linux page may be spanned across multiple Xen page, although
> 
> 	                                                     pages,
> 
> >>  	 * it's not possible to have a mix of local and foreign Xen page.
> 
> 	                                                            pages.

yes to both


> >>  	 * Furthermore, range_straddles_page_boundary is already checking
> >>  	 * if buffer is physically contiguous in the host RAM.
> >> --
> 
> 
> -- 
> ~Randy
> 
