Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26B43A8DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 02:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhFPAsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 20:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhFPAs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:48:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5B0861153;
        Wed, 16 Jun 2021 00:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623804384;
        bh=Tfs8NCON6aZ23cjJVAqJGuB3PbUUxl2ih7k0KDLeOko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WboQ0sdgVD321nkRTISHJ5oGwH+F5hC4xA6lXUu3dRqpY8BBVo2Gzasgz0rh7fbOH
         GEVXMOC9faSYg8Wk0ONKCjSc1+vim20DakayaqoTgdky9mTDtgGf7FTtmGaVEwPcpr
         cjPtQLNlVJLpDPRuynphPeELrWVZGIGgT86rZ1QoK4NmtDzckCREPL2Va0cZWGaszq
         AUPwt25aP5r5FQmgd6MoXSIwb0QRF0IVF5Is21A6dE5faMq5JeWhJ0YICBct0w6VVi
         vTK4G08TnREdjKKhWBXHwV5s/hjd9zqBeKhHfjWj8lOPOyNQ0NPfWDQiaWh5wjB+i8
         T4WLUYhf4Z/AA==
Date:   Wed, 16 Jun 2021 09:46:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] trace/kprobe: Remove limit on kretprobe maxactive
Message-Id: <20210616094622.c8bd37840898c67dddde1053@kernel.org>
In-Reply-To: <1623777582.jsiokbdey1.naveen@linux.ibm.com>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <a751a0617a2c06e7e233f2c98ccabe8b94a8076d.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <20210615183527.9068ef2f70fdd2a45fea78f0@kernel.org>
        <1623777582.jsiokbdey1.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 23:11:27 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > On Mon, 14 Jun 2021 23:33:29 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> >> We currently limit maxactive for a kretprobe to 4096 when registering
> >> the same through tracefs. The comment indicates that this is done so as
> >> to keep list traversal reasonable. However, we don't ever iterate over
> >> all kretprobe_instance structures. The core kprobes infrastructure also
> >> imposes no such limitation.
> >> 
> >> Remove the limit from the tracefs interface. This limit is easy to hit
> >> on large cpu machines when tracing functions that can sleep.
> >> 
> >> Reported-by: Anton Blanchard <anton@ozlabs.org>
> >> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > 
> > OK, but I don't like to just remove the limit (since it can cause
> > memory shortage easily.)
> > Can't we make it configurable? I don't mean Kconfig, but 
> > tracefs/options/kretprobe_maxactive, or kprobes's debugfs knob.
> > 
> > Hmm, maybe debugfs/kprobes/kretprobe_maxactive will be better since
> > it can limit both trace_kprobe and kprobes itself.
> 
> I don't think it is good to put a new tunable in debugfs -- we don't 
> have any kprobes tunable there, so this adds a dependency on debugfs 
> which shouldn't be necessary.
> 
> /proc/sys/debug/ may be a better fit since we have the 
> kprobes-optimization flag to disable optprobes there, though I'm not 
> sure if a new sysfs file is agreeable.

Indeed.

> But, I'm not too sure this really is a problem. Maxactive is a user 
> _opt-in_ feature which needs to be explicitly added to an event 
> definition. In that sense, isn't this already a tunable?

Let me explain the background of the limiation.

Maxactive is currently no limit for the kprobe kernel module API,
because the kernel module developer must take care of the max memory
usage (and they can).

But the tracefs user may NOT have enough information about what
happens if they pass something like 10M for maxactive (it will consume
around 500MB kernel memory for one kretprobe).

To avoid such trouble, I had set the 4096 limitation for the maxactive
parameter. Of course 4096 may not enough for some use-cases. I'm welcome
to expand it (e.g. 32k, isn't it enough?), but removing the limitation
may cause OOM trouble easily.

Thank you,

> 
> 
> - Naveen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
