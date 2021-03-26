Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDB334A5BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhCZKnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCZKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:42:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6C6C0613B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LharEvnUUAlqEV0VE+GqkPrGoupTe1G3O1pfkr+0ZOw=; b=mjs4A9FTwgRgRkHTkT+vWLbm1t
        AhQ4P3ldkeL2Hw9mUqgDCFAx36Rt0RrDaoGXgpE5SnrRUjyw2HejYQWdZzRT6T2xjAB836CCRhc//
        B+Xjo2mXXjpOZFEqSN7Q3KgI+1a1sh+O5hdSXWNhf/EOd0R/urOA0GjwDpxGKk4pTc75rU/FqToIW
        yCD0HjGxKO//TbaEVz0Medd90A8kyPB+XcS8dl76DZO4A2UcxvzFProzCfFSrDWKw9z6QxKtrLNB0
        q9kwwQCoZAXVyo/X2UdMR8dr3ZoW2wp8Vdi+YyxMKXiuMfmVnFaWOlT/vi9AZawiY3B81QIbwAnxu
        v+8AKDeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPjvE-003L6D-UJ; Fri, 26 Mar 2021 10:42:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7387301324;
        Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9EE7E2BCA7ED1; Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Message-ID: <20210326103352.603456266@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 11:33:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com
Subject: [PATCH 0/9] sched: Clean up SCHED_DEBUG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have sysctl, procfs and debugfs SCHED_DEBUG interfaces, end the
insanity and move everything to debugfs.

And since this is a nice moment to have people re-evaluate their 'tunings',
also change how some of the values work.

