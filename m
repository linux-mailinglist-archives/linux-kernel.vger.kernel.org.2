Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FFC3DEA33
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhHCKBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:01:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:49782 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234913AbhHCKBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:01:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="213627398"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="213627398"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 03:00:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="479416899"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.13.248]) ([10.213.13.248])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 03:00:46 -0700
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: Add max98390 echo reference
 support
To:     Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>,
        alsa-devel@alsa-project.org
Cc:     kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        mac.chiang@intel.com, lance.hou@intel.com, broonie@kernel.org,
        brent.lu@intel.com, bard.liao@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        mark_hsieh@wistron.com
References: <20210803092013.10749-1-mark_hsieh@wistron.corp-partner.google.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <c002c16c-dc89-d9ca-dab2-c252c83c5b06@intel.com>
Date:   Tue, 3 Aug 2021 12:00:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803092013.10749-1-mark_hsieh@wistron.corp-partner.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-03 11:20 AM, Mark Hsieh wrote:
> Signed-off-by: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
> ---

Hello,

Any commit message is better than none. Please provide one.

Regards,
Czarek
