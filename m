Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002B7329418
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 22:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbhCAVrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbhCARXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:23:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C444C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Ft4xpiOGsbkSiIzxGO0wDAmkrh0poiXa0IrMPfjA+4=; b=QUsKIMvToHdgZTouzZ7LUvq2A/
        PRosT3bz694OWdcnOWE8ArpUFf3TX91fqx7xPsHOV8rppEgPJ3pdQpUsPFyYQK2NzvwTH8xKVkJtV
        JMBmoAzSj4WSZRFklPkN7+C4DyqSiGOa4vhzdeO9IBgDxhbIGDasDEPauM38H76BzNsfTOwflfKN8
        UPfTgOqCVtvBj+mu03ghJ/63agfxbbbFdr3VqmVSBoKE4KP9yHeHPFDzTfiwINzTrm3eRhkGll+9F
        6mlJlnUnZ9TxUfoSEwvL5uypk0xQJFqc6r/5KgMYshendGVluLhg6zROkpvsCOVC+xRoR4+UNz9J+
        gofo/sxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lGmEY-00G03h-Hn; Mon, 01 Mar 2021 17:21:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B86D0301959;
        Mon,  1 Mar 2021 18:21:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A23662B973BDC; Mon,  1 Mar 2021 18:21:23 +0100 (CET)
Date:   Mon, 1 Mar 2021 18:21:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>, mingo@readhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/pelt: Fix task util_est update filtering
Message-ID: <YD0ik65KwwU5R4Rv@hirez.programming.kicks-ass.net>
References: <20210225165820.1377125-1-vincent.donnefort@arm.com>
 <YDi0Ip11fpOubQqz@hirez.programming.kicks-ass.net>
 <b1471e3a-e8c5-3ab4-5db4-0084612ade55@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1471e3a-e8c5-3ab4-5db4-0084612ade55@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 05:34:09PM +0100, Dietmar Eggemann wrote:
> On 26/02/2021 09:41, Peter Zijlstra wrote:
> > On Thu, Feb 25, 2021 at 04:58:20PM +0000, Vincent Donnefort wrote:
> >> +#define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
> >> +
> >>  /*
> >> - * Check if a (signed) value is within a specified (unsigned) margin,
> >> + * Check if a (signed) value is within the (unsigned) util_est margin,
> >>   * based on the observation that:
> >>   *
> >>   *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
> >>   *
> >> - * NOTE: this only works when value + maring < INT_MAX.
> >> + * NOTE: this only works when value + UTIL_EST_MARGIN < INT_MAX.
> >>   */
> >> -static inline bool within_margin(int value, int margin)
> >> +static inline bool util_est_within_margin(int value)
> >>  {
> >> -	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
> >> +	return ((unsigned int)(value + UTIL_EST_MARGIN - 1) <
> >> +		(2 * UTIL_EST_MARGIN - 1));
> >>  }
> > 
> >> -	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
> >> +	if (util_est_within_margin(last_ewma_diff)) {
> > 
> > What was the purpose of this change? What was a generic helper is now
> > super specific.
> 
> I guess because it was only ever used in util_est for last_ewma_diff.
> 
> It's now used for last_ewma_diff and last_enqueued_diff, still only for
> util_est though and both times with the same margin
> (SCHED_CAPACITY_SCALE / 100)).
> 
> Vincent D. should be back on Wed from hols.

Fair enough; I've un-done it but kept the rest of the patch.
