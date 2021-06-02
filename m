Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07CA398564
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhFBJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232006AbhFBJjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622626686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuUnyNjde/pjQgQQG07CjN8TUSeAQTiGMiv0EXqDgAo=;
        b=CKc/Zrn7wBunUnwrMXRT5hTUaWQRdllbzpL/xljgDgk5hLqxHKb4A3Yb6TBWhwLSNKjOnV
        SXTyCnxZPnRkEalFzsxlXm/vjXTD+Xx8N5quYXBRNqQt/BV0uwDlG3v4ZfY4H4NLbAUOqm
        MX99cgTaGb1TQLCS1NqbtwMOxF8L3OQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-4hxGii2cN7ejiMbefGrCFQ-1; Wed, 02 Jun 2021 05:38:05 -0400
X-MC-Unique: 4hxGii2cN7ejiMbefGrCFQ-1
Received: by mail-wm1-f70.google.com with SMTP id 18-20020a05600c0252b029019a0ce35d36so1953391wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 02:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vuUnyNjde/pjQgQQG07CjN8TUSeAQTiGMiv0EXqDgAo=;
        b=f/Cec4f0V2xYtEKY6HWu2R1m6ZTcXJpJc8xO5sbj4XJ1E3BUCTRT7WPvBA1o2zTh2g
         yBhz0baY0aVCribYQrN6+SPEM7BdsP3+nxuRfqE0TBCqZYg7qS+MD2FjUabnN7CMuOKW
         kBN0zuwKC/SCtqTOjKQv/fe3WEAsw+4AQQztdmKUjT4zl2Hgyf60lRIhu0GUIWcqnHGY
         LdA+LmJrCBRetqxN+qP+bTmA5cY4WD7Jn/CZgjCoaQ2POaro5bqxMf0x9j4xuvTLHzwm
         +lKjmxW73cwrtULWuiHjHRHY5x/W+jKub3msJIYvxXwW/JcOH8kziPwqu7KE+VQ3ulqE
         OkvA==
X-Gm-Message-State: AOAM533xlUzyhhwbPHnhHDul857x4YTXAbJCHkIK0xNy6YXdUQShte0f
        ct/069YOdqW9/x9og1Kihb+WoorwPMYhN/y4FRHWtiV6FY3qYSdHCMSRryb/gwwc2RapvhuhI3M
        P724bAwRU7ZShOu7SotdM174l
X-Received: by 2002:adf:f50f:: with SMTP id q15mr31274642wro.279.1622626684542;
        Wed, 02 Jun 2021 02:38:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRD3SSRXzmAyCuxy2PzOo6snLJFzX3XM09IptabpoPYg6EyZ9pHuOwVIGL+KfJh3auppifTg==
X-Received: by 2002:adf:f50f:: with SMTP id q15mr31274632wro.279.1622626684381;
        Wed, 02 Jun 2021 02:38:04 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f? ([2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f])
        by smtp.gmail.com with ESMTPSA id p187sm2156402wmp.28.2021.06.02.02.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 02:38:04 -0700 (PDT)
Message-ID: <924be4021c3b9f65d15aa12765facb9eb58911b0.camel@redhat.com>
Subject: Re: [RFC] trace: Add option for polling ring buffers
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, corbet@lwn.net, mtosatti@redhat.com
Date:   Wed, 02 Jun 2021 11:38:03 +0200
In-Reply-To: <20210528133253.27c749ab@gandalf.local.home>
References: <20210519175755.670876-1-nsaenzju@redhat.com>
         <20210528133253.27c749ab@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven, thanks for having a look at this.

On Fri, 2021-05-28 at 13:32 -0400, Steven Rostedt wrote:
> On Wed, 19 May 2021 19:57:55 +0200
> Nicolas Saenz Julienne <nsaenzju@redhat.com> wrote:
> 
> > To minimize trace's effect on isolated CPUs. That is, CPUs were only a
> > handful or a single, process are allowed to run. Introduce a new trace
> > option: 'poll-rb'.
> > 
> > This option changes the heuristic used to wait for data on trace
> > buffers. The default one, based on wait queues, will trigger an IPI[1]
> > on the CPU responsible for new data, which will take care of waking up
> > the trace gathering process (generally trace-cmd). Whereas with
> > 'poll-rb' we will poll (as in busy-wait) the ring buffers from the trace
> > gathering process, releasing the CPUs writing trace data from doing any
> > wakeup work.
> > 
> > This wakeup work, although negligible in the vast majority of workloads,
> > may cause unwarranted latencies on systems running trace on isolated
> > CPUs. This is made worse on PREEMPT_RT kernels, as they defer the IPI
> > handling into a kernel thread, forcing unwarranted context switches on
> > otherwise extremely busy CPUs.
> > 
> > To illustrate this, tracing with PREEMPT_RT=y on an isolated CPU with a
> > single process pinned to it (NO_HZ_FULL=y, and plenty more isolation
> > options enabled). I see:
> >   - 50-100us latency spikes with the default trace-cmd options
> >   - 14-10us latency spikes with 'poll-rb'
> >   - 11-8us latency spikes with no tracing at all
> > 
> > The obvious drawback of 'poll-rb' is putting more pressure on the
> > housekeeping CPUs. Wasting cycles. Hence the notice in the documentation
> > discouraging its use in general.
> > 
> > [1] The IPI, in this case, an irq_work, is needed since trace might run
> > in NMI context. Which is not suitable for wake-ups.
> 
> Can't this simply be done in user-space?
>
> Set the reading of the trace buffers to O_NONBLOCK and it wont wait for
> buffering to happen, and should prevent it from causing the IPI wake ups.

Yes, I hadn't thought of O_NONBLOCK...

> If you need this for trace-cmd, we can add a --poll option that would do
> this.

I just sent a patch with my attempt at implementing --poll.

-- 
Nicolás Sáenz

