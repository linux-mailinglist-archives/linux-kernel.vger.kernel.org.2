Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACAF454ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbhKQQWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbhKQQVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:21:53 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA1C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:18:54 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b1so10893020lfs.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hjfveKxN4psxRyRP8zJoBweMn3Lw5e9A8i8e9HabaRs=;
        b=cXjpncGlEQy9G8NpNYHDYVtOJkGz521GTmJVE57ZM0X2szXjsRlzDZEsZ+m1aXdvK0
         dzpNvOScqheMzWgLTD16c9o0OQguM3khzsmUbuXbYfR3IH0qBY4x0lwt4fj95BZRJPZr
         ITkpEe8wAVFFGl+nJwzc6NFW0wtvVrlsFttHgKVGKisY4oPQ34rjRrkDlpFJ4Xs0/WtM
         WX5qNX7U1+aCUCGqe9Tnp4wsQ7MzzWN3iW5QBj6Bvue4g6smVhOrkk+OCZ0AT0KaFz1A
         Q73cLusyby0LimYJpi/M5wlcpcJA04bAinoV2RuaUYQO7RYnZoJis5Pspt+8+i2q9/eW
         MiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hjfveKxN4psxRyRP8zJoBweMn3Lw5e9A8i8e9HabaRs=;
        b=NG5NR9JtsMqF8gDExAoVyqLYiVru+VyC+Zw3nwaDJJGf1JteyXHAmRVdaXJOgcrdWj
         1XuAiTQQarQRyOGb5HNOzhINhdiVYcLHq64Dyb/6Gy8/CWmuNGfETFONOhlHSB27Zq7A
         yPSNdiC1xwRs2RGaI9ZArCgANParTEMIq4DMRcX+J1g036GLUO2j6SWFAkT6EQDKd1/9
         ihF9XbPpVUJmSEFTlbTYDrqjUQHkqtsiZxu6dwlxiBxmUMp2D1T3KLe+9Qbxk15k+z74
         7hL5rstiIJFjfkLXDhd88nIG8uhQQlPw+yBsSvtwH/SoLTSoOAqfLXGOGP0HmFMxx1QM
         IcxQ==
X-Gm-Message-State: AOAM5309YwZFCGCob9lr9fvU9EXtLS/WmLrJQl2ah2bDH7gcHQCrJOky
        IUS4yXztUZ8Hsuj3MFWm8+pj/A==
X-Google-Smtp-Source: ABdhPJwWRYcEtdPjEAb+4OfDZCDouPSQyXhoKDINlkwSw0H/GA/dD5/+QFpznR4L0nyAbi3RgXlxvw==
X-Received: by 2002:a05:651c:1257:: with SMTP id h23mr9003910ljh.17.1637165931841;
        Wed, 17 Nov 2021 08:18:51 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i18sm23235lfe.186.2021.11.17.08.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 08:18:51 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id C62D9103122; Wed, 17 Nov 2021 19:18:55 +0300 (+03)
Date:   Wed, 17 Nov 2021 19:18:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound updates for 5.16-rc1
Message-ID: <20211117161855.m45mxcqszkfcetai@box.shutemov.name>
References: <s5hwnlpmt9x.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hwnlpmt9x.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 11:24:10AM +0100, Takashi Iwai wrote:
> Linus,
> 
> please pull sound updates for v5.16-rc1 from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.16-rc1
> 
> The topmost commit is df0380b9539b04c1ae8854a984098da06d5f1e67
> 
> ----------------------------------------------------------------
> 
> sound updates for 5.16-rc1
> 
> Lots of code development have been see in ASoC side as usual, while
> the continued development on memalloc helper and USB-audio low-
> latency support are found in the rest.  Note that a few changes in the
> unusual places like arch/sh are included, which are a part of ASoC DAI
> format cleanups.
> 
> ALSA core:
> - Continued memallloc helper updates and cleanups, now supporting
>   non-coherent and non-contiguous pages
> - Fixes for races in mixer OSS layer
> 
> ASoC:
> - A new version of the audio graph card which supports a wider range
>   of systems
> - Several conversions to YAML DT bindings
> - Continuing cleanups to the SOF and Intel code
> - Move of the Cirrus DSP framework into drivers/firmware to allow for
>   future use by non-audio DSPs
> - An overhaul of the cs42l42 driver, correcting many problems
> - DAI format terminology conversions over many drivers for cleanups
> - Support for AMD Vangogh and Yelow Cap, Cirrus CS35L41, Maxim
>   MAX98520 and MAX98360A, Mediatek MT8195, Nuvoton NAU8821, nVidia
>   Tegra210, NXP i.MX8ULP, Qualcomm AudioReach, Realtek ALC5682I-VS,
>   RT5682S, and RT9120 and Rockchip RV1126 and RK3568
> 
> USB-audio:
> - Continued improvements on low-latency playback
> - Quirks for Pioneer devices, Line6 HX-Stomp XL, Audient iD14
> 
> HD-audio:
> - Reduce excessive udelay() calls on Intel platforms; this should
>   reduce the CPU load with PulseAudio
> - Quirks for HP and Clevo laptops
> 
> FireWire:
> - Support for meter information on MOTU
> 

...

> Takashi Iwai (29):
>       ALSA: hda: Reduce udelay() at SKL+ position reporting
>       ALSA: hda: Use position buffer for SKL+ again
>       ALSA: usb-audio: Restrict rates for the shared clocks
>       ALSA: usb-audio: Fix possible race at sync of urb completions
>       ALSA: usb-audio: Rename early_playback_start flag with lowlatency_playback
>       ALSA: usb-audio: Disable low-latency playback for free-wheel mode
>       ALSA: usb-audio: Disable low-latency mode for implicit feedback sync
>       ALSA: usb-audio: Check available frames for the next packet size
>       ALSA: usb-audio: Add spinlock to stop_urbs()
>       ALSA: usb-audio: Improved lowlatency playback support

This commit breaks audio playback for me. The sample plays for fraction of
a second than stops.

I use SMSL SA300. Let me know what ifo is needed to track it down.

Also I can test potential fixups if needed.

-- 
 Kirill A. Shutemov
