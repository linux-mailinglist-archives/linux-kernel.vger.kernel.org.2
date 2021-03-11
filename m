Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB42336FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhCKKZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:25:06 -0500
Received: from mail1.perex.cz ([77.48.224.245]:44692 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232321AbhCKKYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:24:41 -0500
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D03CFA003F;
        Thu, 11 Mar 2021 11:24:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D03CFA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1615458271; bh=L5IgBNO2fmFDEe9Mj6mTow4/9RaSsRkfUSeV3Z9ysHc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ETWC3PUztLMZwBlgzpRw3vVIi3geRiYoqpDzVxfvBBwoa69kw8fGsPBrtutrMUnBd
         ey0ZMOgU8W3uepE6VJ6mcoR6oi0hcJudFxnL4bexm/f733KSokzXsEno5u6K+SLjvt
         PJoxFmX6oZHBZoWqtTkEHekoETwNtwKxg23d+JsE=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu, 11 Mar 2021 11:24:22 +0100 (CET)
Subject: Re: No sound cards detected on Kabylake laptops after upgrade to
 kernel 5.8
To:     Chris Chiu <chris.chiu@canonical.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        yang.jie@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org
References: <CABTNMG31sH99P0F7EKhpFwJf99x4U-VjFWrwXVe1wkra6owFLw@mail.gmail.com>
 <dba864a6-1442-1ebc-9de0-8c1511682b70@intel.com>
 <CABTNMG1bO2AJLY0o58TX2=1QZPnPsZXabtYZA01QyqDS40JORg@mail.gmail.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <d2efd828-f0b7-fe3f-cfda-cf86d49861bb@perex.cz>
Date:   Thu, 11 Mar 2021 11:24:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CABTNMG1bO2AJLY0o58TX2=1QZPnPsZXabtYZA01QyqDS40JORg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 11. 03. 21 v 6:50 Chris Chiu napsal(a):
> On Tue, Mar 9, 2021 at 11:29 PM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:
>>
>> On 2021-03-09 1:19 PM, Chris Chiu wrote:
>>> Hi Guys,
>>>      We have received reports that on some Kabylake laptops (Acer Swift
>>> SF314-54/55 and Lenovo Yoga C930...etc), all sound cards no longer be
>>> detected after upgrade to kernel later than 5.8. These laptops have
>>> one thing in common, all of them have Realtek audio codec and connect
>>> the internal microphone to DMIC of the Intel SST controller either
>>> [8086:9d71] or [8086:9dc8]. Please refer to
>>> https://bugzilla.kernel.org/show_bug.cgi?id=201251#c246 and
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1915117.
>>>
>>>      From the dmesg from kernel 5.8, the sound related parts only show
>>> as follows but the expected snd_hda_codec_realtek and the snd_soc_skl
>>> are not even loaded then.
>>> [ 13.357495] snd_hda_intel 0000:00:1f.3: DSP detected with PCI
>>> class/subclass/prog-if info 0x040100
>>> [ 13.357500] snd_hda_intel 0000:00:1f.3: Digital mics found on
>>> Skylake+ platform, using SST driver
>>>
>>>      Building the kernel with the CONFIG_SND_SOC_INTEL_KBL removed can
>>> load the snd_hda_codec_realtek successfully and the pulseaudio and
>>> alsa-utils can detect the sound cards again. The result of bisecting
>>> between kernel 5.4 and 5.8 also get similar result, reverting the
>>> commit "ALSA: hda: Allow SST driver on SKL and KBL platforms with
>>> DMIC" can fix the issue. I tried to generate the required firmware for
>>> snd_soc_skl but it did not help. Please refer to what I did in
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1915117/comments/14
>>> and https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1915117/comments/18.
>>>
>>>      Since the skl_hda_dsp_generic-tplg.bin and dfw_sst.bin are not in
>>> the linux-firmware. The Intel SST support for Skylake family is not
>>> yet complete. Can we simply revert the "ALSA: hda: Allow SST driver on
>>> SKL and KBL platforms with DMIC" in the current stage and wait for SOF
>>> support for Skylake family? Or please suggest a better solution for
>>> this. Thanks
>>>
>>> Chris
>>>
>>
>> Hello Chris,
>>
>> Guide: "Linux: HDA+DMIC with skylake driver" [1] should help
>> understanding history behind the problem as well as fixing it.
>>
>> Upstream skylake driver - snd_soc_skl - is intended to support HDA DSP +
>> DMIC configuration via means of snd_soc_skl_hda_dsp machine board
>> driver. You _may_ switch to legacy HDAudio driver - snd_hda_intel -
>> losing DMIC support in the process. To remove any confusion - for
>> Skylake and Kabylake platforms, snd_soc_skl is your option.
>>
>> Now, due to above, I doubt any skylake-related topology has ever been
>> upstreamed to linux-firmware as a) most boards are I2S-based, these are
>> used by our clients which we support via separate channel b) hda
>> dsp+dmic support on linux for missing until early 2020.
>>
>> Topologies for most common skylake driver configurations:
>> - skl/kbl with i2s rt286
>> - apl/glk with i2s rt298
>> - <any> with hda dsp
>> can be found in alsa-topology-conf [2].
>>
>> Standard, official tool called 'alsatplg' is capable of compiling these
>> into binary form which, after being transferred to /lib/firmware/ may be
>> consumed by the driver during runtime.
>> I have no problem with providing precompiled binaries to linux-firmware,
>> if that's what community wants.
>>
>> Regards,
>> Czarek
>>
>>
> 
> I think the guild [1] is too complicated for normal users to fix the problem.
> Given it's not only the internal microphone being affected, it's no sound
> devices being created at all so no audio functions can work after kernel 5.8.
> 
> Is there any potential problem to built-in the "<any> with hda dsp" precompiled
> binary in linux-firmware?

How do you distribute the SOF firmware? I'm going to include those binary
topology files to the SOF firmware package for Fedora. Perhaps, you may follow
this.

					Jaroslav

> 
> Chris
> 
>> [1]: https://gist.github.com/crojewsk/4e6382bfb0dbfaaf60513174211f29cb
>> [2]: https://github.com/alsa-project/alsa-topology-conf/tree/master/topology


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
