Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11973BC80E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhGFIri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhGFIrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:47:37 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA832C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 01:44:58 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id x22-20020a9d6d960000b0290474a76f8bd4so19257877otp.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 01:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgrItQJr2ir+Fs/SeQicLPg9OYSx68QtKgebdUSItu8=;
        b=RAjEOAebi4J3YM9YGSPzmzivXE1//ZDLDl19txj0j0LF91GQGcSY4RN9tLtpGezFmd
         mudvebEncqvwkD/pbQpVpOnRcuCipeuawtE5MyIEhRUTCdCt+UiBe3IC3s9rjXrd/GH/
         UYDaOJFcn6QbQGfqkBCEUbMbbNqu7QG06FUI8oSkQgVH5FimZlVs6Yw/U4cgZir6By4F
         qk7J/Y5mRmq7wZcgFbbWA840bIRSxKxJXd8IvChoPZqIwW7frY/Z0k+gLw2pckPUVfAz
         AlELsB2BQR5AZbGmGitW3WYA0fmJ0BxkxfkUv3KJoiLxylk8mZsFcZhqFdqb/PE9GSwY
         /uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgrItQJr2ir+Fs/SeQicLPg9OYSx68QtKgebdUSItu8=;
        b=UxG/Ox3EquudGD2DHK9oim1raaFKcglgeL/nZTeSPo2b7Wn1vHUTwjPeo3QkRT2UZ+
         6tmRwSpeHlrQhmPzFS9RZH05p6k1EJWQXSnovrY8ZynlHYmvWNc4THnPdryl3LyWwlKV
         Z24wSaIpD4QEN7DkL830Wg2XKoSIaoQgULjirq97jOukXHjN0vGk+aPGchgIDUTZZYBr
         dLxjftbAPGZaZXUYOj4JXg7faydtiAYKEFrXrcldmWWpDnP1BbEI83CdfDxClVoBlfNq
         CAz5eNWKKZP1nL10iCvd6wE/jyDc6u6u5dKIaqLUN/wid/RLb7fpJw36sYyR6HrXRIqg
         cboQ==
X-Gm-Message-State: AOAM531AC4p9/Kt7QH7tTIn5GKnC3szByZu3l7hWsXFSfMANcKgRVQ39
        TSGrRXpyIAmuz7doMogMJ2gzscW0D7BptiOdY50d+A==
X-Google-Smtp-Source: ABdhPJzbuFxwRRs4m/6lag2YCxJxLxrIDyq/gj/ZvUkCTURxi8MHrihzPivvkcuVUqHnfltrGQm2ZWnTZmFJCGWA9Y4=
X-Received: by 2002:a9d:d04:: with SMTP id 4mr14800001oti.251.1625561097822;
 Tue, 06 Jul 2021 01:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <YMxYR33XEfVg6AoD@hirez.programming.kicks-ass.net>
 <YMxgbuEdrq8k3eZp@elver.google.com> <YMyC0iux0wKzc1JG@hirez.programming.kicks-ass.net>
 <20210618204800.GK4397@paulmck-ThinkPad-P17-Gen-1> <YM+TlNDJm1Jx1WQW@hirez.programming.kicks-ass.net>
 <20210620210127.GR4397@paulmck-ThinkPad-P17-Gen-1> <YNA/gkHbq46A/21C@hirez.programming.kicks-ass.net>
 <20210621133757.GS4397@paulmck-ThinkPad-P17-Gen-1> <YOQNgsS9Tjt4aDmG@hirez.programming.kicks-ass.net>
In-Reply-To: <YOQNgsS9Tjt4aDmG@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 6 Jul 2021 10:44:46 +0200
Message-ID: <CANpmjNNRAJ34KUF-1hWrP3F0Ooy4oi6kbH82WWpDxmVqVSj4SA@mail.gmail.com>
Subject: Re: RCU vs data_race()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2021 at 10:00, Peter Zijlstra <peterz@infradead.org> wrote:
[...]
> In that case, would not an explicit: data_debug(addr) call (implemented
> by KASAN/KCSAN/whoever), which would report whatever knowledge they have
> about that address, be even more useful?

KCSAN/KASAN report data-races/memory errors as soon as they encounter
them, but before they do, cannot give you any more than that (metadata
if it exists, but not sure it can be interpreted in any useful way
before an error occurs).

But maybe I misunderstood. Is data_debug() meant to not return
anything and instead just be a "fake access"?

For those, we already have various existing primitives:

-- KCSAN: ASSERT_EXCLUSIVE_{ACCESS,WRITER}()
(https://www.kernel.org/doc/html/latest/dev-tools/kcsan.html#race-detection-beyond-data-races)

-- All sanitizers (KASAN & KCSAN right now): <linux/instrumented.h>:
instrument_*() calls, for generic explicit instrumentation.

-- For sanitizer-specific checks, there's everything else in
<linux/{kasan,kcsan}-checks.h>, but instrumented.h should be
preferred.

Thanks,
-- Marco
