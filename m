Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5366E3FEEC8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345236AbhIBNhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:37:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:41554 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345226AbhIBNhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:37:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="215975585"
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="215975585"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 06:35:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="467424866"
Received: from leeyapha-desk2.amr.corp.intel.com (HELO [10.251.212.83]) ([10.251.212.83])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 06:35:39 -0700
Subject: Re: [PATCH 1/2] ASoC: SOF: imx: Add code to manage DSP related clocks
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@nxp.com>, alsa-devel@alsa-project.org,
        kai.vehmanen@linux.intel.com, shawnguo@kernel.org,
        ranjani.sridharan@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, s-anna@ti.com,
        festevam@gmail.com
References: <20210902123216.787025-1-daniel.baluta@oss.nxp.com>
 <20210902123216.787025-2-daniel.baluta@oss.nxp.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Message-ID: <896baddd-5bd7-8f85-91c3-0a4498694d77@linux.intel.com>
Date:   Thu, 2 Sep 2021 16:35:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902123216.787025-2-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 02/09/2021 15:32, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> There are two types of clocks:
> 	* DSP IP clocks
> 	* DAI clocks
> 
> This clocks are necessary in order to power up DSP and DAIs.
> 
> We choose to enable DAI clocks here because of the way i.MX8/i.MX8X
> design handles resources (including clocks).
> 
> All clocks are managed by a separate core (named SCU) which communicates
> with Linux managed ARM core via a well known API.
> 
> We parse and enable the clocks in probe function and disable them in
> remove function.
> 
> Future patches will introduce Power Management support so that we
> disable clocks while DSP is not used or system enters power save.

Unfortunately this patch does not apply to next.

I might be a bit too cautius, but I would also add "&& COMMON_CLK" for 
the COMPILE_TEST in Kconfig or select it from where it is appropriate?

> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>   sound/soc/sof/imx/imx-common.c | 77 ++++++++++++++++++++++++++++++++++
>   sound/soc/sof/imx/imx-common.h | 16 +++++++
>   sound/soc/sof/imx/imx8.c       | 32 ++++++++++++++
>   sound/soc/sof/imx/imx8m.c      | 33 +++++++++++++++
>   4 files changed, 158 insertions(+)
> 
> diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
> index 30624fafc632..482c25ab15ce 100644
> --- a/sound/soc/sof/imx/imx8m.c
> +++ b/sound/soc/sof/imx/imx8m.c
> @@ -23,6 +23,20 @@
>   #define MBOX_OFFSET	0x800000
>   #define MBOX_SIZE	0x1000
>   
> +#define IMX8M_DSP_CLK_NUM	3
> +static const char *imx8m_dsp_clks_names[IMX8M_DSP_CLK_NUM] = {

static const char *imx8m_dsp_clks_names[]

+ ARRAY_SIZE(imx8m_dsp_clks_names) instead IMX8M_DSP_CLK_NUM ?


-- 
Péter
