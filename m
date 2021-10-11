Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8F1429456
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 18:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhJKQRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 12:17:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:58415 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230388AbhJKQRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 12:17:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="214057915"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="214057915"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 09:14:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="562278398"
Received: from cpeng4-mobl.amr.corp.intel.com (HELO [10.213.182.8]) ([10.213.182.8])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 09:14:19 -0700
Subject: Re: [PATCH v2 0/4] ASoC: Intel: bytcr_rt5651: few cleanups
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
References: <20211007170250.27997-1-andriy.shevchenko@linux.intel.com>
 <0a74d8d1-2f36-18dc-56a3-4e5033dcab85@redhat.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d669b2ad-dbe8-f069-5f02-7ddcf2f90b78@linux.intel.com>
Date:   Mon, 11 Oct 2021 09:19:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0a74d8d1-2f36-18dc-56a3-4e5033dcab85@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> Andy Shevchenko (4):
>>   ASoC: Intel: bytcr_rt5651: Get platform data via dev_get_platdata()
>>   ASoC: Intel: bytcr_rt5651: Use temporary variable for struct device
>>   ASoC: Intel: bytcr_rt5651: use devm_clk_get_optional() for mclk
>>   ASoC: Intel: bytcr_rt5651: Utilize dev_err_probe() to avoid log
>>     saturation
> 
> Thanks, the entire series looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> for the series.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
