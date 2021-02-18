Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95EE31EB70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 16:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhBRPVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 10:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbhBRM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:59:59 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95218C061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 04:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iuEfkBioZL3PCBzEa6OP03Pzw+w4+imJNcSQvvYATy8=; b=t6icCduspY+I9AH1D7+qy/25Q0
        S5Glin8vpPrwIAFpqOfu/HKQKLDNCQcJt/NQ0FaBthMXarcp37d1TXbemeCWVU/nL/nJ3NWUECqKt
        uLsQJi2xdgGW4wp9wR1usLRf4mCyTVTeSflw40kt+jHa/fArFKN7orTpINzuwdY7vkha5dJcK+FiF
        esK8n0dlr81bzcLwigta8BrpcdM/DC7RdzXIlJ0ENXQv35pooebImDsiMh0ROIYSWTpTYygOM+2kW
        27iGBGwmkmwoQwtY8d/me2QW1mp4fMOfAv7Jcwvwp0NjMzGGEVFnsHp64Egb1Ot8BiTYc28grEMA/
        EjpsO2kQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lCisy-0007Xt-Gy; Thu, 18 Feb 2021 12:58:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EED59305C10;
        Thu, 18 Feb 2021 13:58:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D87E9201AFBA9; Thu, 18 Feb 2021 13:58:22 +0100 (CET)
Date:   Thu, 18 Feb 2021 13:58:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Use true and false for bool variable
Message-ID: <YC5kboV4OSnimDOg@hirez.programming.kicks-ass.net>
References: <1613643011-114108-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613643011-114108-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 06:10:11PM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
> 
> ./kernel/sched/fair.c:9504:9-10: WARNING: return of 0/1 in function
> 'voluntary_active_balance' with return type bool.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

You and your robot are welcomed to my /dev/null filter. I'm sick and
tired of telling you to stop sending these useless patches.

YCOQhImbjjJaM/Qe@hirez.programming.kicks-ass.net
YAmiG3FLMYKwF0jV@hirez.programming.kicks-ass.net
20201109125543.GJ2611@hirez.programming.kicks-ass.net

