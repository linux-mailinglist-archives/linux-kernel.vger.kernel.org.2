Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C453BA6A6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 03:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhGCBja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 21:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhGCBja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 21:39:30 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A94C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 18:36:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a15so21338275lfr.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 18:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIQfJgZz6sQUNmrW+8lsTn6XLkJzqpq66j2tqKofu78=;
        b=bBxtJUQ7d20SqqPD0eIf6OwTfTwozN4H48L9Q5eLUCr/C3o5n44Ku/ZOVQ/+Jcnep7
         U1tpaxOIv6+Nhur41cPfGnP3ibyaPJPqYRCcfeAlzI+jwQ+EfbxjEIzKMGjYz7gn7hwu
         gZ0IBXw0ywk7BhFv6BFhyzZjv5xHnL0cBHwIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIQfJgZz6sQUNmrW+8lsTn6XLkJzqpq66j2tqKofu78=;
        b=oLgC/69U7B8gUuX7CnjlN7zM4mDk+pSzCt0IJyKYcTaGs/RRBhWx+XQjtuFmVlrGjN
         +5IHG6BNaDnq7wCszJ6vlnLv/xJRwVtOCAJVMQFAzYVChFUsLwgmU14xkk8/cEMZuVZG
         QJBdX5HTh5Asxua7K1x6/88yv0TaEM2zpmmZlSfV07plYpCSEW3vyFAByAiT/j4OYFc8
         UBIwnuanjn01LYRsOHs0uqobTZEAoE7TxVkSHTBzFJp6biMxphntLKswl19iwpPCtHGJ
         7y5i6B2reiwHqGCD3scOXz/s3DhJW/pZ8z/+fYbPTDRggZ93N3sFnvwZDJkDzTPo8WdU
         c3Qg==
X-Gm-Message-State: AOAM531QLrQSPa/F3zKDwbumhrEShERt7I6lHyLJKstxd3hmmZDiQkz8
        7vvP72KCbdYFME+Xz1nZIME7RuqhnXCIbPr7FaM=
X-Google-Smtp-Source: ABdhPJwzglE9lmt3d/0Afi/Qe+pV6xPslFUDVeUDEHVMvyD+wW+LvGqEJigCAB6e6kEjKECIb/SqWQ==
X-Received: by 2002:ac2:5dd6:: with SMTP id x22mr1833698lfq.60.1625276215145;
        Fri, 02 Jul 2021 18:36:55 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id a17sm419899lfs.59.2021.07.02.18.36.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 18:36:54 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id bq39so8756674lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 18:36:54 -0700 (PDT)
X-Received: by 2002:ac2:4903:: with SMTP id n3mr1734658lfi.487.1625276214267;
 Fri, 02 Jul 2021 18:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <s5hbl7li0fe.wl-tiwai@suse.de>
In-Reply-To: <s5hbl7li0fe.wl-tiwai@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jul 2021 18:36:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTwX5mzzEcw3jk3QdW600Hntt=Ehgoyz8K-VU8zbEmBg@mail.gmail.com>
Message-ID: <CAHk-=wiTwX5mzzEcw3jk3QdW600Hntt=Ehgoyz8K-VU8zbEmBg@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 5.14-rc1
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 1:29 AM Takashi Iwai <tiwai@suse.de> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.14-rc1

After incorrectly suspecting Andrew's -mm tree (because the kernel
hung with a watchdog on TLB flushing, and so I suspected mm problems),
I've now bisected my hung machine into the sound tree.

And in fact, I have a couple of NMI backtraces that point very
directly at the sound code, and a couple of the hung cores had stack
traces like this:

  Call Trace:
   _raw_spin_lock_irqsave+0x35/0x40
   snd_pcm_period_elapsed+0x1b/0xa0 [snd_pcm]
   snd_complete_urb+0x119/0x580 [snd_usb_audio]
   __usb_hcd_giveback_urb+0xb2/0x100
   usb_giveback_urb_bh+0xaf/0xd0
   tasklet_action_common+0xe0/0x160
   __do_softirq+0x142/0x296
   __irq_exit_rcu+0xc5/0xf0
   common_interrupt+0x78/0x90

  Call Trace:
   _raw_spin_lock_irqsave+0x35/0x40
   snd_pcm_period_elapsed+0x1b/0xa0 [snd_pcm]
   snd_usb_endpoint_start+0x1a0/0x3c0 [snd_usb_audio]
   start_endpoints+0x23/0x90 [snd_usb_audio]
   snd_usb_substream_playback_trigger+0x7b/0x1a0 [snd_usb_audio]
   snd_pcm_common_ioctl+0x1c44/0x2360 [snd_pcm]
   snd_pcm_ioctl+0x2e/0x40 [snd_pcm]
   __se_sys_ioctl+0x72/0xc0
   do_syscall_64+0x4c/0xa0
   entry_SYSCALL_64_after_hwframe+0x44/0xae

so it looks like it's that

        snd_pcm_stream_lock_irqsave(substream, flags);

that hangs. Presumably somebody has forgotten to unlock a spinlock they took.

I'll continue bisecting, but this is on my AMD Gigabyte TRX30 Aorus
Master board, which has that internal USB-Audio too, but what I
actually use is that external USB Audioengine 2

 0 [Headphone      ]: USB-Audio - Aorus Master Front Headphone
                      Gigabyte-Aorus-Master-Front-Headphone
 1 [Generic        ]: HDA-Intel - HD-Audio Generic
                      HD-Audio Generic at 0xfa200000 irq 156
 2 [HDMI           ]: HDA-Intel - HDA ATI HDMI
                      HDA ATI HDMI at 0xe1c60000 irq 158
 3 [A2             ]: USB-Audio - Audioengine 2
                      Audioengine Ltd. Audioengine 2  at
usb-0000:03:00.3-2.3, full speed
 4 [Audio          ]: USB-Audio - Aorus Master Main Audio
                      Gigabyte-Aorus-Master-Main-Audio

does a hung spinlock make anybody go "Oh, I know!"

My bisect will hopefully have it narrowed down more soon enough. Knock wood.

               Linus
