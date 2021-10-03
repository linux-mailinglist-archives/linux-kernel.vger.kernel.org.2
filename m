Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F77242033C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 20:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhJCSNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 14:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhJCSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:12:59 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCEFC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 11:11:12 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y197so17687506iof.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 11:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03zSPuwgcyuPWlzavMUzzry8631FQwG9HWEfh5JVqAo=;
        b=EBng0DgqvSkqKPixTYzc0Hv16vJe6gKESioOdjfOoEf9RRxXbj3VdkV+N9okI0GEEW
         ixjUe4eh3nkUJVWrac0wP49ztda80CwX415HWxzfY0eQOtpbv4job8t6E1DznNXyiiOd
         1jxK4LXrddiWZfhbCXQTcGkr2tgRsl75rVkqaniU8jWzppzTIWJfwB+DW8eD0wLW+gsY
         79+BsG76wruPU5EmXcJrtL7Dd+PdmKbMxDJ+YZirYOHH1lMBtsCljFRb1GLXjuB3cRwe
         O0Sd6yL2gmVYklVN3RaVKqNhivHj5f5VFmAayGcKqcbpSN58kWpCB1W7DxospG3MQA4E
         /wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03zSPuwgcyuPWlzavMUzzry8631FQwG9HWEfh5JVqAo=;
        b=1odDAuHOLUP/vX3ccirqoiA1BZl27KVNKkz4niku0YWqjUrbDkaXmN+yGh3+4wktEX
         Q2reLcjjdu7Qmr5lwtwWYZp5YbG3Xl8oX2jA9qdFF5oT2XWKipfSfzdswhk5pOUNzPSq
         O9+w/mOfqVhOLlrQ4JszhXo/AoF5ENzQ0/b9SoCrB24LFCb+HaAWppNi6/hFCpIyiTqL
         7gZb1QY7nqw5+BNnQ/in2GpPhZqWluMl9ps3f1rTyweNeF0LJZW8Iyf+EYg33eIbulEs
         +UBljp3euft8cpZImYf+MIpSIokfYo8AsdPe402PGc7XVQgMeRDUFy8tlps6nWzA9Zq/
         0lZw==
X-Gm-Message-State: AOAM530UhXlp7b4mBHKr+NUyVRMu9wwuXrUmyWsXGPUwS/2aFCLPZ2Dm
        7BeyuEG6r9CdY+Cm0YlFGqnUtEt8H95JPnf1g2w=
X-Google-Smtp-Source: ABdhPJwIwEmvfSn0nk9FDk/YIAQ+9xdtC3xUWleHn3IDV3PC/zxiQ1m3+ocahKCrldzvWaWjQ/dkfLbED1xYjHf56E8=
X-Received: by 2002:a05:6638:16c5:: with SMTP id g5mr7675904jat.130.1633284670747;
 Sun, 03 Oct 2021 11:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210923164741.1859522-1-bigeasy@linutronix.de>
In-Reply-To: <20210923164741.1859522-1-bigeasy@linutronix.de>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 3 Oct 2021 20:11:00 +0200
Message-ID: <CA+fCnZcJ4YeTR6ZRZUrr0NYWZC+OVpUKdnHg-Tjf_DCG0B1H3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] kcov: PREEMPT_RT fixup + misc
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 6:47 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> This is a repost of my initial series [0] with collected tags.
>
> The last patch in series is follow-up to address the PREEMPT_RT issue
> within in kcov reported by Clark [1].
> Patches 1-3 are smaller things that I noticed while staring at it.
> Patch 4 is small change which makes replacement in #5 simpler / more
> obvious.
> I tested this with the snippets in examples, Marco Elver used to run syzkaller
> for a few hours.
>
> [0] https://lkml.kernel.org/r/20210830172627.267989-1-bigeasy@linutronix.de
> [1] https://lkml.kernel.org/r/20210809155909.333073de@theseus.lan
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

for the series.
