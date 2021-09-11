Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3CA407691
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 14:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhIKMWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 08:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhIKMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 08:22:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1335BC061574;
        Sat, 11 Sep 2021 05:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pIrRTaD+W3liNDOnfLn+k/tfGaQxG0Xkh6UvYgCUGCE=; b=SKQ72EcLo22dWu7sxbKE7Ff1QP
        UAawh8J5AABJMqYA0VWmHSVSozT+h3sAI0QmewQwHGDcD86Jk96FJzblUVyKf8Ls9giZMrh0xZ552
        CfsFUI6hmQose/sv1nVRol7lQFj2NBRLxZd22PuQrd3VoV4jRBiPsM2Z27JJjnjjU0D8/O49Zzvj+
        n86OyjkD8mcYuh7YR2SKC8+YoFAsyCRZ7hr1OpRw1WF9TgZoGFyj1bzgv2S9QJU8eJW/+aCoLkqFb
        bpvWYZArQXo2gl1YwvHKrsnHlgRkEdEKRT8Qzj4HO2rbeTxFZkddJCoAi/lqWwAVg/L2k77r7RfGb
        ZeXjNH5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mP202-00Bprv-LF; Sat, 11 Sep 2021 12:21:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 899B89862C9; Sat, 11 Sep 2021 14:20:49 +0200 (CEST)
Date:   Sat, 11 Sep 2021 14:20:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [peterz-queue:sched/core 13/19] kernel/sched/fair.c:892:34:
 warning: variable 'stats' set but not used
Message-ID: <20210911122049.GW4323@worktop.programming.kicks-ass.net>
References: <202109110214.oh62aoIq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109110214.oh62aoIq-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 02:21:26AM +0800, kernel test robot wrote:

> compiler: m68k-linux-gcc (GCC) 11.2.0

>    kernel/sched/fair.c: In function 'update_curr':
>    kernel/sched/fair.c:860:42: warning: unused variable 'stats' [-Wunused-variable]
>      860 |                 struct sched_statistics *stats = __schedstats_from_se(curr);
>          |                                          ^~~~~

OK, compiler guys, this code reads like:

#define schedstats_enabled()	(0)
#define __schedstat_set(x, y)	do { } while (0)


	if (schedstats_enabled()) {
		struct sched_statistics *stats = __schedstats_from_se(curr);

		__schedstat_set(stats->exec_max,
				max(delta_exec, stats->exec_max));
	}

So yes, we initialize a variable that then isn't used, but the whole
bloody thing is inside if (0) which will not ever get ran *anyway*.

This is a crap warning if ever I saw one...
