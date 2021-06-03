Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BBF39A49B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhFCPeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:34:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:5379 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhFCPeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:34:10 -0400
IronPort-SDR: psSAieq2oZp4zM3Zb3G3zpZCOOfp+ajPqTVF1IQwv8Ps2i96tJ8asIGFlxyoWEtPMOv81B2is+
 1bgHq6eqIGsg==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="265240279"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="265240279"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 08:32:23 -0700
IronPort-SDR: qWZID5tBZ37vSk5PGxk1TeluGIpGIOstEBtNWjTBAomczxbxaFTwEXp82xKFmoK5W4uKpwGii7
 p2cLy9rm2y4g==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="636276600"
Received: from camleint-mobl2.amr.corp.intel.com ([10.213.188.150])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 08:32:23 -0700
Message-ID: <b1c971fd42af39d93de71568b3015520e8d1808a.camel@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: Remove duplicate include of shim.h
From:   Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 03 Jun 2021 08:32:22 -0700
In-Reply-To: <1622689193-29884-1-git-send-email-wanjiabing@vivo.com>
References: <1622689193-29884-1-git-send-email-wanjiabing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-06-03 at 10:59 +0800, Wan Jiabing wrote:
> shim.h is included twice.
> As shim.h is not related to later header file,
> keep one which has comment and remove the former one.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  sound/soc/sof/intel/pci-tng.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/sof/intel/pci-tng.c b/sound/soc/sof/intel/pci-
> tng.c
> index 4ee1da3..4bded66 100644
> --- a/sound/soc/sof/intel/pci-tng.c
> +++ b/sound/soc/sof/intel/pci-tng.c
> @@ -15,7 +15,6 @@
>  #include <sound/sof.h>
>  #include "../ops.h"
>  #include "atom.h"
> -#include "shim.h"
>  #include "../sof-pci-dev.h"
>  #include "../sof-audio.h"
>  
Thanks for the patch.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

