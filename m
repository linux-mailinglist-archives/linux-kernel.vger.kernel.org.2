Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C569334A61A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhCZLGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhCZLFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:05:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C8F761A14;
        Fri, 26 Mar 2021 11:05:47 +0000 (UTC)
Date:   Fri, 26 Mar 2021 12:05:45 +0100
From:   Greg KH <greg@kroah.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] sched: Move /proc/sched_debug to debugfs
Message-ID: <YF3ACeJuxoW5GX3R@kroah.com>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.340951208@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326103935.340951208@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 11:34:00AM +0100, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/debug.c |   25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)

Yes!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
