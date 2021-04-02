Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA4A352473
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbhDBA1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233677AbhDBA1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:27:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77E6761132;
        Fri,  2 Apr 2021 00:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617323235;
        bh=/Exqmsj4fbDXgH8gSPGLMJ8j4wuc+/oIkvYQ004EMXo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HQAWp0D1E2Kq+vHg51vvMsqRvT69fv2eapjK+P54tNoh23W9F4eMrRHZ3/ugCEKkR
         OzWIoaxHzUUWV6EvXzV5nD9yGN1dfIbvEnQqk/2TbDQOJH5t8+C+yGYYoPxxRdI4sy
         /SHTmek8WdU6Ihc3k2GIYlL7CsJiaGUZUi6VNEus=
Date:   Thu, 1 Apr 2021 17:27:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, kael_w@yeah.net,
        Masahiro Yamada <masahiroy@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>
Subject: Re: [PATCH] scripts: A new script for checking duplicate struct
 declaration
Message-Id: <20210401172714.1bccb8623fbcbd02bba21bac@linux-foundation.org>
In-Reply-To: <20210401110943.1010796-1-wanjiabing@vivo.com>
References: <20210401110943.1010796-1-wanjiabing@vivo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 19:09:43 +0800 Wan Jiabing <wanjiabing@vivo.com> wrote:

> checkdeclares: find struct declared more than once.
> Inspired by checkincludes.pl.
> This script checks for duplicate struct declares.
> Note that this will not take into consideration macros, so
> you should run this only if you know you do have real dups
> and do not have them under #ifdef's.
> You could also just review the results.

include/linux/bpf-cgroup.h: struct bpf_prog is declared more than once.
include/linux/bpf.h: struct xdp_buff is declared more than once.
include/linux/bpf.h: struct sk_buff is declared more than once.
include/linux/bpf.h: struct btf_type is declared more than once.
include/linux/debug_locks.h: struct task_struct is declared more than once.
include/linux/fs.h: struct iov_iter is declared more than once.
include/linux/fs.h: struct files_struct is declared more than once.
include/linux/gpio.h: struct device is declared more than once.
include/linux/host1x.h: struct host1x is declared more than once.
include/linux/intel_rapl.h: struct rapl_package is declared more than once.
include/linux/libnvdimm.h: struct device is declared more than once.
include/linux/lightnvm.h: struct nvm_rq is declared more than once.
include/linux/memcontrol.h: struct mem_cgroup is declared more than once.
include/linux/mount.h: struct path is declared more than once.
include/linux/mutex.h: struct ww_acquire_ctx is declared more than once.
include/linux/netfilter.h: struct flowi is declared more than once.
include/linux/netfilter.h: struct nf_conntrack_tuple is declared more than once.
include/linux/netfilter.h: struct nlattr is declared more than once.
include/linux/netfilter.h: struct nf_conn is declared more than once.
include/linux/profile.h: struct pt_regs is declared more than once.
include/linux/trace_events.h: struct trace_array is declared more than once.

Sigh.  I keep telling them - "put the forward declaration at
top-of-file so it doesn't get duplicated later on".  Nobody listens to
Andrew.

> --- /dev/null
> +++ b/scripts/checkdeclares.pl
> @@ -0,0 +1,53 @@
> +#!/usr/bin/env perl
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# checkdeclares: find struct declared more than once
> +#
> +# Copyright 2021 Wan Jiabing<wanjiabing@vivo.com>
> +# Inspired by checkincludes.pl
> +#
> +# This script checks for duplicate struct declares.
> +# Note that this will not take into consideration macros so
> +# you should run this only if you know you do have real dups
> +# and do not have them under #ifdef's.
> +# You could also just review the results.
> +
> +use strict;
> +
> +sub usage {
> +	print "Usage: checkdeclares.pl \n";
> +	print "We just warn of struct declaration duplicates\n";

Not quite accurate.  I added this fixup:

--- a/scripts/checkdeclares.pl~scripts-a-new-script-for-checking-duplicate-struct-declaration-fix
+++ a/scripts/checkdeclares.pl
@@ -15,8 +15,8 @@
 use strict;
 
 sub usage {
-	print "Usage: checkdeclares.pl \n";
-	print "We just warn of struct declaration duplicates\n";
+	print "Usage: checkdeclares.pl file1.h ...\n";
+	print "Warns of struct declaration duplicates\n";
 	exit 1;
 }
 

