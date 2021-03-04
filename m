Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36232CA19
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhCDBiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:38:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:35128 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231966AbhCDBho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 20:37:44 -0500
IronPort-SDR: myc3WgeKLqn7vg38XKjxKv8kTcp/uayvBIvf+e3ARRYaHVNuiTVP/51EnyuX6/AfP9gKA0pnGJ
 dUpMTqt7Dccw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="248717150"
X-IronPort-AV: E=Sophos;i="5.81,221,1610438400"; 
   d="scan'208";a="248717150"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 17:37:02 -0800
IronPort-SDR: 9RiAkg9sT3iCjF+cUaD22nwn9OPxBvcSrZKvWc6OQTj0pf0K23F21pE+2XMbGJ41Fr44SRkrEq
 RK04pAPLwMHg==
X-IronPort-AV: E=Sophos;i="5.81,221,1610438400"; 
   d="scan'208";a="407491347"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 17:36:59 -0800
Date:   Thu, 4 Mar 2021 09:36:57 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v9 17/18] virt: acrn: Introduce an interface for Service
 VM to control vCPU
Message-ID: <20210304013657.GC9695@shuo-intel.sh.intel.com>
References: <20210207031040.49576-1-shuo.a.liu@intel.com>
 <20210207031040.49576-18-shuo.a.liu@intel.com>
 <20210303173719.GA30356@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303173719.GA30356@zn.tnic>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed  3.Mar'21 at 18:37:19 +0100, Borislav Petkov wrote:
>On Sun, Feb 07, 2021 at 11:10:39AM +0800, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> ACRN supports partition mode to achieve real-time requirements. In
>> partition mode, a CPU core can be dedicated to a vCPU of User VM. The
>> local APIC of the dedicated CPU core can be passthrough to the User VM.
>> The Service VM controls the assignment of the CPU cores.
>>
>> Introduce an interface for the Service VM to remove the control of CPU
>> core from hypervisor perspective so that the CPU core can be a dedicated
>> CPU core of User VM.
>>
>> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
>> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Zhi Wang <zhi.a.wang@intel.com>
>> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>> Cc: Yu Wang <yu1.wang@intel.com>
>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  drivers/virt/acrn/hsm.c       | 48 +++++++++++++++++++++++++++++++++++
>>  drivers/virt/acrn/hypercall.h | 14 ++++++++++
>>  2 files changed, 62 insertions(+)
>
>This one causes:
>
>drivers/virt/acrn/hsm.c: In function ‘remove_cpu_store’:
>drivers/virt/acrn/hsm.c:389:3: error: implicit declaration of function ‘remove_cpu’; did you mean ‘register_cpu’? [-Werror=implicit-function-declaration]
>   remove_cpu(cpu);
>   ^~~~~~~~~~
>   register_cpu
>drivers/virt/acrn/hsm.c:402:2: error: implicit declaration of function ‘add_cpu’; did you mean ‘task_cpu’? [-Werror=implicit-function-declaration]
>  add_cpu(cpu);
>  ^~~~~~~
>  task_cpu
>cc1: some warnings being treated as errors
>make[3]: *** [scripts/Makefile.build:271: drivers/virt/acrn/hsm.o] Error 1
>make[3]: *** Waiting for unfinished jobs....
>make[2]: *** [scripts/Makefile.build:514: drivers/virt/acrn] Error 2
>make[1]: *** [scripts/Makefile.build:514: drivers/virt] Error 2
>make[1]: *** Waiting for unfinished jobs....
>make: *** [Makefile:1849: drivers] Error 2

This patchset could fix it.
https://lore.kernel.org/lkml/20210221134339.57851-1-shuo.a.liu@intel.com/.

Thanks
shuo
