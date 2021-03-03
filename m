Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68DF32BA88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhCCLZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbhCCDBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 22:01:15 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BC2C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 19:00:34 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id t26so15289770pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 19:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ubk/tn6yfSpO7LtICTo6ZlZyh2FjSG4zV5mu/FLlvoQ=;
        b=OI1iIu755PF1/cRkiaMjRJAZwP7B0ZVfHiBIVxTPPPPr9Uh7ZoRCIVjfbymhPh5HlX
         /vmIy2D8VdC8dQiND+O9IkQzqeLhWnkmgUBcO02sRBM1vWlBh3yo7Nie7MpsEcFb6WUY
         VWeI4qjoKqBHc+9SEcgbIj3CUg9LZbz3dq0N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ubk/tn6yfSpO7LtICTo6ZlZyh2FjSG4zV5mu/FLlvoQ=;
        b=gpjoB64BYp46B3vRS8GpyppSNlghFRzytgUttTcIW/+7uwT77+YoufxDCgdLjzLCHt
         e9NB6eHKB816NdFhdTATNzKmewv9s1k/9dq0ENQCSyNzXcdL5tigYs+2QUmpOafSq5U6
         NCpq1kHaJD7LPOZkjDsnCnT6qeYZvS47EaWGxmf2UmBaOkgRT+T7xE+A1Yzp8lecUFcX
         nP/zxlELSjD4Bn/fB7TYNBcWcSJL8uyWDnsv2364WqWIBLxRkeUjZH9BZWxbaAJfd3a3
         MDbWgP1CG+3zrBGthSqNdksIEMIQR0m4GWeozGM1uEpbXvIiXmsVahNnNarMChUvrHlG
         2mJw==
X-Gm-Message-State: AOAM531he11NpLbuBeaj7ZKGfOaFw5BX81aIQAc1GPP+4rk4X1rIczCn
        ehE01vyhL1II6ZvbDzcDZCkbtw==
X-Google-Smtp-Source: ABdhPJz88lAi/GI+2fKAltbiVzeVEU8OANZYjuSCwqF+2k8CfBAVfwHRgywjomQHKm9dRmsp6aMUQw==
X-Received: by 2002:a62:5302:0:b029:1ee:c519:8cdd with SMTP id h2-20020a6253020000b02901eec5198cddmr2284575pfb.79.1614740434242;
        Tue, 02 Mar 2021 19:00:34 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id z29sm22272664pfr.114.2021.03.02.19.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 19:00:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210302210136.3ded3ab3@gandalf.local.home>
References: <20210301174749.1269154-1-swboyd@chromium.org> <20210301174749.1269154-6-swboyd@chromium.org> <20210302210136.3ded3ab3@gandalf.local.home>
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
To:     Steven Rostedt <rostedt@goodmis.org>
Date:   Tue, 02 Mar 2021 19:00:32 -0800
Message-ID: <161474043200.1478170.15118093304775120279@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steven Rostedt (2021-03-02 18:01:36)
> On Mon,  1 Mar 2021 09:47:47 -0800
> Stephen Boyd <swboyd@chromium.org> wrote:
>=20
> >  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNIN=
G+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
> >  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cg=
roup uinput xt_MASQUERADE
> >  CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de20566=
2d5a9e0d4c580f19a1
> >  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
> >  pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=3D--)
> >  pc : lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e=
143b259e)
> >  lr : lkdtm_do_action+0x24/0x40 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d=
7e143b259e)
>=20
> Why not just change the "Modules linked in:" portion to show the build IDs
> instead of every function call? Maybe make it a config option to do so?
>=20

As I wrote in the commit text

=E2=94=82 An alternative to changing the printk format would be to update t=
he                                                                         =
                                                                   =20
=E2=94=82 "Modules linked in:" line to include the build ID of each module =
linked                                                                     =
                                                                   =20
=E2=94=82 in. This can become quite long when many modules are loaded (i.e.=
 on a                                                                      =
                                                                   =20
=E2=94=82 distro) so I've opted for the printk format instead.

Implementing it is fairly simple compared to a new printk format. In
fact I did that initially but decided against it because it felt
unreadable and provided more information than was necessary if the
stacktrace wasn't in a module.

Example:

 Modules linked in: rfcomm 4de3e669b9fee915 algif_hash 915c61c32d476f01 alg=
if_skcipher 53a4a330149bf071 af_alg b49d66496907f376 xt_cgroup 36fbbb65e762=
0df9 uinput a0ff6a06c1c53685 xt_MASQUERADE d130585f728315d2 snd_soc_sc7180 =
5c130cd310c81a12 venus_dec 2071e263fde9ca07 qcom_spmi_temp_alarm 41e28f2a9c=
c8b562 qcom_spmi_adc_tm5 7e0e48d0b6550c7a qcom_spmi_adc5 40b81a00bc2d0c1d q=
com_vadc_common 09bb012dd1662dea snd_soc_rt5682_i2c c92b8935ad4a1729 venus_=
enc efaf3335b88287bf snd_soc_qcom_common 56d1e87c267ed02e videobuf2_dma_sg =
e9bc3c9e2758dfc9 snd_soc_rt5682 c4c9b31bf9a43f8b snd_soc_rl6231 908446e3243=
6898c hci_uart 107b5fe6884df077 btqca 401a2fcc17b80a39 bluetooth 3369c88149=
6a3cf8 venus_core a11eee3aa201ad8e ecdh_generic 883e01f98b778108 ecc 226b25=
8cf40ad1ba v4l2_mem2mem 592f197cbad39e6b snd_soc_lpass_sc7180 42a99cb812d5e=
2e3 snd_soc_lpass_hdmi 95cce2160cfc58e2 snd_soc_lpass_cpu 475a4b395577affd =
snd_soc_lpass_platform 67517083263035ec snd_soc_max98357a 03ec1af0493d1c59
  fuse 82d170244a4d4ac6 iio_trig_sysfs b879a6228e059834 cros_ec_lid_angle a=
713c5f0a06a7a82 cros_ec_sensors 03f0c142ec521f67 cros_ec_sensors_core ada3f=
44647980056 cros_ec_sensors_ring f99590e87e998485 industrialio_triggered_bu=
ffer c697969d67f73d77 kfifo_buf e8a3aeb3069188f0 cros_ec_sensorhub 041ed1ff=
cefc991b ath10k_snoc 2f60802a74ff6ca7 lzo_rle 49a6228cec0c6885 ath10k_core =
9407c36a2b8f8fae lzo_compress e9b4375d4bad668a ath 20c585ba6f3998f0 zram c5=
cdfc1d7d8a35d9 mac80211 9eaed1c76e000c02 cfg80211 872178d2dcebb722 cdc_ethe=
r 2baa214f72289402 usbnet 2bec73d0922ade28 uvcvideo eee0352cb1846ee4 r8152 =
47b76561b78e9b1b mii b306d150923fe614 videobuf2_vmalloc 55431ec52fa6af84 vi=
deobuf2_memops 4d43ad18fa7b1e4e videobuf2_v4l2 cdda06b9d95ab11d videobuf2_c=
ommon 69cef0ca55a70a4a joydev 148399325b72d4a0

compared to=20

 Modules linked in: rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinpu=
t xt_MASQUERADE snd_soc_sc7180 venus_dec qcom_spmi_temp_alarm qcom_spmi_adc=
_tm5 qcom_spmi_adc5 qcom_vadc_common snd_soc_rt5682_i2c venus_enc snd_soc_q=
com_common videobuf2_dma_sg snd_soc_rt5682 snd_soc_rl6231 hci_uart btqca bl=
uetooth venus_core ecdh_generic ecc v4l2_mem2mem snd_soc_lpass_sc7180 snd_s=
oc_lpass_hdmi snd_soc_lpass_cpu snd_soc_lpass_platform snd_soc_max98357a=20
  fuse iio_trig_sysfs cros_ec_lid_angle cros_ec_sensors cros_ec_sensors_cor=
e cros_ec_sensors_ring industrialio_triggered_buffer kfifo_buf cros_ec_sens=
orhub ath10k_snoc lzo_rle ath10k_core lzo_compress ath zram mac80211 cfg802=
11 cdc_ether usbnet uvcvideo r8152 mii videobuf2_vmalloc videobuf2_memops v=
ideobuf2_v4l2 videobuf2_common joydev=20

I suppose it could be surrounded by parenthesis or brackets and that
would be a little better? I'll try this approach again and see what
folks think.
