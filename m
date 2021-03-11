Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8CF336BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 06:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhCKFu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 00:50:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46749 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCKFuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 00:50:37 -0500
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lKEDU-0005Wj-Ck
        for linux-kernel@vger.kernel.org; Thu, 11 Mar 2021 05:50:36 +0000
Received: by mail-oi1-f198.google.com with SMTP id o124so477187oia.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 21:50:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hhrtXdhcVtzIL3rMgHjbyflZREjwdEPHtqMCZp4XLg=;
        b=H2KrU9jCWWhm6IwmGM22xzIziSCnGM2qqkMO9a8qW2OMqgHM4aS0NBbgzUWxkvrCbR
         6X5QFwvsG8YNRLKEDnl8xKW4OzZWgkdC1R6fo35Evx6KNiOvnk+enD8TbiEN3m8RhUHp
         BtEkdxfoxpMg+yzZ7W2bc/hE7s5leHkiRDgrbjM7Zms5dxpMZrvRDJiUB8IcRIY9VHdp
         0WRylxl1kNqCUqPOefdEZzzDSBn9mh9yG90g4uT9RGNWMRlzgo23C5ZEMzTxCyhURKwb
         WMTs8dc5y+Pw19fDGVnQ2mwN+Go9yee31ZKUqTVj19o5qE0RViK6dPhaQEnUtvF033s3
         DvpA==
X-Gm-Message-State: AOAM533uAiGnGGvWO7aU8TzgIPBthguimegTzWio8HlrOO2NUgtr8tHB
        CCHPuEHLy9gpG7UYG66wlNioHs373iAyLQd4ER2DtbYpeyK1DF+11Qfs550wlFS9Wd+mWzxU3S0
        3SmsCKIKZ+xo0sUhOorhn9eMbZu/ybWecsczF6UI31ghDMBQcjGSvbmshOQ==
X-Received: by 2002:a9d:6481:: with SMTP id g1mr5478702otl.303.1615441835344;
        Wed, 10 Mar 2021 21:50:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIXt75ECUfdiHwjMp8yz8OW9UifCOusRUyrBrHzIcwFqbbwvbqu3OG8xiTHHTRJWtdBm5tCHAPWHaoftkEDyA=
X-Received: by 2002:a9d:6481:: with SMTP id g1mr5478695otl.303.1615441835121;
 Wed, 10 Mar 2021 21:50:35 -0800 (PST)
MIME-Version: 1.0
References: <CABTNMG31sH99P0F7EKhpFwJf99x4U-VjFWrwXVe1wkra6owFLw@mail.gmail.com>
 <dba864a6-1442-1ebc-9de0-8c1511682b70@intel.com>
In-Reply-To: <dba864a6-1442-1ebc-9de0-8c1511682b70@intel.com>
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Thu, 11 Mar 2021 13:50:24 +0800
Message-ID: <CABTNMG1bO2AJLY0o58TX2=1QZPnPsZXabtYZA01QyqDS40JORg@mail.gmail.com>
Subject: Re: No sound cards detected on Kabylake laptops after upgrade to
 kernel 5.8
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 11:29 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2021-03-09 1:19 PM, Chris Chiu wrote:
> > Hi Guys,
> >      We have received reports that on some Kabylake laptops (Acer Swift
> > SF314-54/55 and Lenovo Yoga C930...etc), all sound cards no longer be
> > detected after upgrade to kernel later than 5.8. These laptops have
> > one thing in common, all of them have Realtek audio codec and connect
> > the internal microphone to DMIC of the Intel SST controller either
> > [8086:9d71] or [8086:9dc8]. Please refer to
> > https://bugzilla.kernel.org/show_bug.cgi?id=201251#c246 and
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1915117.
> >
> >      From the dmesg from kernel 5.8, the sound related parts only show
> > as follows but the expected snd_hda_codec_realtek and the snd_soc_skl
> > are not even loaded then.
> > [ 13.357495] snd_hda_intel 0000:00:1f.3: DSP detected with PCI
> > class/subclass/prog-if info 0x040100
> > [ 13.357500] snd_hda_intel 0000:00:1f.3: Digital mics found on
> > Skylake+ platform, using SST driver
> >
> >      Building the kernel with the CONFIG_SND_SOC_INTEL_KBL removed can
> > load the snd_hda_codec_realtek successfully and the pulseaudio and
> > alsa-utils can detect the sound cards again. The result of bisecting
> > between kernel 5.4 and 5.8 also get similar result, reverting the
> > commit "ALSA: hda: Allow SST driver on SKL and KBL platforms with
> > DMIC" can fix the issue. I tried to generate the required firmware for
> > snd_soc_skl but it did not help. Please refer to what I did in
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1915117/comments/14
> > and https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1915117/comments/18.
> >
> >      Since the skl_hda_dsp_generic-tplg.bin and dfw_sst.bin are not in
> > the linux-firmware. The Intel SST support for Skylake family is not
> > yet complete. Can we simply revert the "ALSA: hda: Allow SST driver on
> > SKL and KBL platforms with DMIC" in the current stage and wait for SOF
> > support for Skylake family? Or please suggest a better solution for
> > this. Thanks
> >
> > Chris
> >
>
> Hello Chris,
>
> Guide: "Linux: HDA+DMIC with skylake driver" [1] should help
> understanding history behind the problem as well as fixing it.
>
> Upstream skylake driver - snd_soc_skl - is intended to support HDA DSP +
> DMIC configuration via means of snd_soc_skl_hda_dsp machine board
> driver. You _may_ switch to legacy HDAudio driver - snd_hda_intel -
> losing DMIC support in the process. To remove any confusion - for
> Skylake and Kabylake platforms, snd_soc_skl is your option.
>
> Now, due to above, I doubt any skylake-related topology has ever been
> upstreamed to linux-firmware as a) most boards are I2S-based, these are
> used by our clients which we support via separate channel b) hda
> dsp+dmic support on linux for missing until early 2020.
>
> Topologies for most common skylake driver configurations:
> - skl/kbl with i2s rt286
> - apl/glk with i2s rt298
> - <any> with hda dsp
> can be found in alsa-topology-conf [2].
>
> Standard, official tool called 'alsatplg' is capable of compiling these
> into binary form which, after being transferred to /lib/firmware/ may be
> consumed by the driver during runtime.
> I have no problem with providing precompiled binaries to linux-firmware,
> if that's what community wants.
>
> Regards,
> Czarek
>
>

I think the guild [1] is too complicated for normal users to fix the problem.
Given it's not only the internal microphone being affected, it's no sound
devices being created at all so no audio functions can work after kernel 5.8.

Is there any potential problem to built-in the "<any> with hda dsp" precompiled
binary in linux-firmware?

Chris

> [1]: https://gist.github.com/crojewsk/4e6382bfb0dbfaaf60513174211f29cb
> [2]: https://github.com/alsa-project/alsa-topology-conf/tree/master/topology
