Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0932BD44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448686AbhCCPmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:42:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:5678 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357340AbhCCKt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:49:29 -0500
IronPort-SDR: CjZoDPzn0aSsNNDv60/nXalcwtH42Pij7jT0NW7npe6G09m6JpIYX++XaaK8BmmsDx/hDHQOdK
 uDuUjqnh/lKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="187198599"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="187198599"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 00:21:36 -0800
IronPort-SDR: qHA1K7Qn1BJsaz7fU0+bn7bDpllENc2l1wteDUW/VwqvWsIyaXjUWOZfUvraJPYK5gSaZu80EK
 fqkRch3mNs+w==
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="435946065"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 00:19:21 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lHMin-009ais-Mx; Wed, 03 Mar 2021 10:19:05 +0200
Date:   Wed, 3 Mar 2021 10:19:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
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
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
Message-ID: <YD9GeXcKbF3bsDLo@smile.fi.intel.com>
References: <20210301174749.1269154-1-swboyd@chromium.org>
 <20210301174749.1269154-6-swboyd@chromium.org>
 <20210302210136.3ded3ab3@gandalf.local.home>
 <161474043200.1478170.15118093304775120279@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <161474043200.1478170.15118093304775120279@swboyd.mtv.corp.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 07:00:32PM -0800, Stephen Boyd wrote:
> Quoting Steven Rostedt (2021-03-02 18:01:36)
> > On Mon,  1 Mar 2021 09:47:47 -0800
> > Stephen Boyd <swboyd@chromium.org> wrote:
> > 
> > >  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
> > >  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE
> > >  CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de205662d5a9e0d4c580f19a1
> > >  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
> > >  pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=--)
> > >  pc : lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
> > >  lr : lkdtm_do_action+0x24/0x40 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
> > 
> > Why not just change the "Modules linked in:" portion to show the build IDs
> > instead of every function call? Maybe make it a config option to do so?
> > 
> 
> As I wrote in the commit text
> 
> │ An alternative to changing the printk format would be to update the                                                                                                                                             
> │ "Modules linked in:" line to include the build ID of each module linked                                                                                                                                         
> │ in. This can become quite long when many modules are loaded (i.e. on a                                                                                                                                          
> │ distro) so I've opted for the printk format instead.
> 
> Implementing it is fairly simple compared to a new printk format. In
> fact I did that initially but decided against it because it felt
> unreadable and provided more information than was necessary if the
> stacktrace wasn't in a module.
> 
> Example:
> 
>  Modules linked in: rfcomm 4de3e669b9fee915 algif_hash 915c61c32d476f01 algif_skcipher 53a4a330149bf071 af_alg b49d66496907f376 xt_cgroup 36fbbb65e7620df9 uinput a0ff6a06c1c53685 xt_MASQUERADE d130585f728315d2 snd_soc_sc7180 5c130cd310c81a12 venus_dec 2071e263fde9ca07 qcom_spmi_temp_alarm 41e28f2a9cc8b562 qcom_spmi_adc_tm5 7e0e48d0b6550c7a qcom_spmi_adc5 40b81a00bc2d0c1d qcom_vadc_common 09bb012dd1662dea snd_soc_rt5682_i2c c92b8935ad4a1729 venus_enc efaf3335b88287bf snd_soc_qcom_common 56d1e87c267ed02e videobuf2_dma_sg e9bc3c9e2758dfc9 snd_soc_rt5682 c4c9b31bf9a43f8b snd_soc_rl6231 908446e32436898c hci_uart 107b5fe6884df077 btqca 401a2fcc17b80a39 bluetooth 3369c881496a3cf8 venus_core a11eee3aa201ad8e ecdh_generic 883e01f98b778108 ecc 226b258cf40ad1ba v4l2_mem2mem 592f197cbad39e6b snd_soc_lpass_sc7180 42a99cb812d5e2e3 snd_soc_lpass_hdmi 95cce2160cfc58e2 snd_soc_lpass_cpu 475a4b395577affd snd_soc_lpass_platform 67517083263035ec snd_soc_max98357a 03ec1af0493d1c59
>   fuse 82d170244a4d4ac6 iio_trig_sysfs b879a6228e059834 cros_ec_lid_angle a713c5f0a06a7a82 cros_ec_sensors 03f0c142ec521f67 cros_ec_sensors_core ada3f44647980056 cros_ec_sensors_ring f99590e87e998485 industrialio_triggered_buffer c697969d67f73d77 kfifo_buf e8a3aeb3069188f0 cros_ec_sensorhub 041ed1ffcefc991b ath10k_snoc 2f60802a74ff6ca7 lzo_rle 49a6228cec0c6885 ath10k_core 9407c36a2b8f8fae lzo_compress e9b4375d4bad668a ath 20c585ba6f3998f0 zram c5cdfc1d7d8a35d9 mac80211 9eaed1c76e000c02 cfg80211 872178d2dcebb722 cdc_ether 2baa214f72289402 usbnet 2bec73d0922ade28 uvcvideo eee0352cb1846ee4 r8152 47b76561b78e9b1b mii b306d150923fe614 videobuf2_vmalloc 55431ec52fa6af84 videobuf2_memops 4d43ad18fa7b1e4e videobuf2_v4l2 cdda06b9d95ab11d videobuf2_common 69cef0ca55a70a4a joydev 148399325b72d4a0
> 
> compared to 
> 
>  Modules linked in: rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE snd_soc_sc7180 venus_dec qcom_spmi_temp_alarm qcom_spmi_adc_tm5 qcom_spmi_adc5 qcom_vadc_common snd_soc_rt5682_i2c venus_enc snd_soc_qcom_common videobuf2_dma_sg snd_soc_rt5682 snd_soc_rl6231 hci_uart btqca bluetooth venus_core ecdh_generic ecc v4l2_mem2mem snd_soc_lpass_sc7180 snd_soc_lpass_hdmi snd_soc_lpass_cpu snd_soc_lpass_platform snd_soc_max98357a 
>   fuse iio_trig_sysfs cros_ec_lid_angle cros_ec_sensors cros_ec_sensors_core cros_ec_sensors_ring industrialio_triggered_buffer kfifo_buf cros_ec_sensorhub ath10k_snoc lzo_rle ath10k_core lzo_compress ath zram mac80211 cfg80211 cdc_ether usbnet uvcvideo r8152 mii videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common joydev 
> I suppose it could be surrounded by parenthesis or brackets and that
> would be a little better? I'll try this approach again and see what
> folks think.

But you can do:
Modules linked: module1 [buildidX]
 module2 [buildidY]
 module3 [buildidZ]
...

i.o.w. one module per line.

* Yes, I understand that downside maybe split message, so it's just for
consideration.

-- 
With Best Regards,
Andy Shevchenko


