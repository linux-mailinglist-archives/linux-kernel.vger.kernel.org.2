Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AFD32A0E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576775AbhCBEc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:32:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444692AbhCBCoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:44:04 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D922F61601;
        Tue,  2 Mar 2021 02:43:21 +0000 (UTC)
Date:   Mon, 1 Mar 2021 21:43:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
Message-ID: <20210301214319.7e54c66f@oasis.local.home>
In-Reply-To: <20210301174749.1269154-6-swboyd@chromium.org>
References: <20210301174749.1269154-1-swboyd@chromium.org>
        <20210301174749.1269154-6-swboyd@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Mar 2021 09:47:47 -0800
Stephen Boyd <swboyd@chromium.org> wrote:

> The %pS printk format (among some others) is used to print kernel
> addresses symbolically. When the kernel prints an address inside of a
> module, the kernel prints the addresses' symbol name along with the
> module's name that contains the address. Let's make kernel stacktraces
> easier to identify on KALLSYMS builds by including the build ID of a
> module when we print the address.

Please no!

This kills the output of tracing with offset, and can possibly break
scripts. I don't want to look at traces like this!

          <idle>-0       [004] ..s1   353.842577: ipv4_conntrack_in+0x0/0x10 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_hook_slow+0x40/0xb0
          <idle>-0       [004] ..s1   353.842577: nf_conntrack_in+0x0/0x5c0 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_hook_slow+0x40/0xb0
          <idle>-0       [004] ..s1   353.842577: get_l4proto+0x0/0x190 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_conntrack_in+0x92/0x5c0 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051)
          <idle>-0       [004] ..s1   353.842577: nf_ct_get_tuple+0x0/0x240 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_conntrack_in+0xec/0x5c0 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051)
          <idle>-0       [004] ..s1   353.842577: hash_conntrack_raw+0x0/0x170 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_conntrack_in+0x28c/0x5c0 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051)
          <idle>-0       [004] ..s1   353.842578: __nf_conntrack_find_get.isra.0+0x0/0x2f0 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_conntrack_in+0x29d/0x5c0 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051)
          <idle>-0       [004] ..s1   353.842578: nf_conntrack_tcp_packet+0x0/0x1760 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_conntrack_in+0x3c8/0x5c0 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051)
          <idle>-0       [004] ..s2   353.842578: nf_ct_seq_offset+0x0/0x40 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_conntrack_tcp_packet+0x26d/0x1760 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051)
          <idle>-0       [004] ..s1   353.842578: __nf_ct_refresh_acct+0x0/0x50 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051) <-nf_conntrack_tcp_packet+0x558/0x1760 [nf_conntrack] (3b39eb771b2566331887f671c741f90bfba0b051)

 NACK!

-- Steve
