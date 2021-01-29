Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5733308E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhA2UUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:20:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:36204 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232344AbhA2UUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:20:16 -0500
IronPort-SDR: hu4iLSsYfyUXtOud4MFusD9vgBwYDKTPAfki+NP5vfgde5SrdEygSIwpwDuhjGey4x2+6GQBlD
 4Z92pp7kPWhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="244564158"
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="244564158"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 12:17:06 -0800
IronPort-SDR: bX7zwAyHAz1U/uXbMTOCh7Oznrc8J8hBPGDCjl3a5vNQiXilCQuGyUVE9xVxKAZUhbq52PWJq0
 2lETdK5o7PSg==
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="431149988"
Received: from kagerrar-mobl.amr.corp.intel.com (HELO [10.212.16.186]) ([10.212.16.186])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 12:17:05 -0800
Subject: Re: [PATCH 3/6] soundwire: qcom: set continue execution flag for
 ignored commands
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210129173248.5941-1-srinivas.kandagatla@linaro.org>
 <20210129173248.5941-4-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f475b33b-94e3-bcd9-51a9-ecf786baa15a@linux.intel.com>
Date:   Fri, 29 Jan 2021 13:21:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210129173248.5941-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/21 11:32 AM, Srinivas Kandagatla wrote:
> version 1.5.1 and higher IPs of this controller required to set
> continue execution on ingored command flag. This patch sets this flag.

typo: ignored.
