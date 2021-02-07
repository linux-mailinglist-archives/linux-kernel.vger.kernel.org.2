Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB333126A0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 19:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBGSRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 13:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBGSQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 13:16:49 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A933BC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 10:16:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f1so18850069lfu.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 10:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qFbuzE573qtLwGbwQtkZ6BG15gTWn988HYyGWV0H+M=;
        b=Jn3uEURrvOTi/Do+ChQ3nM2c1iuGRQ96ZRAI3i5YWLWspGQfqE/8CkX/vjfSMuUBPn
         jnSW+6x/O9dAOrf0H/jS8pZxLtzXNnVqmRNv4+Ck2wa6znIrxkAFoGX01S6MJ+kYbloS
         tv5HBdE4veDLJJRX+rki4Iykcude6SUVmNO24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qFbuzE573qtLwGbwQtkZ6BG15gTWn988HYyGWV0H+M=;
        b=symyV7x38k9lQt9qhwfTvxp1mp6nUlq5xGGmE4U3Hax7AXF7PeOfKOoGk/PVvnBjJG
         pbB7Ik3+zkunOj+EEhhfFgBFJzlxeoI11iC1PakNbunUp3r+0jOvwXJ+2oHwoMNO41WI
         eRWo5QCH0UMBuNlk/j3mLYk/oOZwcc8ALCc/H1rA/ASgwFRJAayhrGAU0NXyd6xxy5kq
         8q6K9xyY3fAd6qClafIsy5OkrlNPXWk1T6MXRERKdx6DaplGrFKR8Bs4+OxQYCFvSyKp
         EKOvZZOW4uTQAi769/ha7U4jmXhrM4YIrU5UpizAV21y/1C5RX3KmVHzSaqVGP4SlHfK
         GkXw==
X-Gm-Message-State: AOAM532MZWAFIKnHYjncwqJy9R7hdn9WcEA6FTaE0QzdmgD+VRf/w51i
        mrseFjUufx1K7hUDNfOSrJtcDwHMwXkD6w==
X-Google-Smtp-Source: ABdhPJxxKDjcQkacftYqTWVGlJ/ra++kFX+TDT88iKMGkAtFvvHfoK/l/+spwPI94Zu6ohlSkxKBXw==
X-Received: by 2002:a19:234f:: with SMTP id j76mr7906931lfj.399.1612721766858;
        Sun, 07 Feb 2021 10:16:06 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id b18sm1806035lfj.140.2021.02.07.10.16.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 10:16:05 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id u4so14050578ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 10:16:05 -0800 (PST)
X-Received: by 2002:a2e:b70b:: with SMTP id j11mr8332999ljo.61.1612721765390;
 Sun, 07 Feb 2021 10:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20210207104022.GA32127@zn.tnic> <CAHk-=widXSyJ8W3vRrqO-zNP12A+odxg2J2_-oOUskz33wtfqA@mail.gmail.com>
 <20210207175814.GF32127@zn.tnic>
In-Reply-To: <20210207175814.GF32127@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Feb 2021 10:15:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5z9S7x94SKYNj6qSHBqz+OD76GW=MDzo-KN2Fzm-V4Q@mail.gmail.com>
Message-ID: <CAHk-=wi5z9S7x94SKYNj6qSHBqz+OD76GW=MDzo-KN2Fzm-V4Q@mail.gmail.com>
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc7
To:     Borislav Petkov <bp@suse.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 9:58 AM Borislav Petkov <bp@suse.de> wrote:
>
> It probably is an item on some Intel manager's to-enable list. So far,
> the CET enablement concentrates only on userspace but dhansen might know
> more about future plans. CCed.

I think the new Ryzen 5000 series also supports CET, but I don't have
any machines to check.

Hopefully somebody ends up with hardware that supports it and a urge
to try to make it work in kernel land too.

I do suspect involved people should start thinking about how they want
to deal with functions starting with

        endbr64
        call __fentry__

instead of the call being at the very top of the function.

I _assume_ it's mostly tracing, bpf and objtool that are going to
notice, and it's going to be largely invisible to anybody else.

So hopefully the involved people can at least just try to see how
their code looks when they turn off retpoline and add

  -fcf-protection=full

to the compiler command line (assuming they have a gcc that can do
it), even if they can't actually test the end result on hardware.

            Linus
