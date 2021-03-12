Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DF8339403
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhCLQ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:56:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:41916 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232238AbhCLQ4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:56:34 -0500
IronPort-SDR: kEmlWVVO53mUnbq2jyYItsuZTSabuZ+diJnR3GMhmARBQnjzk+jttV+CVGaMFhF5+IME/QhAR7
 RSX/z5+1Thfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="273900510"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="273900510"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 08:56:34 -0800
IronPort-SDR: m7PV7WkfAc93lqSIuY6CTzzWASguNbQtVIwM4ROE95HmqWyBGDjCzP7tQWliwQi4pEojYFkEZk
 gIQ0aA0uy8ag==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="411064612"
Received: from akharche-mobl2.ccr.corp.intel.com (HELO [10.212.135.254]) ([10.212.135.254])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 08:56:33 -0800
Subject: Re: [PATCH v4 0/9] soundwire: qcom: various improvements
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
References: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5afd877e-2213-85f5-cd3c-eca8d060d75c@linux.intel.com>
Date:   Fri, 12 Mar 2021 10:33:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210312120009.22386-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/21 6:00 AM, Srinivas Kandagatla wrote:
> Thanks for reviewing v3 of this patchset!
> 
> During testing SoundWire controller on SM8250 MTP, we found
> few issues like all the interrupts are not handled,
> all transport parameters are not read from device tree.
> Patch to add Auto Enumeration supported by the controller
> is also part of this series.
> 
> Other major issue was register read/writes which was interrupt based
> was an overhead and puts lot of limitation on context it can be used from.
> 
> With previous approach number of interrupts generated
> after enumeration are around 130:
> $ cat /proc/interrupts  | grep soundwire
> 21: 130 0 0 0 0 0 0 0 GICv3 234 Edge      soundwire
>      
> after this patch they are just 3 interrupts
> $ cat /proc/interrupts  | grep soundwire
> 21: 3 0 0 0 0 0 0 0 GICv3 234 Edge      soundwire
> 
> So this patchset add various improvements to the existing driver
> to address above issues.
> 
> Tested it on SM8250 MTP with 2x WSA881x speakers, HeadPhones on
> WCD938x via lpass-rx-macro and Analog MICs via lpass-tx-macro.
> Also tested on DragonBoard DB845c with 2xWSA881x speakers.

LGTM, for the series

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Changes since v3:
> 	- Fixed setting assigned bit during autoenumeration
> 
> Srinivas Kandagatla (9):
>    dt-bindings: soundwire: qcom: clarify data port bus parameters
>    soundwire: qcom: add support to missing transport params
>    soundwire: qcom: set continue execution flag for ignored commands
>    soundwire: qcom: start the clock during initialization
>    soundwire: qcom: update register read/write routine
>    soundwire: qcom: add support to new interrupts
>    soundwire: export sdw_compare_devid() and sdw_extract_slave_id()
>    soundwire: qcom: add auto enumeration support
>    soundwire: qcom: wait for enumeration to be complete in probe
> 
>   .../bindings/soundwire/qcom,sdw.txt           |  20 +
>   drivers/soundwire/bus.c                       |   4 +-
>   drivers/soundwire/qcom.c                      | 529 ++++++++++++++----
>   include/linux/soundwire/sdw.h                 |   2 +
>   4 files changed, 442 insertions(+), 113 deletions(-)
> 
