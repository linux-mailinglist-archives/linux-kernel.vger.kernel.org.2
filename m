Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEC430D9D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhBCMas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhBCMap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:30:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811B2C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 04:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0whPSGFN1CVL6QUNOgyRMN72vs82UCOXVmcMiQnW0mY=; b=KsJHH3VoRB7/HwwSj2rVkY+K8w
        IzQDXGLucXhRN7IcT7oY8qR7wEJ0+APhXypzcZth0nvGcASOCFCDYzGU5yo4MTlpH4e6Ts6I9zch8
        zBHnk4GKQrFECeJNnjxwoINuPKcZ40z4DIFlx7l2OZVasA8zfHT8XgYUhs7/OM+EIfsPeZQQLXKnX
        Mb8tKrElPS61aBuA63c/5xOBHD3yF8bObwrlsphimQZkvYTa+UgxWSchVff//gVa3gbER8cQTFDPZ
        gmdcpKNlUGQw8DgbUQkrcIZOXUzFe6RkWRzdeVR6VRgcdGr4jfTAeuse2ZzxGZ+5x8PeFKqbgPabF
        pXBj+3Zg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7HI7-00Gplz-4o; Wed, 03 Feb 2021 12:29:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44042301179;
        Wed,  3 Feb 2021 13:29:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 261922BD45B6A; Wed,  3 Feb 2021 13:29:50 +0100 (CET)
Date:   Wed, 3 Feb 2021 13:29:50 +0100
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
Message-ID: <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net>
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net>
 <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
 <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 09:50:20AM +0100, Dmitry Vyukov wrote:
> Or, alternatively would it be reasonable for perf to generate SIGTRAP
> directly on watchpoint hit (like ptrace does)? That's what I am
> ultimately trying to do by attaching a bpf program.

Perf should be able to generate signals, The perf_event_open manpage
lists two ways of trigering signals. The second way doesn't work for
you, due to it not working on inherited counters, but would the first
work?

That is, set attr::wakeup_events and fcntl(F_SETSIG).

