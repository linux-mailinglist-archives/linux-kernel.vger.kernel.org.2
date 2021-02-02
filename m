Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2111A30C7CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbhBBRbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:31:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:7379 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237482AbhBBR3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:29:34 -0500
IronPort-SDR: yriaTroZyN9QN2rHOvE9DTotLabdtkGNmrgY20Rl/8grkrzc1EU8zotAjX8Vv5PlOflcKh7N+j
 evZZovEjtSiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="242408116"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="242408116"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 09:27:47 -0800
IronPort-SDR: IR5PjwCStZQdpQtqcFgz7Wkc3sQluaVrplLmP+UXdn9IEf6Dj2MrBuPMBZhqPK9XXI78Fl3zZx
 Dee3RsH9FPoQ==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="370798487"
Received: from ncruzgar-mobl.amr.corp.intel.com (HELO [10.212.75.122]) ([10.212.75.122])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 09:27:46 -0800
Subject: Re: [PATCH 2/3] soundwire: intel: add
 SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH quirk
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        jank@cadence.com, sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
 <20210126083746.3238-3-yung-chuan.liao@linux.intel.com>
 <20210201104229.GY2771@vkoul-mobl>
 <0ed1c91b-09ca-dc6f-39d1-850d12f4f9c4@linux.intel.com>
 <20210202044139.GH2771@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <32df8d27-3393-f049-a493-4ba43962d490@linux.intel.com>
Date:   Tue, 2 Feb 2021 10:53:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202044139.GH2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>> +	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH;
>>>
>>> Should this not be last 'enabling' the quirk patch in series :)
>>
>> Sorry, I don't understand the comment. Do you mind clarifying Vinod?
> 
> Sure, I would like to series built as, first defining the quirk
> along/followed by bus changes. Then the last patch should be intel
> controller changes and setting the quirks (like above) in the last
> patch.
> 
> Let me know if you would need further clarification

Got it, thanks.
