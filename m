Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF8E3F616E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbhHXPUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhHXPUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:20:31 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AA7C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:19:47 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1mIYDH-0000h4-KA; Tue, 24 Aug 2021 11:19:43 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 3D1D656006F; Tue, 24 Aug 2021 11:19:43 -0400 (EDT)
Date:   Tue, 24 Aug 2021 11:19:43 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 5.14-rc breaks iotop swap io monitoring.
Message-ID: <20210824151943.GA386@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210824031648.GA2725@codemonkey.org.uk>
 <YSSuVO47ieWDfWMQ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSSuVO47ieWDfWMQ@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:31:16AM +0200, Peter Zijlstra wrote:
 > On Mon, Aug 23, 2021 at 11:16:48PM -0400, Dave Jones wrote:
 > > I just noticed that in 5.14-rc running iotop, it complains on startup
 > > that "CONFIG_TASK_DELAY_ACCT not enabled in kernel, cannot determine
 > > SWAPIN and IO %" and sure enough a bunch of columns show up as
 > > 'unavailable'.
 > > 
 > > My suspicion is this commit, which I've not confirmed yet as it doesn't
 > > cleanly revert.  I'll poke at it some more in the morning, but figured
 > > I'd bring it up sans-evidence in the hope that I'll wake up to someone
 > > having an Ah-ha moment.
 > 
 > If you need DELAYACCT I'm thinking:
 > 
 >   e4042ad49235 ("delayacct: Default disabled")
 > 
 > and
 > 
 >   0cd7c741f01d ("delayacct: Add sysctl to enable at runtime")

That does sound more relevant. however, even after echo 1  > /proc/sys/kernel/task_delayacct,
it still fails in the same way.

	Dave

