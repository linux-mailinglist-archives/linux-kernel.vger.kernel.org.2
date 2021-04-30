Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34F73703C2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 00:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhD3WyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 18:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhD3WyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 18:54:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5167C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:53:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j10so19296673lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BTgt2rKyo5EHlL4H+FuDoTYjHpqVyUW/BzNOzPQCHM=;
        b=II0RkhMkk8xNobNV4veFb/WsfB9VX4ZY9XWsjhCjMyfKtBl4EX/nT1LOk5O8Wqjc8Y
         RNnxXNucaUDHr3yrtRUSzmTCKAyIqm3DzMtuemPTIxEMTk0DAT5qrV+5HI8EoyOrIxfp
         klKmQfQbyhSdVO9P44IhRZNOgz0BON76ogg2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BTgt2rKyo5EHlL4H+FuDoTYjHpqVyUW/BzNOzPQCHM=;
        b=DOOFa2uC6nOJf7sGBdpoXUZvL9vpfGzTE9DAYsBCXXkhL4R9pyN8LLbp4NeEGyN0Zo
         yiOj6OOjqRgo08bmVGPliqVQ+F99lsxs+E8WSmlSV+u9k/0vEoeL5PKR/JgneI6mM1hH
         O+Ah9485W/AG3tAOOa3JN5EuKQSirryhma7/qxudjj1C9FtT/4Fe+1MehFBl5nw58SEP
         4sdg9+3uW7ckKCzsARUjjg1PMG+AWz4U8VL/wyPflZAUZKRCjq9dmOXXReqjQI10SiMM
         CfsKY7prhkqLjAT/mdjJYbu96PNveE2Y+SkB7G1u2pQgua0WNTNtRrP7r0jQcFMJHxJx
         +JpQ==
X-Gm-Message-State: AOAM533LteLiS3OzrSq+eb7AnqL3cImcC5VMvexPD1OivMg4sQ7/IF7C
        LPKV6onUzLyZbO54djL81R5Zlw98EnSLKCJ6
X-Google-Smtp-Source: ABdhPJxldBw2jMTjFxo5I0QOCXZUEPk0NrNT7vFr7ucrc4jEZGTGJ7G7HKBKbYwYor5d9dLSQ7VjrA==
X-Received: by 2002:a19:f706:: with SMTP id z6mr771098lfe.24.1619823189529;
        Fri, 30 Apr 2021 15:53:09 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id q24sm138893lfc.261.2021.04.30.15.53.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 15:53:08 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id v6so87562ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 15:53:08 -0700 (PDT)
X-Received: by 2002:a05:651c:44f:: with SMTP id g15mr5186411ljg.48.1619823188419;
 Fri, 30 Apr 2021 15:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <75d07691-1e4f-741f-9852-38c0b4f520bc@synopsys.com>
 <CAHk-=wjJEgjCYzHZFPxTs01p7FMEHKKqXyqwRVBk6KnvHB1qVA@mail.gmail.com> <9538bb7e-a600-2211-6b4d-561b99f1deca@synopsys.com>
In-Reply-To: <9538bb7e-a600-2211-6b4d-561b99f1deca@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Apr 2021 15:52:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizZ-HoBJ24TPFawS5zHqT+HcreqfmFRf3Cw4SS0NxV+Q@mail.gmail.com>
Message-ID: <CAHk-=wizZ-HoBJ24TPFawS5zHqT+HcreqfmFRf3Cw4SS0NxV+Q@mail.gmail.com>
Subject: Re: Heads up: gcc miscompiling initramfs zlib decompression code at -O3
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jann Horn <jannh@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 3:44 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> I agree that -O2 is default, but we've had -O3 default for ARC kernel
> forever, since last decade seriously. The reason I turned it on back
> then was upside of 10% performance improvement on select LMBench numbers
> on hardware at the time which for a rookie kernel hacker was yay momemt.
> I can revisit this and see if that is still true.

It would be interesting if you can actually show 10% improvement, and
also pinpoint things in the profile.

I (long long long ago) actually used -O6 for kernel builds as a "give
me everything you have" (I don't think gcc has actually ever done
anything more than O3, but whatever).

In fact, you can find

   Q: What Does gcc -O6 Do?

in some kernel FAQ's from those historical times.

We eventually gave up on it, because it just generated bigger and
slower code, and people got very tired of all the compiler bugs.

               Linus
