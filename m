Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBA33F15D6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhHSJK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhHSJK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:10:57 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A7AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:10:21 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id y3so5247352ilm.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZ3CToCG3juWBo4uXSiPR3dQNTGtjH08RmsNnVvcEdM=;
        b=GlsyqZ60mR4Jb195DNR0iUo8ZVyc+xbfTqPuxCN8jKL0SocJ2mcD3cEczU0+RNSVtp
         /2POP99Dyqv45MqZLx95Xm8RJm1+kHsIieRWMHgUQip3hTYqMKIeMjHT0+j5OKRwDP5K
         5RYLzwpIOOWETVntPXHk0mVF+IYSKgVo1u2Z/V9bHzw55Y6MFaAcxSM1Yu7mByszsxyq
         Z8PRnt2BAMZ7bZtluCP32IK0MihUm8b4GhWUVNaat0EOndartBjt579la/MfngAgrkEt
         TN/6H1dj2Vfh/BePaSQflMl7fZ3XLbm1fQMyIiYO7XTonjoX7/72D7znc95GWzf08TlC
         M02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZ3CToCG3juWBo4uXSiPR3dQNTGtjH08RmsNnVvcEdM=;
        b=MZhpOem7OUmEhgwf/P4amwHFyYjRCPm5vM9/Q67L2M4Gh8iY7QczRUuwNywwbSUjri
         ay+pHGE3dAKNQiMglILkkBSzrxvGO1VT5sKQTYHiKRi1wqs/7iJMrOpbbcR5FozBSyMq
         UCHw9qNt13RL8wCsPGQhLvnuHE4sVr+JdBIcv8X30ShtcDl3xAnZJ9DcriKGuXk5zYL3
         a6Wjit19XM6uKNx9Ec9mdUJLcZt5l1v6DkBmpwosGYryUx4nMUrxOICCCxm7GiMrfktr
         TizKo4RbAmAnZYFKr5xzShFiZp9aYBNbijTWQZ4PMqIxWj47nEgNl2s0nYwdHlbkKnZN
         Hbvw==
X-Gm-Message-State: AOAM532lbMg7kSBgrPygSrU2Qrk/MyKG/0C+cE/dAHXP9/v+UEag1mTj
        5kd6W8/7N3GK0glV3SnmGKv3/Ddq2G7MTQ7KZt4=
X-Google-Smtp-Source: ABdhPJzWrgxLb164lORkiiVfIZ8tsSObzJ0sWkzhyZvsCUTgz2Qg7BH9GY8iQrX1/DlFXdoSgu6ZeOF45h/oPFgnEsQ=
X-Received: by 2002:a92:6802:: with SMTP id d2mr8918753ilc.40.1629364220674;
 Thu, 19 Aug 2021 02:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMLyx+CvBQbLz-xQvwLS692tx-4xOgU7b-V2J676D29yg@mail.gmail.com>
 <d983217b-e117-361c-0306-b131695bb93f@denx.de> <CAKmqyKOsUcta1cXxamJZnf01G9beCZrDKia068HR+J0AadgNiA@mail.gmail.com>
 <bff9ba97-bc26-f091-ba71-5e639af524d4@denx.de> <CAKmqyKPF3T_Sx+hL=4OSamLdjy=0fwmrTrVeb-GY0Ja9M=mi+Q@mail.gmail.com>
 <ab2b7f4f-3e36-461c-6a6c-02ee7ed6cb99@denx.de> <CAKmqyKN8devNyDvVL5B_dDASU3se1dSui0bsnf6gQ+CkZ_TaKg@mail.gmail.com>
 <YR1Th65KKRS4D/6+@ravnborg.org>
In-Reply-To: <YR1Th65KKRS4D/6+@ravnborg.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 19 Aug 2021 19:10:00 +1000
Message-ID: <CAKmqyKOBYXiWwO4QJBJ9sEO5ay5QyYmO=yzvT31evB7BKeniYw@mail.gmail.com>
Subject: Re: Revert "video: fbdev: mxsfb: Remove driver"
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, b.zolnierkie@samsung.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 4:38 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Alistair,
>
> >
> > These are the EINVAL strace tells me in the not working case:
> >
> > prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > ioctl(5, FBIOPUT_VSCREENINFO, 0x4ce8e0) = -1 EINVAL (Invalid argument)
> >
> > I'm guessing it's related to FBIOPUT_VSCREENINFO then, is that
> > something that could be added to the DRM emulation?
>
> If it turns out FBIOPUT_VSCREENINFO is the culprint it would also be
> good to know why we see EINVAL.
> One way is to sprinkle a number of printk's in fb_set_var(),
> then you can see how far you get before it fails.

Thanks for the help.

I see this line:

ret = info->fbops->fb_check_var(var, info);

in fb_set_var()

returning early.

Alistair

>
> This could hopefully give a clue why this fails with fbdev emulation.
>
>         Sam
