Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207D13879F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349616AbhERNap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349605AbhERNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:30:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685A4C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x+8ov7WeoqkL6cbNjsMCn38IjePqIrEIwedSZHosK/s=; b=lbchOzQ9yFxjTWjoZIadvaqKkZ
        sUjXQDGwIY12zb+H6990nXY4iDtn215XYfSK0hKuXmoX/3Ysbgj/8xKVrMXexT4RNDuC5V0gUqohh
        VM7Fe6otv4T/SFxqvPr2CgTICn+RfKyPYK3vXzEdxtnkqpAVM2m/naMWdFeuMUt/bPl8/+HpxWuZ3
        XoTMlmwC9eYKvx/YbtxkAI+HKgGV+fdeS9XTj/G4j0LMzHNWA7OgA0/yUGXPhq+fQO6+tonvPncPv
        Q3H+aP44jB1G1dh+5txPDhXml3ZOrewL+sHn3rEkJWqU5SAMmrQvzs+lprMtMHDuefSE4PJQPGBDL
        sLFPMqqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lizlD-00E0un-9f; Tue, 18 May 2021 13:27:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95683300233;
        Tue, 18 May 2021 15:27:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CAAD284C277F; Tue, 18 May 2021 15:27:46 +0200 (CEST)
Date:   Tue, 18 May 2021 15:27:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Yejune Deng <yejunedeng@gmail.com>
Subject: Re: [PATCH] sched: simplify is_cpu_allowed() code
Message-ID: <YKPA0v3we3WTWIy2@hirez.programming.kicks-ass.net>
References: <1621342486-9643-1-git-send-email-yejunedeng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621342486-9643-1-git-send-email-yejunedeng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 08:54:46PM +0800, Yejune Deng wrote:
> Combine multiple if statements that return the same value.

This patch is not a nop; You now deny cpu_dying() for everyone, while we
explicitly allow it for kthread_is_per_cpu().

