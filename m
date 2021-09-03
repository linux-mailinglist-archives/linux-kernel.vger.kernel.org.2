Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB16C4007FD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 00:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhICWvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 18:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232112AbhICWvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 18:51:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF05E60FA0;
        Fri,  3 Sep 2021 22:50:37 +0000 (UTC)
Date:   Fri, 3 Sep 2021 18:50:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] trace: Add migrate-disabled counter to tracing
 output.
Message-ID: <20210903185035.54ee75f8@gandalf.local.home>
In-Reply-To: <20210902071650.azcpx6nzjox3ymxe@linutronix.de>
References: <20210806164907.xtgvrb25eb4isxhd@linutronix.de>
        <20210806135124.1279fc94@oasis.local.home>
        <20210810132625.ylssabmsrkygokuv@linutronix.de>
        <20210902071650.azcpx6nzjox3ymxe@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2021 09:16:50 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

>  
>  Ping.

Crap, this fell through the cracks.

Let me pull it in and start testing it.

We still have another week of the merge window, luckily.

-- Steve
