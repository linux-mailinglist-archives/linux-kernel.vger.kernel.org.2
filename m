Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731243E2067
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 03:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbhHFBEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 21:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhHFBEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 21:04:04 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8C6C0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 18:03:49 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c6so1033354qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 18:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zdjxi4Fa3+ypzllJ/AyX6+tXVRJghFv1IfDBReY0s4E=;
        b=MjDYXRchkMHR1K5FB/rmmwE8O1/Ig0ZpF2+r6THxJtWckbXWrh8lBX57SAvayQHw/X
         P84k1I9/gj+P+RSPgR/1FmAPof0p1wPjgKcWI34IJFAVrGO7V5ozPkk7vfPUqWi0yoO6
         IS1uJtTDqV1jipDSFiGGs3hmV/khlOtPZGReZsrRiqrK78uWc8Ve46v5qGkAka8R+rD0
         0Xv8SirP0FGqBBDgr8CibvMdH/jCVQn65oStCqnGImutvKiu1l4VN+BwWWpumB7nONy4
         lTpyew+8vYjn3VHcPR/PFegdxeKwHbyEhuCpEEg5OiZMhqUE/NZx1MB/9Jdb56zjLcGR
         +w2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zdjxi4Fa3+ypzllJ/AyX6+tXVRJghFv1IfDBReY0s4E=;
        b=W84Q4AFz9IE0eP+GFVe5dzdnQrO1ahp99N/WXE68GdIRcMHc17YO1mDBs5WKJca1JH
         XZnC6jgNV+UAzirfW5nhQn2wiNNDoRgfIwIRyXIxqDZZhaEdD/lo0qQidDmVLs8JKlv6
         x8D07FT8HHOP+jRRwn45dTBZ3cVI1J3tR3ZbeKA9rq2a8zd1oHNYZN9kbZpKiD54yZZV
         dcgUYCMtRR1FB31TXtv2ZtJX1X5yEfnXHMKGhViMvYLWEEXK90WsWR7sGWsnTLvyR00B
         K23AV3+ZNqQP6b8nQGH3o3mjPzufkmP/zchixt7sLTOIEFIBns57UX2P2Xbl90mg4Mxo
         9btw==
X-Gm-Message-State: AOAM5315EG92Tkxat9CMw/NNCpZbmgX1b+QXuZoVXe6Gs6BZmlIR465X
        Pb7ffBJd6CQ2InOnmCDq2EeWb5A/hoxw01KW7RI=
X-Google-Smtp-Source: ABdhPJzYF7AHiMBuo/3+tXUl+VEji15oVKcEHzNU1d9kup9ThZgSbEolru+V7969gCh8x5het/lQclWXFd1jwExT/Ok=
X-Received: by 2002:ac8:5a96:: with SMTP id c22mr6804098qtc.229.1628211828611;
 Thu, 05 Aug 2021 18:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEsQvctJDnsaRTXAGAJ6==juKazoo2=AJrWabLzqE=jCfg5EEA@mail.gmail.com>
 <20210805075401.21170-1-chihhao.chen@mediatek.com> <CAEsQvcsvbJdgvAOxkv_kbLohGi676Zrgz4XSFW2o3CWU3Q68Dg@mail.gmail.com>
 <CAEsQvcvJeAXoVE9FE9vsKNvXMaQYgHZBoPyKfZLT=UA-4BMe_Q@mail.gmail.com>
In-Reply-To: <CAEsQvcvJeAXoVE9FE9vsKNvXMaQYgHZBoPyKfZLT=UA-4BMe_Q@mail.gmail.com>
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
Date:   Thu, 5 Aug 2021 22:03:39 +0000
Message-ID: <CAEsQvcvArDwA9aeAm-FN6f9-G0HM0tNDRxXvX9roFQ1koqQKrg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix incorrect clock source setting
To:     chihhao chen <chihhao.chen@mediatek.com>
Cc:     alsa-devel@alsa-project.org, damien@zamaudio.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        tiwai@suse.com, Takashi Iwai <tiwai@suse.de>,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chihhao Chen,

Since you're the one with the hardware I believe the bug report for
Samsung should be done by your side.

Maybe Takashi Iwai has somebody in mind that develops audio code for
Samsung and has already contributed to ALSA?

It's best if Takashi Iwai helps you out, and you take the shortcut to
the corporate structure, otherwise the importance of our findings may
be underestimated.

Chihhao Chen, please include the following link in your bug report to
Samsung: https://lore.kernel.org/patchwork/patch/1466711/

I'd politely remind them that the headset requires a very specific
quirk to work with recent Linux, that the patch has entered Linux-Next
however it's a workaround because the headset is apparently breaking
UAC compliance when it sets both Clock Selectors at the same time,
regardless of what Clock Selector we tell it to set via USB Control
Message.

But you're free to do as you wish. I'm sure you'll be fine.

Good luck,
Geraldo Nascimento

On Thu, Aug 5, 2021 at 11:31 PM Geraldo Nascimento
<geraldogabriel@gmail.com> wrote:
>
> Em Qui, 5 de ago de 2021 12:50, Geraldo Nascimento <geraldogabriel@gmail.com> escreveu:
>>
>> > There is no noise and I think this should be a firmware bug.
>
>
> The fact that there's no noise during the echo test itself doesn't mean it's not a firmware bug.
>
> It may just mean the MIC is able to support both 48KHz and 96KHz.
>
> Because from the log we see both Clock Selectors end up selected to pin 1.
>
> Thank you,
> Geraldo Nascimento
