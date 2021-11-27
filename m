Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC3460164
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 21:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352073AbhK0USb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 15:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbhK0UQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 15:16:30 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D4C061574
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 12:13:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id r11so53689341edd.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 12:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3bMyxoNGuDs9iRbDnfu8c4sxuLB/y5pYminIazb2JE=;
        b=XfXE+RUSCElVl2hjMTGZZisEUZE2HdpPmq/tOzkime+eLGJhGKYGIarhr+IzJW49K3
         A1SaexG8ZDMVRzA/SjFPll/Yw98tRmCuEYTYFehU4v/6YlDNpprRkbdP2KnpF5HiPPEW
         B31ILDMj3O/GPW5B2yCpM/9Gnae7Gm96bC7gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3bMyxoNGuDs9iRbDnfu8c4sxuLB/y5pYminIazb2JE=;
        b=8J2SqF7ID1Z0jjzlqLVDbIhmJtSMoVGhRIhS5TefctMuAr34Uw6Er7H21BNadxT5eU
         yXoLfT4gIxIZEfFlznyG8uud+yZn0MHog7UXltZ224eboikqEwqL0ylGA93Fe5RKAHjt
         2bxJWmluTaxl3yEEFptRm9bsvyuLRCErdvWracpkJDW/p6n/2wtYU5r9p1djgpDUJbgp
         b9O+X5kdb/tmuMlxI9b5Q/Hsp4KeDxSoVNDRIhZs2MfuM/FQiqMOZ3TdB/CMVSeE5t7x
         b5C5q5NvjkJH2gUHIhyNDdRCQyag9o4ZkxtHpMzdJgBBifEasal0yDRzq4N0nTYHG2W+
         KITw==
X-Gm-Message-State: AOAM533UyjJ9BbPO/mraskfae3zpVuRGnqfFnR78BBU1NsPIonH3D7ud
        mH41bFN+DwIM+d/R4NmByl1I91BMMbXp9Cz4
X-Google-Smtp-Source: ABdhPJzGWeNdd/WfoT5Op7YmHT9QAvi7GLHqMSwfifN1jJLp39rj/cAR5Xq9/zlJHFYzDVK3pODgDQ==
X-Received: by 2002:a17:906:3489:: with SMTP id g9mr47153582ejb.17.1638043992657;
        Sat, 27 Nov 2021 12:13:12 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id t3sm6083211edr.63.2021.11.27.12.13.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 12:13:11 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id a18so26763168wrn.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 12:13:11 -0800 (PST)
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr21715547wrx.378.1638043991440;
 Sat, 27 Nov 2021 12:13:11 -0800 (PST)
MIME-Version: 1.0
References: <20211127132822.5d4d2a8b@gandalf.local.home>
In-Reply-To: <20211127132822.5d4d2a8b@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Nov 2021 12:12:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJn3L26=1m4RAeGJ-PFQkrqGNCgdH1bWu7+XJKtwfvgw@mail.gmail.com>
Message-ID: <CAHk-=wiJn3L26=1m4RAeGJ-PFQkrqGNCgdH1bWu7+XJKtwfvgw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Two event pid filtering bug fixes
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 10:28 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Two fixes to event pid filtering:
>
> - Have created events reflect the current state of pid filtering
>
> - Test pid filtering on discard test of recorded logic.
>   (Also clean up the if statement to be cleaner).

I could not parse either of those statements. The second one in
particular is just a jumble of random words in a random order.

I tried to make it make sense by looking at the commits themselves,
but who knows. Maybe I made it worse by turning it from
incomprehensible to actively wrong.

Please make those explanations more clear in the future, ok?

               Linus
