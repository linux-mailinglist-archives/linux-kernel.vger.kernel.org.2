Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497F43BF0C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 22:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhGGUgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 16:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhGGUgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 16:36:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F83C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 13:33:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t3so5104159edt.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RksO08zxXShmv/TbRX/JnQALfaTc9XSb/QqN0uX0Y4c=;
        b=Y7teMaxBpvvKQ2gnp5u8kzquNml4aUTJpZl5jIW1lKNpT8ve4ZLtzc/vUNwsNvhqtp
         e0O3MvxbR+K7v8lrbKbXDJQjN+cz35SF8NgNYZLfyFCmlAgWsI44MSKyzjegkMwU+vte
         92HL+Ve+mX19cYQvEVbbBWmk4DELZB3xCkswltxfaTeOEyEu6ZespLqNGXkwgTDggNmr
         7Xu4l4KUl3MPnitEsBrOQ8uLWDQwKQIKN1CspgpX2TY4zpyZAT34emBtjii2hLQ5Pz2R
         FB5Bp/m+eDQRrAyXNb/mIBM+UdkhiidNSP6fwcIs9h27GGGPGHQaY8q43ABqQlje4KDt
         cMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RksO08zxXShmv/TbRX/JnQALfaTc9XSb/QqN0uX0Y4c=;
        b=hdvR+a3DUa5wFafcYzlYM2Gt0pzyX3S68ioVxsoh4LqE/g5vbyk/WCnMeT/7ypDmYL
         kmo1a1RqgL198cB7zfnIz4WpRKYZuJsWEN8mB+LMBUYNQtIvof+5lblZO5jLLrbxYNng
         gCRsdIcLICl61gSeVADaYEDqLJmAnb7X6xF5W3Lzzu3zkt1Jg+CQDeOMT61XGsek5z+8
         3WSezOxvOR5cR2LpkXT1UfXODc0PKpOFfWjGwQfnQkpS6oH+4g8iC/V2rHdWkJp3BHss
         vk4uywzaQH33cBr70m2iBMrYl1zhAy7VUO+/7sR1DqorpkVbE+FhS28fP7IAFtN8FqLZ
         Sktw==
X-Gm-Message-State: AOAM5331QKtI5vzcgWV/6p8Jnk9nEWQBqq1SOFaNsNIT6QGbNOm8Sc0n
        IKMy5UEgTfYZz1Aj4DJBvFbB/ZGAE4ruXz0VJZk=
X-Google-Smtp-Source: ABdhPJzL4aKhFnDbKJLykRHEyOt/2yk5mRO6vIgkimxjmW2858+h68zn4jLxxbwEIpTXiZisK01GMIBFtDZ8ByOBvSI=
X-Received: by 2002:a50:8fc3:: with SMTP id y61mr31809870edy.107.1625690013534;
 Wed, 07 Jul 2021 13:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <YJ4yBmIV6RJCo42U@google.com> <s5hk0o18tio.wl-tiwai@suse.de>
 <YJ5cHdv6MVmAKD3b@google.com> <YKDYQfDf7GiMfGCN@google.com>
 <YKDYbaprE3K2QpCe@google.com> <s5hbl9b6mah.wl-tiwai@suse.de>
 <CAMo8BfKKMQkcsbOQaeEjq_FsJhdK=fn598dvh7YOcZshUSOH=g@mail.gmail.com>
 <s5ho8be8v3z.wl-tiwai@suse.de> <CAMo8Bf+FF8Ofq=FwoZZXp9vKiMaUZNAm+W=OJmu2j2XN6kLb-Q@mail.gmail.com>
 <s5hk0m26lfu.wl-tiwai@suse.de>
In-Reply-To: <s5hk0m26lfu.wl-tiwai@suse.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 7 Jul 2021 13:33:22 -0700
Message-ID: <CAMo8BfLj+VLUbfUmHUSHOfc3PwbWd2w_xnaTZa9HyrcmvJCAkQ@mail.gmail.com>
Subject: Re: ALSA: intel8x0: div by zero in snd_intel8x0_update()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 11:14 AM Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 07 Jul 2021 19:50:07 +0200, Max Filippov wrote:
> > It didn't change anything in my case. My further observation is that
> > the snd_intel8x0_update is called before the ichdev->prepared
> > is set to one and as a result IRQ is apparently never cleared.
>
> So it's broken in anyway no matter whether
> intel8x0_measure_ac97_clock() is called or not, right?

The change that you suggested didn't eliminate the call to
intel8x0_measure_ac97_clock, it's still called and an interrupt
flood happens at the same place.

I've also tried the following change instead and it fixes my issue:

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 5b124c4ad572..13d1c9edea10 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -692,11 +692,14 @@ static inline void snd_intel8x0_update(struct
intel8x0 *chip, struct ichdev *ich
       int status, civ, i, step;
       int ack = 0;

-       if (!ichdev->prepared || ichdev->suspended)
-               return;
-
       spin_lock_irqsave(&chip->reg_lock, flags);
       status = igetbyte(chip, port + ichdev->roff_sr);
+       if (!ichdev->prepared || ichdev->suspended) {
+               spin_unlock_irqrestore(&chip->reg_lock, flags);
+               iputbyte(chip, port + ichdev->roff_sr,
+                        status & (ICH_FIFOE | ICH_BCIS | ICH_LVBCI));
+               return;
+       }
       civ = igetbyte(chip, port + ICH_REG_OFF_CIV);
       if (!(status & ICH_BCIS)) {
               step = 0;


> I'm afraid that something is wrong in VM, then.  The driver has been
> working over decades on thousands of real different boards.
>
> Skipping the clock measurement on VM would be still useful,
> independent from your problem, though.

-- 
Thanks.
-- Max
