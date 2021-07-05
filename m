Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169653BB877
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 09:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhGEH6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:58:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:56039 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhGEH6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:58:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="188622900"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="188622900"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 00:55:53 -0700
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="496036221"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 00:55:52 -0700
Subject: Re: [kbuild-all] arch/arm64/kvm/sys_regs.c:1544:13: warning:
 initialized field overwritten
To:     Marc Zyngier <maz@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202107011859.Aaa29UW0-lkp@intel.com>
 <e1a81333-7113-8c33-3513-594c15c7b190@intel.com>
 <877di99e3y.wl-maz@kernel.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <42a490cd-aebf-c31f-d3d3-9bb7988ba45f@intel.com>
Date:   Mon, 5 Jul 2021 15:55:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <877di99e3y.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/21 6:58 PM, Marc Zyngier wrote:
> Hi Rong,
>
> On Fri, 02 Jul 2021 09:55:00 +0100,
> Rong Chen <rong.a.chen@intel.com> wrote:
>> Hi Marc,
>>
>> It looks like another report
>> https://lore.kernel.org/lkml/202106302037.QmEffgZV-lkp@intel.com/
>> Do you want us to stop report this commit too?
> Yes please. In general, I'm not interested in reports that are
> triggered by the presence of '-Woverride-init' in the compilation
> options.
>
> Thanks,
>
> 	M.
>

Got it, thanks for the information.

Best Regards,
Rong Chen


