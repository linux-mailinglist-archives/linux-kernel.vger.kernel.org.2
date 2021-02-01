Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2F430AF9E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhBASlV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Feb 2021 13:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232491AbhBAScx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:32:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0B3614A7;
        Mon,  1 Feb 2021 18:32:12 +0000 (UTC)
Date:   Mon, 1 Feb 2021 13:32:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4 v2] tracing: Merge irqflags + preempt counter.
Message-ID: <20210201133210.2fabed06@gandalf.local.home>
In-Reply-To: <20210201182345.xcdcxxpa2bysbgzc@linutronix.de>
References: <20210125140323.6b1ff20c@gandalf.local.home>
        <20210125194511.3924915-1-bigeasy@linutronix.de>
        <20210201182345.xcdcxxpa2bysbgzc@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 19:23:45 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2021-01-25 20:45:07 [+0100], To linux-kernel@vger.kernel.org wrote:
> > The merge irqflags + preempt counter, v2.
> > 
> > v1…v2:
> >  - Helper functions renamed.
> >  - Added patch #2 which inlines the helper functions.
> >   
> 
> a gentle ping.
> 
> Sebastian

Hi!

I pulled your patches in locally. They are in queue to be tested, but some
patches before them had slight issues that needed tweaking, slowing down
the process.

I'll let you know if your patches have any issues, but expect to seem a
"for-next" post this week (if all goes well!).

-- Steve
