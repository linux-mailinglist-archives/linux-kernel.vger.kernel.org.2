Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0872A458318
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 12:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbhKUL1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 06:27:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232729AbhKUL1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 06:27:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 928FB60E54;
        Sun, 21 Nov 2021 11:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637493872;
        bh=/u5GyBLZHocuj1Q9VEuGHkh2L3MrHSF+jdj5cFjvs9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=PC1hhrZoAlUkoS8qh/j/B1kG2kZ0mrh1DJhSxiEb+tOpOb4dPCM65zF/nsyV4FDji
         gDU+hABIKFT8b2BI10XbJaPPhZeREg8ug7pJmRtPkzAeBxM96DR1UKn/Lic6sxCx0f
         MNtdxEOl1cHuDchgAGYLcILW0lTprGxTLy3tPuvjWfzM0UDcfJTfGT8mVOneaEb5Wj
         e9mgWKAO9ME0QY2HWJEOa46NEcJKfE+A6eH2x3VdVsOrFVzfyDTT1z0FFfuIKoLD83
         LsWNjVG90QnR3dB9uXunsAkDLbccEr6rPLoN8S6HWO51JvYvJTB6cuuHnoCtIjQ47v
         njrT2LBeOlf1A==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 1/2] mm/damon/dbgfs: Modify Damon dbfs interface dependency in Kconfig
Date:   Sun, 21 Nov 2021 11:24:17 +0000
Message-Id: <20211121112417.33255-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <fbf27c39e8f23d12d5474b9b659d3d45f8dd38ca.1637429074.git.xhao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Sun, 21 Nov 2021 01:27:53 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> If you want to support "DAMON_DBGFS" in config file, it only depends on
> any one of "DAMON_VADDR" and "DAMON_PADDR".

This is not true.  DAMON_DBGFS really depends on both.

This patch even makes the build fails with some configs.

      CC      mm/damon/dbgfs.o
    linux/mm/damon/dbgfs.c: In function ‘dbgfs_target_ids_write’:
    linux/mm/damon/dbgfs.c:409:3: error: implicit declaration of function ‘damon_pa_set_primitives’; did you mean ‘damon_va_set_primitives’? [-Werror=implicit-function-declaration]
       damon_pa_set_primitives(ctx);
       ^~~~~~~~~~~~~~~~~~~~~~~
       damon_va_set_primitives
    cc1: some warnings being treated as errors


Thanks,
SJ

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/damon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index 5bcf05851ad0..971ffc496596 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -54,7 +54,7 @@ config DAMON_VADDR_KUNIT_TEST
>  
>  config DAMON_DBGFS
>  	bool "DAMON debugfs interface"
> -	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
> +	depends on DAMON_VADDR || DAMON_PADDR && DEBUG_FS
>  	help
>  	  This builds the debugfs interface for DAMON.  The user space admins
>  	  can use the interface for arbitrary data access monitoring.
> -- 
> 2.31.0
> 
> 
