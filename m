Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18E3424409
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhJFR0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:26:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:37402 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhJFR0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:26:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="206174624"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="206174624"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 10:24:44 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="439198434"
Received: from nbasa-mobl2.amr.corp.intel.com (HELO [10.213.170.135]) ([10.213.170.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 10:24:37 -0700
Subject: Re: [PATCH 3/3] ASoC: Intel: sof_rt5682: use id_alt to enumerate
 rt5682s
To:     Hans de Goede <hdegoede@redhat.com>, Brent Lu <brent.lu@intel.com>,
        alsa-devel@alsa-project.org,
        Bard liao <yung-chuan.liao@linux.intel.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        linux-kernel@vger.kernel.org, Rander Wang <rander.wang@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>
References: <20211006161805.938950-1-brent.lu@intel.com>
 <20211006161805.938950-4-brent.lu@intel.com>
 <fdcdf447-352f-3dbc-f55d-b3bb3588dca3@redhat.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ecde4150-2782-9529-3288-b1eb9e247883@linux.intel.com>
Date:   Wed, 6 Oct 2021 12:24:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <fdcdf447-352f-3dbc-f55d-b3bb3588dca3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> @@ -196,6 +201,7 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
>>  	},
>>  	{
>>  		.id = "10EC5682",
>> +		.id_alt = &rt5682s_hp,
>>  		.drv_name = "sof_rt5682",
>>  		.sof_fw_filename = "sof-byt.ri",
>>  		.sof_tplg_filename = "sof-byt-rt5682.tplg",
> 
> So this is only useful if there actually are any BYT devices using the "RTL5682"
> ACPI HID, the 100+ BYT/CHT DSDTs which I've gather over time say there aren't any.
> 
> Actually there also aren't any using the non alt "10EC5682" ACPI HID either...
> 
> Bard Liao, you added this in commit f70abd75b7c6 ("ASoC: Intel: add sof-rt5682 machine driver")
> but I wonder how useful this is. I guess it may be available as (and tested on?) some dev-kit.
> 
> But I don't think there us any hardware out there in the wild using this ?

In the past we used this configuration for SOF CI tests with the
MinnowBoard + an RT5682 eval board. We gradually fried most boards and
no longer check this capability for each SOF PR.

So I would agree we can avoid changing anything for BYT/CHT and possibly
APL, it'd be an untested configuration.

in other words, let's add this compatible/alt_id for platforms where we
know it'll be used.
