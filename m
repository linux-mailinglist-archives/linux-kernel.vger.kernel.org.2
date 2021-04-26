Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144B836B91E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbhDZSka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:40:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:59769 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238660AbhDZSkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:40:20 -0400
IronPort-SDR: lCAV9zdUiiHY/6Hv1LlVqXShAndDtLrP9F46oThXPiGgbAut5prudLF8qKQCFAudzr9suAMB8h
 kSz0OZGJm56A==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196497240"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="196497240"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:39:37 -0700
IronPort-SDR: 1DSOqko7Kr00REDrsDtAuK+wvLdAQdx/HRbZeFFrvRk92kP1HxjahktUTmdyV4WbdINXQM8whJ
 3xZ1c4SBtBtA==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="403015418"
Received: from fdubuc-mobl1.amr.corp.intel.com (HELO [10.212.41.8]) ([10.212.41.8])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:39:37 -0700
Subject: Re: [PATCH v2 5/5] ASoC: da7219: properly get clk from the provider
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20210421120512.413057-1-jbrunet@baylibre.com>
 <20210421120512.413057-6-jbrunet@baylibre.com>
 <69eaa840-ed77-fc01-2925-7e5e9998e80f@linux.intel.com>
Message-ID: <883fda5c-0ef5-8b9c-80fa-4348b4368f5c@linux.intel.com>
Date:   Mon, 26 Apr 2021 13:39:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <69eaa840-ed77-fc01-2925-7e5e9998e80f@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 4/21/21 7:05 AM, Jerome Brunet wrote:
>> Instead of using the clk embedded in the clk_hw (which is meant to go
>> away), a clock provider which need to interact with its own clock should
>> request clk reference through the clock provider API.
>>
>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> 
> This patch seems to introduce a regression in our modprobe/rmmod tests
> 
> https://github.com/thesofproject/linux/pull/2870
> 
> RMMOD    snd_soc_da7219
> rmmod: ERROR: Module snd_soc_da7219 is in use
> 
> Reverting this patch restores the ability to remove the module.
> 
> Wondering if devm_ increases a module/device refcount somehow?

the following diff fixes the issue for me

There is an explicit try_module_get() in clk_hw_create_clk, so you 
end-up increasing the refcount of your own module.

devm_ doesn't seem like a good idea here, I think we have to release the 
clk and its implicit module reference when the component is freed, no?

I can send a proper fix if there is consensus.


diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index bd3c523a8617..8696ac749af3 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -2182,7 +2182,7 @@ static int da7219_register_dai_clks(struct 
snd_soc_component *component)
                         goto err;
                 }

-               da7219->dai_clks[i] = devm_clk_hw_get_clk(dev, 
dai_clk_hw, NULL);
+               da7219->dai_clks[i] = clk_hw_get_clk(dai_clk_hw, NULL);
                 if (IS_ERR(da7219->dai_clks[i]))
                         return PTR_ERR(da7219->dai_clks[i]);

@@ -2218,6 +2218,8 @@ static int da7219_register_dai_clks(struct 
snd_soc_component *component)
                 if (da7219->dai_clks_lookup[i])
                         clkdev_drop(da7219->dai_clks_lookup[i]);

+               clk_put(da7219->dai_clks[i]);
+
                 clk_hw_unregister(&da7219->dai_clks_hw[i]);
         } while (i-- > 0);

@@ -2240,6 +2242,8 @@ static void da7219_free_dai_clks(struct 
snd_soc_component *component)
                 if (da7219->dai_clks_lookup[i])
                         clkdev_drop(da7219->dai_clks_lookup[i]);

+               clk_put(da7219->dai_clks[i]);
+
                 clk_hw_unregister(&da7219->dai_clks_hw[i]);
         }



