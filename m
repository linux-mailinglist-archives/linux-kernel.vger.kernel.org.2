Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EA63D7514
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 14:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhG0Mbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 08:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhG0MbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:31:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCCFB61989;
        Tue, 27 Jul 2021 12:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627389073;
        bh=y58pUwdVQz/ZqFSprbKApGIjx53BBO+DN/1lqAEsvtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzldbQU97C1vKxSLIa1feDwa+Y+EQE0S2TIuC+hW+d80QuF0NcOx0Wc/OtEQcAnOa
         Mz3JoWg2V6uUxZQWMnKDMeULaWtlUC3qxJVKH5qRvi8JIUS+GZVqdF0E81sG3ehTt7
         BagQEiIbObnqITbKC9ScBOpFQs1ST8w6tVpFgQTU=
Date:   Tue, 27 Jul 2021 14:31:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Filip Schauer <filip@mg6.at>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers core: Fix oops when driver probe fails
Message-ID: <YP/8jqfW4+HHUL+X@kroah.com>
References: <20210727112311.GA7645@DESKTOP-E8BN1B0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727112311.GA7645@DESKTOP-E8BN1B0.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 01:23:11PM +0200, Filip Schauer wrote:
> dma_range_map is freed to early, which might cause an oops when
> a driver probe fails.
>  Call trace:
>   is_free_buddy_page+0xe4/0x1d4
>   __free_pages+0x2c/0x88
>   dma_free_contiguous+0x64/0x80
>   dma_direct_free+0x38/0xb4
>   dma_free_attrs+0x88/0xa0
>   dmam_release+0x28/0x34
>   release_nodes+0x78/0x8c
>   devres_release_all+0xa8/0x110
>   really_probe+0x118/0x2d0
>   __driver_probe_device+0xc8/0xe0
>   driver_probe_device+0x54/0xec
>   __driver_attach+0xe0/0xf0
>   bus_for_each_dev+0x7c/0xc8
>   driver_attach+0x30/0x3c
>   bus_add_driver+0x17c/0x1c4
>   driver_register+0xc0/0xf8
>   __platform_driver_register+0x34/0x40
>   ...
> 
> This issue is introduced by commit d0243bbd5dd3 ("drivers core:
> Free dma_range_map when driver probe failed"). It frees
> dma_range_map before the call to devres_release_all, which is too
> early. The solution is to free dma_range_map only after
> devres_release_all.
> 
> Fixes: d0243bbd5dd3 ("drivers core: Free dma_range_map when driver probe failed")
> Signed-off-by: Filip Schauer <filip@mg6.at>
> ---
>  drivers/base/dd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Oh, nice catch!  This is a v2, right?  Next time please be explicit :)

thanks,

greg k-h
