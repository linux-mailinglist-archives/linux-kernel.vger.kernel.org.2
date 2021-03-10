Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00072333C99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCJM10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCJM1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:27:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AC3C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 04:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z2fH+lcyyGo0ZM4lIpRkUgjnEz2lLIgr6ohv3ie7wnM=; b=wP7+V78+L6qz/SN8lcA87aAWoU
        RWlIZ6tcfJ1Flk8TkgW6rsQaSyu8HBMVao7ypjdEDP/uNFHwU9/sLq/L5OEmzVTq+klgtTwntDZZI
        LFqKpw8ytStinD4P9OdX2rlSPXMyUeV4mkKbhxdjPB9sQ6BWGt86Zfk2ap+fJ8NWcdOF41y66ALFS
        ArShCTCTVKVxzMztxPbl4LCbDUdjpPgDK8GORRG9YZjWd95RZE9vvUlhOnqE5dE83VkOHw6OHe8kH
        ++poUV6Gn93I6xWaAdcUZCRIpUGWsyZYfy7mppkTxXVUIUOVk0sswr08zqy4a5HHa3J8MKY66OduA
        Z0rY3rpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJxv9-003NFB-78; Wed, 10 Mar 2021 12:26:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 849083010CF;
        Wed, 10 Mar 2021 13:26:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CD7D20160C00; Wed, 10 Mar 2021 13:26:21 +0100 (CET)
Date:   Wed, 10 Mar 2021 13:26:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     changhuaixin <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        pauld@redhead.com, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, vincent.guittot@linaro.org,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v3 0/4] sched/fair: Burstable CFS bandwidth controller
Message-ID: <YEi67Tv7Lu5Ej/rh@hirez.programming.kicks-ass.net>
References: <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
 <9FD4A7E9-B545-40AB-A5B5-66DF37991474@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9FD4A7E9-B545-40AB-A5B5-66DF37991474@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 06:18:59PM +0800, changhuaixin wrote:
> Ping, any new comments on this patchset? If there're no other
> concerns, I think it's ready to be merged?

I only found this by accident...

Thread got lost because you're posting new series as replies to older
series. Please don't do that, it's crap.

I'll go have a look.
