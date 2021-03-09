Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEDD332555
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhCIMU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:20:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38079 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhCIMT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:19:56 -0500
Received: from mail-oo1-f69.google.com ([209.85.161.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lJbL9-0001C9-BB
        for linux-kernel@vger.kernel.org; Tue, 09 Mar 2021 12:19:55 +0000
Received: by mail-oo1-f69.google.com with SMTP id p5so6838001oot.21
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 04:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kyuouq159+7INzRG8WSfkepPVZJgFcOh7phpyb9bAxU=;
        b=Mbe6xb7Ln1o0tY/pyZxok4Bv7xYbKRItyc1hSQps20t6JIkhzkm5Jry7EgVlrzXiZn
         fJxJql53K0/rMrGXXBn+N1XQMWNiQ5jLUhFMqaW6Is4LSOga5kx2xqbNEB5K7dtiMVaU
         WhjW4570ZTSEP/uouSA8ySG67gEBcb/TYDx8K9B006xcOMsV+6WrLFoabhPcNTPoXZbo
         BeA06eJKILVcJydYU8CJAw6cX1/JUO4x7dSLpApIJtwuh3JVXAVUSMIJgSlOmJLz1l3o
         3SkPBRJuCEaMCCfcUUWIQ/KqiyHOLZMteZg3+boEp1FXYnU499JbqKf83E+A0QgvMa2J
         hHtA==
X-Gm-Message-State: AOAM532R046IcjWyxUGm2cJUxyuEHZGvq5Be31u7fo9zgdFu/zOgWFj7
        iXNb8qRd2ip21jvpihJVExte1XTjGQbKKGRMLtvI4T/lDR3eWs5VU0VDTjIvTuBCCrxaQz46dan
        xyaO3Nt2C7FqTcP/LB9r7fqnDtwxl5aj+QZ4TQw2cGvCkC7EZYFWqXCpmmA==
X-Received: by 2002:aca:5ac3:: with SMTP id o186mr1337194oib.169.1615292394262;
        Tue, 09 Mar 2021 04:19:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqCJlDjRWj5jsnvQxCujMBUIcBeLBVV5b4v5TmTjXk9Cj5sOx6THJe3xppaGzoC139kVUzTvDsNGEJE/2TeKA=
X-Received: by 2002:aca:5ac3:: with SMTP id o186mr1337173oib.169.1615292394015;
 Tue, 09 Mar 2021 04:19:54 -0800 (PST)
MIME-Version: 1.0
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Tue, 9 Mar 2021 20:19:43 +0800
Message-ID: <CABTNMG31sH99P0F7EKhpFwJf99x4U-VjFWrwXVe1wkra6owFLw@mail.gmail.com>
Subject: No sound cards detected on Kabylake laptops after upgrade to kernel 5.8
To:     pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,
    We have received reports that on some Kabylake laptops (Acer Swift
SF314-54/55 and Lenovo Yoga C930...etc), all sound cards no longer be
detected after upgrade to kernel later than 5.8. These laptops have
one thing in common, all of them have Realtek audio codec and connect
the internal microphone to DMIC of the Intel SST controller either
[8086:9d71] or [8086:9dc8]. Please refer to
https://bugzilla.kernel.org/show_bug.cgi?id=201251#c246 and
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1915117.

    From the dmesg from kernel 5.8, the sound related parts only show
as follows but the expected snd_hda_codec_realtek and the snd_soc_skl
are not even loaded then.
[ 13.357495] snd_hda_intel 0000:00:1f.3: DSP detected with PCI
class/subclass/prog-if info 0x040100
[ 13.357500] snd_hda_intel 0000:00:1f.3: Digital mics found on
Skylake+ platform, using SST driver

    Building the kernel with the CONFIG_SND_SOC_INTEL_KBL removed can
load the snd_hda_codec_realtek successfully and the pulseaudio and
alsa-utils can detect the sound cards again. The result of bisecting
between kernel 5.4 and 5.8 also get similar result, reverting the
commit "ALSA: hda: Allow SST driver on SKL and KBL platforms with
DMIC" can fix the issue. I tried to generate the required firmware for
snd_soc_skl but it did not help. Please refer to what I did in
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1915117/comments/14
and https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1915117/comments/18.

    Since the skl_hda_dsp_generic-tplg.bin and dfw_sst.bin are not in
the linux-firmware. The Intel SST support for Skylake family is not
yet complete. Can we simply revert the "ALSA: hda: Allow SST driver on
SKL and KBL platforms with DMIC" in the current stage and wait for SOF
support for Skylake family? Or please suggest a better solution for
this. Thanks

Chris
