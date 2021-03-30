Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A084134F1B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 21:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhC3Tju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 15:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233136AbhC3Tj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:39:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50A836199A;
        Tue, 30 Mar 2021 19:39:24 +0000 (UTC)
Date:   Tue, 30 Mar 2021 15:39:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: kprobes/ftrace: Add recursion protection to the
 ftrace callback
Message-ID: <20210330153922.29f33262@gandalf.local.home>
In-Reply-To: <20210330021440.44280b7f@xhacker>
References: <20210330021440.44280b7f@xhacker>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 02:14:40 +0800
Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:

> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Currently, the riscv's kprobes(powerred by ftrace) handler is
> preemptible. Futher check indicates we miss something similar as the
> commit c536aa1c5b17 ("kprobes/ftrace: Add recursion protection to the
> ftrace callback"), so do similar modifications as the commit does.
> 
> Fixes: 829adda597fe ("riscv: Add KPROBES_ON_FTRACE supported")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Looks fine to me.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
