Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCB23374D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhCKOB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhCKOBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:01:14 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D660C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:01:14 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id j6so10236459plx.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJF95wh7Vf1iAu9VFx4eXo/tjVyufB4h+2uhaVD9LE8=;
        b=EUqHqJRcYFF9PqkBg9cKdXfdahh8QTsY8St9qL7peDpXwxY2mvvuSvCVEtsO1QPCfG
         pztIhwh3ZUcsaaaa0Ts9d1RTaGcSkLRCfP35DzGfGUTUbeEARwh5y8MMQm80rhHZtnBk
         jiZZPQgR5eALIyYAlwI6lDe+kzVAKiWr8OatF/y9ZzTbRbETiyzKvplnd3IHhgSkDKeM
         b1X+kaNKneczbbfJoPEVq1Zdh6Oq0bB+2byPtG6x8dQiiCWtnQETrpFIPwd2bn5m2hM+
         /sTWfnyHeg+8Ir01nhgSbF+RZMS73L3qZI78xd7H6IpY8omiDwjX4C4qNmskYEYPXMig
         ChFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJF95wh7Vf1iAu9VFx4eXo/tjVyufB4h+2uhaVD9LE8=;
        b=Xla9icgbevPmX04gIkjSW2eC8LcYXtLd3BGpnPMr4qYtXsGXFgtsx3pcYCJp1DrHXy
         dezQM/O54CiSkVr9YPiC1z/FIrqOjWrH9OGw0xIZSPK9uuEb51zhzGu/vrTbDgwRFv78
         qg0vcXthQRZSstiXgOgG6XpIqOC6ucgHJOS47Wb/AWArNnn8Xquihra3GAwIT1jxSbqj
         9chhZL7vj9gwBhvfKxLDKePKStbmOz21WSitFOZ7gCkO/Wp2DE2uu7iZy4GZctqiWI9k
         Dk5+zlYnOHv4ez1xy4RjLXSWiqAsZA0ibaVRSYua0lrzeJN7tN4EmhrBW8Axgewefxcw
         WZQw==
X-Gm-Message-State: AOAM531ZXAOEaSJvLIKvOEBhx56ygAIKkaC/pZh8WSw7fkhvEKE0dihz
        yRHouRrofSM7bcZCMH78+1WlbCHFHovNjXpYUD4=
X-Google-Smtp-Source: ABdhPJxZjrZHaMw8TojuQopQn/Ngqmtn7yVuKwSmGnaHZAqHscmhqJ2iTgbYrq/3wgwhtdxCCsumdDjRuVo/maTZpFk=
X-Received: by 2002:a17:902:ee02:b029:e6:5397:d79c with SMTP id
 z2-20020a170902ee02b02900e65397d79cmr8139769plb.21.1615471273960; Thu, 11 Mar
 2021 06:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20210311132748.81071-1-andriy.shevchenko@linux.intel.com> <s5hr1klvmp3.wl-tiwai@suse.de>
In-Reply-To: <s5hr1klvmp3.wl-tiwai@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Mar 2021 16:00:57 +0200
Message-ID: <CAHp75VcjwzPOrxVhou-0i4-87X3VGAY6NqVaS=kdy3mPMOUtvQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ALSA: hda/realtek: Sort alphanumerically the
 HDA_CODEC_ENTRY() entries.
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 3:36 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 11 Mar 2021 14:27:48 +0100,
> Andy Shevchenko wrote:
> >
> > Sort alphanumerically the HDA_CODEC_ENTRY() entries for better maintenance.
> > No functional change implied.
> >
> > Note, that HDA_CODEC_REV_ENTRY() goes after HDA_CODEC_ENTRY() as per
> > default value in the latter macro.
>
> This breaks the matching rule.  Please put the HDA_CODEC_REV_ENTRY()
> before the HDA_CODEC_ENTRY().

Oh, indeed. What I was thinking about... :-)
Thanks!

-- 
With Best Regards,
Andy Shevchenko
