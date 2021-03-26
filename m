Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCEC34AC75
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCZQZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:25:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:39373 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhCZQYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:24:52 -0400
IronPort-SDR: 7O7LdODh+d+QVSmQ8vnxebogPQ8gmuok/cC2GDtlImyfKRHhqqu1bIVd3hPaOGy3XqAFgEFEJr
 HB0CxC3XBK8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="171170472"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="171170472"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 09:24:51 -0700
IronPort-SDR: ccSVrBGzoKh5mP8SxuOFXDz87BSeqVxPwOM342JchlsoMfb1rq2jgWzAXHLQ+y1eNEN/f/64kH
 xB6W47jCc+xA==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="443869822"
Received: from ttle1-mobl.amr.corp.intel.com (HELO [10.212.227.242]) ([10.212.227.242])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 09:24:50 -0700
Subject: Re: [PATCH] soundwire: intel: move to auxiliary bus
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, vinod.koul@linaro.org,
        linux-kernel@vger.kernel.org, hui.wang@canonical.com,
        vkoul@kernel.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
 <YFmatyAoMZmBmkuZ@kroah.com>
 <777b4ca6-0d51-285d-549f-6ef768f2a523@linux.intel.com>
 <YFo0WW8hOsHesSFC@kroah.com>
 <35cc8d35-a778-d8b2-bee3-bb53f8a6c51e@linux.intel.com>
 <YFsG00+iDV/A4i3y@kroah.com>
 <357d9576-f79a-0ea6-eee4-292e27597565@linux.intel.com>
 <YFtchhxHDjfbyY46@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e76719e4-57aa-2a19-c9e4-469bab4ef1ca@linux.intel.com>
Date:   Fri, 26 Mar 2021 11:24:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFtchhxHDjfbyY46@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/21 10:36 AM, Greg KH wrote:
> On Wed, Mar 24, 2021 at 09:55:01AM -0500, Pierre-Louis Bossart wrote:
>> Note at this point it would mean an API change and impact the existing
>> Nvidia/Mellanox code, we are using the same sequence as them
> 
> THere is no "stable api" in the kernel, so if something has to change,
> that's fine, we can change the users at the same time, not an issue.

What I meant is that this requires consensus to make a change, and so 
far I haven't seen any burning desire from the contributors to revisit 
the 2-step sequence.

I will however modify the code in this patch to implement a SoundWire 
'linkdev' register/unregister function, it'll be much easier to review 
and maintain, and will follow the same pattern as the mlx5 code (all 
errors and domain-specific initializations handled in the same 
function). Draft code being tested is at 
https://github.com/thesofproject/linux/pull/2809
