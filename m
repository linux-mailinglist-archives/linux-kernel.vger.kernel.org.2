Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0415A3D21D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhGVJaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:30:03 -0400
Received: from foss.arm.com ([217.140.110.172]:49630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231573AbhGVJ34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:29:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56BBC106F;
        Thu, 22 Jul 2021 03:10:31 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DF3C3F73D;
        Thu, 22 Jul 2021 03:10:30 -0700 (PDT)
Subject: Re: [PATCH] dma-debug: fix debugfs initialization order
To:     Anthony Iliopoulos <ailiop@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210722091818.13434-1-ailiop@suse.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1ea36b32-9bbc-a611-402d-9fa196eda166@arm.com>
Date:   Thu, 22 Jul 2021 11:10:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722091818.13434-1-ailiop@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-22 10:18, Anthony Iliopoulos wrote:
> Due to link order, dma_debug_init is called before debugfs has a chance
> to initialize (via debugfs_init which also happens in the core initcall
> stage), so the directories for dma-debug are never created.
> 
> Move the dma_debug_init initcall from core to postcore stage so that
> debugfs will already be initialized by the time this is called, making
> it oblivious to link-ordering.

Playing initcall chicken here doesn't work so well - the later you 
initialise dma-debug itself, the more chance it has to miss early 
mappings and raise false positives later. As discussed previously[1] the 
better solution would be to decouple the debugfs setup so that just that 
part can be deferred until core_initcall_sync or later.

Robin.

[1] https://lore.kernel.org/linux-iommu/YIgGa6yF%2Fadg8OSN@kroah.com/

> Fixes: 15b28bbcd567 ("dma-debug: move initialization to common code")
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>   kernel/dma/debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 14de1271463f..49d80ef7f995 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -915,7 +915,7 @@ static int dma_debug_init(void)
>   	pr_info("debugging enabled by kernel config\n");
>   	return 0;
>   }
> -core_initcall(dma_debug_init);
> +postcore_initcall(dma_debug_init);
>   
>   static __init int dma_debug_cmdline(char *str)
>   {
> 
