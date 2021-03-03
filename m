Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C19432BCEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447447AbhCCPDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843072AbhCCKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:25:14 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD10AC061A86
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:56:28 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id h4so15825836pgf.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=7P6bTNdMTvWkmZpC9yYVIKZGVXHk59BxjedK2z5UWWw=;
        b=g2Qw/RtvxSqnTWMqM4cjQwKkUCF2PD17X6zPiGtKR2vQcMXL3CLOvTGO0a4ST2UCUH
         zB9HTT+MJkdxsbZ2xB/cErGzYibt7v5BDNs9IdVuL/u3DQtOGPnH7mhYaGhu+z6MDMWB
         1sIhxYLZigP44KZGrTnEqkkhOvEtTj67w6vTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=7P6bTNdMTvWkmZpC9yYVIKZGVXHk59BxjedK2z5UWWw=;
        b=qe2XUVPkqJYj1Yi5cqAqDB/3hqLo1PcWt6eBPcz2bmsluqkxUtfBmXbk5LyRP7d9Q0
         Zyly7SQd1i7EX3VV9Nut2pVq5j+I60qtUQWlxUtIVnfXplELoQwzIPpo4W+jDqBMAvR6
         2+tSBV5C92kzR/wVJrEhn0yUi9jpl7CzB7eDgCGo4Za8xwrcf1uKTtUq1sw8zvOF2R3M
         QK2H5ZXe8Upqb47/ZUrQf5wWQiubfGDjpFw4IAZqxqbXcA0H87qVnu6VZ0yFT9AACUw6
         s/As45WNlM1Qu0G73OHTBHzv5/BzS+rzRks8zF7rhXnPUiwJveNuk6gWrVBBw7YUML+5
         DIXg==
X-Gm-Message-State: AOAM531UMQHAGnn9h3Uup9vXWvVRFgBt1IKtAnm4zzIWSDqDNP07e0Uf
        MVHDxGaPWdnCKelqti75lqjv/w==
X-Google-Smtp-Source: ABdhPJxPWxDHa2G+L/upjcCheaQyysFbnYpN3uWB9+cR1tjo8dXlXiJAfwIloU5AB8icYv5Od6UoRA==
X-Received: by 2002:a62:1cd4:0:b029:1ee:9db0:3dc3 with SMTP id c203-20020a621cd40000b02901ee9db03dc3mr2131390pfc.59.1614761788071;
        Wed, 03 Mar 2021 00:56:28 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:2510:ab07:78a:7d78])
        by smtp.gmail.com with ESMTPSA id c29sm22448002pgb.58.2021.03.03.00.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 00:56:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YD9GeXcKbF3bsDLo@smile.fi.intel.com>
References: <20210301174749.1269154-1-swboyd@chromium.org> <20210301174749.1269154-6-swboyd@chromium.org> <20210302210136.3ded3ab3@gandalf.local.home> <161474043200.1478170.15118093304775120279@swboyd.mtv.corp.google.com> <YD9GeXcKbF3bsDLo@smile.fi.intel.com>
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Wed, 03 Mar 2021 00:56:25 -0800
Message-ID: <161476178590.1478170.5751112944097540029@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2021-03-03 00:19:05)
> On Tue, Mar 02, 2021 at 07:00:32PM -0800, Stephen Boyd wrote:
> > Quoting Steven Rostedt (2021-03-02 18:01:36)
> > > On Mon,  1 Mar 2021 09:47:47 -0800
> > > Stephen Boyd <swboyd@chromium.org> wrote:
> > >=20
> > > >  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WA=
RNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
> > > >  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg x=
t_cgroup uinput xt_MASQUERADE
> > > >  CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de2=
05662d5a9e0d4c580f19a1
> > > >  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
> > > >  pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=3D--)
> > > >  pc : lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba789929=
2d7e143b259e)
> > > >  lr : lkdtm_do_action+0x24/0x40 [lkdtm] (ed5019fdf5e53be37cb1ba7899=
292d7e143b259e)
> > >=20
> > > Why not just change the "Modules linked in:" portion to show the buil=
d IDs
> > > instead of every function call? Maybe make it a config option to do s=
o?
> > >=20
> >=20
> > As I wrote in the commit text
> >=20
> > =E2=94=82 An alternative to changing the printk format would be to upda=
te the                                                                     =
                                                                       =20
> > =E2=94=82 "Modules linked in:" line to include the build ID of each mod=
ule linked                                                                 =
                                                                       =20
> > =E2=94=82 in. This can become quite long when many modules are loaded (=
i.e. on a                                                                  =
                                                                       =20
> > =E2=94=82 distro) so I've opted for the printk format instead.
> >=20
> > Implementing it is fairly simple compared to a new printk format. In
> > fact I did that initially but decided against it because it felt
> > unreadable and provided more information than was necessary if the
> > stacktrace wasn't in a module.
> >=20
> > Example:
> >=20
> >  Modules linked in: rfcomm 4de3e669b9fee915 algif_hash 915c61c32d476f01=
 algif_skcipher 53a4a330149bf071 af_alg b49d66496907f376 xt_cgroup 36fbbb65=
e7620df9 uinput a0ff6a06c1c53685 xt_MASQUERADE d130585f728315d2 snd_soc_sc7=
180 5c130cd310c81a12 venus_dec 2071e263fde9ca07 qcom_spmi_temp_alarm 41e28f=
2a9cc8b562 qcom_spmi_adc_tm5 7e0e48d0b6550c7a qcom_spmi_adc5 40b81a00bc2d0c=
1d qcom_vadc_common 09bb012dd1662dea snd_soc_rt5682_i2c c92b8935ad4a1729 ve=
nus_enc efaf3335b88287bf snd_soc_qcom_common 56d1e87c267ed02e videobuf2_dma=
_sg e9bc3c9e2758dfc9 snd_soc_rt5682 c4c9b31bf9a43f8b snd_soc_rl6231 908446e=
32436898c hci_uart 107b5fe6884df077 btqca 401a2fcc17b80a39 bluetooth 3369c8=
81496a3cf8 venus_core a11eee3aa201ad8e ecdh_generic 883e01f98b778108 ecc 22=
6b258cf40ad1ba v4l2_mem2mem 592f197cbad39e6b snd_soc_lpass_sc7180 42a99cb81=
2d5e2e3 snd_soc_lpass_hdmi 95cce2160cfc58e2 snd_soc_lpass_cpu 475a4b395577a=
ffd snd_soc_lpass_platform 67517083263035ec snd_soc_max98357a 03ec1af0493d1=
c59
> >   fuse 82d170244a4d4ac6 iio_trig_sysfs b879a6228e059834 cros_ec_lid_ang=
le a713c5f0a06a7a82 cros_ec_sensors 03f0c142ec521f67 cros_ec_sensors_core a=
da3f44647980056 cros_ec_sensors_ring f99590e87e998485 industrialio_triggere=
d_buffer c697969d67f73d77 kfifo_buf e8a3aeb3069188f0 cros_ec_sensorhub 041e=
d1ffcefc991b ath10k_snoc 2f60802a74ff6ca7 lzo_rle 49a6228cec0c6885 ath10k_c=
ore 9407c36a2b8f8fae lzo_compress e9b4375d4bad668a ath 20c585ba6f3998f0 zra=
m c5cdfc1d7d8a35d9 mac80211 9eaed1c76e000c02 cfg80211 872178d2dcebb722 cdc_=
ether 2baa214f72289402 usbnet 2bec73d0922ade28 uvcvideo eee0352cb1846ee4 r8=
152 47b76561b78e9b1b mii b306d150923fe614 videobuf2_vmalloc 55431ec52fa6af8=
4 videobuf2_memops 4d43ad18fa7b1e4e videobuf2_v4l2 cdda06b9d95ab11d videobu=
f2_common 69cef0ca55a70a4a joydev 148399325b72d4a0
> >=20
> > compared to=20
> >=20
> >  Modules linked in: rfcomm algif_hash algif_skcipher af_alg xt_cgroup u=
input xt_MASQUERADE snd_soc_sc7180 venus_dec qcom_spmi_temp_alarm qcom_spmi=
_adc_tm5 qcom_spmi_adc5 qcom_vadc_common snd_soc_rt5682_i2c venus_enc snd_s=
oc_qcom_common videobuf2_dma_sg snd_soc_rt5682 snd_soc_rl6231 hci_uart btqc=
a bluetooth venus_core ecdh_generic ecc v4l2_mem2mem snd_soc_lpass_sc7180 s=
nd_soc_lpass_hdmi snd_soc_lpass_cpu snd_soc_lpass_platform snd_soc_max98357=
a=20
> >   fuse iio_trig_sysfs cros_ec_lid_angle cros_ec_sensors cros_ec_sensors=
_core cros_ec_sensors_ring industrialio_triggered_buffer kfifo_buf cros_ec_=
sensorhub ath10k_snoc lzo_rle ath10k_core lzo_compress ath zram mac80211 cf=
g80211 cdc_ether usbnet uvcvideo r8152 mii videobuf2_vmalloc videobuf2_memo=
ps videobuf2_v4l2 videobuf2_common joydev=20
> > I suppose it could be surrounded by parenthesis or brackets and that
> > would be a little better? I'll try this approach again and see what
> > folks think.
>=20
> But you can do:
> Modules linked: module1 [buildidX]
>  module2 [buildidY]
>  module3 [buildidZ]
> ...
>=20
> i.o.w. one module per line.
>=20
> * Yes, I understand that downside maybe split message, so it's just for
> consideration.
>=20

Yes that's another option. We could put every module on a different
line. That could be over 100 more lines of error message though. That's
probably a bad idea? Or we could print at most 5, 10 or 20 modules per
line. Given that the build id is 20 characters and then 2 brackets, 4 or
5 modules per line comes out to 120 to 150 or so characters per line.

Right now I see this:

 WARNING: CPU: 1 PID: 2124 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x=
28/0x30 [lkdtm]
 Modules linked in: vhost_vsock[b5de74de4890f7f9b6c6b9a75bf75cf2b7f828b9] v=
mw_vsock_virtio_transport_common[939626f71b43da4aab49d0490a3d86da3647f0ec] =
vsock[edf8bdd739f3bc46d8b9ee00fd5243e0d719aceb] vhost[d2f63a2bc2d33122a520e=
a624a5ed45709691edc] vhost_iotlb[4042a67c527796e0e2e19b9acd5b38c938e19bf8] =
lkdtm[6c2215028606bda50de823490723dc4bc5bf46f9] rfcomm[1853b40495371f7bbfdc=
07d27018693d0a65e32e] algif_hash[d0035cb2ccdd3e20faea6138168f5b3ee7f55027] =
algif_skcipher[290ded176708249e5f3fe6c20fb2645f46c38c7b] af_alg[9e1891ab464=
76a7f1252a23b14a8e8fd59026986] xt_cgroup[3b8d96cd8b13e760e88162b441be9ceb98=
500f75] uinput[3027573e498d509f71b6cb29aa7474bac9fbdba6] uvcvideo[a7676ff13=
9a41297fcc33b80582af3ef68bbdbfa] videobuf2_vmalloc[591709b0f39979156cf3e8b9=
0a61af75da36902a] xt_MASQUERADE[52bbd416ac57cf9c1081cb85ae0dd46fe7c256c7] v=
enus_dec[50bf3f03f8a694acfe61f66dcdac73fde4b08384] videobuf2_dma_sg[a4d4ec2=
1723a234278ddfe27081033ce366e82f4] hci_uart[152d461e1a2a8b5831507fc96fe18cd=
94391d5db]
  videobuf2_memops[3b3feac7d6440b52ac9fde356cc434f98b26f91d] btqca[0f921bc6=
d55432a7552dbe0677477d81bb44c6e4] bluetooth[8a98be2c3e842b9c1284775096c3d35=
04d5723e5] ath10k_snoc[525af7ae4d44d0f467980b67769cacaf6d9a5445] cros_ec_ty=
pec[9bc93ec5d8d14765642576b24901d5313c5db1b4] venus_core[3cea3f6cd84bdaee7b=
bce46f58d1eb0bf046763c] typec[e90cdc31cd39d173af46fa3b964215c8d0316534] ecd=
h_generic[26db794ec69dcbfbabf8dec23c7311ca529dbe6f] qcom_spmi_adc5[5fd6407c=
665b2af74b8b7d7a7f2ee49e6cec0bdf] ath10k_core[f54f6fd17fb433f83d1c60e32737b=
eba72fbd151] qcom_spmi_temp_alarm[74c703822ed24645942437dda1772bc9cfdc431b]=
 ecc[328c5244919fb66e50bd7319de74a73232d23e42] qcom_vadc_common[bc2afd1da3c=
27b19cfd96ea70bf23ffd710e2aad] snd_soc_rt5682_i2c[4296e093615aaf4ec303fb605=
bb4d870f4cf2eb4] snd_soc_rt5682[eb897b37a96eb95bae1581adf4cd0386b224cc4d] v=
4l2_mem2mem[b4b843c3844f4c492d0e9f89714fb7133e1d3e8c] snd_soc_sc7180[8216ab=
c2f56916ca36e5073b776ed493f1af8e4e]
  snd_soc_qcom_common[54fbd61a2f457db385b40ae0a37c5a0719e2a8de] videobuf2_v=
4l2[d100d30e4b9ad480471dab30494d85d1ae2f4044] snd_soc_lpass_sc7180[aa5e3313=
ee630c10a1c890213c8777f6365f5ef5] ath[8f4ab51a49478f7955b3a2a95101de0de4bf0=
864] snd_soc_rl6231[a668e6b9790e698a5f64e3e0e45713adce578de7] videobuf2_com=
mon[bd4f81493fa674a6804ecf3244932f5a3e921d5d] snd_soc_lpass_hdmi[90a3aaff7f=
90ed2086b896bbdd9df09e48e3a6f6] snd_soc_lpass_cpu[c3f3eefc220abcf50857b0c20=
2b0002ebf90a41a] snd_soc_lpass_platform[9a20405ac4e1778db7632aecf68c5cf777d=
c4254] mac80211[6f6acbb06c6c2c9538c37062bbfa4865708bf66b] snd_soc_max98357a=
[61ed67be8e6cf3c82da549b30f09c8ec1dbf7270] fuse[3b0043fe3eec1552df28ffc568b=
f787d75347269] iio_trig_sysfs[43a2fd24bb26966e7faa3f7532193407afb9b1ae] cro=
s_ec_lid_angle[2e7c1c179ab8c9ee76f8abcd6e6139546743cf84] cros_ec_sensors[1b=
f8ac89e90b6549b9935729882722eda7b924fa] cros_ec_sensors_core[273e9b0a90fbb7=
066e55023a27f8b6d86371018f] cros_ec_sensors_ring[16ff4eb75deb8bcd81b1ddc5ee=
a1eecf32c7fb14]
  industrialio_triggered_buffer[8fe79c5203ccb4f16ed9638554924a42c4a7ec9d] k=
fifo_buf[c1b3c4d10b52365c3887ba106b3b879c04f96f1d] cfg80211[c4084b0457e32a8=
408e230cdbc22432ace087c31] cros_ec_sensorhub[e1e51bc2c5324bb000c335ce427263=
cd17974144] lzo_rle[7c620147cbf701a30e9efa51c176394f2534a2a5] lzo_compress[=
4fcd02f3181b4d541032ff1f1759d482205e7c5c] zram[bec5be42fb85409cb0776b5d63c1=
a257b15af2ef] r8152[0a4bcdca4912d965082c8e0f27c2325c3b3e48d3] mii[0e4046722=
1c7b7455a93ceafea794e4ce5c4d09e] joydev[0eabd30a73ec9378792dfb343ed38c2ad5a=
599bc]
 CPU: 1 PID: 2124 Comm: bash Not tainted 5.11 #6 5a995ea7d5d0bd2ed0ccfc90e8=
c36fcccc04b81b
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=3D--)
 pc : lkdtm_WARNING+0x28/0x30 [lkdtm]
 lr : lkdtm_do_action+0x24/0x40 [lkdtm]
 sp : ffffffc013043ca0
 x29: ffffffc013043ca0 x28: ffffff987e295540=20
 x27: 0000000000000000 x26: 0000000000000000=20
 x25: 0000000000000000 x24: ffffffe179b7b2c0=20
 x23: 0000000000000020 x22: ffffffe179b79366=20
 x21: ffffffe179b7b2e0 x20: ffffffc013043de0=20
 x19: 0000000000000008 x18: 0000000000000000=20
 x17: ffffff9847b569fc x16: 0000000000000000=20
 x15: 0000000000000000 x14: 0000000000000012=20
 x13: ffffffe1d96d892c x12: ffffffe1da505068=20
 x11: 0000000000000000 x10: 0000000000000000=20
 x9 : 0000000000000001 x8 : ffffffe179b7d000=20
 x7 : aaaaaaaaaaaaaaaa x6 : 0000000000000000=20
 x5 : 0000000000000000 x4 : 0000000000000001=20
 x3 : 0000000000000008 x2 : ffffff99beec5a70=20
 x1 : ffffff99beeb5788 x0 : ffffffe179b7b2e0=20
 Call trace:
  lkdtm_WARNING+0x28/0x30 [lkdtm]
  direct_entry+0x16c/0x1b4 [lkdtm]
  full_proxy_write+0x74/0xa4
  vfs_write+0xec/0x2e8
  ksys_write+0x84/0xf0
  __arm64_sys_write+0x24/0x30
  el0_svc_common+0xf4/0x1c0
  do_el0_svc_compat+0x28/0x3c
  el0_svc_compat+0x10/0x1c
  el0_sync_compat_handler+0xa8/0xcc
  el0_sync_compat+0x178/0x180
 ---[ end trace e1c971e4a46de18e ]---

And here's 10 per line with spacing

 WARNING: CPU: 0 PID: 2009 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x=
28/0x30 [lkdtm]
 Modules linked in: lkdtm [6c2215028606bda50de823490723dc4bc5bf46f9] rfcomm=
 [1853b40495371f7bbfdc07d27018693d0a65e32e] algif_hash [d0035cb2ccdd3e20fae=
a6138168f5b3ee7f55027] algif_skcipher [290ded176708249e5f3fe6c20fb2645f46c3=
8c7b] af_alg [9e1891ab46476a7f1252a23b14a8e8fd59026986] xt_cgroup [3b8d96cd=
8b13e760e88162b441be9ceb98500f75] uinput [3027573e498d509f71b6cb29aa7474bac=
9fbdba6] uvcvideo [a7676ff139a41297fcc33b80582af3ef68bbdbfa] videobuf2_vmal=
loc [591709b0f39979156cf3e8b90a61af75da36902a] xt_MASQUERADE [52bbd416ac57c=
f9c1081cb85ae0dd46fe7c256c7]
  venus_dec [50bf3f03f8a694acfe61f66dcdac73fde4b08384] videobuf2_dma_sg [a4=
d4ec21723a234278ddfe27081033ce366e82f4] videobuf2_memops [3b3feac7d6440b52a=
c9fde356cc434f98b26f91d] hci_uart [152d461e1a2a8b5831507fc96fe18cd94391d5db=
] btqca [0f921bc6d55432a7552dbe0677477d81bb44c6e4] bluetooth [8a98be2c3e842=
b9c1284775096c3d3504d5723e5] venus_core [3cea3f6cd84bdaee7bbce46f58d1eb0bf0=
46763c] ath10k_snoc [525af7ae4d44d0f467980b67769cacaf6d9a5445] ecdh_generic=
 [26db794ec69dcbfbabf8dec23c7311ca529dbe6f] v4l2_mem2mem [b4b843c3844f4c492=
d0e9f89714fb7133e1d3e8c]
  videobuf2_v4l2 [d100d30e4b9ad480471dab30494d85d1ae2f4044] cros_ec_typec [=
9bc93ec5d8d14765642576b24901d5313c5db1b4] ath10k_core [f54f6fd17fb433f83d1c=
60e32737beba72fbd151] qcom_spmi_adc5 [5fd6407c665b2af74b8b7d7a7f2ee49e6cec0=
bdf] videobuf2_common [bd4f81493fa674a6804ecf3244932f5a3e921d5d] typec [e90=
cdc31cd39d173af46fa3b964215c8d0316534] snd_soc_sc7180 [8216abc2f56916ca36e5=
073b776ed493f1af8e4e] snd_soc_rt5682_i2c [4296e093615aaf4ec303fb605bb4d870f=
4cf2eb4] ecc [328c5244919fb66e50bd7319de74a73232d23e42] qcom_vadc_common [b=
c2afd1da3c27b19cfd96ea70bf23ffd710e2aad]
  snd_soc_rt5682 [eb897b37a96eb95bae1581adf4cd0386b224cc4d] qcom_spmi_temp_=
alarm [74c703822ed24645942437dda1772bc9cfdc431b] ath [8f4ab51a49478f7955b3a=
2a95101de0de4bf0864] snd_soc_qcom_common [54fbd61a2f457db385b40ae0a37c5a071=
9e2a8de] snd_soc_rl6231 [a668e6b9790e698a5f64e3e0e45713adce578de7] snd_soc_=
lpass_sc7180 [aa5e3313ee630c10a1c890213c8777f6365f5ef5] snd_soc_lpass_hdmi =
[90a3aaff7f90ed2086b896bbdd9df09e48e3a6f6] snd_soc_lpass_cpu [c3f3eefc220ab=
cf50857b0c202b0002ebf90a41a] mac80211 [6f6acbb06c6c2c9538c37062bbfa4865708b=
f66b] snd_soc_lpass_platform [9a20405ac4e1778db7632aecf68c5cf777dc4254]
  snd_soc_max98357a [61ed67be8e6cf3c82da549b30f09c8ec1dbf7270] fuse [3b0043=
fe3eec1552df28ffc568bf787d75347269] cfg80211 [c4084b0457e32a8408e230cdbc224=
32ace087c31] iio_trig_sysfs [43a2fd24bb26966e7faa3f7532193407afb9b1ae] cros=
_ec_lid_angle [2e7c1c179ab8c9ee76f8abcd6e6139546743cf84] cros_ec_sensors [1=
bf8ac89e90b6549b9935729882722eda7b924fa] cros_ec_sensors_core [273e9b0a90fb=
b7066e55023a27f8b6d86371018f] industrialio_triggered_buffer [8fe79c5203ccb4=
f16ed9638554924a42c4a7ec9d] cros_ec_sensors_ring [16ff4eb75deb8bcd81b1ddc5e=
ea1eecf32c7fb14] kfifo_buf [c1b3c4d10b52365c3887ba106b3b879c04f96f1d]
  cros_ec_sensorhub [e1e51bc2c5324bb000c335ce427263cd17974144] lzo_rle [7c6=
20147cbf701a30e9efa51c176394f2534a2a5] lzo_compress [4fcd02f3181b4d541032ff=
1f1759d482205e7c5c] zram [bec5be42fb85409cb0776b5d63c1a257b15af2ef] r8152 [=
0a4bcdca4912d965082c8e0f27c2325c3b3e48d3] mii [0e40467221c7b7455a93ceafea79=
4e4ce5c4d09e] [last unloaded: joydev]
 CPU: 0 PID: 2009 Comm: bash Not tainted 5.11 #8 715ebac18cc41a59b9a429ad92=
73467cba4680ae
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=3D--)
 pc : lkdtm_WARNING+0x28/0x30 [lkdtm]
 lr : lkdtm_do_action+0x24/0x40 [lkdtm]
 sp : ffffffc012e9bca0
 x29: ffffffc012e9bca0 x28: ffffffbc34fbc440=20
 x27: 0000000000000000 x26: 0000000000000000=20
 x25: 0000000000000000 x24: ffffffdc41c382c0=20
 x23: 0000000000000020 x22: ffffffdc41c36366=20
 x21: ffffffdc41c382e0 x20: ffffffc012e9bde0=20
 x19: 0000000000000008 x18: ffffffbc1bf65618=20
 x17: ffffffbc003cc7fc x16: 0000000000000000=20
 x15: 001d23f6e6650cfa x14: 0000000000000012=20
 x13: ffffffdcad4d892c x12: ffffffdcadef2c94=20
 x11: 0000000000000000 x10: 0000000000000000=20
 x9 : 0000000000000001 x8 : ffffffdc41c3a000=20
 x7 : bbbbbbbbbbbbbbbb x6 : 0000000000000020=20
 x5 : ffffffc010683d40 x4 : 0000000000000001=20
 x3 : 0000000000000008 x2 : ffffffbd7eea5a70=20
 x1 : ffffffbd7ee95788 x0 : ffffffdc41c382e0=20
 Call trace:
  lkdtm_WARNING+0x28/0x30 [lkdtm]
  direct_entry+0x16c/0x1b4 [lkdtm]
  full_proxy_write+0x74/0xa4
  vfs_write+0xec/0x2e8
  ksys_write+0x84/0xf0
  __arm64_sys_write+0x24/0x30
  el0_svc_common+0xf4/0x1c0
  do_el0_svc_compat+0x28/0x3c
  el0_svc_compat+0x10/0x1c
  el0_sync_compat_handler+0xa8/0xcc
  el0_sync_compat+0x178/0x180
 ---[ end trace 5f51a26c92780793 ]---

5 looks pretty nice

 WARNING: CPU: 2 PID: 3836 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x=
28/0x30 [lkdtm]
 Modules linked in: lkdtm [6c2215028606bda50de823490723dc4bc5bf46f9] vhost_=
vsock [b5de74de4890f7f9b6c6b9a75bf75cf2b7f828b9] vmw_vsock_virtio_transport=
_common [939626f71b43da4aab49d0490a3d86da3647f0ec] vsock [edf8bdd739f3bc46d=
8b9ee00fd5243e0d719aceb] vhost [d2f63a2bc2d33122a520ea624a5ed45709691edc]
  vhost_iotlb [4042a67c527796e0e2e19b9acd5b38c938e19bf8] rfcomm [1853b40495=
371f7bbfdc07d27018693d0a65e32e] algif_hash [d0035cb2ccdd3e20faea6138168f5b3=
ee7f55027] algif_skcipher [290ded176708249e5f3fe6c20fb2645f46c38c7b] af_alg=
 [9e1891ab46476a7f1252a23b14a8e8fd59026986]
  uinput [3027573e498d509f71b6cb29aa7474bac9fbdba6] xt_cgroup [3b8d96cd8b13=
e760e88162b441be9ceb98500f75] uvcvideo [a7676ff139a41297fcc33b80582af3ef68b=
bdbfa] videobuf2_vmalloc [591709b0f39979156cf3e8b90a61af75da36902a] xt_MASQ=
UERADE [52bbd416ac57cf9c1081cb85ae0dd46fe7c256c7]
  venus_dec [50bf3f03f8a694acfe61f66dcdac73fde4b08384] videobuf2_dma_sg [a4=
d4ec21723a234278ddfe27081033ce366e82f4] hci_uart [152d461e1a2a8b5831507fc96=
fe18cd94391d5db] btqca [0f921bc6d55432a7552dbe0677477d81bb44c6e4] videobuf2=
_memops [3b3feac7d6440b52ac9fde356cc434f98b26f91d]
  snd_soc_rt5682_i2c [4296e093615aaf4ec303fb605bb4d870f4cf2eb4] qcom_spmi_t=
emp_alarm [74c703822ed24645942437dda1772bc9cfdc431b] snd_soc_rt5682 [eb897b=
37a96eb95bae1581adf4cd0386b224cc4d] snd_soc_sc7180 [8216abc2f56916ca36e5073=
b776ed493f1af8e4e] qcom_spmi_adc5 [5fd6407c665b2af74b8b7d7a7f2ee49e6cec0bdf]
  qcom_vadc_common [bc2afd1da3c27b19cfd96ea70bf23ffd710e2aad] bluetooth [8a=
98be2c3e842b9c1284775096c3d3504d5723e5] snd_soc_qcom_common [54fbd61a2f457d=
b385b40ae0a37c5a0719e2a8de] snd_soc_rl6231 [a668e6b9790e698a5f64e3e0e45713a=
dce578de7] ecdh_generic [26db794ec69dcbfbabf8dec23c7311ca529dbe6f]
  ecc [328c5244919fb66e50bd7319de74a73232d23e42] ath10k_snoc [525af7ae4d44d=
0f467980b67769cacaf6d9a5445] cros_ec_typec [9bc93ec5d8d14765642576b24901d53=
13c5db1b4] ath10k_core [f54f6fd17fb433f83d1c60e32737beba72fbd151] typec [e9=
0cdc31cd39d173af46fa3b964215c8d0316534]
  venus_core [3cea3f6cd84bdaee7bbce46f58d1eb0bf046763c] v4l2_mem2mem [b4b84=
3c3844f4c492d0e9f89714fb7133e1d3e8c] videobuf2_v4l2 [d100d30e4b9ad480471dab=
30494d85d1ae2f4044] videobuf2_common [bd4f81493fa674a6804ecf3244932f5a3e921=
d5d] snd_soc_lpass_sc7180 [aa5e3313ee630c10a1c890213c8777f6365f5ef5]
  ath [8f4ab51a49478f7955b3a2a95101de0de4bf0864] snd_soc_lpass_hdmi [90a3aa=
ff7f90ed2086b896bbdd9df09e48e3a6f6] snd_soc_lpass_cpu [c3f3eefc220abcf50857=
b0c202b0002ebf90a41a] snd_soc_lpass_platform [9a20405ac4e1778db7632aecf68c5=
cf777dc4254] mac80211 [6f6acbb06c6c2c9538c37062bbfa4865708bf66b]
  snd_soc_max98357a [61ed67be8e6cf3c82da549b30f09c8ec1dbf7270] fuse [3b0043=
fe3eec1552df28ffc568bf787d75347269] iio_trig_sysfs [43a2fd24bb26966e7faa3f7=
532193407afb9b1ae] cfg80211 [c4084b0457e32a8408e230cdbc22432ace087c31] cros=
_ec_sensors_ring [16ff4eb75deb8bcd81b1ddc5eea1eecf32c7fb14]
  cros_ec_lid_angle [2e7c1c179ab8c9ee76f8abcd6e6139546743cf84] cros_ec_sens=
ors [1bf8ac89e90b6549b9935729882722eda7b924fa] cros_ec_sensors_core [273e9b=
0a90fbb7066e55023a27f8b6d86371018f] industrialio_triggered_buffer [8fe79c52=
03ccb4f16ed9638554924a42c4a7ec9d] kfifo_buf [c1b3c4d10b52365c3887ba106b3b87=
9c04f96f1d]
  cros_ec_sensorhub [e1e51bc2c5324bb000c335ce427263cd17974144] lzo_rle [7c6=
20147cbf701a30e9efa51c176394f2534a2a5] lzo_compress [4fcd02f3181b4d541032ff=
1f1759d482205e7c5c] zram [bec5be42fb85409cb0776b5d63c1a257b15af2ef] cdc_eth=
er [ced80b6f61771514901ed65242f51b60f2fe762b]
  usbnet [6b967ceea5e9faff6f054218e2a7fc4296313688] r8152 [0a4bcdca4912d965=
082c8e0f27c2325c3b3e48d3] mii [0e40467221c7b7455a93ceafea794e4ce5c4d09e] [l=
ast unloaded: joydev]
 CPU: 2 PID: 3836 Comm: bash Not tainted 5.11 #9 775145666670b360a22616ad81=
88bd8edf5dfd36
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=3D--)
 pc : lkdtm_WARNING+0x28/0x30 [lkdtm]
 lr : lkdtm_do_action+0x24/0x40 [lkdtm]
 sp : ffffffc01892bca0
 x29: ffffffc01892bca0 x28: ffffff9329533340=20
 x27: 0000000000000000 x26: 0000000000000000=20
 x25: 0000000000000000 x24: ffffffe95a2cc2c0=20
 x23: 0000000000000020 x22: ffffffe95a2ca366=20
 x21: ffffffe95a2cc2e0 x20: ffffffc01892bde0=20
 x19: 0000000000000008 x18: 0000000000000000=20
 x17: 0000000000000000 x16: 0000000000000037=20
 x15: ffffffe98d6ab134 x14: 0000000000000003=20
 x13: 0000000000000004 x12: 0000000000000000=20
 x11: 0000000000000000 x10: 0000000000000000=20
 x9 : 0000000000000001 x8 : ffffffe95a2ce000=20
 x7 : 0000000000000000 x6 : ffffffe98e3f6b54=20
 x5 : 0000000000000000 x4 : 0000000000000000=20
 x3 : ffffffc01892b938 x2 : ffffff947eee5a70=20
 x1 : ffffff947eed5788 x0 : ffffffe95a2cc2e0=20
 Call trace:
  lkdtm_WARNING+0x28/0x30 [lkdtm]
  direct_entry+0x16c/0x1b4 [lkdtm]
  full_proxy_write+0x74/0xa4
  vfs_write+0xec/0x2e8
  ksys_write+0x84/0xf0
  __arm64_sys_write+0x24/0x30
  el0_svc_common+0xf4/0x1c0
  do_el0_svc_compat+0x28/0x3c
  el0_svc_compat+0x10/0x1c
  el0_sync_compat_handler+0xa8/0xcc
  el0_sync_compat+0x178/0x180
 ---[ end trace afd0105bfc489130 ]---

 And the one per line approach

 WARNING: CPU: 1 PID: 3402 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x=
28/0x30 [lkdtm]
 Modules linked in: lkdtm [6c2215028606bda50de823490723dc4bc5bf46f9]
  rfcomm [1853b40495371f7bbfdc07d27018693d0a65e32e]
  algif_hash [d0035cb2ccdd3e20faea6138168f5b3ee7f55027]
  algif_skcipher [290ded176708249e5f3fe6c20fb2645f46c38c7b]
  af_alg [9e1891ab46476a7f1252a23b14a8e8fd59026986]
  xt_cgroup [3b8d96cd8b13e760e88162b441be9ceb98500f75]
  uinput [3027573e498d509f71b6cb29aa7474bac9fbdba6]
  venus_dec [50bf3f03f8a694acfe61f66dcdac73fde4b08384]
  videobuf2_dma_sg [a4d4ec21723a234278ddfe27081033ce366e82f4]
  xt_MASQUERADE [52bbd416ac57cf9c1081cb85ae0dd46fe7c256c7]
  qcom_spmi_adc5 [5fd6407c665b2af74b8b7d7a7f2ee49e6cec0bdf]
  hci_uart [152d461e1a2a8b5831507fc96fe18cd94391d5db]
  btqca [0f921bc6d55432a7552dbe0677477d81bb44c6e4]
  qcom_spmi_temp_alarm [74c703822ed24645942437dda1772bc9cfdc431b]
  qcom_vadc_common [bc2afd1da3c27b19cfd96ea70bf23ffd710e2aad]
  bluetooth [8a98be2c3e842b9c1284775096c3d3504d5723e5]
  snd_soc_sc7180 [8216abc2f56916ca36e5073b776ed493f1af8e4e]
  snd_soc_qcom_common [54fbd61a2f457db385b40ae0a37c5a0719e2a8de]
  ecdh_generic [26db794ec69dcbfbabf8dec23c7311ca529dbe6f]
  ath10k_snoc [525af7ae4d44d0f467980b67769cacaf6d9a5445]
  cros_ec_typec [9bc93ec5d8d14765642576b24901d5313c5db1b4]
  typec [e90cdc31cd39d173af46fa3b964215c8d0316534]
  snd_soc_rt5682_i2c [4296e093615aaf4ec303fb605bb4d870f4cf2eb4]
  ecc [328c5244919fb66e50bd7319de74a73232d23e42]
  ath10k_core [f54f6fd17fb433f83d1c60e32737beba72fbd151]
  snd_soc_rt5682 [eb897b37a96eb95bae1581adf4cd0386b224cc4d]
  venus_core [3cea3f6cd84bdaee7bbce46f58d1eb0bf046763c]
  snd_soc_rl6231 [a668e6b9790e698a5f64e3e0e45713adce578de7]
  ath [8f4ab51a49478f7955b3a2a95101de0de4bf0864]
  v4l2_mem2mem [b4b843c3844f4c492d0e9f89714fb7133e1d3e8c]
  snd_soc_lpass_sc7180 [aa5e3313ee630c10a1c890213c8777f6365f5ef5]
  mac80211 [6f6acbb06c6c2c9538c37062bbfa4865708bf66b]
  snd_soc_lpass_hdmi [90a3aaff7f90ed2086b896bbdd9df09e48e3a6f6]
  snd_soc_lpass_cpu [c3f3eefc220abcf50857b0c202b0002ebf90a41a]
  snd_soc_lpass_platform [9a20405ac4e1778db7632aecf68c5cf777dc4254]
  snd_soc_max98357a [61ed67be8e6cf3c82da549b30f09c8ec1dbf7270]
  fuse [3b0043fe3eec1552df28ffc568bf787d75347269]
  iio_trig_sysfs [43a2fd24bb26966e7faa3f7532193407afb9b1ae]
  cfg80211 [c4084b0457e32a8408e230cdbc22432ace087c31]
  cros_ec_lid_angle [2e7c1c179ab8c9ee76f8abcd6e6139546743cf84]
  cros_ec_sensors_ring [16ff4eb75deb8bcd81b1ddc5eea1eecf32c7fb14]
  cros_ec_sensors [1bf8ac89e90b6549b9935729882722eda7b924fa]
  cros_ec_sensors_core [273e9b0a90fbb7066e55023a27f8b6d86371018f]
  industrialio_triggered_buffer [8fe79c5203ccb4f16ed9638554924a42c4a7ec9d]
  kfifo_buf [c1b3c4d10b52365c3887ba106b3b879c04f96f1d]
  cros_ec_sensorhub [e1e51bc2c5324bb000c335ce427263cd17974144]
  lzo_rle [7c620147cbf701a30e9efa51c176394f2534a2a5]
  lzo_compress [4fcd02f3181b4d541032ff1f1759d482205e7c5c]
  zram [bec5be42fb85409cb0776b5d63c1a257b15af2ef]
  cdc_ether [ced80b6f61771514901ed65242f51b60f2fe762b]
  usbnet [6b967ceea5e9faff6f054218e2a7fc4296313688]
  r8152 [0a4bcdca4912d965082c8e0f27c2325c3b3e48d3]
  uvcvideo [a7676ff139a41297fcc33b80582af3ef68bbdbfa]
  mii [0e40467221c7b7455a93ceafea794e4ce5c4d09e]
  videobuf2_vmalloc [591709b0f39979156cf3e8b90a61af75da36902a]
  videobuf2_memops [3b3feac7d6440b52ac9fde356cc434f98b26f91d]
  videobuf2_v4l2 [d100d30e4b9ad480471dab30494d85d1ae2f4044]
  videobuf2_common [bd4f81493fa674a6804ecf3244932f5a3e921d5d]
  joydev [0eabd30a73ec9378792dfb343ed38c2ad5a599bc]
 CPU: 1 PID: 3402 Comm: bash Not tainted 5.11 #10 03359bc46737cb22e11f0e92c=
efc7144afedf9c3
 Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
 pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=3D--)
 pc : lkdtm_WARNING+0x28/0x30 [lkdtm]
 lr : lkdtm_do_action+0x24/0x40 [lkdtm]
 sp : ffffffc0125cbca0
 x29: ffffffc0125cbca0 x28: ffffffb26a3a8040=20
 x27: 0000000000000000 x26: 0000000000000000=20
 x25: 0000000000000000 x24: ffffffdd7129b2c0=20
 x23: 0000000000000020 x22: ffffffdd71299366=20
 x21: ffffffdd7129b2e0 x20: ffffffc0125cbde0=20
 x19: 0000000000000008 x18: 0000000000000000=20
 x17: 0000000000000000 x16: 0000000000000037=20
 x15: ffffffdd908ab0b4 x14: 0000000000000003=20
 x13: 0000000000000004 x12: 0000000000000000=20
 x11: 0000000000000000 x10: 0000000000000000=20
 x9 : 0000000000000001 x8 : ffffffdd7129d000=20
 x7 : 0000000000000000 x6 : ffffffdd915f6b54=20
 x5 : 0000000000000000 x4 : 0000000000000000=20
 x3 : ffffffc0125cb938 x2 : ffffffb3beec5a70=20
 x1 : ffffffb3beeb5788 x0 : ffffffdd7129b2e0=20
 Call trace:
  lkdtm_WARNING+0x28/0x30 [lkdtm]
  direct_entry+0x16c/0x1b4 [lkdtm]
  full_proxy_write+0x74/0xa4
  vfs_write+0xec/0x2e8
  ksys_write+0x84/0xf0
  __arm64_sys_write+0x24/0x30
  el0_svc_common+0xf4/0x1c0
  do_el0_svc_compat+0x28/0x3c
  el0_svc_compat+0x10/0x1c
  el0_sync_compat_handler+0xa8/0xcc
  el0_sync_compat+0x178/0x180
 ---[ end trace de6a15f0c875cfee ]---
