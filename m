Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EC340FFD6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 21:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243183AbhIQTaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 15:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243124AbhIQTaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 15:30:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB69C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 12:28:50 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d42so15430242lfv.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVsbbRzVJIuvkAecV/mPB5ntjxB6ICpPqlG5XK4mtXY=;
        b=CfZRtIqox1bWXczJF7ZmaaS/zOqyuVpCby5N9clLECoYgDo0bqXmAVoaWAV3Id1lJu
         w7PqKSYAiip9t8N3ZAQDbUUYQmQYSe37MPrBlatUT8JfbVQCHTF+/9dOfUbgxwbTYrBd
         pC2pUtxMQi+8C+xb079m77UOEgK2R4X1IFSYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVsbbRzVJIuvkAecV/mPB5ntjxB6ICpPqlG5XK4mtXY=;
        b=mE+anF6XVElZFUeGTrDKrEhDtghkRYOuZWZjRlQEzCdcQvunp1cuy2Uj+7XB2K1Q0k
         fxXwSHEW07yaneDmDaCdR1AoEUXT34ZI4thv1OmyHWa3/ylqfkxDzbvpI1tIgMlb4XV/
         rjQyOdD4LWXMDkpWdPNn8d8qAYHeljScb1LWWQA6oqCgZi5HtuTzqUpVogAYGayLqUK3
         oL5JEhRuA40wR81od26pw64Rcm9Rl0+7mQNw/3DJFgS3zbJ5Bc1V00Xl8BLAVJgIkUHD
         pR1baLqDNXzaR8jADUaVdu+D8OU5aRrlm9gijDLXllkBPlLHONsq4eLM7lJ+wiUO0cd3
         BKSA==
X-Gm-Message-State: AOAM530TVOcX4OFKKcgFHkny4RT7nPlKPybYsQFYjmozGL3z4+M/vGjN
        EwfiQCjfHnavGm8AC2e55vaobBWMQXav6x20rko=
X-Google-Smtp-Source: ABdhPJw/Mx3vGZTr/1ZDibMxEqMh14rsa/GizIqmb9dRvROdnbV7UtmpoAFLDIEpuFQFoe5RXkqlQA==
X-Received: by 2002:a2e:a0c8:: with SMTP id f8mr10925664ljm.170.1631906928024;
        Fri, 17 Sep 2021 12:28:48 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id v1sm794904lja.134.2021.09.17.12.28.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 12:28:47 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id g1so37634471lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 12:28:47 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr10944151ljp.494.1631906926871;
 Fri, 17 Sep 2021 12:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <6786526.72e2EbofS7@devpool47> <CAHk-=wgyk0mwYcMRC8HakzoAKL2Y3gwzD433tqKYYhV+r1PLnA@mail.gmail.com>
 <xmqq7dfgtfpt.fsf@gitster.g> <2722184.bRktqFsmb4@devpool47>
In-Reply-To: <2722184.bRktqFsmb4@devpool47>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Sep 2021 12:28:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgv42Wm3uHPntZNEYFu-dDVYW7yRen1fUBi6keZaKb+_g@mail.gmail.com>
Message-ID: <CAHk-=wgv42Wm3uHPntZNEYFu-dDVYW7yRen1fUBi6keZaKb+_g@mail.gmail.com>
Subject: Re: data loss when doing ls-remote and piped to command
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>,
        Tobias Ulmer <tu@emlix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 11:59 PM Rolf Eike Beer <eb@emlix.com> wrote:
>
> When I run the whole thing with strace I can't see the effect, which isn't
> really surprising. But there is a difference between the cases where I run
> with redirection "2>&1":
>
> ioctl(2, TCGETS, 0x7ffd6f119b10)        = -1 ENOTTY (Inappropriate ioctl for device)

Ehh. That format of strace implies that you didn't use "strace -f"
(which would have the PID in it).

Although maybe you edited it out.

I think the error output would come from the other process (ssh, or
whatever process you use to run "git-upload-pack" on the other end).

I still strongly doubt it's about pipes - we've had changes to them,
but if they are broken we'd see a lot more breakage than some very
incidental use by git.

But I can easily see it being timing-dependent. And yes, sadly
'strace' can often end up hiding any timing issues because it
obviously slows down the target quite a bit.

Doing "strace -o tracefile -f" in a loop would be interesting if you
can reproduce it (and then stop when you reproduce it, so that the
final 'tracefile' is the one for the case that reproduced it).

            Linus
