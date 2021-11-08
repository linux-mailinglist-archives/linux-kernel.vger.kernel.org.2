Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38E9448065
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbhKHNmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:42:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:2279 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhKHNmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:42:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="219423204"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="219423204"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 05:39:34 -0800
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="533315761"
Received: from anushave-mobl1.amr.corp.intel.com (HELO [10.255.85.158]) ([10.255.85.158])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 05:39:31 -0800
Subject: Re: [PATCH] ASoC: SOF: build compression interface into snd_sof.ko
To:     Arnd Bergmann <arnd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bud Liviu-Alexandru <budliviu@gmail.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20211108111132.3800548-1-arnd@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <63c5b1fb-575e-f026-5a76-f08a366f7f38@linux.intel.com>
Date:   Mon, 8 Nov 2021 07:39:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211108111132.3800548-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/21 5:11 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With CONFIG_SND_SOC_SOF_COMPRESS=m, the compression code is
> not built into a the main SOF driver when that is built-in:
> 
> x86_64-linux-ld: sound/soc/sof/ipc.o: in function `ipc_stream_message':
> ipc.c:(.text+0x5a2): undefined reference to `snd_sof_compr_fragment_elapsed'
> x86_64-linux-ld: sound/soc/sof/topology.o: in function `sof_dai_load':
> topology.c:(.text+0x32d1): undefined reference to `snd_sof_compr_init_elapsed_work'
> x86_64-linux-ld: topology.c:(.text+0x32e1): undefined reference to `snd_sof_compr_init_elapsed_work'
> 
> Make this a 'bool' symbol so it just decides whether the
> code gets built at all.
> 
> Fixes: 858f7a5c45ca ("ASoC: SOF: Introduce fragment elapsed notification API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

It's Monday morning and my memory is still foggy but I think we fixed
this problem with https://github.com/thesofproject/linux/pull/3180,
where we changed the Kconfigs for i.MX. We haven't sent this update
upstream for some reason.

Arnd, can you share the configuration that breaks with the existing
upstream code, I can check if the problem still exists.

Thanks!
