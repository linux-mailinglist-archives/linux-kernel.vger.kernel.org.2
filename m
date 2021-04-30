Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498CC36F95E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhD3LfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 07:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229874AbhD3LfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 07:35:24 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B1461423;
        Fri, 30 Apr 2021 11:34:33 +0000 (UTC)
Date:   Fri, 30 Apr 2021 07:34:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "zong.li@sifive.com" <zong.li@sifive.com>,
        "guoren@linux.alibaba.com" <guoren@linux.alibaba.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "chenhuang5@huawei.com" <chenhuang5@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH] RISC-V: insn: Use a raw spinlock to protect TEXT_POKE*
Message-ID: <20210430073431.1bc4946d@oasis.local.home>
In-Reply-To: <MN2PR04MB6207E102997326E6513416AB8D5E9@MN2PR04MB6207.namprd04.prod.outlook.com>
References: <20210429061713.783628-1-palmer@dabbelt.com>
        <20210429123007.5144fc0d@gandalf.local.home>
        <20210429215451.yuey5gzmfh2dkzp5@mail.google.com>
        <20210429224742.391154ae@oasis.local.home>
        <MN2PR04MB6207E102997326E6513416AB8D5E9@MN2PR04MB6207.namprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2021 04:06:35 +0000
Anup Patel <Anup.Patel@wdc.com> wrote:

> This patch only takes care of ftrace path.
> 
> The RISC-V instruction patching is used by RISC-V jump label implementation
> as well and will called from various critical parts of core kernel.
> 
> The RAW spinlock approach allows same instruction patching to be used
> for kprobes, ftrace, and jump label.

So what path hits this outside of stop machine?

-- Steve
