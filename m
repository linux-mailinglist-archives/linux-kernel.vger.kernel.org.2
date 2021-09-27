Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CBD4196A3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhI0Osy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:48:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:31128 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234799AbhI0Osw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:48:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="285499513"
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; 
   d="scan'208";a="285499513"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 07:47:14 -0700
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; 
   d="scan'208";a="486170661"
Received: from asen4-mobl2.amr.corp.intel.com (HELO [10.212.27.2]) ([10.212.27.2])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 07:47:12 -0700
Subject: Re: [PATCH] ASoC: intel: sof_rt5682: update platform device name for
 Maxim amplifier
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Libin Yang <libin.yang@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Bard Liao <bard.liao@intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Rander Wang <rander.wang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Yong Zhi <yong.zhi@intel.com>
References: <20210927143249.439129-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b08ed96d-853f-2f00-d4d5-5704573722ee@linux.intel.com>
Date:   Mon, 27 Sep 2021 09:47:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927143249.439129-1-brent.lu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/21 9:32 AM, Brent Lu wrote:
> To follow 20-character length limitation of platform device name, we
> have only 7 character space for amplifier. Therefore, the last
> character of mx98357a and mx98360a is removed to save space.
> 
> Signed-off-by: Brent Lu <brent.lu@intel.com>

This patch fixes an issue reported in our Sparse checks:

sound/soc/intel/boards/sof_rt5682.c:1070:25: error: too long
initializer-string for array of char(no space for nul char)

Fixes: e224ef76fa8a ('ASoC: intel: sof_rt5682: support
jsl_rt5682s_mx98360a board')

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

FWIW here's what we use in our checks:

export ARCH=x86_64 CF="-Wsparse-error -Wsparse-all -Wno-bitwise-pointer
-Wno-pointer-arith -Wno-typesign -Wnoshadow"
make allmodconfig
make -k sound/soc/sof/ C=2
make -k sound/soc/intel/common/ C=2
make -k sound/soc/intel/boards/ C=2
make -k sound/soc/amd/ C=2
make -k drivers/soundwire/ C=2

