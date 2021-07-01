Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC6B3B8DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 08:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhGAG02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 02:26:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53305 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhGAG00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 02:26:26 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <jeremy.szu@canonical.com>)
        id 1lyq77-0005ke-KV
        for linux-kernel@vger.kernel.org; Thu, 01 Jul 2021 06:23:53 +0000
Received: by mail-wm1-f72.google.com with SMTP id d16-20020a1c73100000b02901f2d21e46efso1736945wmb.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 23:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXdKYyIu+S7k+FvmITaCyj+OTI3RbufpPTCFCWcfng8=;
        b=jygNpp3/xgdsOrOw6IfxRbU09G72FaEjSzvUPIwHKQLzj3sW5O0EXW6zj4h8kEpkyo
         wg7mJN10gMvlBP6QUbRmd2vOmdwz+cq5uAK4LbiA/HXWRD07EgrJBTthiA4qO3eJhOQg
         PUEz6v0MIoYQXohOfEYaPYmMQt9qq+IhjxBLxnID98FFPZvG4nh58pUrIP9NmWPR12Ql
         M1Ddr5xS5XPyWSN10n8y5zT7yCsaf1AqT9DCnbfrCPTolF15Sa5gKvrgfx0o9sjzVBnF
         LGiBydPZgTByg2Pb9/Pf/ETlzN2Z9r72141RKvcac5ztoTCJMMp4O8DgS87r4BiSRqqw
         0h0Q==
X-Gm-Message-State: AOAM533DijdjErSCcaaUuoIo6zFQj6F+v4DWLO6RiM+NSkwka5KAOLf1
        lEu0S3mdeLf1AkjHMCO6NvZATZ8kj7swFF2u3jFnJhiTXztTBFvYmZgplg48hlH8aoqTA0YJ0Zh
        v97NliklinVnZpx3/A6JpbNaFuR993SRTTbQFKDX9L4NoZ2GivIyj1/PIqw==
X-Received: by 2002:a1c:4b0c:: with SMTP id y12mr2084827wma.174.1625120633291;
        Wed, 30 Jun 2021 23:23:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydxPVG9884cPbugTvj5HsOfiiAP8uk2JUcCkaGU2OHeP1ojJI4hRolPvQMYtQl82uPsoROQs7X3ekGttLLimc=
X-Received: by 2002:a1c:4b0c:: with SMTP id y12mr2084800wma.174.1625120633043;
 Wed, 30 Jun 2021 23:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210625133414.26760-1-jeremy.szu@canonical.com> <s5h8s2xkiw8.wl-tiwai@suse.de>
In-Reply-To: <s5h8s2xkiw8.wl-tiwai@suse.de>
From:   Jeremy Szu <jeremy.szu@canonical.com>
Date:   Thu, 1 Jul 2021 14:23:42 +0800
Message-ID: <CAKzWQkzX-EdmY359W2D-vC-i+a-OH3-EQyEET6skAvbj6hwMfg@mail.gmail.com>
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

May I know where the tree containing this patch is?
I didn't see this patch in
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git.


On Sat, Jun 26, 2021 at 12:29 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 25 Jun 2021 15:34:13 +0200,
> Jeremy Szu wrote:
> >
> > The HP EliteBook 830 G8 Notebook PC using ALC285 codec which using 0x04 to
> > control mute LED and 0x01 to control micmute LED.
> > Therefore, add a quirk to make it works.
> >
> > Signed-off-by: Jeremy Szu <jeremy.szu@canonical.com>
>
> Thanks, applied.
>
>
> Takashi



-- 
Sincerely,
Jeremy Su
