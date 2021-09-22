Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DCB4150D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhIVUAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhIVUAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:00:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B7DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zR61vV1oybrOw3cyGY8F42IMCGnnL9DJ5uQe7oNLLZ0=; b=GWesiIwwuZoSo0GUVbwI/18JuB
        ngeTKQ8CHD4cT/52SQoaWaKG8T4IaOdBMMSBtSTJ+HdCQnupJkjpvrcIbIowx6O4evWoP5kZ1vf0n
        pU7Q6jlU8Ad6fdS+izfz+kE0wL9vYivvba9ivJX5hi7fFThSJpn2nUE7dSRmqBq//5clvj7KwQMaX
        wVU3cnzm6GcFIXlNlh3Endf9lyA5qdjsJMYsL2KTLHC/vbIUmXZoHYyigpmGgcIa5i2lclgPEmXqv
        4N/mJrlbpKz28z5TLpHpeuPL+b6QmNeN/cwCNtwPTvzy0ZyWzY2jjmwWzT56mtrJ5rQuC6h0R8jOo
        3AlxbuVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT8Ip-0055N5-3G; Wed, 22 Sep 2021 19:53:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4EDF3001CD;
        Wed, 22 Sep 2021 21:53:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 570E82D7CF34A; Wed, 22 Sep 2021 21:53:07 +0200 (CEST)
Date:   Wed, 22 Sep 2021 21:53:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Colin Ian King <colin.king@canonical.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Balbir Singh <sblbir@amazon.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH] kernel: introduce prctl(PR_LOG_UACCESS)
Message-ID: <YUuJo7IfS4x0iLfX@hirez.programming.kicks-ass.net>
References: <20210922061809.736124-1-pcc@google.com>
 <29f1822d-e4cd-eedb-bea8-619db1d56335@redhat.com>
 <20210922152250.4e7c869a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922152250.4e7c869a@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 03:22:50PM -0400, Steven Rostedt wrote:
> On Wed, 22 Sep 2021 19:46:47 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
> > > All signals except SIGKILL and SIGSTOP are masked for the interval
> > > between the prctl() and the next syscall in order to prevent handlers
> > > for intervening asynchronous signals from issuing syscalls that may
> > > cause uaccesses from the wrong syscall to be logged.  
> > 
> > Stupid question: can this be exploited from user space to effectively 
> > disable SIGKILL for a long time ... and do we care?
> 
> I first misread it too, but then caught my mistake reading it a second
> time. It says "except SIGKILL". So no, it does not disable SIGKILL.

Disabling SIGINT might already be a giant nuisance. Letting through
SIGSTOP but not SIGCONT seems awkward. Blocking SIGTRAP seems like a bad
idea too. Blocking SIGBUS as delivered by #MC will be hillarious.
