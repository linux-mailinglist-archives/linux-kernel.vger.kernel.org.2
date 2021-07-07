Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C8D3BECFC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 19:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhGGR0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 13:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGR0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 13:26:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02409C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 10:23:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id v14so5845497lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 10:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7YGSy37fYgov/nu/eHIw5R4NrzDeOEToKWhoVDtJ3Y=;
        b=cb52bxmhnl9yk2czoTUjGteBUzb+GDAVEHPn/4CGxQho2sqt0F1sr4FDWRsdYs5LKb
         Fp/T5Kh9W+LM9kbeJL+L94H+6L0TT3CQySegbIN7K7+Rb5XRLNbgg+KVDtTxE2YFjhjN
         fsOmYItJxVvsHLg+IUeqRHDhcgLQurF/BEUbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7YGSy37fYgov/nu/eHIw5R4NrzDeOEToKWhoVDtJ3Y=;
        b=lik8W+QCHOBUqPvwy823H7FVc9nHGreMK7odSqOLAJn+R7nKV6bxtPioC+yUTJiaaM
         Qe1MxPL7nscwsj1kroVPFAZVtSAQrH9D7jjLiLyRzWtZ08cKKR9oH78LziodFlU1v6vH
         xG9Voy9OHq32IZi4UGNNFHIQ+bV9Yw/nKDAaXlk//2ON9yqNMi56qocdh/3U8dICmXRU
         rsVcMMcHq0XK3EUaZ7OrzfwEyW+/76KM/BmKbeh2S1bn2721bmG2w/OallVbFCiK4F5v
         3ZwMB6UWgrGOX9wid5tImpriIgC9KgLMuDwUhvjAxegm6/VTuXTIpJ6XaFDb1QUTuFwh
         dRMQ==
X-Gm-Message-State: AOAM5330X7/PFgqJOiSP8uh5B0VL2KAWrgEV7WDUeng9kpHbOkhmxSyU
        O67ZpJzwc3b41cFFX4IiCuQGWcXv9+kn+JAv
X-Google-Smtp-Source: ABdhPJzDJL+Q7QoKhl4Mu4fkUviJo4la33G7szi5mp2Xx8v8fQstWrQ236VFt2CSTobADZlhj/M45g==
X-Received: by 2002:ac2:4356:: with SMTP id o22mr20722097lfl.309.1625678632678;
        Wed, 07 Jul 2021 10:23:52 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id s16sm2102029lji.131.2021.07.07.10.23.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 10:23:52 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id n14so5787168lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 10:23:51 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr19433402lfc.201.1625678631269;
 Wed, 07 Jul 2021 10:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjQks3o_3=WewaXw++h+a318B3LTLSFER9Ee4n1pLCZLw@mail.gmail.com>
 <20210702175442.1603082-1-legion@kernel.org> <CAHk-=whfoVN6wiP5VHekckvqivRhpB+b1FnwyWEjz1SB2FN6HQ@mail.gmail.com>
 <20210707165008.tym4352uw3hu7uwp@example.org>
In-Reply-To: <20210707165008.tym4352uw3hu7uwp@example.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Jul 2021 10:23:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirhF8G1XniAfxzJXCYUnuAx23Q1WLi_n4+HGsUXv72KQ@mail.gmail.com>
Message-ID: <CAHk-=wirhF8G1XniAfxzJXCYUnuAx23Q1WLi_n4+HGsUXv72KQ@mail.gmail.com>
Subject: Re: [PATCH] ucounts: Fix UCOUNT_RLIMIT_SIGPENDING counter leak
To:     Alexey Gladkov <legion@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 9:50 AM Alexey Gladkov <legion@kernel.org> wrote:
>
> >   +             dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1);
> >   +             fallthrough;
> >   +     case LONG_MAX:
>
> I think that the counter should be decreased in this case too.
> inc_rlimit_ucounts() increments the counter in all parent userns. If we
> don't decrease the counter then the parent userns will have a counter
> leak.

Ack. So basically that patch, but move the dec_rlimit_ucounts() into
the LONG_MAX case?

Would you mind making a real patch with a commit message, and trying
whatever test-case you had for that KASAN use-after-free report?

              Linus
