Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA84245C350
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 14:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349340AbhKXNhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 08:37:21 -0500
Received: from foss.arm.com ([217.140.110.172]:38212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350147AbhKXNfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 08:35:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D840A1042;
        Wed, 24 Nov 2021 05:32:05 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D945D3F73B;
        Wed, 24 Nov 2021 05:32:03 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Longpeng \(Mike\, Cloud Infrastructure Service Product Dept.\)" 
        <longpeng2@huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "xen-devel\@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH] cpu/hotplug: Allow the CPU in CPU_UP_PREPARE state to be brought up again.
In-Reply-To: <408748bfefde4a1b963382d372792661@huawei.com>
References: <20211122154714.xaoxok3fpk5bgznz@linutronix.de> <87r1b6d9kl.mognet@arm.com> <408748bfefde4a1b963382d372792661@huawei.com>
Date:   Wed, 24 Nov 2021 13:31:58 +0000
Message-ID: <87lf1dd6i9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/21 00:19, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
>> -----Original Message-----
>> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
>> For my own education, this is talking about *host* CPU hotplug, right?
>>
>
> It's about the *guest* CPU hotplug.
>
> 1. Users in Primary VM:
> Split out vcpuX (offline from Primary VM) for Enclave VM
>
> 2. Hypervisor:
> Set a flag for vcpuX, all requests from Primary VM to bring up vcpuX
> will be ignore.
>
> 3. Users in Primary VM:
> echo 1 > .../vcpuX/online would fail and leave the CPU state of vcpuX
> in CPU_UP_PREPARE.
>
> 4. Users in Primary VM terminate the Enclave VM:
> Hypervisor should clear the flag (set in step 2) of vcpuX, so the vcpuX
> can continue to receive requests.
>
> 5. Users in Primary VM:
> Try to online the vcpuX again (expect success), but it's always failed.
>

If I followed the rabbit hole in the right direction, this is about:
ff8a4d3e3a99 ("nitro_enclaves: Add logic for setting an enclave vCPU")

So there's a 1:1 CPU:vCPU mapping and an Enclave carves a chunk out of the
Primary VM...

Thanks for the detailed explanation!
