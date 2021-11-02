Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE2944370F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 21:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhKBUPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhKBUPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 16:15:12 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D74AC06122B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 13:12:15 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e144so155497iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vSPlWm2hs69Rrwv7pMsIZ6ZEjm3Jr85/4hUvPPRbxSY=;
        b=HYAtKgTX3PWNExtxLEVgelwQbaKIcCqdFVUUlL+xjFymnNK4MBlki0KZ8xiwn5pTTU
         50wtyk9r0viovOjnSlH//z1q/vyUwgLFADoCTESoPdmsy921k2KE7d532c/UbGk5jQqg
         FppHvZTuqWz/yVxxXUfNpf0ZplB8TbeFFdhPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vSPlWm2hs69Rrwv7pMsIZ6ZEjm3Jr85/4hUvPPRbxSY=;
        b=ZawCivGPOQt6CUdVOhLDNEPj9+TOzStAcZdWIds4r70xfCUr8Bp3gVlwRoBgqBWZco
         j4UL8KmsWS8v8AfjPKF/0k5P74p8/RjWOmU8okF4LnPxRjmxdAv0z8w2X72fVvy4dQZB
         TBQbBCqwk8u1c1lQiISOHkqLLr1+EbZMQTGCq3j7SMkxmYoBw2coWkDPOgSNc8rKthpm
         JukrdWvz1PuzXzcaCGfO02xzoPeyFLgdAYHGzbgCbgurzfGqt+xd3HXrijnz9/c0YnaN
         Bbx9t7Q9u1+SJg7niBBDA0dmNnrpxI6dSJRryfGN8UQjohu0Le82VxMXaiHfNMe83I/J
         WwAA==
X-Gm-Message-State: AOAM533r+zOOzQ7Yb4k3PtjGPHmxKTX2WWUixeP5vaJTD284cFdGCCro
        DF83Ub64yFT9uNNJiU56w1TGouTuRB6aCg==
X-Google-Smtp-Source: ABdhPJyTIK2OZjAbz1w3LPFeLRwjWexYob4M3Q4L/MRv+lzn2b6PfFPTMv/jcNTgqO32Uts+WDGQNA==
X-Received: by 2002:a05:6602:2b10:: with SMTP id p16mr27926726iov.207.1635883934420;
        Tue, 02 Nov 2021 13:12:14 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id y13sm27685ill.77.2021.11.02.13.12.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 13:12:13 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id n128so119460iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 13:12:13 -0700 (PDT)
X-Received: by 2002:a6b:109:: with SMTP id 9mr2801480iob.128.1635883932783;
 Tue, 02 Nov 2021 13:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211102173158.3315227-1-daniel.thompson@linaro.org>
In-Reply-To: <20211102173158.3315227-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 2 Nov 2021 13:12:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uk43Y3L0oTAxR1YDBUO3axz3joK2NGkGNXQPbUPwerig@mail.gmail.com>
Message-ID: <CAD=FV=Uk43Y3L0oTAxR1YDBUO3axz3joK2NGkGNXQPbUPwerig@mail.gmail.com>
Subject: Re: [PATCH v4] kdb: Adopt scheduler's task classification
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        jing yangyang <jing.yangyang@zte.com.cn>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 2, 2021 at 10:32 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently kdb contains some open-coded routines to generate a summary
> character for each task. This code currently issues warnings, is
> almost certainly broken and won't make sense to any kernel dev who
> has ever used /proc to examine task states.
>
> Fix both the warning and the potential for confusion by adopting the
> scheduler's task classification. Whilst doing this we also simplify the
> filtering by using mask strings directly (which means we don't have to
> guess all the characters the scheduler might give us).
>
> Unfortunately we can't quite match the scheduler classification completely.
> We add four extra states: - for idle loops and i, m and s sleeping system
> daemons (which means kthreads in one of the I, M and S states). These
> extra states are used to manage the filters for tools to make the output
> of ps and bta less noisy.
>
> Note: The Fixes below is the last point the original dubious code was
>       moved; it was not introduced by that patch. However it gives us
>       the last point to which this patch can be easily backported.
>       Happily that should be enough to cover the introduction of
>       CONFIG_WERROR!
>
> Fixes: 2f064a59a11f ("sched: Change task_struct::state")
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Notes:
>     v4:
>     - Get rid of the final `DRSTCZEUIMA` from the comments (Doug)
>     - Change "state [ism]" to "state [ims]" to match other uses
>       of IMS/ims (Doug)
>     - Fix broken english in the bta online help (Doug)
>     - Update ps online help to use <state_chars> to match other
>       synopses (me)
>
>     v3:
>     - Fix the uninitialized cpu variable (Doug and 0-day CI bot)
>     - Added a Fixes: (Doug)
>     - Changed "state I" -> "state -" and "state M" to "state [ism]"
>
>     v2:
>     - Fix the typos in the description (Doug)
>     - Stop trying to bend to world so I can keep 'I' exactly as
>       it was before. Instead we now replace 'I' with '-' and
>       fully adopt the scheduler description of tasks. kdb
>       it an interactive tool, not ABI so this is OK. (Doug)
>     - Don't try to enumerate all possible letters in the
>       comments and help. You can learn what to filter from
>       the output of ps anyway, (Doug)
>     - Fix the sleeping system daemon stuff.
>
>  kernel/debug/kdb/kdb_bt.c      |  16 ++---
>  kernel/debug/kdb/kdb_main.c    |  37 ++++++-----
>  kernel/debug/kdb/kdb_private.h |   4 +-
>  kernel/debug/kdb/kdb_support.c | 118 +++++++--------------------------
>  4 files changed, 53 insertions(+), 122 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
