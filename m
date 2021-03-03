Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955A032C04F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578308AbhCCSRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238549AbhCCQGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:06:20 -0500
X-Greylist: delayed 726 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Mar 2021 08:05:36 PST
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDE5C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 08:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0V8iaVrS9bbYkyh+xtRHW7JRJEzfSQzM4g1PJy5uybY=; b=CL8bsjhQTRwdH8MOMN9eETZKUw
        asRyF5QF37Caw8jAOC+GyArfPT/fLKO2HQDA65PT51JtXpV/oKyX2+kkzHXIx0Cm9/mLpJOJkO1of
        oUJmnQfot4IplGSMabPnQgZUOZjScXHflRrOb+fdTmu3mOerWI+Ot9GPhTK1H3nIapBIZUsoiC/zx
        Ge3f/TZ2G+jMDnkAkAHIWG01QB8+dpmygD8sflCO9ZeKhzZL2aZW4rlSQ1el0jVz7JnvIpQOeAJ7D
        neNZi1L9dl9zXyj+SUmF1DunGodBwZCmtUMEnm3YgyoKS7zTMrOSiIcH9jmXRgS9P0e1B+PmQD9hP
        c8kfVYgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lHTzy-005WbH-3G; Wed, 03 Mar 2021 16:05:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C9CC3017B7;
        Wed,  3 Mar 2021 17:05:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D48323CE7A85; Wed,  3 Mar 2021 17:05:15 +0100 (CET)
Date:   Wed, 3 Mar 2021 17:05:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH v2 0/4] psi: Add PSI_CPU_FULL state and some code
 optimization
Message-ID: <YD+zu0UVKEG1ZK/H@hirez.programming.kicks-ass.net>
References: <20210303034659.91735-1-zhouchengming@bytedance.com>
 <YD+kP0z0yWm9UeDK@cmpxchg.org>
 <YD+sAnZ+Ep0il5lp@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD+sAnZ+Ep0il5lp@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 04:32:18PM +0100, Peter Zijlstra wrote:

> Yes, I can do that. Thanks!

Please double check the patches as found here:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=sched/core

I've manually edited the tags.
