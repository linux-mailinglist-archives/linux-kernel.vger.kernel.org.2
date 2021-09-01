Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304E43FDD0B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbhIANHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346128AbhIANHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630501571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6YZViCnYs0eR5/63fdWEJvo5ozOWVgp0c50/QeWT3bM=;
        b=bCM/kHztsVIXAwyEG1y67Y1KqKZUB+I10+Mrw7ci1RPRFo8oBs8a7b6Df3DlfS5FXbhjAK
        qO7fRvEC3Z0cJvdAGEYZbu5EC/fTJareJGaZp7yTSU0KM88aHyqEB3EO1xTQy2bSzTvbj/
        WZDPKoRyf9yJEG8CEgGMifTDeLbfrbs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-4tHKzDgUPU238yobkDBX7g-1; Wed, 01 Sep 2021 09:06:09 -0400
X-MC-Unique: 4tHKzDgUPU238yobkDBX7g-1
Received: by mail-lf1-f72.google.com with SMTP id d10-20020ac24c8a000000b003dce50ea2c4so1020294lfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 06:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6YZViCnYs0eR5/63fdWEJvo5ozOWVgp0c50/QeWT3bM=;
        b=RE+GVH0YQW6OK2QjXNhVQkzIU2EobFcMHiqEn750x34Sq4B9pV4LVKM+CBLz4jBItt
         TTQdIMbzkXjgACWieV50+B+8Nt7wm2k1Ez+u0Myf/nWbiR44x6JqoPoHsIn27YH0tDHq
         Fj6/DgM3gLnBoM10uSf3+Xgavxu4EAp4PIbwrYgW1Eqti2jNXhJ6QK/0g444LBf0ZUtV
         lJQNqhLdVSC9bINEbv8+HTGzIrWGqgJiokhfw4I8v7Q0GQe8frIQ/WlG/mTw8ubkPEIl
         gtnsSasNhBZc/QF9primUEywR+ujUvTCg7L+DUDgE9mANo/Bvy8M5aaURRFPp0cK9rjJ
         MMBg==
X-Gm-Message-State: AOAM532kcw2STsU2LgsP+K6Sj3LwWm+Pn82cYQHWS1+BMulM+zCSOusV
        yEiObcv2KgtPWJf1HQsAo1tGdJCGB/O+Vshr+mM03592t9MWnlyR62VghSTTaGL97s81pDKQK/H
        kHGabDXmWoolhntg/QtlwAmHIbdZGEfwBBFpZidec
X-Received: by 2002:a2e:6c09:: with SMTP id h9mr29879243ljc.30.1630501566606;
        Wed, 01 Sep 2021 06:06:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4KgSc7FdbP3ZCPei50jhJPE9x61plgM6g2/l28VIOxCxWA9hGn77raRvHcCEIZypl+16IpdgtwN7PDzwupHg=
X-Received: by 2002:a2e:6c09:: with SMTP id h9mr29879177ljc.30.1630501565974;
 Wed, 01 Sep 2021 06:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210824152423.300346181@fuller.cnet> <20210824152646.948424573@fuller.cnet>
In-Reply-To: <20210824152646.948424573@fuller.cnet>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Wed, 1 Sep 2021 09:05:55 -0400
Message-ID: <CAFki+LkNcwFATSth4cvU=-7aBZjaLLNU6UFWYv1DxkeYwkeuSg@mail.gmail.com>
Subject: Re: [patch V3 8/8] mm: vmstat_refresh: avoid queueing work item if
 cpu stats are clean
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Tue, Aug 24, 2021 at 11:42 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> It is not necessary to queue work item to run refresh_vm_stats
> on a remote CPU if that CPU has no dirty stats and no per-CPU
> allocations for remote nodes.
>
> This fixes sosreport hang (which uses vmstat_refresh) with
> spinning SCHED_FIFO process.
>

I was still able to reproduce the sosreport hang with this patchset and I
am wondering if that is because right now we do vmstat_sync and then cancel
any pending jobs on a CPU in the context of one task.

However, while this task is running another process can come in and can
dirty the stats resulting in vmstat job getting placed on CPUs running
SCHED_FIFO tasks.
Am I missing something?

What we can probably do is to communicate that a CPU is running on task
isolation mode to any other process that is trying to run and schedule
jobs there.

-- 
Thanks
Nitesh

