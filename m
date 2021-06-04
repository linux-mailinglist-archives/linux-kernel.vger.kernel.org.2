Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD99239BCE1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFDQTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230201AbhFDQTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:19:52 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83190613FF;
        Fri,  4 Jun 2021 16:18:04 +0000 (UTC)
Date:   Fri, 4 Jun 2021 12:18:02 -0400
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
Subject: Re: [PATCH V3 5/9] tracing/trace: Add a generic function to
 read/write u64 values from tracefs
Message-ID: <20210604121802.192caa07@oasis.local.home>
In-Reply-To: <a5e96ac9-f188-a9df-3eac-624002031e21@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
        <c585e3316f49c9e33acc79452588fc26ce11dfa4.1621024265.git.bristot@redhat.com>
        <20210603172244.6d2a6059@gandalf.local.home>
        <a5e96ac9-f188-a9df-3eac-624002031e21@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 18:05:06 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> 
> The reason for this patch is that hwlat, osnoise, and timerlat have "u64 config"
> options that are read/write via tracefs "files." In the previous version, I had
> multiple functions doing basically the same thing:
> 
> A write function that:
> 	read a u64 from user-space
> 	get a lock,
> 	check for min/max acceptable values
> 		save the value
> 	release the lock.
> 
> and a read function that:
> 	write the config value to the "read" buffer.
> 
> And so, I tried to come up with a way to avoid code duplication.
> 
> question: are only the names that are bad? (I agree that they are bad) or do you
> think that the overall idea is bad? :-)
> 
> Suggestions?

I don't think the overall idea is bad, if it is what I think you are
doing. I just don't believe you articulated what you are doing.

It has nothing to do with 64 bit reads and writes, but instead has to
do with reading and writing values that depend on each other for what
is acceptable.

Perhaps have it called trace_min_max_write() and trace_min_max_read(),
and document what it is used for.

-- Steve
