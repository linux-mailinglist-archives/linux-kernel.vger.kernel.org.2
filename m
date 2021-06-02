Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CE7399322
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFBTG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhFBTGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:06:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 686B5613DE;
        Wed,  2 Jun 2021 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622660672;
        bh=1s3WT318ictohTUfF3d1I01V0SMUDcGKZwBUXHKF/10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZsRKlKjKj+I3Q9YlsSS7TDXstEsiTy3tFrF3u6OjsI8sJ8AePvy6/Rmbqn7RfL8k
         3CIQFqawgLsG6Z1hEdfa6q+dl1gNzAGske28SJ1k/3dBsYB8aILEaRdHKddSEWrt+Z
         4+5KADomuVXD6zqGLSSN6AlCvrzhrQiBHSuC1OmRILo+DWlmJ1hiCApvLBxZYAZJgr
         qN3Tfbp4eurKSjZY9boWcs3s1RNlT1Fea83f7M4Aselsq4HKqK9NbdpG8s+dP+GJfg
         kFToWhmSgg+HwkFokj547vfXkaE5gnRDQOa5Xa3O+lA7inBqjODgEL12TzXrdm/kqt
         bsSOlxHaeWm0A==
Date:   Wed, 2 Jun 2021 22:04:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     ysato@users.sourceforge.jp, akpm@linux-foundation.org,
        sboyd@kernel.org, geert+renesas@glider.be,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] h8300: Remove unused variable
Message-ID: <YLfWONfYC0Fw2mdL@kernel.org>
References: <20210602185431.11416-1-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602185431.11416-1-jrdr.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 12:24:31AM +0530, Souptick Joarder wrote:
> Kernel test robot throws below warning ->
> 
> >> arch/h8300/kernel/setup.c:72:26:
> warning: Unused variable: region [unusedVariable]
>     struct memblock_region *region;
> 
> Fixed it by removing unused variable.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

I believe a Fixes: tag would be appropriate here. Otherwise

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/h8300/kernel/setup.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
> index 15280af7251c..5745a763dc78 100644
> --- a/arch/h8300/kernel/setup.c
> +++ b/arch/h8300/kernel/setup.c
> @@ -69,8 +69,6 @@ void __init h8300_fdt_init(void *fdt, char *bootargs)
>  
>  static void __init bootmem_init(void)
>  {
> -	struct memblock_region *region;
> -
>  	memory_end = memory_start = 0;
>  
>  	/* Find main memory where is the kernel */
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
