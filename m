Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9E339E128
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhFGPtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231565AbhFGPtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:49:13 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738A461059;
        Mon,  7 Jun 2021 15:47:20 +0000 (UTC)
Date:   Mon, 7 Jun 2021 11:47:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 8/9] tracing: Add osnoise tracer
Message-ID: <20210607114718.5f8d6c38@oasis.local.home>
In-Reply-To: <f4426022-b388-55bf-669f-74f53b91efba@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
        <bd09a2be9cd0cecee86374dbb49235dd2ef9d750.1621024265.git.bristot@redhat.com>
        <20210604172803.527aa070@oasis.local.home>
        <f4426022-b388-55bf-669f-74f53b91efba@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2021 14:00:56 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> I am using these more "generic terms" because they are also used by the timerlat
> tracer.
> 
> In the timerlat tracer, the "in" file is used to stop the tracer for a given IRQ
> latency (so, the "inside" operation), while the "out" is used to stop the tracer
> in the thread latency (hence the outside operation).
> 
> The total sounds good for the "out"! But the single does not work fine for the
> IRQ... how about: stop_tracing_partial_us ?
> 
> It is hard to find a good shared name :-/

What about:

stop_tracing_us and stop_tracing_total_us, and not have anything
special for the first one?

-- Steve
