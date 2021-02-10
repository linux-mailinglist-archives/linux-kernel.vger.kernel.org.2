Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AFA316067
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhBJHx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbhBJHwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:52:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F92C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 23:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ehy3BRMFxuSUIPeY2xq1gffh6iFP6VP6Ll46ItImkRQ=; b=ZODxaYWJ6R82n8Tbei85dvMrlM
        x0QL/8qrw0ePnLnNJAeATmgFshcYffGRHxfiZOyWPjfrNpHe+zOJTJJCIMk5wJbjmbOiyEBKAOVZ3
        2icbhDGH5VyM5ELgcpzBg/hr4+HND5S8w4FbZrBujcskM28laYjwBXPVjTa9Tbf5F3SFB/WfX599I
        GYVZp+9ZqL7HcPrSBGe2xpuPdLvHhGITS0rY45xc7drjXOSArjKmAmC5TXe3NBxysy8eVJeUpw6VW
        BS8iLJNkxBUi4FO2+4WJJbn63G4xmw+OuNOcoGYyBbJMPUoQqsAydUlT4GnqjMP8j5UeLt/CtNEX4
        1f7SuoAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9kHe-0008RN-Ke; Wed, 10 Feb 2021 07:51:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E6503006D0;
        Wed, 10 Feb 2021 08:51:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14E0C201D19B1; Wed, 10 Feb 2021 08:51:32 +0100 (CET)
Date:   Wed, 10 Feb 2021 08:51:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/autogroup: Use true and false for bool variable
Message-ID: <YCOQhImbjjJaM/Qe@hirez.programming.kicks-ass.net>
References: <1612928785-114683-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612928785-114683-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 11:46:25AM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warning:

Please fix your robot or find yourself in the 'special' mailbox.

2b076054e524 ("remove boolinit.cocci")
