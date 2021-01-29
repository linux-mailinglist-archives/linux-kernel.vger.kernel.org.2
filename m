Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B59308E45
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhA2US5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:18:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:36204 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232855AbhA2US4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:18:56 -0500
IronPort-SDR: DoSkoHJU21WcRy9gMuMehTdznOZPQZRy0ZKS/qxOf0dVNJZfCimSdqNjsuFFJHu7d1lTmthCfl
 PdwvQrv/odaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="244564152"
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="244564152"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 12:17:04 -0800
IronPort-SDR: HULWv+4oCxXM5ywY8ZWbeu8rPHsujEmyJYRoLepbouLQxVkyWOKhES8vSMDi+et+Mi7Nkrp5uN
 uw1KbC9VffEg==
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="431149972"
Received: from kagerrar-mobl.amr.corp.intel.com (HELO [10.212.16.186]) ([10.212.16.186])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 12:17:03 -0800
Subject: Re: [PATCH 1/6] soundwire: qcom: add support to missing transport
 params
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-2-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <29eb1b75-d92f-9641-8181-1fe250b189ec@linux.intel.com>
Date:   Fri, 29 Jan 2021 13:20:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210129173248.5941-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   struct qcom_swrm_port_config {
>   	u8 si;
>   	u8 off1;
>   	u8 off2;
>   	u8 bp_mode;
> +	u8 hstart;
> +	u8 hstop;
> +	u8 word_length;
> +	u8 bgp_count;

I couldn't figure out what 'bgp' was and had to search. Not sure how you 
came up with this abbreviation of "qcom,ports-block-group-count". Adding 
a comment wouldn't hurt.

> +	u8 lane_control;

Are you able to use lane_control != 0 ? I thought we were missing stuff 
at the bus.c level?

