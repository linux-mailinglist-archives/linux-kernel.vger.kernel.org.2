Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D87345AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhCWJ2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:28:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:1761 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhCWJ2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:28:32 -0400
IronPort-SDR: 89Nhr/qKAMRxpK7A2KctE3fFwTjytkPYCH347I4ocVhVNRRxYT0VC3YkztvahGhrL/6ZEypRCB
 WzJ4w+HJqN7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="275540469"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="275540469"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 02:28:32 -0700
IronPort-SDR: zUzoIO+8x9t1jUO2KUMLx4QsGUIQE5vj3QLqY6Q1v3OlO8ZrJ6kCZIkfPvmmw9kUfIdZqEdIPM
 ZuvGNpKGIrNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="513676832"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 23 Mar 2021 02:28:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 23 Mar 2021 11:28:27 +0200
Date:   Tue, 23 Mar 2021 11:28:27 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: Handle device properties with software node
 API
Message-ID: <YFm0u9k/DNy5URsR@kuha.fi.intel.com>
References: <20210322110638.2681-1-heikki.krogerus@linux.intel.com>
 <786795eb-6832-fd7d-4674-65be394c083d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786795eb-6832-fd7d-4674-65be394c083d@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:02:40AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 3/22/21 6:06 AM, Heikki Krogerus wrote:
> > The function device_add_properties() is going to be removed.
> > Replacing it with software node API equivalents.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> > Hi,
> > 
> > This patch depends on a fix from mainline, available in v5.12-rc4:
> > 
> > 	2a92c90f2ecc ("software node: Fix device_add_software_node()")
> > 
> > Cheers,
> > ---
> >   sound/soc/intel/boards/bytcht_es8316.c      |  2 +-
> >   sound/soc/intel/boards/bytcr_rt5640.c       |  2 +-
> >   sound/soc/intel/boards/bytcr_rt5651.c       |  2 +-
> >   sound/soc/intel/boards/sof_sdw_rt711.c      | 20 +++++++++++++++-----
> >   sound/soc/intel/boards/sof_sdw_rt711_sdca.c | 20 +++++++++++++++-----
> >   5 files changed, 33 insertions(+), 13 deletions(-)
> > 
> > diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> > index 06df2d46d910b..4a9817a95928c 100644
> > --- a/sound/soc/intel/boards/bytcht_es8316.c
> > +++ b/sound/soc/intel/boards/bytcht_es8316.c
> > @@ -544,7 +544,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
> >   		props[cnt++] = PROPERTY_ENTRY_BOOL("everest,jack-detect-inverted");
> >   	if (cnt) {
> > -		ret = device_add_properties(codec_dev, props);
> > +		ret = device_create_managed_software_node(codec_dev, props, NULL);
> 
> I don't think this is correct. This is using the codec_dev device, but this
> property is created in the machine driver - different device. I think the
> proper fix is to remove the property in the machine driver .remove()
> callback, as done below for the SoundWire case, and not to rely on devm_
> with the wrong device.
> 
> there was a thread between July and October on this in
> https://github.com/thesofproject/linux/pull/2306/
> 
> It seems that we need to restart this work.
> 
> Heikki, do you mind if I take your patches (keeping you as the author) and
> rework+test them with the SOF tree + CI ?

OK by me (though, I'm not sure about the author part after that).


thanks,

-- 
heikki
