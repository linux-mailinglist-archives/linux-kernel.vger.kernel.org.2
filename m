Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54117419151
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhI0JLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:11:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:24438 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233519AbhI0JK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:10:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="285450906"
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; 
   d="scan'208";a="285450906"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 02:09:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,326,1624345200"; 
   d="scan'208";a="518490283"
Received: from unknown (HELO [10.251.220.221]) ([10.251.220.221])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 02:09:17 -0700
Message-ID: <1ab40375-57fd-a3c6-68d7-9db78a20ed6e@linux.intel.com>
Date:   Mon, 27 Sep 2021 12:09:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 10/12] ASoC: SOF: Intel: hda: make sure DAI widget is
 set up before IPC
Content-Language: en-US
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
References: <20210917143659.401102-1-daniel.baluta@oss.nxp.com>
 <20210917143659.401102-11-daniel.baluta@oss.nxp.com>
 <203bf6cd-6407-f01d-52c3-e399d06cb3f6@linux.intel.com>
 <b90eff84-b56c-7764-a5bb-f1e07db57cc3@linux.intel.com>
 <ab4ea50f-9149-3468-ce2b-7cd421095b40@linux.intel.com>
 <CAEnQRZDmubE9aLG+7YtTeRTB2euqGpRh8FWqtgV5+h3H3M8JGA@mail.gmail.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <CAEnQRZDmubE9aLG+7YtTeRTB2euqGpRh8FWqtgV5+h3H3M8JGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 24/09/2021 10:42, Daniel Baluta wrote:
> On Thu, Sep 23, 2021 at 4:04 PM Péter Ujfalusi
> <peter.ujfalusi@linux.intel.com> wrote:
>>
>>
>>
>> On 23/09/2021 15:58, Pierre-Louis Bossart wrote:
>>>
>>>>> +static struct sof_ipc_dai_config *hda_dai_update_config(struct snd_soc_dapm_widget *w,
>>>>> +                                                   int channel)
>>>>>  {
>>>>> +   struct snd_sof_widget *swidget = w->dobj.private;
>>>>>     struct sof_ipc_dai_config *config;
>>>>>     struct snd_sof_dai *sof_dai;
>>>>> -   struct sof_ipc_reply reply;
>>>>> -   int ret = 0;
>>>>>
>>>>> -   list_for_each_entry(sof_dai, &hda_stream->sdev->dai_list, list) {
>>>>> -           if (!sof_dai->cpu_dai_name)
>>>>> -                   continue;
>>>>> +   if (!swidget) {
>>>>> +           dev_err(swidget->scomp->dev, "error: No private data for widget %s\n", w->name);
>>>>
>>>> NULL pointer dereference, just return NULL without the print. The caller
>>>> is printing anyways.
>>>
>>> yes good catch, we need a v3 with the fixes suggested by Peter in
>>> https://github.com/thesofproject/linux/pull/3171/ applied.
>>
>> Only the second patch in the PR is applicable for upstream, but it
>> should be squashed in for v3.
> 
> Thanks Peter, will squash this in and send v3.

As we discussed, I'll send the v3 with the fix.

Thanks for sending the initial versions upstream!

-- 
Péter
