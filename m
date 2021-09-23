Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C3415F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbhIWNAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:00:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:17297 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241098AbhIWNAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:00:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="309392101"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="309392101"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 05:58:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="558348226"
Received: from upatel2-mobl.amr.corp.intel.com (HELO [10.251.134.231]) ([10.251.134.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 05:58:39 -0700
Subject: Re: [PATCH v2 10/12] ASoC: SOF: Intel: hda: make sure DAI widget is
 set up before IPC
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        daniel.baluta@nxp.com
References: <20210917143659.401102-1-daniel.baluta@oss.nxp.com>
 <20210917143659.401102-11-daniel.baluta@oss.nxp.com>
 <203bf6cd-6407-f01d-52c3-e399d06cb3f6@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b90eff84-b56c-7764-a5bb-f1e07db57cc3@linux.intel.com>
Date:   Thu, 23 Sep 2021 07:58:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <203bf6cd-6407-f01d-52c3-e399d06cb3f6@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static struct sof_ipc_dai_config *hda_dai_update_config(struct snd_soc_dapm_widget *w,
>> +							int channel)
>>  {
>> +	struct snd_sof_widget *swidget = w->dobj.private;
>>  	struct sof_ipc_dai_config *config;
>>  	struct snd_sof_dai *sof_dai;
>> -	struct sof_ipc_reply reply;
>> -	int ret = 0;
>>  
>> -	list_for_each_entry(sof_dai, &hda_stream->sdev->dai_list, list) {
>> -		if (!sof_dai->cpu_dai_name)
>> -			continue;
>> +	if (!swidget) {
>> +		dev_err(swidget->scomp->dev, "error: No private data for widget %s\n", w->name);
> 
> NULL pointer dereference, just return NULL without the print. The caller
> is printing anyways.

yes good catch, we need a v3 with the fixes suggested by Peter in
https://github.com/thesofproject/linux/pull/3171/ applied.
