Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC033D674
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbhCPPFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:05:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:62006 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237762AbhCPPFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:05:11 -0400
IronPort-SDR: AE5U5EUA6TQGRkTP0FPYi8Zv/H+M+j4p/boF+m7cb+7eSzA1Imbo0K3lJhg3+6js95HA35OXBu
 eLL8DSQCt/1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="176869906"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="176869906"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 08:04:45 -0700
IronPort-SDR: ZGgvL0zLqcwacdfAybfgzcPBHc5oXgdtfqdvBMp77181rJn6gKrGGmkEXJbFlex8iA2Ksjfev8
 GCcpTqNW3oZg==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="601857037"
Received: from mdacha-mobl3.amr.corp.intel.com (HELO [10.212.75.21]) ([10.212.75.21])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 08:04:43 -0700
Subject: Re: [PATCH v3] ASoC: amd: add support for rt5682 codec in machine
 driver
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>, Alexander.Deucher@amd.com,
        Virendra-Pratap.Arya@amd.com, Murali-krishna.Vemuri@amd.com
References: <1615824133-21553-1-git-send-email-Vijendar.Mukunda@amd.com>
 <efa02319-2abf-4fb9-efec-13b6279f3d78@linux.intel.com>
 <87f41e68-3158-38f8-5e84-270ab184691b@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6bdef069-374a-d215-30a4-715e05304fc7@linux.intel.com>
Date:   Tue, 16 Mar 2021 09:53:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87f41e68-3158-38f8-5e84-270ab184691b@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/21 8:37 AM, Mukunda,Vijendar wrote:
> 
> 
> On 15/03/21 9:30 pm, Pierre-Louis Bossart wrote:
>>
>>> +static int rt5682_clk_enable(struct snd_pcm_substream *substream)
>>> +{
>>> +    int ret;
>>> +    struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
>>> +
>>> +    /*
>>> +     * Set wclk to 48000 because the rate constraint of this driver is
>>> +     * 48000. ADAU7002 spec: "The ADAU7002 requires a BCLK rate that is
>>> +     * minimum of 64x the LRCLK sample rate." RT5682 is the only clk
>>> +     * source so for all codecs we have to limit bclk to 64X lrclk.
>>> +     */
>>> +    clk_set_rate(rt5682_dai_wclk, 48000);
>>> +    clk_set_rate(rt5682_dai_bclk, 48000 * 64);
>>> +    ret = clk_prepare_enable(rt5682_dai_bclk);
>>> +    if (ret < 0) {
>>> +        dev_err(rtd->dev, "can't enable master clock %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +    return ret;
>>> +}
>>
>> Out of curiosity, is there a reason why you use clk_prepare_enable() 
>> for the bclk but not for the wclk?These changes were shared by codec 
>> vendor as an initial patch.
> We should use clk_prepare_enable() for wclk not for bclk.
> We will update and share the new patch.

Well the question remains: if you have two clocks and only enable one, 
why do you need to get two clocks.

Also this patch was modeled after the da7219 case, where the same open 
applies.
