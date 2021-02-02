Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736FB30C7EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbhBBRf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:35:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:7379 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237533AbhBBRcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:32:55 -0500
IronPort-SDR: E9DMBEbBzOtqcUFGlPwnbaD47/cipNW6MEodDrmCtaQz8QNcx4L92zOqqlC0hwcz744D7LpSEM
 WrNtgo2WETxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="242408124"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="242408124"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 09:27:49 -0800
IronPort-SDR: HfFg+VQ4ZEeKVhk/vhJsVfeAKKZst4btROqlGQgAxTN89jRrSMDa05gehdk5qY7c3sM6Pdt7KB
 cpNrvBd+eG1A==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="370798503"
Received: from ncruzgar-mobl.amr.corp.intel.com (HELO [10.212.75.122]) ([10.212.75.122])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 09:27:48 -0800
Subject: Re: [PATCH 5/6] soundwire: qcom: update register read/write routine
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-6-srinivas.kandagatla@linaro.org>
 <5c69ed09-60be-2f3d-ed25-f6dbfcb9d62f@linux.intel.com>
 <3a2b5c2d-21aa-2bf5-62df-ef85c7c9293c@linaro.org>
 <b87758d0-5862-3b4e-5a90-7b27d0c78d0d@linux.intel.com>
 <4e3ebb99-5647-f71c-1256-a2c55bd9995f@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <25ca91d5-4492-34f8-46df-4cb53c3a0b1b@linux.intel.com>
Date:   Tue, 2 Feb 2021 10:58:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4e3ebb99-5647-f71c-1256-a2c55bd9995f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> generates interrupt after it successfully finishes. This is really
>>>>> overhead, limiting and not really necessary unless we are doing
>>>>> something special.
>>>>>
>>>>> We can simply read/write the fifo that should also give exactly
>>>>> what we need! This will also allow to read/write registers in
>>>>> interrupt context, which was not possible with the special
>>>>> command approach.
>>>>
>>>> This is really unclear, sorry.
>>>
>>> If read/writes are waiting for an interrupt, it becomes difficult to 
>>> read or write to any registers from same interrupt handler!
>>
>> Well, yes, you need to handle the complete() at a lower level than the 
>> code that initiates the transactions otherwise you self-deadlock.
>>
>> IIRC in the Intel initial code, the complete was in the handler and 
>> the register IOs in the thread.
>>
> Yes, we did the same in previous version of the code, however with this 
> patch reading/writing fifo directly without need of completion should 
> remove that need of another thread!

Right, but you'll also write-off some command/control efficiency by 
either sleeping too much before checking the status, or sleeping too 
little and reading status from a transaction that's not finished.
