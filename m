Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B33B9DC1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhGBIya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:54:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:55573 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhGBIy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:54:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="294345115"
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="294345115"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 01:51:57 -0700
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="559850599"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 01:51:55 -0700
Subject: Re: [kbuild-all] Re: arch/arm64/include/asm/cpufeature.h:273:2:
 warning: initialized field overwritten
To:     Marc Zyngier <maz@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
References: <202106302037.QmEffgZV-lkp@intel.com>
 <87fswzy23t.wl-maz@kernel.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <001d6fd4-49b1-fe11-73e5-b35808dc6332@intel.com>
Date:   Fri, 2 Jul 2021 16:51:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87fswzy23t.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/21 8:21 PM, Marc Zyngier wrote:
> On Wed, 30 Jun 2021 13:08:41 +0100,
> kernel test robot <lkp@intel.com> wrote:
>> Hi Marc,
>>
>> FYI, the error/warning still remains.
> [...]
>
> I really wish the build bot would stop moaning about this. Overriding
> a default when statically initialising a structure is not going away,
> and I have no intention to "fix" it any time soon.
>
> So yes, it remains, and will remain until we get a semantic tool
> allowing us to annotate these cases.
>
> Thanks,
>
> 	M.
>

Hi Marc,

Thanks for the feedback, we'll stop report for this commit.

Best Regards,
Rong Chen
