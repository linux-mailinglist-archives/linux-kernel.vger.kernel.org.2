Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7586637D1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 20:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352563AbhELSDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 14:03:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:23556 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241391AbhELQ1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:27:07 -0400
IronPort-SDR: W49jOorMNATVSlfdFZ5xAzjB0zIITVOIi9q6yJs/hUQUFJqG6bU8IDtUOrwzt3wc6fhqVuasJr
 mDI4Ra/dC7bQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187172842"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="187172842"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 09:25:58 -0700
IronPort-SDR: dHfPVdrBuQvyobdL3A9WvlZuIsDR0OwBTAZWGxKLKH/0nZHrk0K2RmOiIZ11T4dXanxRqC3bLb
 vR0taFWc/cfg==
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="455671473"
Received: from tzehanch-mobl2.amr.corp.intel.com (HELO [10.213.186.26]) ([10.213.186.26])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 09:25:56 -0700
Subject: Re: [PATCH -next] ASoC: intel/boards: add missing MODULE_DEVICE_TABLE
To:     Mark Brown <broonie@kernel.org>
Cc:     sathyanarayana.nujella@intel.com, fred.oh@linux.intel.com,
        cezary.rojewski@intel.com, dharageswari.r@intel.com,
        kai.vehmanen@linux.intel.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, yang.jie@linux.intel.com,
        tiwai@suse.com, liam.r.girdwood@linux.intel.com,
        tzungbi@google.com, ranjani.sridharan@linux.intel.com,
        Zou Wei <zou_wei@huawei.com>, alsa-devel@alsa-project.org,
        brent.lu@intel.com, yong.zhi@intel.com
References: <1620791647-16024-1-git-send-email-zou_wei@huawei.com>
 <50fa973b-aa9f-ccb4-8020-9d38a63e2c30@linux.intel.com>
 <20210512155318.GA54562@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b2873226-4505-5a7b-74ce-95e8d4dd72b5@linux.intel.com>
Date:   Wed, 12 May 2021 11:25:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512155318.GA54562@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> I wonder if this MODULE_DEVICE_TABLE generates the alias automatically,
>> which would make the existing ones added manually at the end of the files
>> unnecessary? If that was the case, then we should remove those MODULE_ALIAS
>> as well, no?
> 
> Yes, you shouldn't need the MODULE_ALIAS stuff there.

ok, if that's alright with everyone I'll send a larger patchset that 
correct this for all machine drivers, and add the following two tags to 
give proper credits to the reporters.

Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Zou Wei <zou_wei@huawei.com>

