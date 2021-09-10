Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57FB4073D6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhIJX0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233561AbhIJX0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:26:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFE1D61167;
        Fri, 10 Sep 2021 23:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631316291;
        bh=EH4b4wOqgmR5fMb5cwT0NEac+L5t0raAiWP84suO8JA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=smsy9tlu9CPSDn4fKjl46u3jjfq2R3njFi5e6jxWnldXvJHvGzQuMXnKBS5huhkpu
         UH0VszBrYKYtR7yu7SoXbE03cDE9F2V8w96d535j2SuQBcWf+r5Jy3JubwD53wYzh7
         YZyBepcZw2vZH+dRSiTXJDf7UKR4l3IpTt8R9MOwWQlAPVkfb+tSEe9+v+bceD06qx
         M63ZxeL+/06x2IfWAJXY5tYhUtpERojIx+a5wncFAAkDjMFUZY5XrzJtbrtecUwPrH
         0LbIow+aLPOKBEZ+gHjKyAbQGzjor6Pmm7diWflLvgc6aDn6EoCCtPAGtOzVMBoZ51
         68yjfbrauu0/w==
Date:   Fri, 10 Sep 2021 16:24:50 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jan Beulich <jbeulich@suse.com>
cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 07/12] swiotlb-xen: drop leftover __ref
In-Reply-To: <7cd163e1-fe13-270b-384c-2708e8273d34@suse.com>
Message-ID: <alpine.DEB.2.21.2109101624431.10523@sstabellini-ThinkPad-T480s>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com> <7cd163e1-fe13-270b-384c-2708e8273d34@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021, Jan Beulich wrote:
> Commit a98f565462f0 ("xen-swiotlb: split xen_swiotlb_init") should not
> only have added __init to the split off function, but also should have
> dropped __ref from the one left.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -154,7 +154,7 @@ static const char *xen_swiotlb_error(enu
>  
>  #define DEFAULT_NSLABS		ALIGN(SZ_64M >> IO_TLB_SHIFT, IO_TLB_SEGSIZE)
>  
> -int __ref xen_swiotlb_init(void)
> +int xen_swiotlb_init(void)
>  {
>  	enum xen_swiotlb_err m_ret = XEN_SWIOTLB_UNKNOWN;
>  	unsigned long bytes = swiotlb_size_or_default();
> 
