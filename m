Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D2417706
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 16:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346889AbhIXOsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 10:48:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:51674 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346185AbhIXOsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 10:48:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="203580780"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="203580780"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 07:46:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="551835095"
Received: from bordone-mobl1.amr.corp.intel.com (HELO [10.209.164.235]) ([10.209.164.235])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 07:46:30 -0700
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt8195: add machine driver with
 mt6359, rt1011 and rt5682
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        tiwai@suse.com, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        aaronyu@google.com, linux-arm-kernel@lists.infradead.org
References: <20210910104405.11420-1-trevor.wu@mediatek.com>
 <20210910104405.11420-2-trevor.wu@mediatek.com>
 <10fc49fa-9791-0225-365d-e3074680596c@linux.intel.com>
 <4d703c5f7cf27ddc8b9886b111ffeeba0c4aa08b.camel@mediatek.com>
 <1d7fe7455a054819daf05d41ab3658afdc1caced.camel@mediatek.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c34d03ff-f349-724e-0dcf-7893f3622cd9@linux.intel.com>
Date:   Fri, 24 Sep 2021 09:46:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1d7fe7455a054819daf05d41ab3658afdc1caced.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +/* Module information */
>>>> +MODULE_DESCRIPTION("MT8195-MT6359-RT1011-RT5682 ALSA SoC machine
>>>> driver");
>>>> +MODULE_AUTHOR("Trevor Wu <trevor.wu@mediatek.com>");
>>>> +MODULE_LICENSE("GPL v2");
>>>
>>> "GPL" is enough
>>>
>>
>> I see many projects use GPL v2 here, and all mediatek projects use
>> GPL
>> v2, too.
>> I'm not sure which one is better.
>> Do I need to modify this?

See
https://www.kernel.org/doc/html/latest/process/license-rules.html?highlight=module_license#id1

Loadable kernel modules also require a MODULE_LICENSE() tag. This tag is
neither a replacement for proper source code license information
(SPDX-License-Identifier) nor in any way relevant for expressing or
determining the exact license under which the source code of the module
is provided.

“GPL”

Module is licensed under GPL version 2. This does not express any
distinction between GPL-2.0-only or GPL-2.0-or-later. The exact license
information can only be determined via the license information in the
corresponding source files.

“GPL v2”

Same as “GPL”. It exists for historic reasons.

So "GPL v2" is not incorrect but for new contributions you might as well
use the recommended tag.
