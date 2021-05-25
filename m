Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE2038FDED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhEYJez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:34:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:24343 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232590AbhEYJet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:34:49 -0400
IronPort-SDR: fJnQoZ6GzfbC2p/nuN+FRwYLl6HsPlDOBjPGgi8iuUx/HQhShoWvkzn4wQKrs9oqpW0Yan6uiz
 G2Llo6hZOX7w==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="189269519"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="189269519"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:33:16 -0700
IronPort-SDR: 03bxMCJnHjkapOYeBavX3PK6rCBaqzbrD754BtcWIUXQm6MdhrnVdDmwdedAwlJQ1BK16JcpW0
 X6QlnuI5o7FQ==
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="546702087"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:33:14 -0700
Date:   Tue, 25 May 2021 12:28:17 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
cc:     broonie@kernel.org, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: Intel: boards: Select SND_SOC_HDAC_HDMI for
 Soundwire machine driver
In-Reply-To: <9ed54875-fe77-f70f-9085-0f3b4c9d576e@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2105251158580.3922722@eliteleevi.tm.intel.com>
References: <20210520163324.19046-1-rf@opensource.cirrus.com> <9ed54875-fe77-f70f-9085-0f3b4c9d576e@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 24 May 2021, Pierre-Louis Bossart wrote:

> On 5/20/21 11:33 AM, Richard Fitzgerald wrote:
> > Add select of SND_SOC_HDAC_HDMI for SND_SOC_INTEL_SOUNDWIRE_SOF_MACH.
> > Without this the build results in missing references to
> > hdac_hdmi_jack_port_init and hdac_hdmi_jack_init.
> Kai, can you comment on this one? There is nothing specific to HDMI in this
> driver.

usage of hdac-hdmi is removed in newer mach drivers (like 
sof_da7219_max98373, sof-pcm512 and ehl_rt5660 -> and there's no select 
for SND_SOC_HDAC_HDMI for these). For older ones, we've kept hdac-hdmi in 
to keep compatibility.

For sof_sdw, there are still calls to hdac_hdmi_jack_init() and friends
in sof_sdw_hdmi.c, so this is a real problem.

I'd say a better fix is that we remove the hdac-hdmi support from sof_sdw.
I can do a patch for that.

> Something's inconsistent here, it's not limited to SoundWire I am afraid

I checked all the related mach drivers and the Kconfig definitions are 
correct for others. So select is done to HDAC_HDMI whenever the mach 
driver uses hdac_hdmi_jack_*().

Br, Kai
