Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B543B8DC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 08:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhGAGhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 02:37:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53435 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbhGAGhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:37:22 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <jeremy.szu@canonical.com>)
        id 1lyqHj-0006KP-M9
        for linux-kernel@vger.kernel.org; Thu, 01 Jul 2021 06:34:51 +0000
Received: by mail-wm1-f71.google.com with SMTP id m186-20020a1c26c30000b02901e1c85168f1so990851wmm.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 23:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqHVyg8UF47Dyl4T8QTNzcygmIy+wqtlN3mxo+BDvCc=;
        b=Y+B8MpBZeSDWt15ntQjQw7nfEcgf9hdVjTDRo4vgHTewAkeiX3TNIFZMvdXzuzuUNp
         Ayt/vPfsjIlmxCVz3pbBM6XUD+Wr7s1g1B0dfrQBXIwN3JwPWkT+I+YWnqzuiQlbbtGk
         Olwb6bV6tvutuZYnNm79mAXsEwJcOHKfRtUY2TtnhXOj6QRV/H9DhPggZXiOBKIc2stX
         btFZTAQbc4b+J3Vm33lYSMJDGYuQ1X94rcDn7E9rcQJODy29XwgsnNzpazhVO+aMNWyZ
         /3iddFY04ChLtnw4Pr/E49xZvVbLHaS+rN2/f+J6XbDH6Lya0ICoeu2rPPUjgF3HQPzr
         vrpA==
X-Gm-Message-State: AOAM530AXtA9O48Igg7VJHsyM1uMv4kLp2qrZu2jGYXICVpc+X0AcKxX
        g2mNy0+Z5JxkxNJlKoFnH48U4QQu0EWfiBs8cyVeXu2M7SkKQQykuT21x0eaMeCwe8+AfzaI7hg
        4AeSgwXTLiNTQlSsM4wIx1anQeeFceqTiqMb3mbjjwRp56hBY2glWUzZmzg==
X-Received: by 2002:adf:c843:: with SMTP id e3mr44289713wrh.25.1625121291406;
        Wed, 30 Jun 2021 23:34:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI8IIXy6IxZd/acqBJCs8s2mL7QQB52remKdG39KcvNIhtkgzaKm//Xacru3uhJfwwiWY07xQwEU5S/uRqSNI=
X-Received: by 2002:adf:c843:: with SMTP id e3mr44289692wrh.25.1625121291214;
 Wed, 30 Jun 2021 23:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210625133414.26760-1-jeremy.szu@canonical.com>
 <s5h8s2xkiw8.wl-tiwai@suse.de> <CAKzWQkzX-EdmY359W2D-vC-i+a-OH3-EQyEET6skAvbj6hwMfg@mail.gmail.com>
 <s5hsg0yilw9.wl-tiwai@suse.de>
In-Reply-To: <s5hsg0yilw9.wl-tiwai@suse.de>
From:   Jeremy Szu <jeremy.szu@canonical.com>
Date:   Thu, 1 Jul 2021 14:34:40 +0800
Message-ID: <CAKzWQkzbjT_XqpKZzFAKgUmrgp7-FHx18anxxLXm6i+bNcp1bQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook
 830 G8 Notebook PC
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Chris Chiu <chris.chiu@canonical.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sami Loone <sami@loone.fi>,
        Werner Sembach <wse@tuxedocomputers.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

No problem, many thanks!

On Thu, Jul 1, 2021 at 2:33 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 01 Jul 2021 08:23:42 +0200,
> Jeremy Szu wrote:
> >
> > Hi Takashi,
> >
> > May I know where the tree containing this patch is?
> > I didn't see this patch in
> > git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git.
>
> My bad, I forgot to push out the tree before entering my vacation.
> Now it's out.
>
>
> Takashi
>
> >
> >
> > On Sat, Jun 26, 2021 at 12:29 AM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Fri, 25 Jun 2021 15:34:13 +0200,
> > > Jeremy Szu wrote:
> > > >
> > > > The HP EliteBook 830 G8 Notebook PC using ALC285 codec which using 0x04 to
> > > > control mute LED and 0x01 to control micmute LED.
> > > > Therefore, add a quirk to make it works.
> > > >
> > > > Signed-off-by: Jeremy Szu <jeremy.szu@canonical.com>
> > >
> > > Thanks, applied.
> > >
> > >
> > > Takashi
> >
> >
> >
> > --
> > Sincerely,
> > Jeremy Su
> >



-- 
Sincerely,
Jeremy Su
