Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C69314C97
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhBIKKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:10:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhBIKCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:02:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2710064EC3;
        Tue,  9 Feb 2021 10:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612864893;
        bh=8aZXrrIS64dYLIyxQLKVtTRe+kFRnjTdEdr6ubK33PM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWBf0adiBgzD5kS0X+WTQzAjAXsTqELxIkhtxoETyaKfErzTFoad2gc15uSVFM77K
         Ie0J38KwVmKqRMCrvsjyBcQTcc8ks4ozpBsEtsBngd1tkHN/6KlbrWv07G4DTuK+H2
         BCeP0F61LA3EeVyZATQOjqFQ1G3UE77dyG0/ThaI=
Date:   Tue, 9 Feb 2021 11:00:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 00/18] HSM driver for ACRN hypervisor
Message-ID: <YCJdVy+e5Sy2IcnS@kroah.com>
References: <20210207031040.49576-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207031040.49576-1-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 11:10:22AM +0800, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> ACRN is a Type 1 reference hypervisor stack, running directly on the bare-metal
> hardware, and is suitable for a variety of IoT and embedded device solutions.
> 
> ACRN implements a hybrid VMM architecture, using a privileged Service VM. The
> Service VM manages the system resources (CPU, memory, etc.) and I/O devices of
> User VMs. Multiple User VMs are supported, with each of them running Linux,
> Android OS or Windows. Both Service VM and User VMs are guest VM.
> 
> Below figure shows the architecture.
> 
>                 Service VM                    User VM
>       +----------------------------+  |  +------------------+
>       |        +--------------+    |  |  |                  |
>       |        |ACRN userspace|    |  |  |                  |
>       |        +--------------+    |  |  |                  |
>       |-----------------ioctl------|  |  |                  |   ...
>       |kernel space   +----------+ |  |  |                  |
>       |               |   HSM    | |  |  | Drivers          |
>       |               +----------+ |  |  |                  |
>       +--------------------|-------+  |  +------------------+
>   +---------------------hypercall----------------------------------------+
>   |                       ACRN Hypervisor                                |
>   +----------------------------------------------------------------------+
>   |                          Hardware                                    |
>   +----------------------------------------------------------------------+
> 
> There is only one Service VM which could run Linux as OS.
> 
> In a typical case, the Service VM will be auto started when ACRN Hypervisor is
> booted. Then the ACRN userspace (an application running in Service VM) could be
> used to start/stop User VMs by communicating with ACRN Hypervisor Service
> Module (HSM).
> 
> ACRN Hypervisor Service Module (HSM) is a middle layer that allows the ACRN
> userspace and Service VM OS kernel to communicate with ACRN Hypervisor
> and manage different User VMs. This middle layer provides the following
> functionalities,
>   - Issues hypercalls to the hypervisor to manage User VMs:
>       * VM/vCPU management
>       * Memory management
>       * Device passthrough
>       * Interrupts injection
>   - I/O requests handling from User VMs.
>   - Exports ioctl through HSM char device.
>   - Exports function calls for other kernel modules
> 
> ACRN is focused on embedded system. So it doesn't support some features.
> E.g.,
>   - ACRN doesn't support VM migration.
>   - ACRN doesn't support vCPU migration.
> 
> This patch set adds the HSM to the Linux kernel.
> I also added a simple example to launch a small guest (with several instructions
> as payload) on ACRN with demonstration ioctl usage.
> 
> The basic ARCN support was merged to upstream already.
> https://lore.kernel.org/lkml/1559108037-18813-3-git-send-email-yakui.zhao@intel.com/

Thanks for sticking with this, now merged to my tree.

thanks,

greg k-h
