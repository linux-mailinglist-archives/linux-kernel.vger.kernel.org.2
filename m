Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7DB3ABA46
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhFQRJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhFQRJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:09:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84BE1613AA;
        Thu, 17 Jun 2021 17:07:14 +0000 (UTC)
Date:   Thu, 17 Jun 2021 13:07:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] trace/kprobe: Remove limit on kretprobe maxactive
Message-ID: <20210617130713.194a7152@gandalf.local.home>
In-Reply-To: <1623946796.80yhllbpmp.naveen@linux.ibm.com>
References: <cover.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <a751a0617a2c06e7e233f2c98ccabe8b94a8076d.1623693448.git.naveen.n.rao@linux.vnet.ibm.com>
        <20210615183527.9068ef2f70fdd2a45fea78f0@kernel.org>
        <1623777582.jsiokbdey1.naveen@linux.ibm.com>
        <20210616094622.c8bd37840898c67dddde1053@kernel.org>
        <20210615210351.602bc03e@rorschach.local.home>
        <20210616112711.ce318fc66b389038203331d1@kernel.org>
        <20210617001009.d5ae7b2edfdc34f4f8c19ab5@kernel.org>
        <1623946796.80yhllbpmp.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 22:04:34 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> > 2. Move the kretprobe instance pool from kretprobe to struct task.
> >   This pool will allocates one page per task, and shared among all
> >   kretprobes. This pool will be allocated when the 1st kretprobe
> >   is registered. maxactive will be kept for someone who wants to
> >   use per-instance data. But since dynamic event doesn't use it,
> >   it will be removed from tracefs and perf.  
> 
> Won't this result in _more_ memory usage compared to what we have now?

Maybe or maybe not. At least with this approach (or the function graph
one), you will allocate enough for the environment involved. If there's
thousands of tasks, then yes, it will allocate more memory. But if you are
running thousands of tasks, you should have a lot of memory in the machine.

If you are only running a few tasks, it will be less than the current
approach.

-- Steve
