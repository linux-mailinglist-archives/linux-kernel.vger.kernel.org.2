Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C033F31B3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhHTQrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 12:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhHTQq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:46:57 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73CBC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 09:46:19 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id b7so13061298iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BatGZvnfPX/8BO8di0fHBk4PO/vONowvEXDrPfGjhtE=;
        b=QORcfENsVBzv8KOaanpTcj64PpMZIDbzZhbE3mr0pKZBKwLlkGP6mcMz/IL+aw+RTk
         QTCNYTNQwnLnlhZtj+50FDSPi79cQ5ZrCbvDKZIPmpeBW0yo9FMWxpZHAzS/2dqdWflI
         1f0Qa65z/MIWurpflq/kQ63w3GrHyiEUXFNo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BatGZvnfPX/8BO8di0fHBk4PO/vONowvEXDrPfGjhtE=;
        b=Wo7IGBaeeVYfT8xsBy0TfimYFzr6J4pT7Tal/FjDob6S5u2qW7JXxoNAuegzKHlbEg
         L4Gcefl1DO1gVeSKTb622QdpUG+nfMB6yUnVay8wD4/Lh0w7pdUUlkR10AfYHfh9crzB
         ZZGHuplusq36NBbX/18F4ARrqocv6RrUiaX4aBguQAuxrNojDpeGCfuBbG0HyAmwxlGI
         UTTa9gxXxTEu1+hTyCopDw4wNApjW886TzNmSzO6+C1EMooQC+psoDZJMhNXVPZDDmVN
         LBFbcINI6pDatiPpEBW7Mg9zbDve7HMcddZMcMdRPcKxmGLQozc3awI3vEX91uIWKhQn
         /LcQ==
X-Gm-Message-State: AOAM5302+et8kZiU3zbpJ4Y20PNCvIsCmze5GJORwfP0nOOjtwYYLaze
        /xFOxRkRyQ3UF+u/maktugdcE/FX/AoVIw==
X-Google-Smtp-Source: ABdhPJzZ4zxdFC/WBI4xRx9vYEydnpjjyccGsCxmVTGmarH7C4Np+tPZSRY0HPIC9k/18BUChC2jVA==
X-Received: by 2002:a5d:8754:: with SMTP id k20mr16663373iol.160.1629477978897;
        Fri, 20 Aug 2021 09:46:18 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id h9sm3652574ilc.30.2021.08.20.09.46.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 09:46:18 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id a15so13078547iot.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 09:46:17 -0700 (PDT)
X-Received: by 2002:a6b:e70f:: with SMTP id b15mr1231462ioh.140.1629477977297;
 Fri, 20 Aug 2021 09:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210820022442.11107-1-jing.yangyang@zte.com.cn>
In-Reply-To: <20210820022442.11107-1-jing.yangyang@zte.com.cn>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Aug 2021 09:46:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJQQsK4-okC+6HSPQp8q_ahVYFHXDBhigSLGYLvnEJjQ@mail.gmail.com>
Message-ID: <CAD=FV=WJQQsK4-okC+6HSPQp8q_ahVYFHXDBhigSLGYLvnEJjQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] debug:kdb: fix unsigned int win compared to
 less than zero
To:     jing yangyang <cgel.zte@gmail.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        Stephen Zhang <stephenzhangzsd@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 19, 2021 at 7:25 PM jing yangyang <cgel.zte@gmail.com> wrote:
>
> Fix coccicheck warning:
> ./kernel/debug/kdb/kdb_support.c:575:3-10:
> WARNING:Unsigned expression compared with zero  p_state < 0
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> ---
>  kernel/debug/kdb/kdb_support.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> index c605b17..fb30801 100644
> --- a/kernel/debug/kdb/kdb_support.c
> +++ b/kernel/debug/kdb/kdb_support.c
> @@ -560,7 +560,7 @@ unsigned long kdb_task_state_string(const char *s)
>   */
>  char kdb_task_state_char (const struct task_struct *p)
>  {
> -       unsigned int p_state;
> +       int p_state;

This was talked about:

https://www.mail-archive.com/kgdb-bugreport@lists.sourceforge.net/msg06159.html

There, Peter Zijlstra said:

> Pre-existing fail that.. but yes that code (and it's carbon copy in
> arch/powerpc/xmon/xmon.c) are clearly bogus and have been for a long
> time afaict.
>
> Ideally someone that cares about this code can replace it with
> get_task_state() or something.

...so while the warning was introduced by commit 2f064a59a11f ("sched:
Change task_struct::state") and your fix papers over of the warning,
it actually doesn't fix the real bug. Apparently the comment
describing the "state" variable before that commit was wrong and "-1"
didn't mean unrunnable.

Maybe you could submit a v2 that does what Peter suggests?

-Doug
