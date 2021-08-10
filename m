Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03C03E8374
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 21:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhHJTO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 15:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhHJTO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:14:58 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2468561019;
        Tue, 10 Aug 2021 19:14:35 +0000 (UTC)
Date:   Tue, 10 Aug 2021 15:14:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH PREEMPT_RT] kcov:  fix locking splat from
 kcov_remote_start()
Message-ID: <20210810151428.3e02d386@oasis.local.home>
In-Reply-To: <20210810095032.epdhivjifjlmbhp5@linutronix.de>
References: <20210809155909.333073de@theseus.lan>
        <20210810095032.epdhivjifjlmbhp5@linutronix.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 11:50:32 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> - With lock kcov_remote_lock acquired there is a possible
>   hash_for_each_safe() and list_for_each() iteration. I don't know what
>   the limits are here but with a raw_spinlock_t it will contribute to
>   the maximal latency. 

Note, anyone having a kernel with KCOV compiled in, probably doesn't
care about latency ;-) It's like worrying about latency when lockdep is
complied in.

-- Steve
