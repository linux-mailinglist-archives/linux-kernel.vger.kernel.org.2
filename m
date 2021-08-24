Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33C93F6370
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhHXQyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:54:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:31291 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233870AbhHXQyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:54:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="204486974"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="204486974"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:53:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="685433427"
Received: from jlrivera-mobl1.amr.corp.intel.com (HELO [10.212.8.132]) ([10.212.8.132])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 09:53:31 -0700
Subject: Re: [PATCH] [v2] ASoC: Intel: sof_rt5682: Add support for max98390
 speaker amp
To:     Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>,
        alsa-devel@alsa-project.org
Cc:     cezary.rojewski@intel.com, kai.vehmanen@linux.intel.com,
        mac.chiang@intel.com, lance.hou@intel.com, broonie@kernel.org,
        brent.lu@intel.com, bard.liao@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        mark_hsieh@wistron.com
References: <20210824132109.1392-1-mark_hsieh@wistron.corp-partner.google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c0e98e24-1c62-aa37-e283-c8b5f56f4f2e@linux.intel.com>
Date:   Tue, 24 Aug 2021 11:22:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824132109.1392-1-mark_hsieh@wistron.corp-partner.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks mostly good, minor comments below

On 8/24/21 8:21 AM, Mark Hsieh wrote:
> Configure adl_max98390_rt5682 to support the rt5682 headset codec and max98390 speaker
> 
> BUG=b:191811888
> TEST=emerge-brya chromeos-kernel-5_10

I don't think we need this for upstream?

> +struct snd_soc_ops max_98390_ops = {
> +	.hw_params = max_98390_hw_params,
> +};

this could be const. We didn't do it for previous codecs but that was a
miss. I'll send a patch for the max98373

> +extern struct snd_soc_ops max_98390_ops;

const

