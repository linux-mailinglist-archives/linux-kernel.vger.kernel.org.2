Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CF54243F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbhJFRXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFRXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:23:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83242C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 10:21:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f4so7493521edr.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zf0GDu47Yzju5hihM5KzzImrVAe/BDCIuU/sDOojTik=;
        b=lx/Kw0cFW+j/UR9z5BxYuuPMKm4IGT3+2GSY5P8Ycar4BSc99Vmgh+tritVrAbqHZV
         2ysVdsgmAcBwIA3G9az19hp0GSADLiRm8SsMXJ+nQopmhByRPs8W+H0MrXJMeNbNLtyB
         QeWpO6idxuEq+EPtbss9LT4QrhV6RIadomM1VnE7MVl1gaodiNL1U2pRqJGQABJN4I1s
         QJgAY7CHVfi67tIX1YC+JbAC+KebrCo4tcP8H4PHrlJJ7E0qUbTS1hjWdQ7fEqv0UdOP
         kd68BLAz4ibkDCHbdPlbVAiYnMSEm2+ayHGktlKBuXFjKaUOeCEKXAGb3jWSPJpeD/m4
         OwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zf0GDu47Yzju5hihM5KzzImrVAe/BDCIuU/sDOojTik=;
        b=zFfmSKFmagWIBNMfsTPouq9+h+qYvh46Gkxe69ryLlOwZoQA4+UDoEU5pg1k5q33MS
         A8uSBQ0A2LKdzE8kYcf4zm73S8XFj5Yu91eoN1kWjTGnPMmGRXhEecFDwqYjalOQxhd/
         DyUpX2lxt5ppuW9HCo4DVtY/Mla0Mnoj7M84acjvKD7t90wlcappXafEvzjwNYQ5ap9U
         cbfrpZWydqwU6vU2MBM1erqR830o8VHRISsGYjSfIcs2KhLYhb71UMBpH2MUzqRaw8nv
         nh+8jf1JEZXIahHUWWeHyD5faKpwxjFzY1Fq+W0yds51+R3A0Xwszy45BJe7cXqsRJp5
         Conw==
X-Gm-Message-State: AOAM531TBNIrejgVISKR0eOe6coXetx7ENR44OKvR713GyuSfVqVJA0C
        ZxU36LZDb7Tt+23/FPmU4j68755ziCMxqFT4fWI=
X-Google-Smtp-Source: ABdhPJwSCgZPxAWtHp+De7FxfRYpZ0D/pJg2sBTp8/KWM0NcXeFmgFcjBYvMULeP8eBDQwNkaFZ1cezotHEaO5aqsv8=
X-Received: by 2002:a05:6402:358a:: with SMTP id y10mr34846711edc.238.1633540902830;
 Wed, 06 Oct 2021 10:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211006150451.16561-1-andriy.shevchenko@linux.intel.com>
 <20211006150451.16561-3-andriy.shevchenko@linux.intel.com>
 <2d190513-7ac4-731c-7c9a-1f60a98f6345@linux.intel.com> <YV3NZnb6mg43nUC1@smile.fi.intel.com>
 <015e084e-70ed-7b5c-b103-8426ef0842d4@linux.intel.com> <999a1046-864e-2b47-6f44-6e8e42528b18@redhat.com>
In-Reply-To: <999a1046-864e-2b47-6f44-6e8e42528b18@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Oct 2021 20:21:06 +0300
Message-ID: <CAHp75VfYZgXb-h-smW5hMGSkw5RBmv6mTYnoszhY+0Zqqk6z-Q@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] ASoC: Intel: bytcr_rt5651: use devm_clk_get_optional()
 for mclk
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 8:12 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 10/6/21 6:37 PM, Pierre-Louis Bossart wrote:
> > On 10/6/21 11:23 AM, Andy Shevchenko wrote:
> >> On Wed, Oct 06, 2021 at 10:51:52AM -0500, Pierre-Louis Bossart wrote:
> >>> On 10/6/21 10:04 AM, Andy Shevchenko wrote:

...

> >>> I don't get why you removed the test on the BYT_RT5651_MCLK_EN quirk,
> >>> see below it was designed as a fall-back mode. We don't want to return
> >>> an error when we know the clock is not present/desired.
> >>
> >> Why should we do a unneeded test? When we switch to the optional, there
> >> will be no error from these CCF APIs. Besides that it drops indentation
> >> level and makes code neat.
> >
> > By looking at this code only one cannot really visualize that it's a
> > no-op. I personally prefer to see explicit intent rather than have to
> > dig hundreds of lines below what this clock is optional.
> >
> > I am also not even sure that in real products this clock is actually
> > optional, the default is to make use of it:
> >
> > #define BYT_RT5651_DEFAULT_QUIRKS     (BYT_RT5651_MCLK_EN | \
> >
> > and the only platform without this clock is "Minnowboard Max B3" -
> > probably not used by anyone. I fried mine a long time ago.
> >
> > We'd need to Hans to comment on this since he's really the only one
> > maintaining this code.
>
> So as Mark wrote in his later reply:
>
> "AIUI with the clock API the idiomatic thing is that any optionality is
> handled at the point where the clock is acquired - if the clock is
> optional you end up with NULL which in the clock API is a dummy clock
> and ignored.  The rest of the code then doesn't need to worry about any
> of this stuff and the handling can only be in one place."
>
> Combined with there pretty much always actually being an mclk I believe
> that this patch from Andy results in a nice cleanup so I'm in favor with
> this. And the other cleanups also look sensible to me

Thanks!

> I would like to run a small smoke-test with both the series to make
> sure nothing regresses (should be fine but better safe then sorry).

Thanks ahead!

> Andy I believe that there is going to be a v2 to address a couple
> of nitpicks, right ?

Right.

> Note for testing I would prefer a full v2 series, even if some
> patches don't change. And I assume the same applies to Mark for
> applying this.
>
> Sending partial series with only changed patches on the v2
> send turns things into a puzzle, which is not ideal IMHO.

I'll do it tomorrow.


-- 
With Best Regards,
Andy Shevchenko
