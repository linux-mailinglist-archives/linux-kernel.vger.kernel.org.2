Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5178A332A72
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhCIP3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:29:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:61154 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231410AbhCIP3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:29:19 -0500
IronPort-SDR: K6lOzAKmN+HZ8xYshP/ndP1W1RpTxlxq+nam3O4PUQhB+MdaxTaBN++OJAcWvn2E3q8ieHoLqc
 CaYsvruWrVdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9918"; a="208038578"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="208038578"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 07:29:19 -0800
IronPort-SDR: HXhNSzlJcaoWxXYMkJh0n/FLWUC0iN37HDe7/go7waGyvAvW5JPz9GIuQhayOOfHX2Fahu7fN7
 bwUKx3XLRhdw==
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="409775839"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.0.249]) ([10.213.0.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 07:29:16 -0800
Subject: Re: No sound cards detected on Kabylake laptops after upgrade to
 kernel 5.8
To:     Chris Chiu <chris.chiu@canonical.com>,
        pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <CABTNMG31sH99P0F7EKhpFwJf99x4U-VjFWrwXVe1wkra6owFLw@mail.gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <dba864a6-1442-1ebc-9de0-8c1511682b70@intel.com>
Date:   Tue, 9 Mar 2021 16:29:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CABTNMG31sH99P0F7EKhpFwJf99x4U-VjFWrwXVe1wkra6owFLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-09 1:19 PM, Chris Chiu wrote:
> Hi Guys,
>      We have received reports that on some Kabylake laptops (Acer Swift
> SF314-54/55 and Lenovo Yoga C930...etc), all sound cards no longer be
> detected after upgrade to kernel later than 5.8. These laptops have
> one thing in common, all of them have Realtek audio codec and connect
> the internal microphone to DMIC of the Intel SST controller either
> [8086:9d71] or [8086:9dc8]. Please refer to
> https://bugzilla.kernel.org/show_bug.cgi?id=201251#c246 and
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1915117.
> 
>      From the dmesg from kernel 5.8, the sound related parts only show
> as follows but the expected snd_hda_codec_realtek and the snd_soc_skl
> are not even loaded then.
> [ 13.357495] snd_hda_intel 0000:00:1f.3: DSP detected with PCI
> class/subclass/prog-if info 0x040100
> [ 13.357500] snd_hda_intel 0000:00:1f.3: Digital mics found on
> Skylake+ platform, using SST driver
> 
>      Building the kernel with the CONFIG_SND_SOC_INTEL_KBL removed can
> load the snd_hda_codec_realtek successfully and the pulseaudio and
> alsa-utils can detect the sound cards again. The result of bisecting
> between kernel 5.4 and 5.8 also get similar result, reverting the
> commit "ALSA: hda: Allow SST driver on SKL and KBL platforms with
> DMIC" can fix the issue. I tried to generate the required firmware for
> snd_soc_skl but it did not help. Please refer to what I did in
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1915117/comments/14
> and https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1915117/comments/18.
> 
>      Since the skl_hda_dsp_generic-tplg.bin and dfw_sst.bin are not in
> the linux-firmware. The Intel SST support for Skylake family is not
> yet complete. Can we simply revert the "ALSA: hda: Allow SST driver on
> SKL and KBL platforms with DMIC" in the current stage and wait for SOF
> support for Skylake family? Or please suggest a better solution for
> this. Thanks
> 
> Chris
> 

Hello Chris,

Guide: "Linux: HDA+DMIC with skylake driver" [1] should help 
understanding history behind the problem as well as fixing it.

Upstream skylake driver - snd_soc_skl - is intended to support HDA DSP + 
DMIC configuration via means of snd_soc_skl_hda_dsp machine board 
driver. You _may_ switch to legacy HDAudio driver - snd_hda_intel - 
losing DMIC support in the process. To remove any confusion - for 
Skylake and Kabylake platforms, snd_soc_skl is your option.

Now, due to above, I doubt any skylake-related topology has ever been 
upstreamed to linux-firmware as a) most boards are I2S-based, these are 
used by our clients which we support via separate channel b) hda 
dsp+dmic support on linux for missing until early 2020.

Topologies for most common skylake driver configurations:
- skl/kbl with i2s rt286
- apl/glk with i2s rt298
- <any> with hda dsp
can be found in alsa-topology-conf [2].

Standard, official tool called 'alsatplg' is capable of compiling these 
into binary form which, after being transferred to /lib/firmware/ may be 
consumed by the driver during runtime.
I have no problem with providing precompiled binaries to linux-firmware, 
if that's what community wants.

Regards,
Czarek


[1]: https://gist.github.com/crojewsk/4e6382bfb0dbfaaf60513174211f29cb
[2]: https://github.com/alsa-project/alsa-topology-conf/tree/master/topology
