Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5A53E05C3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhHDQUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234064AbhHDQUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:20:44 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8553760F94;
        Wed,  4 Aug 2021 16:20:31 +0000 (UTC)
Date:   Wed, 4 Aug 2021 12:20:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804122029.6c5c837a@oasis.local.home>
In-Reply-To: <c3fa07d1-a3c4-6775-f419-4875eb41bc88@kernel.dk>
References: <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
        <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
        <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
        <20210804131731.GG8057@worktop.programming.kicks-ass.net>
        <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
        <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
        <20210804153308.oasahcxjmcw7vivo@linutronix.de>
        <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
        <20210804154743.niogqvnladdkfgi2@linutronix.de>
        <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
        <20210804155747.cwayhjsdjc4zaubd@linutronix.de>
        <c3fa07d1-a3c4-6775-f419-4875eb41bc88@kernel.dk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2021 10:05:39 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> So what do you propose in the interim? As far as io_uring is concerned,
> it's not a _huge_ deal to do the IRQ dance, but it does bother me that
> we're making things slightly worse for the mainline kernel just to make
> the out-of-tree patches happy.

Note that the purpose of these patches are to be able to bring those
out-of-tree patches into the kernel such that they are no longer
out-of-tree.

-- Steve
