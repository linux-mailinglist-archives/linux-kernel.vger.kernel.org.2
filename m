Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D803A2D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 15:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFJNgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 09:36:00 -0400
Received: from foss.arm.com ([217.140.110.172]:60166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhFJNf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 09:35:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22FCF106F;
        Thu, 10 Jun 2021 06:34:03 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8D213F73D;
        Thu, 10 Jun 2021 06:34:01 -0700 (PDT)
Date:   Thu, 10 Jun 2021 14:33:59 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <qperret@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: iowait boost is broken
Message-ID: <20210610133358.GB30309@e120325.cambridge.arm.com>
References: <CAEXW_YTcO=hbmdq3nOx2RJfT2yPyoFnQx5niB38R2Lzpsp38bA@mail.gmail.com>
 <20210607191031.GA12489@e120325.cambridge.arm.com>
 <YL+tDv/EL5ogf/0w@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL+tDv/EL5ogf/0w@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 07:46:54PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 07, 2021 at 08:10:32PM +0100, Beata Michalska wrote:
> > So back to the expectations.
> > The main problem, as I see it, is what do we actually want to achieve with
> > the I/O boosting? Is it supposed to compensate the time lost while waiting
> > for the I/O request to be completed or is is supposed to optimize the rate
> > at which I/O requests are being made. 
> 
> The latter, you want to increase the race of submission.
> 
> > Do we want to boost I/O bound tasks by
> > default, no limits applied  or should we care about balancing performance
> > vs power ? And unless those expectations are clearly stated, we might not
> > get too far with any changes, really.
> 
> You want to not increase power beyond what is needed to match the rate
> of processing I suppose.

This is what I took as a baseline for my playground.
This tough means we will be are operating on some assumptions (unless we go for
some major rework) and that boosting may not reach the highest level in some cases.
For those, I guess we will have to use another way to deal with performance.

Thanks for your comments.

---
BR
B.
