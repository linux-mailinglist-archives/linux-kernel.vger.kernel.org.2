Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFF0424634
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbhJFSpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:45:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:21358 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhJFSpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:45:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="226025792"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="226025792"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 11:43:12 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="439225258"
Received: from nbasa-mobl2.amr.corp.intel.com (HELO [10.213.170.135]) ([10.213.170.135])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 11:43:10 -0700
Subject: Re: [PATCH 3/3] ASoC: Intel: sof_rt5682: use id_alt to enumerate
 rt5682s
To:     Curtis Malainey <cujomalainey@google.com>,
        Brent Lu <brent.lu@intel.com>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rander Wang <rander.wang@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>
References: <20211006161805.938950-1-brent.lu@intel.com>
 <20211006161805.938950-4-brent.lu@intel.com>
 <CAOReqxjGX6fwqNjX0i31JiQJ+vRCMNTTFBhn7L=iPzYvVMk9mQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0482534d-46c4-5cee-25bd-8739e80a00f0@linux.intel.com>
Date:   Wed, 6 Oct 2021 13:43:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAOReqxjGX6fwqNjX0i31JiQJ+vRCMNTTFBhn7L=iPzYvVMk9mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/21 1:34 PM, Curtis Malainey wrote:
>>  };
>>
>> +static struct snd_soc_acpi_codecs adl_rt5682s_hp = {
>> +       .num_codecs = 1,
>> +       .codecs = {"RTL5682"}
>> +};
>> +
>>  struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>>         {
>>                 .id = "10EC5682",
>> +               .id_alt = &adl_rt5682s_hp,
>>                 .drv_name = "adl_mx98373_rt5682",
>>                 .machine_quirk = snd_soc_acpi_codec_list,
>>                 .quirk_data = &adl_max98373_amp,
>> @@ -296,6 +302,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>>         },
>>         {
>>                 .id = "10EC5682",
>> +               .id_alt = &adl_rt5682s_hp,
>>                 .drv_name = "adl_mx98357_rt5682",
>>                 .machine_quirk = snd_soc_acpi_codec_list,
>>                 .quirk_data = &adl_max98357a_amp,
>> @@ -304,6 +311,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
>>         },
>>         {
>>                 .id = "10EC5682",
>> +               .id_alt = &adl_rt5682s_hp,
>>                 .drv_name = "adl_mx98360_rt5682",
>>                 .machine_quirk = snd_soc_acpi_codec_list,
>>                 .quirk_data = &adl_max98360a_amp,
> 
> Is there any way we can collapse this and the primary id into a single
> list to avoid having 2 locations to track for the IDs?

I was thinking about that too, but in that case we would want to have a
list of strings, rather than the address of a structure which adds one
layer of indirection.

Something like

.id = { "10EC5682", "RTL5682" }

and the .num_codecs removed and some termination added.

