Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493923FEFC9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345684AbhIBPDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:03:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:4229 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235049AbhIBPDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:03:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="304708106"
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; 
   d="scan'208";a="304708106"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 08:02:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; 
   d="scan'208";a="689144054"
Received: from elee5-mobl.amr.corp.intel.com (HELO [10.212.50.6]) ([10.212.50.6])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 08:02:19 -0700
Subject: Re: [PATCH v2] ASoC: Intel: boards: Fix CONFIG_SND_SOC_SDW_MOCKUP
 select
To:     Nathan Chancellor <nathan@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>
References: <20210802190351.3201677-1-nathan@kernel.org>
 <20210802212409.3207648-1-nathan@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <da246896-fbd3-be8d-355f-3c0a83e7d4eb@linux.intel.com>
Date:   Thu, 2 Sep 2021 10:02:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210802212409.3207648-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/21 4:24 PM, Nathan Chancellor wrote:
> When CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH is enabled without
> CONFIG_EXPERT, there is a Kconfig warning about unmet dependencies:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_SDW_MOCKUP
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
> EXPERT [=n] && SOUNDWIRE [=y]
>   Selected by [y]:
>   - SND_SOC_INTEL_SOUNDWIRE_SOF_MACH [=y] && ...
> 
> Selecting a symbol does not account for dependencies. There are three
> ways to resolve this:
> 
> 1. Make CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH select
>    CONFIG_SND_SOC_SDW_MOCKUP only if CONFIG_EXPERT is set.
> 
> 2. Make CONFIG_SND_SOC_SDW_MOCKUP's prompt depend on CONFIG_EXPERT so
>    that it can be selected by options that only depend on
>    CONFIG_SOUNDWIRE but still appear as a prompt to the user when
>    CONFIG_EXPERT is set.
> 
> 3. Make CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH imply
>    CONFIG_SND_SOC_SDW_MOCKUP, which will select
>    CONFIG_SND_SOC_SDW_MOCKUP when its dependencies are enabled but still
>    allow the user to disable it.
> 
> Go with the third option as it gives the most flexibility while
> retaining the original intent of the select.
> 
> Fixes: 0ccac3bcf356 ("ASoC: Intel: boards: sof_sdw: add SoundWire mockup codecs for tests")
> Suggested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

This patch was missed, maybe because I didn't provide a formal ack on my
own suggestion, so here goes:

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Mark, can you add it to 5.15 fixes please? Thank you.
-Pierre
