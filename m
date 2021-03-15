Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCAC33C4F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhCOR41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:56:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:49471 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231909AbhCORsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:48:41 -0400
IronPort-SDR: LyMUd7N00xTB6KZQqPb26mPw4an8l7YeBlpsAK4vol4jW0WiDxDKWP+OmN/JxQFaBoTBd6HiwZ
 IgpO0Iv1HTbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="274171851"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="274171851"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 10:46:00 -0700
IronPort-SDR: v8t5y50ubkXves4zafwbQVR32hXp6Mt5VX4zMLdh7feUVv5AskleWaXsAgrqYunr/+jqDs14wF
 zEIeZvVMn3Bg==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="438962876"
Received: from pwells-mobl2.amr.corp.intel.com (HELO [10.212.5.38]) ([10.212.5.38])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 10:45:59 -0700
Subject: Re: [PATCH v4 0/5] soundwire: add static port map support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c7bbbcb3-cc82-9422-9736-7d5393970fb3@linux.intel.com>
Date:   Mon, 15 Mar 2021 12:10:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210315165650.13392-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/21 11:56 AM, Srinivas Kandagatla wrote:
> In some cases, SoundWire device ports are statically mapped to Controller
> ports during design, however there is no way to expose this information
> to the controller. Controllers like Qualcomm ones use this info to setup
> static bandwidth parameters for those ports.
> 
> A generic port allocation is not possible in this cases!
> This patch adds a new member m_port_map to SoundWire device so that
> it can populate the static master port map and share it with controller
> to be able to setup correct bandwidth parameters.
> 
> As a user of this feature this patchset also adds new bindings for
> wsa881x smart speaker which has 4 ports which are statically mapped
> to the 3 output and 1 input port of the controller.
> 
> Tested it on DB845c and SM8250 MTP.
> 
> thanks,
> srini

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> Changes since v3:
> 	- updated kernel doc for more clarity on m_port_map
> 
> Srinivas Kandagatla (5):
>    soundwire: add static port mapping support
>    soundwire: qcom: update port map allocation bit mask
>    soundwire: qcom: add static port map support
>    ASoC: dt-bindings: wsa881x: add bindings for port mapping
>    ASoC: codecs: wsa881x: add static port map support
> 
>   .../bindings/sound/qcom,wsa881x.yaml          |  9 ++++++
>   drivers/soundwire/qcom.c                      | 31 +++++++++++++++----
>   include/linux/soundwire/sdw.h                 |  2 ++
>   sound/soc/codecs/wsa881x.c                    |  7 +++++
>   4 files changed, 43 insertions(+), 6 deletions(-)
> 
