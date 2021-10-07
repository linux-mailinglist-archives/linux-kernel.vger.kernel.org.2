Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A414254EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241825AbhJGOBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 10:01:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:17351 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241695AbhJGOBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 10:01:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213393937"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="213393937"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 06:59:38 -0700
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="440273795"
Received: from klmutolo-mobl.amr.corp.intel.com (HELO [10.212.1.203]) ([10.212.1.203])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 06:59:37 -0700
Subject: Re: [PATCH v1 1/4] ASoC: Intel: bytcht_es8316: Get platform data via
 dev_get_platdata()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20211006150428.16434-1-andriy.shevchenko@linux.intel.com>
 <c8b85524-6b9f-8fd3-3978-1d26b92660fd@linux.intel.com>
 <CAHp75VdiY98mO2Sj_Urv6m3GgpoUrSyDiPttGxTQeCv_z_1DzQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <16f652da-2473-35bb-acde-9b9cfd23a31a@linux.intel.com>
Date:   Thu, 7 Oct 2021 07:59:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdiY98mO2Sj_Urv6m3GgpoUrSyDiPttGxTQeCv_z_1DzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/21 2:08 AM, Andy Shevchenko wrote:
> On Wed, Oct 6, 2021 at 7:14 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> On 10/6/21 10:04 AM, Andy Shevchenko wrote:
>>> Access to platform data via dev_get_platdata() getter to make code cleaner.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> For the series
>>
>> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.com>
> 
> Are you sure you gave the correct email here?

Thanks for catching this, I need a break obviously.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

