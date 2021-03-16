Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529AD33D134
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbhCPJym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhCPJyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:54:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DD0C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zEZzqY9NQ1ZwI2e1VnLaWuqATKDABTKkoLPBbQWJzsY=; b=iBfZgHYRuZBm8dVqeDo2tOxY9x
        fO/nZGER7uniuvOkhig8YAqsphkGbhN7S0X+TgA3a5SQ0NpvN2Bic17eIvkQQk/jTt9BKF5eUe6/D
        0x2ULHsrPe95AJWiqjhX+NjRY6gOsASBNvArN7OX+3JtW89j8kXw2U0ZQzzfWUNddEK58SjtA0hzm
        PjT4yOngz3nzySwhvOcwFz6xExb4rSuw1xwi9EupsJb71R166RhesF1cvt3xTKCVs2QlIGHp1zpQC
        f3LJ104mE7eSjDsYOGIwUGreNLkJ8CyqCEucHsWbHV4uaUqsQXVoON7EVTt42LMp4Atj20tsUPbQp
        sruoUhHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM6Nv-001m4l-30; Tue, 16 Mar 2021 09:53:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0C23301324;
        Tue, 16 Mar 2021 10:52:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A09020435CF9; Tue, 16 Mar 2021 10:52:56 +0100 (CET)
Date:   Tue, 16 Mar 2021 10:52:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: Re: [PATCH v4 2/4] sched/fair: Make CFS bandwidth controller
 burstable
Message-ID: <YFB/+MltddlbxHLT@hirez.programming.kicks-ass.net>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
 <20210316044931.39733-3-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316044931.39733-3-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



I can't make sense of patch 1 and 2 independent of one another. Why the
split?

