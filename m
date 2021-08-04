Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681C23E05E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbhHDQ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236825AbhHDQZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:25:55 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A9AB60F41;
        Wed,  4 Aug 2021 16:25:42 +0000 (UTC)
Date:   Wed, 4 Aug 2021 12:25:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804122541.741cf858@oasis.local.home>
In-Reply-To: <20210804162231.rfj5i736lqc4nsio@linutronix.de>
References: <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
        <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
        <20210804131731.GG8057@worktop.programming.kicks-ass.net>
        <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
        <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
        <20210804153308.oasahcxjmcw7vivo@linutronix.de>
        <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
        <20210804154743.niogqvnladdkfgi2@linutronix.de>
        <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
        <20210804121704.1587c41b@oasis.local.home>
        <20210804162231.rfj5i736lqc4nsio@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2021 18:22:31 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> no preemption happens here with NEED_RESCHED set.

But if interrupts were disabled, how would NEED_RESCHED be set? As soon
as you enable interrupts, the interrupt that sets NEED_RESCHED would
trigger the preemption.

-- Steve
