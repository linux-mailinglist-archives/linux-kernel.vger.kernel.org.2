Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB200358910
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhDHP6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:58:17 -0400
Received: from ms.lwn.net ([45.79.88.28]:54470 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231866AbhDHP6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:58:16 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A24425ECF;
        Thu,  8 Apr 2021 15:58:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A24425ECF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1617897484; bh=9cJkoMOLSQtZN4qcQxmfnd8lPSGU32bj2b9RIrnsh50=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=admfcPA7smtr4j5sImuuExI+C3qfQpIbQzVsHJ7AGEZsmos64LcmUgk9IV2YN24V2
         XXic6EStNCDO397MzMwf/LcfJMddhPNub1urpF1pQSU2wQAQpj55chzmdb4yEQ8hoR
         itF9Il/N00+AcTfmPlzFMnhOooa3kwjvGFlSDvSphAZ5Ty64qk/dsf2Hrp0i6wvFlo
         /4FfwN1Gt+gpGesVgjyQBKIq/549VV32MPpP+cUUA1r96BevIye079VRP+gFzGp6Du
         m2l628mP3KFmSLMhNZD05wMrZIZilbV/Q9RdkdfaHPQHJ+Uw+YYAeXSUVI5Pj7LOWG
         b3icIsY/QGvOw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Cc:     bristot@redhat.com, kcarcia@redhat.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] tracing: Add the osnoise tracer
In-Reply-To: <3a69303b27bfc5d2274ab893b2cfbd0a8dbe31f7.1617889883.git.bristot@redhat.com>
References: <cover.1617889883.git.bristot@redhat.com>
 <3a69303b27bfc5d2274ab893b2cfbd0a8dbe31f7.1617889883.git.bristot@redhat.com>
Date:   Thu, 08 Apr 2021 09:58:04 -0600
Message-ID: <87pmz422gj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Bristot de Oliveira <bristot@redhat.com> writes:

A quick nit:

>  Documentation/trace/osnoise_tracer.rst |  149 ++
>  include/linux/ftrace_irq.h             |   16 +
>  include/trace/events/osnoise.h         |  141 ++
>  kernel/trace/Kconfig                   |   34 +
>  kernel/trace/Makefile                  |    1 +
>  kernel/trace/trace.h                   |    9 +-
>  kernel/trace/trace_entries.h           |   27 +
>  kernel/trace/trace_osnoise.c           | 1714 ++++++++++++++++++++++++
>  kernel/trace/trace_output.c            |   72 +-
>  9 files changed, 2159 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/trace/osnoise_tracer.rst
>  create mode 100644 include/trace/events/osnoise.h
>  create mode 100644 kernel/trace/trace_osnoise.c

When you create a new RST file, you need to add it to an index.rst (or
similar) file so that it gets incorporated into the docs build.

The document itself looks good on a quick read.  If you're making
another pass over it, you might consider reducing the ``markup noise`` a
bit; we try to keep that to a minimum in the kernel docs.  But otherwise
thanks for writing it!

jon
