Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E8530F5CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhBDPGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbhBDO7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:59:49 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E37CC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XyOwXOoeFZVqveQ9nuOPRZtCFtnB9kvZkp68qQBH4v8=; b=ADLGmyoynXDwSot65CsQLkbkSy
        Th5W55fZXqQWXAMJLlWZEg+V/cWwKcjfyGP+NHgMzvCkGPoMbo1Sidq+7CmrAUDnMXdPQwgIv6JpU
        Mf3qqlQ8nsPeZS+a8VBjlc3ILUmEUfE5Bw82Rk+J/bO6Pfqi+nuods2JQWiNNwdk2DiDvuzy75Nuy
        cvs/hTRrBnTOlYc/bonCffTwMI2/t9J8P4M7mLgMsEKHTLL/wiNeyRl5+XWnXZ8d5XrO38djXSg4e
        0T0ftl11Ap07Cg8zhJcbtkoFEG6L1doHJ4aNtKeAbMfmWo3KOHsyQpeDH61O5yAPfdkMXd4PGV+Wg
        Nm9h0I9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7g63-0006K9-25; Thu, 04 Feb 2021 14:59:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 725ED3003D8;
        Thu,  4 Feb 2021 15:59:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 372D62C1C47CA; Thu,  4 Feb 2021 15:59:01 +0100 (CET)
Date:   Thu, 4 Feb 2021 15:59:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Subject: Re: Process-wide watchpoints
Message-ID: <YBwLtbqZFeqXkmTn@hirez.programming.kicks-ass.net>
References: <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net>
 <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
 <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net>
 <CACT4Y+btOt5QFKH9Q=81EnpDHoidJUHE2s0oZ8v65t-b__awuw@mail.gmail.com>
 <YBvAsku9OWM7KUno@hirez.programming.kicks-ass.net>
 <CACT4Y+ZLSyVMkPfh3PftEWKC1kC+o1XLxo_o6i4BiyRuPig27g@mail.gmail.com>
 <YBvj6eJR/DY2TsEB@hirez.programming.kicks-ass.net>
 <CACT4Y+a17L2pUY1kkRB_v_y3P_sbMpSLb6rVfXmGM7LkbAvj5Q@mail.gmail.com>
 <YBvyTDR+q0M62vKR@hirez.programming.kicks-ass.net>
 <CACT4Y+ZbWMa7zsa84dOBZ0C0Qgik2uDST+bzX=TrSU6vFXkkCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZbWMa7zsa84dOBZ0C0Qgik2uDST+bzX=TrSU6vFXkkCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 02:35:36PM +0100, Dmitry Vyukov wrote:

> I meant that we could restrict synchronous SIGTRAP for (1)
> perf_event_open(pid != 0) and (2) disable it after exec.

Hmm, I think I finally get what you're after. And yes, multi-process or
fork() based thingies are common and might well work too.

disable_on_exec isn't quite right though, it needs to be something that
kills the events entirely. I'll think about it.
