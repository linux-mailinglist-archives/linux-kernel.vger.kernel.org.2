Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96124305D37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbhA0Naf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238422AbhA0N23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:28:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5164C207A0;
        Wed, 27 Jan 2021 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611754067;
        bh=EbCIlPU9f5xBqJq67mxctKmNjWlGB44crWtH0kvcGfM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fHlu3bwPTYx3PqpRgp+nbOJxtggwEoEQ/xSt/QeqBRodDyilH5XthGA6wKi0e/wGS
         Na6AAWF57kikHmjH9xmty78K+8xATWlP1mRIsZIHlrTK+69B0lxBckWg305ub5PuLu
         AYqv2Vvh8HE5A4AcaljWXkZ4gNeDS8ed/P0p6ZiqrmHZfIAZlbJzsuIr1xKFD/ZzMX
         BEsP3X1GkZzHcRpkBYWNMEw144i9s1B2GNbJNJE1kCN4JGf/ZFdtBsVc8g+SRSvjSZ
         UWMp2r6v0+Z1GvSKuuLNEbt3ODHFuebTdAHSu2FtD+YzMSJVrM/eLV2vdJpIEOTCot
         aQzuEHX6Z1Pxw==
Date:   Wed, 27 Jan 2021 22:27:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr err
Message-Id: <20210127222743.771338cf7f89fb0b78dd838c@kernel.org>
In-Reply-To: <AM6PR08MB3589EE4B5F1F56B84FE2750598BB0@AM6PR08MB3589.eurprd08.prod.outlook.com>
References: <20210125160108.2147511-1-Jianlin.Lv@arm.com>
        <20210125181926.GA10248@redhat.com>
        <20210125133840.511b1496@gandalf.local.home>
        <20210126131536.f6e3a737a7b948799084fa7a@kernel.org>
        <20210126202058.GC12469@redhat.com>
        <20210127110226.a65b3e8c66eeab6ee63f8aee@kernel.org>
        <AM6PR08MB3589EE4B5F1F56B84FE2750598BB0@AM6PR08MB3589.eurprd08.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 02:46:10 +0000
Jianlin Lv <Jianlin.Lv@arm.com> wrote:

> 
> 
> > -----Original Message-----
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > Sent: Wednesday, January 27, 2021 10:02 AM
> > To: Oleg Nesterov <oleg@redhat.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>; Jianlin Lv <Jianlin.Lv@arm.com>;
> > mingo@redhat.com; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr err
> >
> > On Tue, 26 Jan 2021 21:20:59 +0100
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > On 01/26, Masami Hiramatsu wrote:
> > > >
> > > > > >
> > > > > > IOW, the "offset != 0" check removed by this patch is obviously wrong,
> > right?
> > > > > >
> > > >
> > > > No, not wrong. Even offset != 0, if the symbol exists in the kernel,
> > > > kprobe_on_func_entry() will check it.
> > >
> > > Yes, but unless I am totally confused... if kprobe_on_func_entry()
> > > returns false, then trace_kprobe_create() should fail with BAD_RETPROBE
> > even if offset == 0 ?
> >
> > Yes, if kprobe_on_func_entry() returns false, register_kretprobe() also
> > returns an error.
> >
> > -----
> > int register_kretprobe(struct kretprobe *rp) {
> >         int ret = 0;
> >         struct kretprobe_instance *inst;
> >         int i;
> >         void *addr;
> >
> >         if (!kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name, rp-
> > >kp.offset))
> >                 return -EINVAL;
> >
> > -----
> >
> > Thank you,
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>
> 
> 
> If register_kretprobe()returns an error -EINVAL.
> This means that __register_trace_kprobe return -EINVAL,
> 
> ---
> ret = __register_trace_kprobe(tk);
> if (ret == -ENOENT && !trace_kprobe_module_exist(tk)) {
> pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
> ret = 0;
> }
> ---
> As code show, cannot enable kretprobe for an unloaded module.
> 
> This is consistent with my test results (no VXLAN module is loaded).
> 
> # perf probe -m /lib/modules/5.11.0-rc2+/kernel/drivers/net/vxlan.ko  \
> 'vxlan_xmit%return $retval'
> Failed to write event: Invalid argument
>   Error: Failed to add events.
> 
> Is this a bug?

Oops, good catch!
It seems that the bug has been introduced when I added kprobe_on_func_entry() to register_Kretprobe.
Let me fix it.

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
