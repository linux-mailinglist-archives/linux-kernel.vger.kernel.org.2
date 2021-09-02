Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7003FEAF6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244917AbhIBJJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244578AbhIBJJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:09:55 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E98FC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 02:08:56 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e133so2566235ybh.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mQr/L7ZjVpmLfN8cENBwEeg7NglFMIF4ED9673cgn3A=;
        b=ajhH2QZuD5pICF/MTN/xhRY8PZ8pix2SLAjQ7OORIOp2PFhgSC/kazkh7Y3QrZFj5o
         nfSfh7DFh8CaSKq6J2apjdnzDCiYCg+xgF1wCmFR0/X2J1wzzEtC40J30ieRCytuBDsw
         GP8neNxMnL71tU6gLnNikZk/aNOQQeXY+P0taZEcTFx1bs475NKpcj0JwqgpWv8PqqWr
         6xaWxNjUhJYGs3vpR+9ZBk9xscGWJ8ghu2L3I/QjcIhnTtjpvj3HlbKFWBmlEZwfcrAP
         TTDSTfr+x5hRGgfT+4odTdyE3tRfidYHjMMssrIAZ5kyyf02qYl1R51zBFu7xVyt/CNf
         yTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mQr/L7ZjVpmLfN8cENBwEeg7NglFMIF4ED9673cgn3A=;
        b=f0wa/sDCvAJ15aF+VN6rrrmVTRgDIUZoiA9T2VZGSk5533aV67UyXjlaqeVHoUZv3M
         Aivcl15sJakNutU5heoNUUCXT719TAxKdZQ6T6OHuRkrAS7aIuq+r7zov8hHzjnlTvtF
         7AGODweOtDN1gPM2DogD/o6Z97LQBNWoJCMnrOKQsq5igAnpi26V6A6MaMPUQBSU3RTY
         lne3dPXU0EF9kHsO24AHvNqRGa3aKyQbp79ElcEZ5aElWYE+jtEZQGL4LRYaUadzvuOZ
         1TGaZd0rjdkzi6wMITtbQAhJh5vIU4+RGk+ruQ07HHTSutyfqofW+EFLTG53efJ0CY9V
         wlCA==
X-Gm-Message-State: AOAM5311svg8fLETQN0pi+WtLxUyPVTUzfnvBR7dbJnBcf+Tm3i2JcK0
        vTIRjbgUpHNpf2eCLvq2q094Ml00P6e8BZ2FacRM844+XOo=
X-Google-Smtp-Source: ABdhPJx3NLSARENTHnXXyb4JxKDC2aWF8hyYDlBhrUqz1UfE+XVEMP3p+wxqLqU2X8A5UZ0jcauto+81232EGJwYZE8=
X-Received: by 2002:a25:2b48:: with SMTP id r69mr3258398ybr.448.1630573735406;
 Thu, 02 Sep 2021 02:08:55 -0700 (PDT)
MIME-Version: 1.0
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 2 Sep 2021 10:08:19 +0100
Message-ID: <CADVatmPB9-oKd=ypvj25UYysVo6EZhQ6bCM7EvztQBMyiZfAyw@mail.gmail.com>
Subject: Regression with mainline kernel on rpi4
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Our last night's test on rpi4 had a nasty trace. The test was with
7c636d4d20f8 ("Merge tag 'dt-5.15' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc"). Previous test
was on 9e9fb7655ed5 ("Merge tag 'net-next-5.15' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next") and it
did not have this trace.

[   40.975161] Unable to handle kernel access to user memory outside
uaccess routines at virtual address 0000000000000348
[   40.986187] Mem abort info:
[   40.989062]   ESR = 0x96000004
[   40.992233]   EC = 0x25: DABT (current EL), IL = 32 bits
[   40.997699]   SET = 0, FnV = 0
[   41.001205]   EA = 0, S1PTW = 0
[   41.004428]   FSC = 0x04: level 0 translation fault
[   41.009468] Data abort info:
[   41.012410]   ISV = 0, ISS = 0x00000004
[   41.016325]   CM = 0, WnR = 0
[   41.019358] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000042ae1000
[   41.025926] [0000000000000348] pgd=0000000000000000, p4d=0000000000000000
[   41.032845] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   41.038495] Modules linked in: overlay algif_hash algif_skcipher
af_alg bnep sch_fq_codel ppdev lp parport ip_tables x_tables autofs4
btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov
async_memcpy async_pq async_xor async_tx xor xor_neon raid6_pq
libcrc32c raid1 raid0 multipath linear uas usb_storage
snd_soc_hdmi_codec btsdio brcmfmac brcmutil hci_uart btqca btrtl
bcm2835_v4l2(C) btbcm crct10dif_ce bcm2835_mmal_vchiq(C) btintel
raspberrypi_hwmon videobuf2_vmalloc videobuf2_memops bluetooth
videobuf2_v4l2 videobuf2_common cfg80211 ecdh_generic ecc vc4
drm_kms_helper videodev dwc2 cec snd_bcm2835(C) i2c_brcmstb udc_core
roles drm xhci_pci mc pwm_bcm2835 xhci_pci_renesas snd_soc_core
ac97_bus snd_pcm_dmaengine snd_pcm phy_generic snd_timer
uio_pdrv_genirq snd fb_sys_fops syscopyarea sysfillrect sysimgblt uio
aes_neon_bs aes_neon_blk crypto_simd cryptd
[   41.116584] CPU: 0 PID: 1569 Comm: pulseaudio Tainted: G         C
      5.14.0-7c636d4d20f8 #1
[   41.125494] Hardware name: Raspberry Pi 4 Model B (DT)
[   41.130699] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   41.137756] pc : vc4_hdmi_audio_prepare+0x3c0/0xba4 [vc4]
[   41.143256] lr : vc4_hdmi_audio_prepare+0x308/0xba4 [vc4]
[   41.148747] sp : ffff800012f73a50
[   41.152099] x29: ffff800012f73a50 x28: ffff0000562ecc00 x27: 0000000000000000
[   41.159338] x26: 0000000000000000 x25: 000000000000ac44 x24: 0000000021002003
[   41.166574] x23: ffff800012f73b40 x22: 0000000000000003 x21: ffff000059400080
[   41.173811] x20: ffff0000594004c8 x19: 0005833333380600 x18: 0000000000000000
[   41.181047] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   41.188283] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000991
[   41.195520] x11: 0000000000000001 x10: 000000000001d4c0 x9 : ffff800009047838
[   41.202757] x8 : 0000000000000031 x7 : 000000000001d4c0 x6 : 0000000000000030
[   41.209993] x5 : ffff800012f73a98 x4 : ffff80000905bb60 x3 : 0000000010624dd3
[   41.217230] x2 : 00000000000003e8 x1 : 0000000000000000 x0 : 0000000000562200
[   41.224466] Call trace:
[   41.226939]  vc4_hdmi_audio_prepare+0x3c0/0xba4 [vc4]
[   41.232080]  hdmi_codec_prepare+0xe8/0x1b0 [snd_soc_hdmi_codec]
[   41.238083]  snd_soc_pcm_dai_prepare+0x5c/0x10c [snd_soc_core]
[   41.244038]  soc_pcm_prepare+0x5c/0x130 [snd_soc_core]
[   41.249276]  snd_pcm_prepare+0x150/0x1f0 [snd_pcm]
[   41.254149]  snd_pcm_common_ioctl+0x1644/0x1d14 [snd_pcm]
[   41.259635]  snd_pcm_ioctl+0x3c/0x5c [snd_pcm]
[   41.264152]  __arm64_sys_ioctl+0xb4/0x100
[   41.268216]  invoke_syscall+0x50/0x120
[   41.272014]  el0_svc_common+0x18c/0x1a4
[   41.275899]  do_el0_svc+0x34/0x9c
[   41.279254]  el0_svc+0x2c/0xc0
[   41.282348]  el0t_64_sync_handler+0xa4/0x12c
[   41.286673]  el0t_64_sync+0x1a4/0x1a8
[   41.290385] Code: 52807d02 72a20c43 f9400421 9ba37c13 (f941a423)
[   41.296563] ---[ end trace dcfe08f10aaf6873 ]---

You can see the complete dmesg at
https://openqa.qa.codethink.co.uk/tests/76#step/dmesg/8

-- 
Regards
Sudip
