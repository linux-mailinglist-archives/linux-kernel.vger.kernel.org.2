Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8473F8EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 21:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243391AbhHZTZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 15:25:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:32744 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243342AbhHZTZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 15:25:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="204959550"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="204959550"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 12:24:23 -0700
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="474321237"
Received: from hjasuja-mobl.amr.corp.intel.com (HELO [10.251.134.37]) ([10.251.134.37])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 12:24:22 -0700
Subject: Re: [RFC PATCH 1/2] ASoC: soc-pcm: protect BE dailink state changes
 in trigger
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Mark@sirena.org.uk, Brown@sirena.org.uk,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        liam.r.girdwood@linux.intel.com, Jaroslav Kysela <perex@perex.cz>,
        vkoul@kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        tiwai@suse.de
References: <20210817164054.250028-1-pierre-louis.bossart@linux.intel.com>
 <20210817164054.250028-2-pierre-louis.bossart@linux.intel.com>
 <163000225499.699341.16303629557242399115.b4-ty@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <27b9fe7a-18cc-61ee-1e4d-72282d8eaa82@linux.intel.com>
Date:   Thu, 26 Aug 2021 14:24:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <163000225499.699341.16303629557242399115.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/21 1:30 PM, Mark Brown wrote:
> From: Mark Brown,,, <broonie@kernel.org>
> 
> On Tue, 17 Aug 2021 11:40:53 -0500, Pierre-Louis Bossart wrote:
>> When more than one FE is connected to a BE, e.g. in a mixing use case,
>> the BE can be triggered multiple times when the FE are opened/started
>> concurrently. This race condition is problematic in the case of
>> SoundWire BE dailinks, and this is not desirable in a general
>> case. The code carefully checks when the BE can be stopped or
>> hw_free'ed, but the trigger code does not use any mutual exclusion.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] ASoC: soc-pcm: protect BE dailink state changes in trigger
>       commit: 0c75fc7193387776c10f7c7b440d93496e3d5e21
> [2/2] ASoC: soc-pcm: test refcount before triggering
>       commit: 6479f7588651cbc9c91e61c20ff39119cbc8feba

Ah sorry, there were still some issues in this RFC, we did more testing
and came up with a lot of improvements. The intent of the RFC status was
also to make sure it wasn't applied before the merge window.

Can this be reverted in your branch Mark?
