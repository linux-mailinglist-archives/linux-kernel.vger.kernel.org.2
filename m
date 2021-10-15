Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7FA42F69C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 17:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbhJOPKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 11:10:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:30284 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233121AbhJOPKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 11:10:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="208041953"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="208041953"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 08:07:57 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="492593233"
Received: from liminghu-mobl.ccr.corp.intel.com (HELO [10.212.23.213]) ([10.212.23.213])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 08:07:56 -0700
Subject: Re: [PATCH] ASoC: Intel: sof_sdw: Initialize the sof_sdw_quirk with
 RT711_JD_NULL
To:     Chris Chiu <chris.chiu@canonical.com>, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20211015133424.494463-1-chris.chiu@canonical.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c40282f6-cb8f-22ca-4a57-26fcbc39f423@linux.intel.com>
Date:   Fri, 15 Oct 2021 10:07:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015133424.494463-1-chris.chiu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/21 8:34 AM, Chris Chiu wrote:
> The jd_src of RT711 which is initialized in rt711/rt711_sdca_init
> will be overridden by rt711/rt711_sdca_add_codec_device_props when
> the sof_sdw_quirk is not RT711_JD_NULL. It will force the JD mode
> to RT711_JD1 and cause confusion while debugging the JD mode of
> the boards without quirk. Initialize sof_sdw_quirk with RT711_JD_NULL
> to honor the jd_src value in rt711/rt711_sdca init.

Not able to follow what the "confusion while debugging the JD mode of
the boards without quirk" is. You need a DMI quirk or need to override
the default quirk with the kernel module parameter.

This also has the side effect of breaking ALL existing DMI quirks
implicitly using JD1...


> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>  sound/soc/intel/boards/sof_sdw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
> index 6b06248a9327..d05c0565e09c 100644
> --- a/sound/soc/intel/boards/sof_sdw.c
> +++ b/sound/soc/intel/boards/sof_sdw.c
> @@ -15,7 +15,7 @@
>  #include "sof_sdw_common.h"
>  #include "../../codecs/rt711.h"
>  
> -unsigned long sof_sdw_quirk = RT711_JD1;
> +unsigned long sof_sdw_quirk = RT711_JD_NULL;
>  static int quirk_override = -1;
>  module_param_named(quirk, quirk_override, int, 0444);
>  MODULE_PARM_DESC(quirk, "Board-specific quirk override");
> 
