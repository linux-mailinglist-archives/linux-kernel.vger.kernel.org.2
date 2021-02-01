Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3937230AC5B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhBAQMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:12:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:28394 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231191AbhBAQME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:12:04 -0500
IronPort-SDR: ADTNSGqMHQSuAPwp9o7M9jjnOYEiOQZFHqn9Xi/mrlRPr98p68DJwIjlGVFvn9/LK6SPBfpLa1
 SaJkdAgN9aMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180852509"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="180852509"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:10:17 -0800
IronPort-SDR: Zi/rRVsm+yVybsbeIAuJoKP7AGQnuZJn/fLtJpA3eIf9FUoBQl+Z74ZDdZ3Zj+OCRMFv0OX11X
 a7P1TVJPrXFQ==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="412472539"
Received: from dkhaldi-mobl1.amr.corp.intel.com (HELO [10.212.126.61]) ([10.212.126.61])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:10:16 -0800
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
To:     Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
 <20210119145220.GS2771@vkoul-mobl>
 <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
 <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
 <6d4d4a6b-f28c-81db-4e67-2b5b94116fa4@linux.intel.com>
 <1fad2388-27d0-7014-818d-1272fa70ed9b@linaro.org>
 <33fe8455-01b4-f867-4974-a3e867c930f0@linux.intel.com>
 <feee8676-33fe-7929-8b6c-6abe3a09159a@linaro.org>
 <20210201101414.GS2771@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4b850685-1058-0e18-d3e8-e23e20086235@linux.intel.com>
Date:   Mon, 1 Feb 2021 10:10:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201101414.GS2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/21 4:14 AM, Vinod Koul wrote:
> On 21-01-21, 17:23, Srinivas Kandagatla wrote:
>>
>>
>> On 21/01/2021 15:12, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 1/21/21 6:03 AM, Srinivas Kandagatla wrote:
>>>>
>>>>
>>>> On 19/01/2021 19:09, Pierre-Louis Bossart wrote:
>>>>>
>>>>>> currently we have
>>>>>> /sys/kernel/debug/soundwire/master-*
>>>>>>
>>>>>> Are you suggesting that we have something like this:
>>>>>>
>>>>>> /sys/kernel/debug/soundwire/xyz-controller/master-<LINK-ID> ??
>>>>>
>>>>> Yes this is what I was thinking about.
>>>>
>>>> Vinod/Pierre,
>>>>
>>>> One Question here,
>>>>
>>>> Why is link_id part of "struct sdw_bus", should it not be part of
>>>> "struct sdw_master_device " ?
>>>>
>>>> Given that "There is one Link per each Master"
>>>
>>> it's true that link == master == bus at the concept level.
>>>
>>> but we have an existing code base with different structures and we can't
>>> break too many things at once.
>>>
>>> In the existing flow, the 'bus' is created and setup first, the
>>> sdw_bus_master_add() routine takes a 'bus' argument, and the link_id is
>>> already set. This routine only creates a device and in the rest of the
>>> code we keep using the 'bus' pointer, so there's no real short-term
>>> scope for moving the information into the 'sdw_master_device' structure
>>> - that would be a lot of surgery when nothing is really broken.
>>
>> I totally agree!
>>
>> If I understand it correctly in Intel case there will be only one Link ID
>> per bus.
> 
> Yes IIUC there would be one link id per bus.
> 
> the ida approach gives us unique id for each master,bus I would like to
> propose using that everywhere

We have cases where link2 is not used but link0, 1 and 3 are.
Using the IDA would result in master-0,1,2 being shown, that would throw 
the integrator off. the link_id is related to hardware and can tolerate 
gaps, the IDA is typically always increasing and is across the system, 
not controller specific.

We can debate forever but both pieces of information are useful, so my 
recommendation is to use both:

snprintf(name, sizeof(name), "master-%d-%d", bus_id, bus->link_id);

