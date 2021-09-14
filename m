Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E0440B57A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhINQ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhINQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:59:16 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17C7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:57:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s12so20625ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqQSMJ8RTVDNrryIulJY4YULkRA8eJdXQSnIYvRutRM=;
        b=bOyzoS6TBDReuHrgJ73iE7TVyyReZIJ23lD6wghw6vtmD+J/kmrNOL66GQYOZbGyn7
         iao01Np6tfD4fXrcNrsZrxBOr/kZX5yIUbmdB+WYDiu0fdw8WROJMqUheZBabwzRdzJc
         S3yRwWcdOIGT+DzwYKmX2UxKzOm/KZEdkUs05mHhxgTb7tT8S+PggPMcaJOWr8QkQVZp
         2Qf9lB+UKDuSz5Wjgt4QRgUgbvRbbZKpsTTT+Lqz04aeMN2mR0MNc4AdjPddJkHMDA/e
         cgtcfH+3u7tLbNezP8DCYXLw9I8RjlsQpv2s/843ZPjaMNl65AkJE4DHLWqd15d9ysK7
         mPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqQSMJ8RTVDNrryIulJY4YULkRA8eJdXQSnIYvRutRM=;
        b=W/Lw1HuG49NlewXD9IPQ2fY4+97QZaZB6s2fVzxZtuCyd0l1m+OfPwkpoDL3mSca9y
         1eD380RCgdKxPKbG7edTU26LTA9PiY4pze6gwOl+a3nwT0AaPl3dLjyHuF3xDYfqFMGM
         yBa8h0YtUUvTHOLgy5hcRQP3hhKhI2htcxV/vEGXjzmTaiT6ukVCXmhIceR4lk7AAMVt
         pg4ZtW3TiZ7Lt3gxi5wG/VTV9njBe1P12iIcKpd4WDTSmDya2aF98iJ5VOIwNIhWuRvH
         u9dsRiBgQ9xhl23KbQZqqcCC6NvfpVr/cBQbif5BdqkH0W/yTaTh76i5ZbZSHqctFBGB
         nfMA==
X-Gm-Message-State: AOAM531FhoPcm9AqrtVbu6TqXAtgqdBH2SlY/5OjiyOfXvFfwx4p5rza
        U9ZAW+RVRtmc02x0szYudmjB6xgPfn45lbhL9ET6A9MgVhg=
X-Google-Smtp-Source: ABdhPJysNsvUDtxy30q4rx85+AbNCPtjDAx3HsUEPIj+nSsSwNY/e2GbTq6iwD8+O1eU5K92Jipb2fb7C5+7NUhYswM=
X-Received: by 2002:a2e:900c:: with SMTP id h12mr16782693ljg.263.1631638677287;
 Tue, 14 Sep 2021 09:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-5-posk@google.com>
 <YUDPWnsLRoU8StFi@geo.homenetwork>
In-Reply-To: <YUDPWnsLRoU8StFi@geo.homenetwork>
From:   Peter Oskolkov <posk@google.com>
Date:   Tue, 14 Sep 2021 09:57:46 -0700
Message-ID: <CAPNVh5eY68FSWEFwQuqN69rx2gvAn6T04SvV6MA=uEhtdy-Uyw@mail.gmail.com>
Subject: Re: [PATCH 4/4 v0.5] sched/umcg: add Documentation/userspace-api/umcg.rst
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 9:34 AM Tao Zhou <tao.zhou@linux.dev> wrote:

[...]

> > +- worker to worker context switch:
> > +  ``W1:RUNNING+W2:IDLE => W1:IDLE+W2:RUNNING``:
> > +
> > +  - in the userspace, in the context of W1 running:
> > +
> > +    - ``W2:IDLE => W2:RUNNING|LOCKED`` (mark W2 as running)
> > +    - ``W1:RUNNING => W1:IDLE|LOCKED`` (mark self as idle)
> > +    - ``W2.next_tid := W1.next_tid; S.next_tid := W2.next_tid``
>                                                         ^^^^^^^^
> W2.next_tid is a server. S.next_tid should be a worker; say:
>
>   S.next_tid := W2.tid

You are definitely right here. I'll fix the doc in the next patchset.
