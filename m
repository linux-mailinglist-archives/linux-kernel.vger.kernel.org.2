Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AA8366EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbhDUPAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240091AbhDUPAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:00:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 371D261454;
        Wed, 21 Apr 2021 15:00:08 +0000 (UTC)
Date:   Wed, 21 Apr 2021 11:00:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@elte.hu" <mingo@elte.hu>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "yuanhan.liu@linux.intel.com" <yuanhan.liu@linux.intel.com>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Subject: Re: [PATCH][RFC] tracing: Enable tracepoints via module parameters
Message-ID: <20210421110006.3652f26a@gandalf.local.home>
In-Reply-To: <7d971eef-72bc-db32-e6a3-26e94b1b4236@rasmusvillemoes.dk>
References: <1299622684.20306.77.camel@gandalf.stny.rr.com>
        <877hc64klm.fsf@rustcorp.com.au>
        <20130813111442.632f3421@gandalf.local.home>
        <87siybk8yl.fsf@rustcorp.com.au>
        <20130814233228.778f25d0@gandalf.local.home>
        <77a6e40b57df092d1bd8967305906a210f286111.camel@intel.com>
        <20210419181111.5eb582e8@gandalf.local.home>
        <CAPcyv4gw7KoL8U66LLx_DVAE+5Jguz7tb3Rax-bdTz4BrpwhvQ@mail.gmail.com>
        <20210420085532.4062b15e@gandalf.local.home>
        <CAPcyv4gHHPdCYPzLeNzX0KMoNrOf8H0N5PBiWam0wF+WhV-Jpg@mail.gmail.com>
        <20210420163243.45293c9a@gandalf.local.home>
        <5d191e26-bd00-c338-e366-b4855ac08053@rasmusvillemoes.dk>
        <20210421102008.411af7c5@gandalf.local.home>
        <7d971eef-72bc-db32-e6a3-26e94b1b4236@rasmusvillemoes.dk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 16:50:30 +0200
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> I don't "want" anything. I just fail to see what advantage that proof of
> concept would bring over the current dev_dbg implementation.

That you don't need to go through the console. The trace ring buffer is
much faster than printk (you can record millions of traces a second,
and barely notice the overhead, which is why you can trace scheduling and
high frequency interrupts), and if you want, you get your very own buffer
to record to, without any noise from anything else, with features like
filtering, histograms, stack traces, etc.

The tracing infrastructure has a lot more to offer than printk does.

-- Steve
