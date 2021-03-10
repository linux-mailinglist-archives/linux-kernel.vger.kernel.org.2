Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B574333D88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhCJNTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhCJNSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:18:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00E2C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 05:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eis4+R44fvabYv/h8cyHmkDydX2d+usvNs4QgffIqJE=; b=vb69C58Eyeg+N03Qb7GiBVKaYg
        vvgZFWsgoAihLoxPKehsyjABbBl0jUnlYgYh8Qhe1B7NcSVXKCc5mSlQxOloQPaXhAlfeD6bTacHv
        Enb5yfEtLYRfQ+wdpmqHHQTRjDhNhVFAqYVHmagGCYbQPILK2Xvp9oniyJyMf3lSs/hFSfBT6dGzE
        OLpcEC0Ni3BP0GD+FOiGMTDE10NQ2N05wv8TDD1F7f/Y/LpubFmk2Gi0dUKL7DqM5sjmWpYOJ5iws
        DXwhJKLp6SQm99oCad+v+XBNhiWU8/+K7OYVKDCOlOEGN9DOPV88pIvAoFWfnMFoBL29GzVtSsNX6
        mnwkUCRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJyiZ-003Vkg-IK; Wed, 10 Mar 2021 13:17:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AAEA9300455;
        Wed, 10 Mar 2021 14:17:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7388D20541634; Wed, 10 Mar 2021 14:17:27 +0100 (CET)
Date:   Wed, 10 Mar 2021 14:17:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        pauld@redhead.com, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v3 4/4] sched/fair: Add document for burstable CFS
 bandwidth control
Message-ID: <YEjG5wNgTzjRLEOL@hirez.programming.kicks-ass.net>
References: <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
 <20210121110453.18899-5-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121110453.18899-5-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 07:04:53PM +0800, Huaixin Chang wrote:
> Basic description of usage and effect for CFS Bandwidth Control Burst.
> 
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>

Guess :-)

> +Sometimes users might want a group to burst without accumulation. This is
> +tunable via::
> +       /proc/sys/kernel/sched_cfs_bw_burst_onset_percent (default=0)
> +
> +Up to 100% runtime of cpu.cfs_burst_us might be given on setting bandwidth.

Sometimes is a very crap reason for code to exist. Also, everything is
in _us, why do we have this one thing as a percent?
