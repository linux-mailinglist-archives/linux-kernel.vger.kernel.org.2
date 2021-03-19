Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E071A3423D1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhCSR4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhCSR4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:56:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0608661985;
        Fri, 19 Mar 2021 17:56:21 +0000 (UTC)
Date:   Fri, 19 Mar 2021 17:56:19 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "chenjun (AM)" <chenjun102@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        "weiyongjun (A)" <weiyongjun1@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH] Kconfig: Move CONFIG_DEBUG_KMEMLEAK_TEST to
 samples/Kconfig
Message-ID: <20210319175619.GF6832@arm.com>
References: <20201022021234.6638-1-chenjun102@huawei.com>
 <e3e03188672c48dfb187e6683ea63308@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3e03188672c48dfb187e6683ea63308@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 02:51:07PM +0000, chenjun (AM) wrote:
> From: Chen Jun <chenjun102@huawei.com>
> 
> commit 1abbef4f51724fb11f09adf0e75275f7cb422a8a
> ("mm,kmemleak-test.c: move kmemleak-test.c to samples dir")
> make CONFIG_DEBUG_KMEMLEAK_TEST depend on CONFIG_SAMPLES implicitly.
> And the dependency cannot be guaranteed by Kconfig.
> 
> move the definition of CONFIG_DEBUG_KMEMLEAK_TEST from lib/Kconfig.debug
> to samples/Kconfig.
> 
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Cc'ing Andrew, I don't think he's seen the patch.

>   lib/Kconfig.debug | 8 --------
>   samples/Kconfig   | 8 ++++++++
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 66d44d3..debacdc 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -678,14 +678,6 @@ config DEBUG_KMEMLEAK_MEM_POOL_SIZE
>   	  fully initialised, this memory pool acts as an emergency one
>   	  if slab allocations fail.
> 
> -config DEBUG_KMEMLEAK_TEST
> -	tristate "Simple test for the kernel memory leak detector"
> -	depends on DEBUG_KMEMLEAK && m
> -	help
> -	  This option enables a module that explicitly leaks memory.
> -
> -	  If unsure, say N.
> -
>   config DEBUG_KMEMLEAK_DEFAULT_OFF
>   	bool "Default kmemleak to off"
>   	depends on DEBUG_KMEMLEAK
> diff --git a/samples/Kconfig b/samples/Kconfig
> index 0ed6e4d..15978dd 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -216,4 +216,12 @@ config SAMPLE_WATCH_QUEUE
>   	  Build example userspace program to use the new mount_notify(),
>   	  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.
> 
> +config DEBUG_KMEMLEAK_TEST
> +	tristate "Simple test for the kernel memory leak detector"
> +	depends on DEBUG_KMEMLEAK && m
> +	help
> +	  This option enables a module that explicitly leaks memory.
> +
> +	  If unsure, say N.
> +
>   endif # SAMPLES
> -- 
> 2.7.4
