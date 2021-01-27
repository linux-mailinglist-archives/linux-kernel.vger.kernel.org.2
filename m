Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8733C30530E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhA0F6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235447AbhA0DSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:18:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98F8E206A5;
        Wed, 27 Jan 2021 02:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611712949;
        bh=SnVsLjOrwXaOkoQ77VYjq+7I5U4ZsKI/BSjcdhz3xj8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K0blX1eqCzpMK+sLBQK75ZL9dx+LGBh0fH7EDw83ywtLTSaGl7GCw1iHYG8AwEKx5
         ImJCyIoEYu3Xo3/9EtMMgXMldCSamwQW7LZHKuzGYqqAlNf8gSS6xqRC0NOFixAbQM
         OwNGG7KAtg7NA3G+Nm8f4WEJx7F4H1voDjoPZoG2T7oDYD7WwyM7aifvlq2OTEeCTv
         puFpRNnVi8XicY/sDotAQT+/bcKn+wsTFylsayrR8OsGiViCjwfpx8SHkXzGRAdQxd
         pZUaM4TavoyjD6mwIRqS8mzjE6cjRqTIKWpuQKJsa42NT9oTbCEmNMoEL2i/MFUaLM
         lRnFaHz7XPfcg==
Date:   Wed, 27 Jan 2021 11:02:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jianlin Lv <Jianlin.Lv@arm.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr err
Message-Id: <20210127110226.a65b3e8c66eeab6ee63f8aee@kernel.org>
In-Reply-To: <20210126202058.GC12469@redhat.com>
References: <20210125160108.2147511-1-Jianlin.Lv@arm.com>
        <20210125181926.GA10248@redhat.com>
        <20210125133840.511b1496@gandalf.local.home>
        <20210126131536.f6e3a737a7b948799084fa7a@kernel.org>
        <20210126202058.GC12469@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 21:20:59 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 01/26, Masami Hiramatsu wrote:
> >
> > > >
> > > > IOW, the "offset != 0" check removed by this patch is obviously wrong, right?
> > > >
> >
> > No, not wrong. Even offset != 0, if the symbol exists in the kernel,
> > kprobe_on_func_entry() will check it.
> 
> Yes, but unless I am totally confused... if kprobe_on_func_entry() returns false,
> then trace_kprobe_create() should fail with BAD_RETPROBE even if offset == 0 ?

Yes, if kprobe_on_func_entry() returns false, register_kretprobe() also returns
an error.

-----
int register_kretprobe(struct kretprobe *rp)
{
        int ret = 0;
        struct kretprobe_instance *inst;
        int i;
        void *addr;

        if (!kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset))
                return -EINVAL;

-----

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
