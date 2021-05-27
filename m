Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F20392D99
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbhE0MJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234976AbhE0MJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622117263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=glX8WQ37pPY27Hd4W81doplaosjS1gaDjtsB4N8hjlA=;
        b=N1dih72XUXqaJE21Ib2lgHXiKApFicYWy7opS78YDodUUpcbhNoIuhOOW/k7JlV861QxWH
        7NsEgDIsi9IjM3TDpzbO2Iwe8jIVzfF4y1odZtBmdkJ3Q+MYvfqT86Z8s0jcYGJIf1xhVf
        B5TgChbRV0RFIyz2S/OqCH+GOYKzSJA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-nuj6LfPPPwaJXW_NPGaMfg-1; Thu, 27 May 2021 08:07:42 -0400
X-MC-Unique: nuj6LfPPPwaJXW_NPGaMfg-1
Received: by mail-ej1-f72.google.com with SMTP id qh7-20020a170906eca7b02903e635498f8aso96898ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=glX8WQ37pPY27Hd4W81doplaosjS1gaDjtsB4N8hjlA=;
        b=Bjn0Oozav5sZ/HMBdl2v76PNPPn7qGx+onIMxBPEP6J/58boNl04j/Pp9ab6tPF0Fk
         3DG+O9kJB0hwJMdsYFbjSwkKOYIJZISQMRQLwZYH/FpfH1t5L+XDjUexrUSk1pTQ7eoa
         2RhFFrQvJCzAlfCaP5y+vTPpfdvAHZg/u6MTIPeBlx9CrCA3C9/yh0INoVOhU2bXJlxk
         uIZfLtNvFqinroT1FX76zKJCYvSN4yw23795VVGS/CrwOryTxRQEzpSMTyP9omUrpOjY
         wHZPlyCA/mTZqqLmqjjdt07PxD8Ncq9aZesefoTSQUY/GAYqxEPiwPjAqtBovIUBCLCV
         +f3w==
X-Gm-Message-State: AOAM5333zywKhvi/hMHbGPsIVoRsa9Tg7yGgZlFz5ZgKiAC848b5phQa
        fRO4BDtU67lhO1eNxAnWwNZPe2s76m8zmkUH0Ci69emF0C1LPickD2xOXL0QwiLqr0E54PYlsfb
        xDkGGY0Qxsim97ySUOGaIfMF8
X-Received: by 2002:a05:6402:944:: with SMTP id h4mr3724872edz.319.1622117260690;
        Thu, 27 May 2021 05:07:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv10JLbulmg0QMgMPpe90hcd0MvW50aSfs6BIzQ1tQse3og6v1oLXz64YgVJLSeticJHDFVQ==
X-Received: by 2002:a05:6402:944:: with SMTP id h4mr3724852edz.319.1622117260436;
        Thu, 27 May 2021 05:07:40 -0700 (PDT)
Received: from localhost.localdomain ([151.29.18.58])
        by smtp.gmail.com with ESMTPSA id bx21sm1012677edb.64.2021.05.27.05.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 05:07:39 -0700 (PDT)
Date:   Thu, 27 May 2021 14:07:37 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 0/9] hwlat improvements and osnoise/timerlat tracers
Message-ID: <YK+LiSdWQngXjior@localhost.localdomain>
References: <cover.1621024265.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621024265.git.bristot@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/05/21 22:51, Daniel Bristot de Oliveira wrote:
> This series proposes a set of improvements and new features for the
> tracing subsystem to facilitate the debugging of low latency
> deployments.
> 
> Currently, hwlat runs on a single CPU at a time, migrating across a
> set of CPUs in a round-robin fashion. This series improves hwlat 
> to allow hwlat to run on multiple CPUs in parallel, increasing the
> chances of detecting a hardware latency, at the cost of using more
> CPU time.
> 
> It also proposes a new tracer named osnoise, that aims to help users
> of isolcpus= (or a similar method) to measure how much noise the OS
> and the hardware add to the isolated application. The osnoise tracer
> bases on the hwlat detector code. The difference is that, instead of
> sampling with interrupts disabled, the osnoise tracer samples the CPU with
> interrupts and preemption enabled. In this way, the sampling thread will
> suffer any source of noise from the OS. The detection and classification
> of the type of noise are then made by observing the entry points of NMIs,
> IRQs, SoftIRQs, and threads. If none of these sources of noise is detected,
> the tool associates the noise with the hardware. The tool periodically
> prints a status, printing the total noise of the period, the max single
> noise observed, the percentage of CPU available for the task, along with
> the counters of each source of the noise. To debug the sources of noise,
> the tracer also adds a set of tracepoints that print any NMI, IRQ, SofIRQ,
> and thread occurrence. These tracepoints print the starting time and the
> noise's net duration at the end of the noise. In this way, it reduces the
> number of tracepoints (one instead of two) and the need to manually
> accounting the contribution of each noise independently.
> 
> Finaly, the timerlat tracer aims to help the preemptive kernel developers
> to find sources of wakeup latencies of real-time threads. The tracer
> creates a per-cpu kernel thread with real-time priority. The tracer thread
> sets a periodic timer to wakeup itself, and goes to sleep waiting for the
> timer to fire. At the wakeup, the thread then computes a wakeup latency
> value as the difference between the current time and the absolute time
> that the timer was set to expire. The tracer prints two lines at every
> activation. The first is the timer latency observed at the hardirq context
> before the activation of the thread. The second is the timer latency
> observed by the thread, which is the same level that cyclictest reports.
> The ACTIVATION ID field serves to relate the irq execution to its
> respective thread execution. The tracer is build on top of osnoise tracer,
> and the osnoise: events can be used to trace the source of interference
> from NMI, IRQs and other threads. It also enables the capture of the
> stacktrace at the IRQ context, which helps to identify the code path
> that can cause thread delay.

FWIW, I've been using the new tracers extensively downstream for a while
now and I find them very useful and quite more precise to detect
problems than what we currently have available.

The fact that one can do almost everything needed to spot latency issues
from entirely inside the kernel with a simple interface is a big plus to me
as well.

I wouldn't mind if this gets accepted very soon! :)

Best,
Juri

