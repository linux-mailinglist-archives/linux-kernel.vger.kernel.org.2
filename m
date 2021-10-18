Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE240430EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhJREej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:34:39 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56692
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229453AbhJREei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:34:38 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 723D540061
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 04:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634531545;
        bh=U/lrU9doQqwd1ysFTM7JHi6pcoTfn5h3DmiyMc5pktE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Z8qvok2JIn8qrfsneVeI//RHbP3KUpI3F9cC/8hA6aNFBrvhZWpXKhkYFQ6n1Y1dP
         cxheHktznMd0pStotod0v3cj/6JiEInjn8r2AJJaILmZzbm7KvB/BYKsnohUo1FeXU
         fApKYl2sFJqdZDG4d5mSWJ/tGLM1qf0b7lSVpUjWSYXLaQ0E75dNU487EzP2K2S9BJ
         bJPYXBl643GIiMw3AKaEatTVHg8VtzBfhjWx0lS16AbBZA1lt4PYI5OFAQ7nfa66nY
         YB8t1zUfOOc0Tj9F+1J1eEA2j27ZrOwv3kd2VapfER1QbYAMhuZqLtF9oxSeSNviBf
         93s4JdjlCazRw==
Received: by mail-oi1-f199.google.com with SMTP id w26-20020a056808019a00b00298e7b4523cso6683322oic.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 21:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/lrU9doQqwd1ysFTM7JHi6pcoTfn5h3DmiyMc5pktE=;
        b=eMNK/WD1TeO+YEMgy5BZsLtEL9v7cE+dx3dJfp4qldkPuMl2je9LtSVbPjsq5SiaHb
         uU0FJjc/ZgZ7Q+2xdzIIsbBeQccEEMTkPty6KzPA3eA2zpvKuhrwt183E6M4vg2bLL27
         sTMS5G4zziAkEbiRXroyxo5GyMTylBRehorZXt6pYLObrnWnQBqlqHUg2QfsU6TdZcX5
         845uCF2jqmU5C42A6Qvn90ITl863Ops7YTGsH5wHiOrHs1dGg1AyxlfsT5QtTPmqcMHP
         +hG+jocBr2nJKp1tVZda66evgLzGjeGfzehmRsjUKU308g+OeyGm0MjIxgrkqNMlB4tt
         CSHg==
X-Gm-Message-State: AOAM533pIJBT/tXbzHseSrQkgQm6H9hoVR1i0ycCkgkTv4Ra1apo7yoW
        YwRCHtX63sAUUkrprEmiK6iRQW3wNcIoizJ0jAX3up/kDHruEYU3GlvwEs0J//P+6NccPq56AKD
        WFV+kirmXZQPT1Xd3i4tWZ3ZGefx7Gs/mnVxAgPu6MPIE2thc7afJu/+RUQ==
X-Received: by 2002:a05:6808:11c9:: with SMTP id p9mr27660165oiv.169.1634531544236;
        Sun, 17 Oct 2021 21:32:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuwwDiJXobfmICV3J4V1DJfAAeQOnBhDnLKVgpTY/0U0gwOLHN8hw694iB0C7OGHwtxz5lB0GaTbOogGT67k4=
X-Received: by 2002:a05:6808:11c9:: with SMTP id p9mr27660146oiv.169.1634531543919;
 Sun, 17 Oct 2021 21:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211015133424.494463-1-chris.chiu@canonical.com> <c40282f6-cb8f-22ca-4a57-26fcbc39f423@linux.intel.com>
In-Reply-To: <c40282f6-cb8f-22ca-4a57-26fcbc39f423@linux.intel.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Mon, 18 Oct 2021 12:32:12 +0800
Message-ID: <CABTNMG0oef2AQywfzQ3iMfHWXxi6RDUL9VaQ_cYfbFp1JZqAWg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: sof_sdw: Initialize the sof_sdw_quirk with RT711_JD_NULL
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 11:08 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 10/15/21 8:34 AM, Chris Chiu wrote:
> > The jd_src of RT711 which is initialized in rt711/rt711_sdca_init
> > will be overridden by rt711/rt711_sdca_add_codec_device_props when
> > the sof_sdw_quirk is not RT711_JD_NULL. It will force the JD mode
> > to RT711_JD1 and cause confusion while debugging the JD mode of
> > the boards without quirk. Initialize sof_sdw_quirk with RT711_JD_NULL
> > to honor the jd_src value in rt711/rt711_sdca init.
>
> Not able to follow what the "confusion while debugging the JD mode of
> the boards without quirk" is. You need a DMI quirk or need to override
> the default quirk with the kernel module parameter.
>
The JD mode will be set by rt711/rt711_sdca_init first (which is JD2
as https://github.com/torvalds/linux/blob/master/sound/soc/codecs/rt711.c#L1209.
Then it will be overridden by rt711_add_codec_device_props() while doing
rt711_parse_dt(), which is now always JD1 since the current
sof_sdw_quirk init value.
I'm afraid that JD2 is a more preferable mode rather than JD1. Then we
will have to
maintain a bigger DMI quirk table for more and more coming alderlake machines.

Given the rt711 codec has initialized the jd_src to JD2, The
sof_sdw_quirk should only
override it unless necessary? But now it's forced to override. Or can
we have a more
generic solution for it?

Chris


> This also has the side effect of breaking ALL existing DMI quirks
> implicitly using JD1...
>
>
> > Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> > ---
> >  sound/soc/intel/boards/sof_sdw.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
> > index 6b06248a9327..d05c0565e09c 100644
> > --- a/sound/soc/intel/boards/sof_sdw.c
> > +++ b/sound/soc/intel/boards/sof_sdw.c
> > @@ -15,7 +15,7 @@
> >  #include "sof_sdw_common.h"
> >  #include "../../codecs/rt711.h"
> >
> > -unsigned long sof_sdw_quirk = RT711_JD1;
> > +unsigned long sof_sdw_quirk = RT711_JD_NULL;
> >  static int quirk_override = -1;
> >  module_param_named(quirk, quirk_override, int, 0444);
> >  MODULE_PARM_DESC(quirk, "Board-specific quirk override");
> >
