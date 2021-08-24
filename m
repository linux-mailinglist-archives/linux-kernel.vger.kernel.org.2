Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF44E3F6371
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhHXQy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:54:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:31294 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233900AbhHXQyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:54:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="204486977"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="204486977"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:53:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="685433440"
Received: from jlrivera-mobl1.amr.corp.intel.com (HELO [10.212.8.132]) ([10.212.8.132])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:53:33 -0700
Subject: Re: [PATCH linux-next] ASoC: SOF: intel: remove duplicate include
To:     CGEL <cgel.zte@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Bard Liao <bard.liao@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20210824030015.57267-1-deng.changcheng@zte.com.cn>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b352affd-7b20-633f-de81-ca0196e5004d@linux.intel.com>
Date:   Tue, 24 Aug 2021 11:27:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824030015.57267-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/21 10:00 PM, CGEL wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Clean up the following includecheck warning:
> 
> ./sound/soc/sof/intel/pci-tng.c: shim.h is included more than once.
> 
> No functional change.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/sof/intel/pci-tng.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/sof/intel/pci-tng.c b/sound/soc/sof/intel/pci-tng.c
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
> 
