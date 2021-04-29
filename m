Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A53136EE55
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 18:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240824AbhD2QpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 12:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232724AbhD2QpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 12:45:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A230D6143B;
        Thu, 29 Apr 2021 16:44:32 +0000 (UTC)
Date:   Thu, 29 Apr 2021 12:44:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        outreachy-kernel@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Replace 'unsigned' with 'unsigned int'
Message-ID: <20210429124430.5755dca8@gandalf.local.home>
In-Reply-To: <20210429122454.9936-1-fmdefrancesco@gmail.com>
References: <20210429122454.9936-1-fmdefrancesco@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 14:24:54 +0200
"Fabio M. De Francesco" <fmdefrancesco@gmail.com> wrote:

> Replaced 'unsigned' with 'unsigned int' because the second is preferred.
> Detected by checkpatch.pl.

Please do not fix existing code because of "preferred" coding style from
checkpatch.pl. It causes unnecessary churn, and a waste of time applying it.

"unsigned" is just as good as "unsigned int" , and honestly, that's what I
prefer.

NACK.

-- Steve
