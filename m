Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB6A429455
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 18:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhJKQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 12:17:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:58415 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhJKQRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:17:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="214057912"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="214057912"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 09:14:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="562278385"
Received: from cpeng4-mobl.amr.corp.intel.com (HELO [10.213.182.8]) ([10.213.182.8])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 09:14:17 -0700
Subject: Re: [PATCH v2 0/4] ASoC: Intel: bytcr_rt5640: few cleanups
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
References: <20211007165715.27463-1-andriy.shevchenko@linux.intel.com>
 <3219a8c9-a9c8-25a9-95df-9aa5dbdf6815@redhat.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d4e5aca7-9ec1-6421-c3b5-b03983bd1bb5@linux.intel.com>
Date:   Mon, 11 Oct 2021 09:19:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3219a8c9-a9c8-25a9-95df-9aa5dbdf6815@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Andy Shevchenko (4):
>>   ASoC: Intel: bytcr_rt5640: Get platform data via dev_get_platdata()
>>   ASoC: Intel: bytcr_rt5640: Use temporary variable for struct device
>>   ASoC: Intel: bytcr_rt5640: use devm_clk_get_optional() for mclk
>>   ASoC: Intel: bytcr_rt5640: Utilize dev_err_probe() to avoid log
>>     saturation
> 
> Thanks, the entire series good to me, this one I've also
> given a quick test-spin, so:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> For the series.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

