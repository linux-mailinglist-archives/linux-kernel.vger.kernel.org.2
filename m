Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E36B3D8D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhG1MTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:19:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:6135 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234880AbhG1MTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:19:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="192930922"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="192930922"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 05:18:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="506438470"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.23.4]) ([10.213.23.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 05:18:54 -0700
Subject: Re: [PATCH] ASoC: Intel: Fix spelling contraction "cant" -> "can't"
To:     Colin King <colin.king@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210728103602.171817-1-colin.king@canonical.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <f95103b4-2527-b469-cd77-3afe4973abae@intel.com>
Date:   Wed, 28 Jul 2021 14:18:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728103602.171817-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-28 12:36 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err message. Fix it.
> 

Thank you for the fix.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
