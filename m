Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE244F63D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 03:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhKNCqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 21:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhKNCqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 21:46:21 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C7C061714;
        Sat, 13 Nov 2021 18:43:27 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id n12so23412968lfe.1;
        Sat, 13 Nov 2021 18:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUpu4lSykD7dSlPKgN4xQTI5XFBlGjwuWpOW+0nOHXg=;
        b=jh7zi/Q7B7hdFGm7ahU24zrKGYh/NA4MY3hI6xXMtIHqnwKo3Ap4Vl1n31yaZiVylS
         4vd55Vo6c6HaKPKycnx045NV5w+pWKSqjXNivyexy1HeOWWdk1zm5cNVc6c4fVK/x2dT
         CR3y1ggyvAr1m9nz9D8rRgEp3pbhxJO5pZ1+HZQ1CcgoerSKGQVXTyB6+2l3GeeJIWPf
         BHihH8nI5B/rQfOINwll/08ktyIywmRZvPtB+XlRWKaIMpg1asCnuRI/8fGP1BQeOk9Q
         6GKtpVIOtJtIkR5eHR0ho8TwDGuFBoXiIQ9TaX3/aeP9eRgBAtq1B2SJHHksZqzdhFj0
         nvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUpu4lSykD7dSlPKgN4xQTI5XFBlGjwuWpOW+0nOHXg=;
        b=8LDZIzpMpziqIg5wIyiu4wA5uOrMbJXX03mO+4NzfPsB8LRd8abN1Z/POS8sEE/8yU
         /Q7COY5m6U+fRo4H6Zh88eleSOfyXY4NDGJKtTjDQXVqAW7c4IznMdfMvObgFuUgd4fc
         QoDRjJqMFJsSFG/CZp05AkAkl6y7XDdE7qv+1DuimGpPDcZh2dvS/n02b4OvX5EI1Tlw
         tyeK7NPFxOLNwxuwoCB9vsXfqsIHLwLbEoThSAs1piD2St+NZBxiwwR597wQ2syAqr0n
         +1WklxkfiJZHAMSoq79LSENwbNCz4rtR54ZNAfA9jzYK65zwnoNnuVFJaSNwz95xgryF
         iOXQ==
X-Gm-Message-State: AOAM532G64Bc4lZsyyqwbfTP/wuZHGZgbE4W7mP8Dga8bPoCtGAvNvUa
        NjuCbUFEN1t3G2UwSzYmqCQyvyJT4Fdi1tWDS6k=
X-Google-Smtp-Source: ABdhPJzKTS1fJB2tohvdz0zEU3hVtmlwwa8OxoSM8bhx8sWusG4xY4XyvLZTJaWJdaVZaRXn9zU+VPoRzDlkrVTCSfk=
X-Received: by 2002:a05:6512:1323:: with SMTP id x35mr26980323lfu.613.1636857805834;
 Sat, 13 Nov 2021 18:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20211113115429.4027571-1-maz@kernel.org> <20211113115429.4027571-9-maz@kernel.org>
 <YY+32A1gdLzCP0TA@sunset>
In-Reply-To: <YY+32A1gdLzCP0TA@sunset>
From:   Dougall <dougallj@gmail.com>
Date:   Sun, 14 Nov 2021 13:43:14 +1100
Message-ID: <CAHT7dO9G6tRfQCC_62OwgkoHQeUbz4AQwseX=t2S3YVYjoHCXA@mail.gmail.com>
Subject: Re: [PATCH 8/8] drivers/perf: Add Apple icestorm/firestorm CPU PMU driver
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple distributes names (and descriptions and affinity masks) for 55
of the events with macOS in the file /usr/share/kpep/a14.plist
(exposed to users in Instruments.app). Many of those 55 events were
added in macOS 12, so it's good to check the latest version. I use
the command "plutil -convert json -o - /usr/share/kpep/a14.plist" to
get these as JSON.

There are many more events that I have discovered experimentally,
but this work is unusually hard to verify, so I'd be inclined to
stick with what's documented.

However, I have observed a few oddities that might be of interest.

The counter 0x9B (INST_LDST) works on PMCs 5, 6 and 7, but gives
different results for paired AMX instructions on PMC 7 (7 counts
instructions, while 5 and 6 count pairs as one). Apple addresses
this by restricting the affinity mask to PMC 7. This is also seen
on undocumented counter 0x96, which counts integer stores. (For
context, microarchitecturally non-load-store AMX operations appear
as stores, as they just need to be posted to the AMX coprocessor on
commit. Consecutive non-load-store AMX operations can be paired
(fused), such that they issue as one uop, which is where this
anomaly can be seen.)

Undocumented counters 0xF1 through 0xFF appear to be operation
counters, meaning their result depends on events selected on other
counters. There are three threshold registers (PMTRHLD2, PMTRHLD4,
PMTRHLD6) which can specify a threshold (in number of cycles) for
the operation counter on the PMC with the same number. There is also
a mapping register (PMMAP), which contains a 3-bit field for each
counter from PMC2 to PMC7, each specifying a PMC index which can be
used as an input to the operation. Binary operations only use
PMC2/4/6 and use PMC(n+1) as their other input. These operation
counters may also behave differently depending on the value
currently in the corresponding PMC (specifically counters F9/FA
which implement shortest/longest run of non-zero counts).

This is complicated, and it's not exposed to the user by macOS, so I
wouldn't worry about supporting it for now. Despite all this, the
events and features on the P and E cores seem to be the same, so I
don't expect a need to distinguish between them in the future.

(I've been meaning to write all this up properly, but haven't got
around to it, sorry!)

Dougall

On Sun, Nov 14, 2021 at 12:04 AM Alyssa Rosenzweig <alyssa@rosenzweig.io> wrote:
>
> Cc'ing Dougall who has worked with the CPU performance counters
> extensively and might be able to shine light on the interpretations.
