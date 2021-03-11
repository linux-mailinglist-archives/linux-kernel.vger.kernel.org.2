Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADE933755E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhCKOWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhCKOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:22:38 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA70DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:22:38 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b23so5931602pfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLqQcnDH1akf38GK334hmF8byJw++p7ERD3Z2/VDPnQ=;
        b=mxhVOKT2VWzkxmCpBe2dT8rUTOb88Ej7btjUrt5PmPVqlqtYbqOvLjaspRQrNOa/ck
         4SxjrGrh9eAJH24KIUDF/72R1gcHMpTWuiSUbvswBWLjhWfSsGlmMqU9eICuy8JUXeSo
         2XMsVvOSEGuAFpY6i62Mwwq/R43xdFBo+H1HDHFzT66HCUshtQXoVlz0X/3H52W0IM9V
         tZPBBeHiM/Oof9KU+ThIXzhajgNkFA/F15nI/jQfV7b8Q05B3Rk1Huzo3jSX1gk/KjMb
         x6xQgzSIiSmFxPB/CL7tLopItwIMsOQLT2GvCkuN8pC8CghVJ4s5bsGBZE6QauZhb+H8
         Ugmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLqQcnDH1akf38GK334hmF8byJw++p7ERD3Z2/VDPnQ=;
        b=sUDqFCcvPwlfTavZ4c2b1tsNEe43ch6pWUtx897dWkZYcj9XK118s3fpcfgQar1kmZ
         Yn4sDA6+mc32POgBw9Ee4L6gaV2RNKG41Pe0TIhsAsjbSzmlMivd5xdgtddaTFCRgFKl
         JDZDV3rdavudjhDwlgZf+il3U0No9fvutFaQFLGDDokO6AtWPKeK44wnCyG+JobXu6ba
         hchGIYFPwdVLo4r6Cn2fwYztWOeZPf01qctXrzfCv2SC3Gwt5gD+g5W3LgVxpVe6waxe
         gDG53sC3GPsiTBQoxREtBRpNmSQU7l+SowH4nxaWkd1fTn0Njbg67WWiaPvUUeRwMC8z
         fQMw==
X-Gm-Message-State: AOAM533lU+bS7Me/BfBSjoRbU77tqBXUXVvSX0Oku3past9M9hHHkd5F
        X9ez5NcPvHrorTfe8khUTZtTeg+dpAYuzkidNHRrOmK0NUWhtg==
X-Google-Smtp-Source: ABdhPJycnJHvxkB6UZq2S7x+dELiZlYITg3gO5H8Q2Lg3iKscF1jDafh5JFqalIX0bVHWFTFghBPHE37jvyYjqPTGww=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr7804061pfb.7.1615472558336; Thu, 11
 Mar 2021 06:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20210311132741.80989-1-andriy.shevchenko@linux.intel.com> <s5hpn05vmhm.wl-tiwai@suse.de>
In-Reply-To: <s5hpn05vmhm.wl-tiwai@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Mar 2021 16:22:22 +0200
Message-ID: <CAHp75VfdsOMpskK0xq7tAo1DJ21MPMxmFb1st--0vHJ6C+Nb6Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ALSA: hda/realtek: Sort alphanumerically the
 SND_PCI_QUIRK() entries.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 3:40 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 11 Mar 2021 14:27:41 +0100,
> Andy Shevchenko wrote:
> >
> > Sort alphanumerically the SND_PCI_QUIRK() entries for better maintenance.
> > No functional change implied.
>
> I'd love to apply this kind of cleanups (and I do sometimes
> partially), but practically seen, this may make the stable backporting
> significantly harder because many quirk patches are backported to the
> very old LTS kernels.  So, unless any specific reason (e.g. some
> entries doubled or wrongly applied) is given, I'd avoid this full
> plastic surgery.

Btw, can we apply the hunks that are against the lines under #if 0?
At least it will reduce the chaos rate in the file w/o worrying that
people will add entries there to backport.

-- 
With Best Regards,
Andy Shevchenko
