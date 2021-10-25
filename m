Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDF8438F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhJYGfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhJYGfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:35:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCF6460EE3;
        Mon, 25 Oct 2021 06:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635143612;
        bh=ka9tOWHk8CyVaySt26h5prsTz0KJokyT7FnqKCGkgwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RCwgJ0IowLgsPGF7Rvw2Bycuz9T/I6uILDTzj0Ay8ripbt7SmbE8I0kcqkM7mcnKd
         InkBbhzmPVF2FC8KhwAZEV3H6CaosWNAvHVw/ep7JM6h09Bws1oWJ8KCA7u2a4qRRD
         MNyNPefojm6t+VrHw0HRuXVu9TH6y/l1TDkluHSoLQ7yOGLzy8mCWlfR63YBCJ74vQ
         gkbAZBwFy18fLB8NfYeR5c6omRL1z/wpPk37oYDhisE2f/dTWbbtOjekcCxr/WexnN
         lgywSiV2JMN/whiL45RHaQvFLZQWSK3TokFTe2sB68lbjBER8Ncse8szoKBr5JJ3XD
         6cGA1GlHFnjrQ==
Date:   Mon, 25 Oct 2021 15:33:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, corbet@lwn.net, ananth@in.ibm.com,
        akpm@linux-foundation.org, randy.dunlap@oracle.com,
        mathieu.desnoyers@polymtl.ca, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] test_kprobes: Move it from kernel/ to lib/
Message-Id: <20211025153328.daad69af917db6647dcd8b9b@kernel.org>
In-Reply-To: <1635132660-5038-4-git-send-email-yangtiezhu@loongson.cn>
References: <1635132660-5038-1-git-send-email-yangtiezhu@loongson.cn>
        <1635132660-5038-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 11:30:59 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> Since config KPROBES_SANITY_TEST is in lib/Kconfig.debug, it is better to
> let test_kprobes.c in lib/, just like other similar tests found in lib/.

This is also good to me. It may be a good timing to move this under the
lib/ because there is KUnit too.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  kernel/Makefile                | 1 -
>  lib/Makefile                   | 1 +
>  {kernel => lib}/test_kprobes.c | 0
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename {kernel => lib}/test_kprobes.c (100%)
> 
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 4df609b..9e4d33d 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -85,7 +85,6 @@ obj-$(CONFIG_PID_NS) += pid_namespace.o
>  obj-$(CONFIG_IKCONFIG) += configs.o
>  obj-$(CONFIG_IKHEADERS) += kheaders.o
>  obj-$(CONFIG_SMP) += stop_machine.o
> -obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
>  obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
>  obj-$(CONFIG_AUDITSYSCALL) += auditsc.o audit_watch.o audit_fsnotify.o audit_tree.o
>  obj-$(CONFIG_GCOV_KERNEL) += gcov/
> diff --git a/lib/Makefile b/lib/Makefile
> index 2cfd339..2c70452 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
>  obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
>  obj-$(CONFIG_TEST_HMM) += test_hmm.o
>  obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
> +obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
>  
>  #
>  # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
> diff --git a/kernel/test_kprobes.c b/lib/test_kprobes.c
> similarity index 100%
> rename from kernel/test_kprobes.c
> rename to lib/test_kprobes.c
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
