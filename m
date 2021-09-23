Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F478415F15
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241147AbhIWNCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:02:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:52141 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235776AbhIWNCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:02:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="221946832"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="221946832"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 06:00:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="474841488"
Received: from mmocanu-mobl1.ger.corp.intel.com (HELO [10.249.36.33]) ([10.249.36.33])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 06:00:27 -0700
Message-ID: <ab4ea50f-9149-3468-ce2b-7cd421095b40@linux.intel.com>
Date:   Thu, 23 Sep 2021 16:00:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 10/12] ASoC: SOF: Intel: hda: make sure DAI widget is
 set up before IPC
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        daniel.baluta@nxp.com
References: <20210917143659.401102-1-daniel.baluta@oss.nxp.com>
 <20210917143659.401102-11-daniel.baluta@oss.nxp.com>
 <203bf6cd-6407-f01d-52c3-e399d06cb3f6@linux.intel.com>
 <b90eff84-b56c-7764-a5bb-f1e07db57cc3@linux.intel.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <b90eff84-b56c-7764-a5bb-f1e07db57cc3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2021 15:58, Pierre-Louis Bossart wrote:
> 
>>> +static struct sof_ipc_dai_config *hda_dai_update_config(struct snd_soc_dapm_widget *w,
>>> +							int channel)
>>>  {
>>> +	struct snd_sof_widget *swidget = w->dobj.private;
>>>  	struct sof_ipc_dai_config *config;
>>>  	struct snd_sof_dai *sof_dai;
>>> -	struct sof_ipc_reply reply;
>>> -	int ret = 0;
>>>  
>>> -	list_for_each_entry(sof_dai, &hda_stream->sdev->dai_list, list) {
>>> -		if (!sof_dai->cpu_dai_name)
>>> -			continue;
>>> +	if (!swidget) {
>>> +		dev_err(swidget->scomp->dev, "error: No private data for widget %s\n", w->name);
>>
>> NULL pointer dereference, just return NULL without the print. The caller
>> is printing anyways.
> 
> yes good catch, we need a v3 with the fixes suggested by Peter in
> https://github.com/thesofproject/linux/pull/3171/ applied.

Only the second patch in the PR is applicable for upstream, but it
should be squashed in for v3.

-- 
Péter
