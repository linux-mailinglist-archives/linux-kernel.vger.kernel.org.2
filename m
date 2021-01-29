Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC1A308E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhA2UXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:23:31 -0500
Received: from mga07.intel.com ([134.134.136.100]:36204 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233092AbhA2UVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:21:40 -0500
IronPort-SDR: 3LCFsF04xiZMDxWqBS5Ek70GqftMiNrmoh5Fdz8j/+Xazaxm1d5hohWItgHZQkCWQPOqBgGwTi
 J4Vika4ROg/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="244564170"
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="244564170"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 12:17:10 -0800
IronPort-SDR: 4iUoTLsK6X6g3lCJu8TKhFGnkmMJ+ssQqrjiJ2apzIBjEOVNvNLlzfm/RfwI8AJ6DkiWcFMtIA
 rR9Z1034pxSw==
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="431150014"
Received: from kagerrar-mobl.amr.corp.intel.com (HELO [10.212.16.186]) ([10.212.16.186])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 12:17:09 -0800
Subject: Re: [PATCH 6/6] soundwire: qcom: add support to new interrupts
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-7-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <95d3b143-6ba7-e6eb-4f44-9a8bb05b7fb7@linux.intel.com>
Date:   Fri, 29 Jan 2021 13:38:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210129173248.5941-7-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/21 11:32 AM, Srinivas Kandagatla wrote:
> Add support to new interrupts and update irq routine in a way
> to deal with multiple pending interrupts with in a single interrupt!

I can't parse the wording after 'update irq routine'.


> +	swrm->reg_write(swrm, SWRM_INTERRUPT_CLEAR, intr_sts);
> +	swrm->reg_write(swrm, SWRM_INTERRUPT_CLEAR, 0x0);

what does this second write 0x0 do? Usually interrupts are W1C, and you 
didn't have this before.

