Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4D33F21B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhCQODE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:03:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:12268 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231582AbhCQOCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:02:48 -0400
IronPort-SDR: cgRl2aDde4l/YrCh/UsJbHhtpNq6DwKuyAh96RV1vmLF5lu/E3e68WA8x3uvlrvgXuCoGvLp0N
 h1pNFLUNP4Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="187096014"
X-IronPort-AV: E=Sophos;i="5.81,256,1610438400"; 
   d="scan'208";a="187096014"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 07:02:48 -0700
IronPort-SDR: N26sReSqZARVAAYucfXKIl+FzwROYWD5HOSN4dBKbUvNS7aoqPXtAGsWFOK8O+f/H1fC3k/Ph6
 lzWlaho3z2rA==
X-IronPort-AV: E=Sophos;i="5.81,256,1610438400"; 
   d="scan'208";a="379296513"
Received: from trentod-mobl.amr.corp.intel.com (HELO [10.212.29.205]) ([10.212.29.205])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 07:02:44 -0700
Subject: Re: [PATCH v3] ASoC: Intel: sof_rt5682: Add ALC1015Q-VB speaker amp
 support
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org,
        Jack Yu <jack.yu@realtek.com>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Libin Yang <libin.yang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        linux-kernel@vger.kernel.org
References: <20210317110824.20814-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <af990f6f-3a8b-3a1e-a02a-3bfe96e4d80a@linux.intel.com>
Date:   Wed, 17 Mar 2021 09:02:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210317110824.20814-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/21 6:08 AM, Brent Lu wrote:
> This patch adds jsl_rt5682_rt1015p which supports the RT5682 headset
> codec and ALC1015Q-VB speaker amplifier combination on JasperLake
> platform.
> 
> This driver also supports ALC1015Q-CG if running in auto-mode.
> Following table shows the audio interface support of the two
> amplifiers.
> 
>            | ALC1015Q-CG | ALC1015Q-VB
> =====================================
> I2C       | Yes         | No
> Auto-mode | 48K, 64fs   | 16k, 32fs
>                          | 48k, 32fs
>                          | 48k, 64fs
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>

The code is looks fine, but Jack Yu added a separate patch that makes 
RTL1019 equivalent to RTL1015, so should this patch also handle the 
RTL1019 case?

