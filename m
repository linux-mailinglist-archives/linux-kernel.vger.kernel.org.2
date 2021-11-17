Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC38D454CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbhKQSYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbhKQSXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:23:53 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5DDC061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:20:53 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id z34so12826644lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8wMoZu0VRhizgyI2wN3ScphE3wkTWS6F6S+vhqR7W3Q=;
        b=HhAjnQNvO2pI95doaIXBiLuvSQpF8bcjUtdAT1Q1Vh8PkCatb542wgpKAHAmAfmzja
         WTw4XVNd5VCKEmHMgN8+Ne+rkzCsWvQndFnl9Wmx4bbAzZSs4gJHdG2cVjTvjVYyDtM1
         yRP08WJB5tyq5a9B+OBccJ5ZErRWc82IEzLVD2FJeCgriEO/hZGBB+MvrcErnwPgSPBc
         X9XZVNV3SSBucYo2GLZ3lwsOcF6zBoRNQt+LVv9OpBlvmoLw9+m6Xw9JVgcq17bleH5E
         QWVvrr/joDQAtNxh8zDjE8pDcFX13NxnYv6oleyoqPO1j/jvNotKv/kxjCXG++0ozzD0
         2Kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8wMoZu0VRhizgyI2wN3ScphE3wkTWS6F6S+vhqR7W3Q=;
        b=ONPubWk/neRtcfiyIKyswp6N7KaheyoUjDtm8ivx0e5v3q9ABd3TPjNOvTC4MvbZh3
         AwQCT+1OREJUOdI5zufLXqf/Gn7emdpgqPlXhOBPqXmyPCSrXSmn0u77Zc6JWrZ9i1GG
         I7LFZYQAtg81UXIcf/oMp9uA+pHPGKHyfT/NTAzXhGJnpYAt5xApnALza/OquN3gdu3q
         pql/KN3SzUzFsH90/3/kOywjTGk3ER+sl3krWI7FXCH+z95mLhhzrvRBJCnL9HBKmIUB
         U7qyWa67pIKqJrYxGUP4bI9DC8zA0td8wiAkkpZZMNAqCVBW8DImArN5tXCBDvP7Y+Z6
         7zKQ==
X-Gm-Message-State: AOAM530NUAUzuB0wGPJUSgVKBAJ0TXO1pdh5F1Gv5x5TG/vExC2D4pO7
        4lzabA9fUrvtAHrNusASLWIMyQ==
X-Google-Smtp-Source: ABdhPJzNnaWr2u/iDxNbo52VZgEW8j3U52SyX49SXu9YXY5FyL4tM1MtrexmCKO662OrbwUiFQMY0A==
X-Received: by 2002:a05:651c:1101:: with SMTP id d1mr9877016ljo.373.1637173251461;
        Wed, 17 Nov 2021 10:20:51 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z19sm53166lfd.68.2021.11.17.10.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 10:20:50 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 00F30103139; Wed, 17 Nov 2021 21:20:54 +0300 (+03)
Date:   Wed, 17 Nov 2021 21:20:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound updates for 5.16-rc1
Message-ID: <20211117182054.fklz7rlpfux2d7j4@box.shutemov.name>
References: <s5hwnlpmt9x.wl-tiwai@suse.de>
 <20211117161855.m45mxcqszkfcetai@box.shutemov.name>
 <s5hmtm2lphf.wl-tiwai@suse.de>
 <20211117174826.23eakoivl33tawb2@box.shutemov.name>
 <s5hfsrulkxk.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hfsrulkxk.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 07:02:47PM +0100, Takashi Iwai wrote:
> On Wed, 17 Nov 2021 18:48:26 +0100,
> Kirill A. Shutemov wrote:
> > 
> > On Wed, Nov 17, 2021 at 05:24:28PM +0100, Takashi Iwai wrote:
> > > On Wed, 17 Nov 2021 17:18:55 +0100,
> > > Kirill A. Shutemov wrote:
> > > > 
> > > > On Wed, Nov 03, 2021 at 11:24:10AM +0100, Takashi Iwai wrote:
> > > > > Linus,
> > > > > 
> > > > > please pull sound updates for v5.16-rc1 from:
> > > > > 
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.16-rc1
> > > > > 
> > > > > The topmost commit is df0380b9539b04c1ae8854a984098da06d5f1e67
> > > > > 
> > > > > ----------------------------------------------------------------
> > > > > 
> > > > > sound updates for 5.16-rc1
> > > > > 
> > > > > Lots of code development have been see in ASoC side as usual, while
> > > > > the continued development on memalloc helper and USB-audio low-
> > > > > latency support are found in the rest.  Note that a few changes in the
> > > > > unusual places like arch/sh are included, which are a part of ASoC DAI
> > > > > format cleanups.
> > > > > 
> > > > > ALSA core:
> > > > > - Continued memallloc helper updates and cleanups, now supporting
> > > > >   non-coherent and non-contiguous pages
> > > > > - Fixes for races in mixer OSS layer
> > > > > 
> > > > > ASoC:
> > > > > - A new version of the audio graph card which supports a wider range
> > > > >   of systems
> > > > > - Several conversions to YAML DT bindings
> > > > > - Continuing cleanups to the SOF and Intel code
> > > > > - Move of the Cirrus DSP framework into drivers/firmware to allow for
> > > > >   future use by non-audio DSPs
> > > > > - An overhaul of the cs42l42 driver, correcting many problems
> > > > > - DAI format terminology conversions over many drivers for cleanups
> > > > > - Support for AMD Vangogh and Yelow Cap, Cirrus CS35L41, Maxim
> > > > >   MAX98520 and MAX98360A, Mediatek MT8195, Nuvoton NAU8821, nVidia
> > > > >   Tegra210, NXP i.MX8ULP, Qualcomm AudioReach, Realtek ALC5682I-VS,
> > > > >   RT5682S, and RT9120 and Rockchip RV1126 and RK3568
> > > > > 
> > > > > USB-audio:
> > > > > - Continued improvements on low-latency playback
> > > > > - Quirks for Pioneer devices, Line6 HX-Stomp XL, Audient iD14
> > > > > 
> > > > > HD-audio:
> > > > > - Reduce excessive udelay() calls on Intel platforms; this should
> > > > >   reduce the CPU load with PulseAudio
> > > > > - Quirks for HP and Clevo laptops
> > > > > 
> > > > > FireWire:
> > > > > - Support for meter information on MOTU
> > > > > 
> > > > 
> > > > ...
> > > > 
> > > > > Takashi Iwai (29):
> > > > >       ALSA: hda: Reduce udelay() at SKL+ position reporting
> > > > >       ALSA: hda: Use position buffer for SKL+ again
> > > > >       ALSA: usb-audio: Restrict rates for the shared clocks
> > > > >       ALSA: usb-audio: Fix possible race at sync of urb completions
> > > > >       ALSA: usb-audio: Rename early_playback_start flag with lowlatency_playback
> > > > >       ALSA: usb-audio: Disable low-latency playback for free-wheel mode
> > > > >       ALSA: usb-audio: Disable low-latency mode for implicit feedback sync
> > > > >       ALSA: usb-audio: Check available frames for the next packet size
> > > > >       ALSA: usb-audio: Add spinlock to stop_urbs()
> > > > >       ALSA: usb-audio: Improved lowlatency playback support
> > > > 
> > > > This commit breaks audio playback for me. The sample plays for fraction of
> > > > a second than stops.
> > > > 
> > > > I use SMSL SA300. Let me know what ifo is needed to track it down.
> > > > 
> > > > Also I can test potential fixups if needed.
> > > 
> > > Could you give alsa-info.sh output with the device?  Run the script
> > > with --no-upload option, and attach the output.
> > 
> > Attached. I run it on kernel without the commit. I hope it is fine.
> > 
> > One note: I use monolitic kernel without CONFIG_MODULES. The script
> > complained about missing /proc/asound/modules and other modules related
> > stuff.
> 
> It's a known problem I forgot, but this doesn't matter much.
> 
> > > Also /proc/asound/card*/stream* file for that usb device, too,
> > > please.
> > 
> > Attached.
> 
> Thanks!
> 
> > > And, which environment are you testing, more exactly?  Which platform,
> > > and with PulseAudio, pipewire, JACK, or direct ALSA device use?
> > 
> > Nothing fancy. Direct ALSA. I tested with 'speaker-test -c2 -t wav' during
> > bisect.
> 
> Did you notice the problem with other applications, too?

Youtube in Firefox hangs trying to play a video. (Browser is still
functional otherwise)

> When you wrote "The sample plays for fraction of a second than
> stops.", it means that the speaker-test program stalls?  Or it's
> shorter playbacks?

On "Front left" check, it stalls after "Fro" or so :P

The speaker-test can be terminated normally with ctrl-c and the symptoms
are the same if you try again.

> Also, please test booting with snd_usb_audio.lowlatency=0 boot
> option.  Does it behave like before again?
> 
> > > For checking the behavior, we'd need to check hw_params in
> > > /proc/asound/card*/pcm*/sub*/* for the corresponding device during
> > > playback/capture operations.
> > 
> > You need this to be collected when the problem triggers, right?
> > I will follow up with this.
> 
> I'll need to test my device at first.  Maybe tomorrow.

Okay.

-- 
 Kirill A. Shutemov
