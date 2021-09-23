Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449A7416473
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbhIWRbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242597AbhIWRbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:31:01 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97690C061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:29:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z24so29610804lfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQuTJey0iMtFxxij1vWY7f+IsNf90JqLBU1/x3EQ76g=;
        b=dd7OfGhC56pTTDuQth+ikUEBmfb6QqKkOcSH2YKjdZCzAmJ4R0z070ECo7ON9fy2dh
         hmHfzta9/fcjr7K0XwOLjpmNW/HWCXRI0ipXrA2Zf/JToqKC6R3uVeNvFoZlGMismyE8
         0S2o3rpDlSx4lFlbDpKhSwrIDEsQ2vNz2j6ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQuTJey0iMtFxxij1vWY7f+IsNf90JqLBU1/x3EQ76g=;
        b=5m7HId/glxS2oDf8ksbvRxZh5Ja+icMOL0PE260mE0YEztlvkjwkVkh58OpCI+A7f4
         mnSLA4lolPQDyA2F+Zfyrl+PXXSyhVFnHnv4tfnjaOH99wA1FSAuRZbek3HSfod03sAD
         yvkfBpDdp+4krYt0dP+WBC8y40huttmvgibeWNFPk1LmVajIj6aBS0pav9fs3ctbHQ4K
         m8a7GatuaRWs8sRil7AgdIBsQtMSzpntEZQ48OyLL4oIYAjGSma3bSDkeaTbx0+MCjpL
         ktxk+ZRNHg13DGKXQkIjsgQQjsUfmZ8/hEETipMxOvHdweytmeYB4rh5K8SI0QonGJsQ
         wFwA==
X-Gm-Message-State: AOAM532HtvET64lBKc1leYjOkpM/v7H/TqZ98Mo4Wuz50qJdaR1UOw8x
        599I7/5MWIJqGrCpS0zdnH9VcH51BrNh8c4nS7k=
X-Google-Smtp-Source: ABdhPJxyTk2PRI61CUm8W11GHMzzavx6A/Tl1gJ3sXqnj9uflXStW10n55I528wtDaB2WsOIg/HqVQ==
X-Received: by 2002:a19:c1c3:: with SMTP id r186mr5327163lff.400.1632418167213;
        Thu, 23 Sep 2021 10:29:27 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id b4sm510994lfo.238.2021.09.23.10.29.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 10:29:25 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a26so681189ljp.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:29:25 -0700 (PDT)
X-Received: by 2002:a2e:5815:: with SMTP id m21mr6222470ljb.95.1632418165461;
 Thu, 23 Sep 2021 10:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
 <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com>
 <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
 <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com>
 <CAHC9VhSZp1-Qi7ApoQHauaFXDgoNaFTwFEieEFFuBtdPqAtXQg@mail.gmail.com>
 <CAHk-=whoExoB6xGD0as0kpfwr38B=W7GRkO2NXWDRW-tmQS6Qw@mail.gmail.com>
 <CAHC9VhTtz_aNY6MOCM6ypbz+SHvS30hx42PWjXJhG1Z=t5jpBw@mail.gmail.com>
 <CAHk-=wivxthY49NPyPG0QG302dmH_hrioE7NdDKMR1Fus0GHow@mail.gmail.com> <CAHC9VhSgG9wRJk9pyUnz90Th8MLfJ9LAMsFKyFMZMjK097+ZXw@mail.gmail.com>
In-Reply-To: <CAHC9VhSgG9wRJk9pyUnz90Th8MLfJ9LAMsFKyFMZMjK097+ZXw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Sep 2021 10:29:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj09_XNBKQZ-735yum5h1xT9i2AgC793HjChBnwoWJ+jQ@mail.gmail.com>
Message-ID: <CAHk-=wj09_XNBKQZ-735yum5h1xT9i2AgC793HjChBnwoWJ+jQ@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 10:13 AM Paul Moore <paul@paul-moore.com> wrote:
>
> It's become clear you *really* don't like passing the cred pointer
> here, presumably based on a very specific security model for lockdown.

Not just that. I'm sensitive about the cred pointer because of the
timing, but I'm also sensitive about just looking at code and saying
"that makes no sense".

Having callers do pointless things that make no sense to the callers
is a bad thing. Having a patch where 59 out of 63 callers just
mindlessly pass in "current_cred()", and then remaining three callers
pass in NULL for NO DISCERNIBLE REASON is a sign of just a bad
interface.

And I realize that to you, these interfaces are what you do.

To everybody else, it's completely mindless noise that makes no sense
at all, because there's no _logic_ to it. It's random LSM calls in
random contexts that have no clear reason for them, because the
"reason" is hidden in some odd SELinux rule that no kernel developer
even knows about.

You can't even grep for the use of it, because there is none. It's
literally randomness. Which means that it _has_ to make conceptual
sense to be at all maintainable.

So when I see a diffstat where basically 90% of the patch has
ABSOLUTELY NOTHING to do with SElinux or anything you maintain, and
that 90% makes absolutely no sense to begin with, guess what? I think
that patch is bad.

When I then look closer, and see that the _reason_ for the patch is
that SElinux - yet again - incorrectly accessed process credentials in
random contexts, I just do "this is not just a bad patch, this is
actually a fundamental problem with SELinux".

See where I'm coming from? The "specific security model for lockdown"
is just the high-level view of what made sense. You violated that view
for bad reasons, with a bad patch, and with bad timing.

This isn't _just_ a SElinux problem. I think it's a LSM problem in
general. Lots of those random callbacks are completely
incomprehensible, have odd rules, and the LSM people aren't even
trying to have them make sense.

As long as the oddity is contained, that's one thing. But when it is
made this obvious and affects random code in strange places in the
kernel, and it's for a feature that had a lot of discussion even when
it got merged, I'm putting my foot down.

             Linus
