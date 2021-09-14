Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D521B40B82D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhINTgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:36:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:64622 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhINTgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:36:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="222166168"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="222166168"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 12:35:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="544252949"
Received: from tjohn2x-mobl.amr.corp.intel.com (HELO [10.209.157.105]) ([10.209.157.105])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 12:34:59 -0700
Subject: Re: [PATCH 0/4] Support ALC5682I-VS codec
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Rander Wang <rander.wang@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Yong Zhi <yong.zhi@intel.com>
References: <20210914101847.778688-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fccf7093-07fe-c8bc-96f8-39670fa56de0@linux.intel.com>
Date:   Tue, 14 Sep 2021 11:07:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914101847.778688-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/21 5:18 AM, Brent Lu wrote:
> Support the ALC5682I-VS codec in Intel's rt5682 machine driver with
> three board configurations.
> 
> Brent Lu (4):
>   ASoC: Intel: sof_rt5682: support ALC5682I-VS codec
>   ASoC: intel: sof_rt5682: support jsl_rt5682s_rt1015p board
>   ASoC: intel: sof_rt5682: support jsl_rt5682s_rt1015 board
>   ASoC: intel: sof_rt5682: support jsl_rt5682s_mx98360a board
> 
>  sound/soc/intel/boards/Kconfig                |   1 +
>  sound/soc/intel/boards/sof_rt5682.c           | 105 +++++++++++++++---
>  .../intel/common/soc-acpi-intel-jsl-match.c   |  24 ++++
>  3 files changed, 112 insertions(+), 18 deletions(-)

Looks good to me, the number of permutations is starting to be hard to
track but at least it's in the same machine driver...

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
