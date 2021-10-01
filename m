Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672CE41F147
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355047AbhJAPbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:31:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:5426 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232091AbhJAPbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:31:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="225123239"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="225123239"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 08:23:06 -0700
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="540276460"
Received: from pwhela2-mobl1.ger.corp.intel.com (HELO [10.213.160.166]) ([10.213.160.166])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 08:23:05 -0700
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: Add support for max98360a
 speaker amp
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "Gopal, Vamshi Krishna" <vamshi.krishna.gopal@intel.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        "Liao, Bard" <bard.liao@intel.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        "Yang, Libin" <libin.yang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211001150316.414141-1-brent.lu@intel.com>
 <MWHPR11MB1919F695979F9AAED31B27E297AB9@MWHPR11MB1919.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4460fe70-2541-ceb1-1d83-b3deebf21bb0@linux.intel.com>
Date:   Fri, 1 Oct 2021 10:23:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1919F695979F9AAED31B27E297AB9@MWHPR11MB1919.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/21 10:07 AM, Lu, Brent wrote:
>>
>> From: Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>
>>
>> Add a board config adl_mx98360a_rt5682 to support alc5682 headset codec
>> and max98360a speaker amplifier. Follow Intel BT offload design by
>> connecting alc5682 to SSP0 and max98360a to SSP1.
>>
>> Signed-off-by: Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>
>> Signed-off-by: Brent Lu <brent.lu@intel.com>
> 
> Already accepted on SOF github. Merged with another fixup patch for the
> platform device name.

Yes this was reviewed by Bard and me on GitHub.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
