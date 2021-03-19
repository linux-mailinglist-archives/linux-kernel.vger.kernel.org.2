Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DEE3422AD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhCSQ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:59:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:37207 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhCSQ63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:58:29 -0400
IronPort-SDR: L+mPZLhgCOU2eGeARA54KFcPvJ/JCnnL6MlZDu8HMCXqHtnk09JSxM1GhFtbczIEeQxwku4g3a
 8x9Ez+qaCTDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="177060429"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="177060429"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 09:58:29 -0700
IronPort-SDR: K8CaVHAuhQq6PMoKxpssvj+a68B72QDjgalp//VNWxiXUqHsWBYYNf3hd21+P4iE7ytjWu45mL
 ASQnpwOGN4ug==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="406867512"
Received: from dgerstma-mobl.amr.corp.intel.com (HELO [10.212.157.39]) ([10.212.157.39])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 09:58:28 -0700
Subject: Re: [PATCH v3 0/7] ASoC: codecs: add wcd938x support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
References: <20210319092919.21218-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <27e19637-b9ea-1adb-46e5-252480a9a353@linux.intel.com>
Date:   Fri, 19 Mar 2021 11:09:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210319092919.21218-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/21 4:29 AM, Srinivas Kandagatla wrote:
> This patchset adds support for Qualcomm WCD938X codec.
> 
> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire devices, RX and
> TX respectively supporting 4 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
> 7 x TX diff inputs, 8 DMICs and MBHC.
> 
> Even though this device has two SoundWire devices, only tx device has
> access to main codec Control/Status Registers!

That part is a new concept we haven't seen so far with SoundWire 
support, and I added a number of comments in the patches.

It would really help if you could add more explanations on how 
regmap/pm_runtime/gpios/regulators/interrupts are supposed to work with 
such a functional split. Thanks!

> This patchset along with other SoundWire patches on the list
> have been tested on SM8250 MTP device.
> 
> Am planning to send support for MBHC once this driver gets accepted!
> 
> Thanks,
> srini
> 
> Many thanks for reviewing v2.
> 
> 
> Changes since v2:
> 	- fixed dt_binding_check error
> 
> 
> Srinivas Kandagatla (7):
>    ASoC: dt-bindings: wcd938x: add bindings for wcd938x
>    ASoC: codecs: wcd-clsh: add new version support
>    ASoC: codecs: wcd938x: add basic driver
>    ASoC: codecs: wcd938x: add basic controls
>    ASoC: codecs: wcd938x: add playback dapm widgets
>    ASoC: codecs: wcd938x: add capture dapm widgets
>    ASoC: codecs: wcd938x: add audio routing
> 
>   .../bindings/sound/qcom,wcd938x.yaml          |  165 +
>   sound/soc/codecs/Kconfig                      |    9 +
>   sound/soc/codecs/Makefile                     |    2 +
>   sound/soc/codecs/wcd-clsh-v2.c                |  350 +-
>   sound/soc/codecs/wcd-clsh-v2.h                |   16 +
>   sound/soc/codecs/wcd938x-sdw.c                |  291 ++
>   sound/soc/codecs/wcd938x.c                    | 3623 +++++++++++++++++
>   sound/soc/codecs/wcd938x.h                    |  676 +++
>   8 files changed, 5122 insertions(+), 10 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
>   create mode 100644 sound/soc/codecs/wcd938x-sdw.c
>   create mode 100644 sound/soc/codecs/wcd938x.c
>   create mode 100644 sound/soc/codecs/wcd938x.h
> 
