Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB49033410A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCJPDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhCJPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:03:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E91C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rVaZvUmwNMQ4cGyM+ZRte5RqiuQMK9xv73vnf6THGC8=; b=DIoJTbsCAVmA8PeceDqyR9Z6BZ
        boXGkWGu9Db40+5NulJYnK6G/poBPzH7G7LAPIIol4Zqjm6QnMeysAuphghCc8ykJ0PuyTfxb8hTx
        2adQ78wGCpvV8+ioaXblSDMS+fmHWXzXImNZ9x+1TmN4IoZDZDhLXNF8r0eRh+fxfJLXSFsYyAOQO
        +72ytS7hk9jYW8C5N798dTlA5f3y5bKakxAd+Dgsol1yq+IfcRAXGz6AMRvo4tb2bZwtFXoa0pXGQ
        GFuVh+FBpBSoIRdgtr3FF4xGpmN9fGwPbNjHBg2PBDe/9zYbqGZNMb0AEUGLcSVmUX6nd49qaZBHY
        QWSyxxcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lK0LF-003kLM-Sp; Wed, 10 Mar 2021 15:01:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 133443013E5;
        Wed, 10 Mar 2021 16:01:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EAF9621ADDC04; Wed, 10 Mar 2021 16:01:40 +0100 (CET)
Message-ID: <20210310145258.899619710@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Mar 2021 15:52:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     valentin.schneider@arm.com, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, qais.yousef@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 0/3] sched: Fix remaining balance_push vs hotplug hole
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While the patches here:

  https://lkml.kernel.org/r/20210121101702.402798862@infradead.org

fixed the immediate hotplug regression, there was still a pending issue with
hotplug rollback (which basically never happens).

I had written these patches at the time, but never got around to actually
posting them. So here goes.

