Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A049F314CFA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhBIK2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:28:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:34106 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231725AbhBIKTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:19:39 -0500
IronPort-SDR: dNkmE8Eyjl9RwoobUve/Ja1o7am2Hyjipna9Q81FnErHtqryca0r1f3K55fDa+IOgWiQUq7Ysn
 TODQwDFEMXfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="182003195"
X-IronPort-AV: E=Sophos;i="5.81,164,1610438400"; 
   d="scan'208";a="182003195"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 02:18:53 -0800
IronPort-SDR: He5tAHtoEYXlOqIKbGKquQgstzXgcG1ROVWz9v9pqn8A6af69CKU4SblPxW7wmBhxSO8hR02LI
 TLfRSOmV1rsA==
X-IronPort-AV: E=Sophos;i="5.81,164,1610438400"; 
   d="scan'208";a="396059715"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 02:18:50 -0800
Date:   Tue, 9 Feb 2021 18:18:48 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 00/18] HSM driver for ACRN hypervisor
Message-ID: <20210209101848.GD15601@shuo-intel.sh.intel.com>
References: <20210207031040.49576-1-shuo.a.liu@intel.com>
 <YCJdVy+e5Sy2IcnS@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YCJdVy+e5Sy2IcnS@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue  9.Feb'21 at 11:00:55 +0100, Greg Kroah-Hartman wrote:
>On Sun, Feb 07, 2021 at 11:10:22AM +0800, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> ACRN is a Type 1 reference hypervisor stack, running directly on the bare-metal
>> hardware, and is suitable for a variety of IoT and embedded device solutions.
>>
>> ACRN implements a hybrid VMM architecture, using a privileged Service VM. The
>> Service VM manages the system resources (CPU, memory, etc.) and I/O devices of
>> User VMs. Multiple User VMs are supported, with each of them running Linux,
>> Android OS or Windows. Both Service VM and User VMs are guest VM.
>>
>> Below figure shows the architecture.
>>
>>                 Service VM                    User VM
>>       +----------------------------+  |  +------------------+
>>       |        +--------------+    |  |  |                  |
>>       |        |ACRN userspace|    |  |  |                  |
>>       |        +--------------+    |  |  |                  |
>>       |-----------------ioctl------|  |  |                  |   ...
>>       |kernel space   +----------+ |  |  |                  |
>>       |               |   HSM    | |  |  | Drivers          |
>>       |               +----------+ |  |  |                  |
>>       +--------------------|-------+  |  +------------------+
>>   +---------------------hypercall----------------------------------------+
>>   |                       ACRN Hypervisor                                |
>>   +----------------------------------------------------------------------+
>>   |                          Hardware                                    |
>>   +----------------------------------------------------------------------+
>>
>> There is only one Service VM which could run Linux as OS.
>>
>> In a typical case, the Service VM will be auto started when ACRN Hypervisor is
>> booted. Then the ACRN userspace (an application running in Service VM) could be
>> used to start/stop User VMs by communicating with ACRN Hypervisor Service
>> Module (HSM).
>>
>> ACRN Hypervisor Service Module (HSM) is a middle layer that allows the ACRN
>> userspace and Service VM OS kernel to communicate with ACRN Hypervisor
>> and manage different User VMs. This middle layer provides the following
>> functionalities,
>>   - Issues hypercalls to the hypervisor to manage User VMs:
>>       * VM/vCPU management
>>       * Memory management
>>       * Device passthrough
>>       * Interrupts injection
>>   - I/O requests handling from User VMs.
>>   - Exports ioctl through HSM char device.
>>   - Exports function calls for other kernel modules
>>
>> ACRN is focused on embedded system. So it doesn't support some features.
>> E.g.,
>>   - ACRN doesn't support VM migration.
>>   - ACRN doesn't support vCPU migration.
>>
>> This patch set adds the HSM to the Linux kernel.
>> I also added a simple example to launch a small guest (with several instructions
>> as payload) on ACRN with demonstration ioctl usage.
>>
>> The basic ARCN support was merged to upstream already.
>> https://lore.kernel.org/lkml/1559108037-18813-3-git-send-email-yakui.zhao@intel.com/
>
>Thanks for sticking with this, now merged to my tree.

Thanks Greg and all for reviewing this series.

A really good Spring Festival gift for ACRN. :)

Thanks
shuo
