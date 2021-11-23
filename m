Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E70B45A062
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 11:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbhKWKmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 05:42:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235457AbhKWKmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 05:42:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1A1A60D42;
        Tue, 23 Nov 2021 10:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637663938;
        bh=wk2+IHntLAQcT6mXlShFzjxw4puPHTIChj9Pge9DG3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=Htaz9y5pb5XN7WUjonIFoaDL+IVJQSQvqJNfN6mTBCjeyISE7Bg1DAIBFEPdgUTyf
         hev9/e+E9MMLUnUZw6aKeh0MUbpV8HICNubS8tPW/Q7BOBx2Fc+hW9LI5x9nwE52Qo
         B09D3Lqh+6v+Bdl55llreGDOTJ1eqWhykSg8o5/x73Gk/wyfdtty7OexzZeyAVI+S0
         QGoRzPSP71oi/cXSYeLncALzX+rCFXbAwGwaGx0zrQTuMhgz2FiWx//pF6vMqzdssa
         Hjq0WpuOzn2CmB3xMFSy1l3GlM4zmqhLS55VTvShbW2XrSCG1TEW8af4D5LkRzu+/J
         0zBSNzZ9TRWMg==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] mm/damon/dbgfs: Modify Damon dbfs interface dependency in Kconfig
Date:   Tue, 23 Nov 2021 10:38:55 +0000
Message-Id: <20211123103855.12592-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <39a61385187fbc293dcf0e32f20137148ca97db6.1637503141.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021 22:07:04 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> If you want to support "DAMON_DBGFS" in config file, it only depends on
> any one of "DAMON_VADDR" and "DAMON_PADDR", and sometimes we just want to
> use damon virtual address function, but it is unreasonable to include "DAMON_PADDR"
> in config file which cause the damon/paddr.c be compiled, so there fix it.

Seems the above lines are not well wrapped[1].

[1] https://docs.kernel.org/process/submitting-patches.html?highlight=75#the-canonical-patch-format

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  include/linux/damon.h | 12 ++++++++++++
>  mm/damon/Kconfig      |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 8a73e825e0d5..00ad96f2ec10 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -463,11 +463,23 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
>  #ifdef CONFIG_DAMON_VADDR
>  void damon_va_set_primitives(struct damon_ctx *ctx);
>  bool damon_va_target_valid(void *t);
> +#else
> +static inline void damon_va_set_primitives(struct damon_ctx *ctx) {}
> +static inline bool damon_va_target_valid(void *t)
> +{
> +	return false;
> +}
>  #endif	/* CONFIG_DAMON_VADDR */
>  
>  #ifdef CONFIG_DAMON_PADDR
>  void damon_pa_set_primitives(struct damon_ctx *ctx);
>  bool damon_pa_target_valid(void *t);
> +#else
> +static inline void damon_pa_set_primitives(struct damon_ctx *ctx) {}
> +static inline bool damon_pa_target_valid(void *t)
> +{
> +	return false;
> +}
>  #endif	/* CONFIG_DAMON_PADDR */
>  
>  #endif	/* _DAMON_H */
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

Due to the lack of parentheses, this allows enabling DAMON_DBGFS while DEBUG_FS
is disabled.

Sorry to say this but this makes me unsure if this patch is sufficiently
tested.  I am also unsure if this patch is carefully handling all possible
corner cases in appropriate ways.  For example, on kernels that doesn't having
'CONFIG_DAMON_PADDR=y', this patch would still make
'echo paddr > $debugfs/damon/target_ids' success.  Is that what you are
intending?  And, have you confirmed that will never make any issue, both in
kernel space and the user space?  Could the behavioral change make the user
space confused?

Basically, reducing the dependency is a good idea.  But, IMHO, the benefit
seems not so big.  After all, efficiency was not a first goal of DAMON debugfs
interface.  That's why it is implemented on debugfs rather than its own
specialized/optimized file system.  Better way for the efficiency of the user
space interface might be inventing such DAMON's own efficient file system, like
tracepoints had its interface on debugfs but now uses its own file system,
tracefs.

So, unless you make me believe the benefit is big enough and all possible
corner cases are well handled and sufficiently tested, I'm sorry but I would
not be convinced with this change.


Thanks,
SJ

>  	help
>  	  This builds the debugfs interface for DAMON.  The user space admins
>  	  can use the interface for arbitrary data access monitoring.
> -- 
> 2.31.0
