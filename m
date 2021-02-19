Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59B732002D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhBSVPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:15:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:24936 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhBSVPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:15:09 -0500
IronPort-SDR: cxrU2MfgzdnCgVys+N/CZHvJwLZaW181f8SZU9aAquP5R0P6Nh4ZkSvAdP/SfWKZFT9RfWe/dW
 PDSpeGYZf9qQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="180453250"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="180453250"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 13:13:24 -0800
IronPort-SDR: HsXOnOiOE04PK4hZwZxbkf9Ni5x5InjymCk2606Ilyk0sKhTY8fo4pabPMIxfRsjAVOx7+S7iC
 V7+eHMAKL4AA==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="440422875"
Received: from cnolsen-mobl1.amr.corp.intel.com (HELO [10.209.128.197]) ([10.209.128.197])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 13:13:22 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] soundwire: add support for static port mapping
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com
References: <9a688b02-80a6-fb1f-d6fa-36ba2d88d3b9@linux.intel.com>
 <c6278763-57d9-2631-7b43-829259a9ea1f@linaro.org>
 <3ee60ad9-9635-649e-ba67-d40a96b25256@linux.intel.com>
 <487c91f9-f6ea-75c2-9150-52db2de42a3a@linaro.org>
 <eaf13d70-86fe-3e18-7a5a-4043f2d8a22d@linux.intel.com>
 <aaf34f07-5eed-3045-e4c6-dc9416689b20@linaro.org>
 <f960757f-ec8b-6d3f-f00e-27242c687926@linux.intel.com>
 <e962caa8-89c3-4a22-5932-4498c406e8f8@linaro.org>
 <adb91730-35db-db7a-75b3-4771723de945@linux.intel.com>
 <31ff9d2b-760a-374e-5b37-45d8e8116f7b@linaro.org>
 <20210201102709.GT2771@vkoul-mobl>
 <c8bb718d-c06d-2942-9c0b-2a6f97031e10@linaro.org>
Message-ID: <64d2537a-bd60-e0a3-c4aa-4f802c34102b@linux.intel.com>
Date:   Fri, 19 Feb 2021 13:52:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c8bb718d-c06d-2942-9c0b-2a6f97031e10@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>> It seems you are in a different solution-space, where the codec driver
>>>> needs to notify the master of which ports it needs to use?
>>> Correct! As Codec is the place where we have mixer controls ant it can
>>> clearly tell which master ports should be used for that particular
>>> configuration.
>> And that should come from firmware (DT etc) and driver should pass on
>> this info
> 
> Are you okay with the patch as it is, provided this information is 
> populated from DT?

I am fine with the direction at a high-level. The premise for SoundWire 
is that the bus is simple enough that it can be used in different 
contexts and architectures, so if Qualcomm need something that differs 
from what is needed for Intel we are really not in a position to object.

That said, I could use more explanations on how the mapping is defined: 
I don't think we have the same definition of 'static port mapping'. For 
SDCA integration, we plan to have a static mapping in some sort of ACPI 
table that will describe which port on the Manager side is connected to 
which ports on Peripheral XYZ. That's static as in set in stone in 
platform firmware. I understand the reference to DT settings as the same 
idea.

But if the mapping depends on the value of mixer controls as you 
describe it, then it's not static and defined by DT settings, but 
run-time defined.

Also maybe we'd want to have a more opaque way of passing the 
information, maybe with a stream private data or a callback, instead of 
hard-coding fields that are only used by Qualcomm.


