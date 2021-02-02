Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE8430C66A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbhBBQry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:47:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:48675 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236724AbhBBQpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:45:10 -0500
IronPort-SDR: QEXjGaHnr/veopYioSE4mCQEL1ka/6KtnhD+ikiKrzyFMATGECqrYoR+P5uFYGTdnFueA4yhP2
 Cdv0XjSi8Fwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="180961609"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="180961609"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 08:43:20 -0800
IronPort-SDR: Mik2ouu6FRss9AOS0SbJY7i4r2d/YqEjTDVgiyZPrxjGNLsPw6PRlAITedaZuVaxHrgoo0nZ5w
 t4l/YFObU0rQ==
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="391564051"
Received: from bmdumitr-mobl.amr.corp.intel.com (HELO [10.212.155.40]) ([10.212.155.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 08:43:16 -0800
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
 <20210119145220.GS2771@vkoul-mobl>
 <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
 <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
 <6d4d4a6b-f28c-81db-4e67-2b5b94116fa4@linux.intel.com>
 <1fad2388-27d0-7014-818d-1272fa70ed9b@linaro.org>
 <33fe8455-01b4-f867-4974-a3e867c930f0@linux.intel.com>
 <feee8676-33fe-7929-8b6c-6abe3a09159a@linaro.org>
 <20210201101414.GS2771@vkoul-mobl>
 <4b850685-1058-0e18-d3e8-e23e20086235@linux.intel.com>
 <20210202041853.GF2771@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6eebbadd-d26b-9dba-f425-01988fb64bec@linux.intel.com>
Date:   Tue, 2 Feb 2021 10:43:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202041853.GF2771@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/21 10:18 PM, Vinod Koul wrote:
> On 01-02-21, 10:10, Pierre-Louis Bossart wrote:
>> On 2/1/21 4:14 AM, Vinod Koul wrote:
>>> On 21-01-21, 17:23, Srinivas Kandagatla wrote:
>>>> On 21/01/2021 15:12, Pierre-Louis Bossart wrote:
>>>>> On 1/21/21 6:03 AM, Srinivas Kandagatla wrote:
> 
>>>> I totally agree!
>>>>
>>>> If I understand it correctly in Intel case there will be only one Link ID
>>>> per bus.
>>>
>>> Yes IIUC there would be one link id per bus.
>>>
>>> the ida approach gives us unique id for each master,bus I would like to
>>> propose using that everywhere
>>
>> We have cases where link2 is not used but link0, 1 and 3 are.
>> Using the IDA would result in master-0,1,2 being shown, that would throw the
>> integrator off. the link_id is related to hardware and can tolerate gaps,
>> the IDA is typically always increasing and is across the system, not
>> controller specific.
>>
>> We can debate forever but both pieces of information are useful, so my
>> recommendation is to use both:
>>
>> snprintf(name, sizeof(name), "master-%d-%d", bus_id, bus->link_id);
> 
> I agree we should use both, but does it really make sense for naming? We
> can keep name in ida and expose the link_id as a parameter for
> integrators to see in sysfs.

That would mean changing the meaning of sysfs properties:

/*
  * The sysfs for properties reflects the MIPI description as given
  * in the MIPI DisCo spec
  *
  * Base file is:
  *	sdw-master-N
  *      |---- revision
  *      |---- clk_stop_modes
  *      |---- max_clk_freq
  *      |---- clk_freq
  *      |---- clk_gears
  *      |---- default_row
  *      |---- default_col
  *      |---- dynamic_shape
  *      |---- err_threshold
  */

N is the link ID in the spec. I am not convinced we'd do the community a 
service by unilaterally changing what an external spec means, or add a 
property that's kernel-defined while the rest is supposed to come from 
firmware. If you want to change the spec then you can contribute 
feedback in MIPI circles (MIPI have a mechanism for maintainers to 
provide such feedback without company/employer membership requirements)

So either we add a sysfs layer that represents a controller (better in 
my opinion so that we can show the link/master count), or keep the 
existing hierarchy but expand the name with a unique ID so that Qualcomm 
don't get errors with duplicate sysfs link0 entries.

