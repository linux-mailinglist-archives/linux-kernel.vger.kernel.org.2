Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39253B2B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhFXJbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhFXJbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:31:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B995C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tyy6oGPDtSV9dFs168w/OuRhaDOFXHofllzuyVaRCEQ=; b=lVGtM5BxpvBqXHCJtXY8Lm+Lkc
        mTIbmW23XvbA4/r89s4H7FCCveAUi3c+08nxekHfnkYzsp8Ng2PRgtG8DXeXp9P75JAD4G7UZSAmT
        WLWqJUy0/nx3JwmgicgO9N6FrFy+4HLmN3Te7whg9CdgUEZ21etPOjHbIJQW5AMP3f9KVFNPiBG9Q
        DgNtIhQh8HW+yiUIi3ArUMZJurmVzYwXb8NTEt5rsEj/fenJ2uN9TwzOGDv9TPKfltvMNqYTqChZl
        gifSyfstIVDkAotlhSX+Uw3Rae7MP/yMxfwZmEuICSALAKPMFHLX4i1fWxHA10RL6Okgqq1yD94hB
        Bv2eb5iQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwLfD-00BBtc-P3; Thu, 24 Jun 2021 09:28:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6198630022B;
        Thu, 24 Jun 2021 11:28:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4094F200B392A; Thu, 24 Jun 2021 11:28:48 +0200 (CEST)
Date:   Thu, 24 Jun 2021 11:28:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     changhuaixin <changhuaixin@linux.alibaba.com>
Cc:     luca.abeni@santannapisa.it, anderson@cs.unc.edu, baruah@wustl.edu,
        Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Odin Ugedal <odin@uged.al>, Odin Ugedal <odin@ugedal.com>,
        pauld@redhead.com, Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, tommaso.cucinotta@santannapisa.it,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v6 1/3] sched/fair: Introduce the burstable CFS controller
Message-ID: <YNRQUK74hIqq3nyX@hirez.programming.kicks-ass.net>
References: <20210621092800.23714-1-changhuaixin@linux.alibaba.com>
 <20210621092800.23714-2-changhuaixin@linux.alibaba.com>
 <YNHjZqbtzoOy8w87@hirez.programming.kicks-ass.net>
 <653A9CDE-2786-4174-9335-75F16B8631C0@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653A9CDE-2786-4174-9335-75F16B8631C0@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 04:48:54PM +0800, changhuaixin wrote:
> Hi, apart from the document issues Odin has replied, is there anything to improve for the other two patches?

I don't like the second patch much; but I've not had enough time to
actually think about anything yet, so I can't really make
recommendations :/

I'll try and get to it..
