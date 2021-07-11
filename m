Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE643C3EB4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 20:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhGKSTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbhGKSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 14:19:41 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17309C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 11:16:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id e20so19285537ljn.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 11:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/AmFTjQ0lkF23rzKntrhpc3RsBuUQRY3cmjok7st+BM=;
        b=XvyTCtLmBbiUUUSd27coMfkiax6APcEE8PpLXEyKlMTY+6NQENsj8L4nFeaW+gL5hU
         amDXVb2KTgJzwJppLtxlcNEl7kuP+hibJ3c2s8AWHSNvNs+BpfTvaKns3aHvbt2mWaY+
         25se6M8mKafNdfP8baczTRwTEr+HJHSj3ySB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/AmFTjQ0lkF23rzKntrhpc3RsBuUQRY3cmjok7st+BM=;
        b=Gw3sQt8q+xQWWPpqnUpffS+FvGXsrcno/JS8Gb+2qvhfwO9FofNlxZ1fnRhtBwAUM1
         21q1JKeUzrSlCXNgWc4Sn3vDFcP6kLgzDgSENszm7AiaXCtcCuqIVhAOVSe9tpzvI0TW
         LvHYTXSwwG3Vb3v1qrEISkYl4aHsFUFzLSJDyKO25MbFLjKWqvmLlo/K5nQmy5fanJcH
         hG6GwTGLsFYwSO5qDny23oLxBLOo9yuWh7ydKrnCeofYbszgrNLsoWDXwGPWPbvz0Bso
         EpkFfkNBQmIwRByIBl/MBhnm0eehj9bohyIVjUWCICdsNjXuH8RvlzMSqL3iut6xshGT
         GhUw==
X-Gm-Message-State: AOAM532zuZL4RGSZwqVd6Unmx46ZfqzWeCZfTZXAAz78hRfIKc2JNxph
        xQvL7GK3c7leL5+VC+VJzydc9UELtI82ceOd
X-Google-Smtp-Source: ABdhPJzlA/7woDV5prWpYkN6bWj1DXLwJ1KTnsC/q7XA40bj9YW1Nh6Rru7JC9/tYqVGin79gLr6eg==
X-Received: by 2002:a2e:743:: with SMTP id i3mr34357984ljd.266.1626027411397;
        Sun, 11 Jul 2021 11:16:51 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u14sm935945lfn.47.2021.07.11.11.16.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jul 2021 11:16:49 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id h19so8417403ljl.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 11:16:49 -0700 (PDT)
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr3219975ljh.61.1626027409058;
 Sun, 11 Jul 2021 11:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <YOrzBvSv4xoU3OAX@gmail.com>
In-Reply-To: <YOrzBvSv4xoU3OAX@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Jul 2021 11:16:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjS48-_nDub4G7pgQ26-0MS2MuuNRyfDsLhp568cUfPA@mail.gmail.com>
Message-ID: <CAHk-=whjS48-_nDub4G7pgQ26-0MS2MuuNRyfDsLhp568cUfPA@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 6:32 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>  - Fix load tracking bug/inconsistency

I was going to report that I still see that

  cfs_rq->avg.load_avg || cfs_rq->avg.util_avg || cfs_rq->avg.runnable_avg
  WARNING: CPU: 8 PID: 52 at kernel/sched/fair.c:3308
update_blocked_averages+0x4c1/0x5f0

but I'm hoping/assuming that commit ceb6ba45dc80 ("sched/fair: Sync
load_sum with load_avg after dequeue") finally fixes it for good.

Hmm?

                   Linus
