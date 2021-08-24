Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306A63F6372
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhHXQya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:54:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:31297 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233911AbhHXQyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:54:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="204486983"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="204486983"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:53:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="685433469"
Received: from jlrivera-mobl1.amr.corp.intel.com (HELO [10.212.8.132]) ([10.212.8.132])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:53:35 -0700
Subject: Re: sound/soc/sof/intel/hda-dai.c:265:22: warning: Value stored to
 'sdev' during its initialization is never read
 [clang-analyzer-deadcode.DeadStores]
To:     kernel test robot <lkp@intel.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>
References: <202108241301.UdSncTEq-lkp@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <77ba5fc1-2bfa-0e9f-525c-dc260642c7ab@linux.intel.com>
Date:   Tue, 24 Aug 2021 11:40:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202108241301.UdSncTEq-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report, I am not sure it's a real issue?
>>> sound/soc/sof/intel/hda-dai.c:265:22: warning: Value stored to 'sdev' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
>            struct snd_sof_dev *sdev =
>                                ^~~~
>    sound/soc/sof/intel/hda-dai.c:265:22: note: Value stored to 'sdev' during its initialization is never read
>            struct snd_sof_dev *sdev =
>                                ^~~~
> fdd961e37e47f2 Keyon Jie         2019-04-12  259  
> fdd961e37e47f2 Keyon Jie         2019-04-12  260  static int hda_link_pcm_prepare(struct snd_pcm_substream *substream,
> fdd961e37e47f2 Keyon Jie         2019-04-12  261  				struct snd_soc_dai *dai)
> fdd961e37e47f2 Keyon Jie         2019-04-12  262  {
> ed3baacd76baa0 Ranjani Sridharan 2019-04-30  263  	struct hdac_ext_stream *link_dev =
> ed3baacd76baa0 Ranjani Sridharan 2019-04-30  264  				snd_soc_dai_get_dma_data(dai, substream);
> fdd961e37e47f2 Keyon Jie         2019-04-12 @265  	struct snd_sof_dev *sdev =
> fdd961e37e47f2 Keyon Jie         2019-04-12  266  				snd_soc_component_get_drvdata(dai->component);
> 1205300af9dba3 Kuninori Morimoto 2020-07-20  267  	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> fdd961e37e47f2 Keyon Jie         2019-04-12  268  	int stream = substream->stream;
> fdd961e37e47f2 Keyon Jie         2019-04-12  269  
> a3ebccb52efdfb Kai Vehmanen      2019-07-22  270  	if (link_dev->link_prepared)
> fdd961e37e47f2 Keyon Jie         2019-04-12  271  		return 0;
> fdd961e37e47f2 Keyon Jie         2019-04-12  272  
> ed3baacd76baa0 Ranjani Sridharan 2019-04-30  273  	dev_dbg(sdev->dev, "hda: prepare stream dir %d\n", substream->stream);
> fdd961e37e47f2 Keyon Jie         2019-04-12  274  
> fdd961e37e47f2 Keyon Jie         2019-04-12  275  	return hda_link_hw_params(substream, &rtd->dpcm[stream].hw_params,
> fdd961e37e47f2 Keyon Jie         2019-04-12  276  				  dai);
> fdd961e37e47f2 Keyon Jie         2019-04-12  277  }
> fdd961e37e47f2 Keyon Jie         2019-04-12  278  

The sdev variable is used in the dev_dbg() log, this looks legit to me?
