Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E25A3A4852
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhFKSFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:05:43 -0400
Received: from foss.arm.com ([217.140.110.172]:37290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhFKSF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:05:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9713E1FB;
        Fri, 11 Jun 2021 11:03:28 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CB943F719;
        Fri, 11 Jun 2021 11:03:26 -0700 (PDT)
Subject: Re: [RFC] Adding A64FX hardware prefetch sysfs interface
To:     "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     "'hpa@zytor.com'" <hpa@zytor.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Will@kernel.org" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Borislav Petkov <bp@alien8.de>
References: <OSBPR01MB2037D114B11153F00F233F8780389@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YL3UpAZ6wZi6GyAx@zn.tnic>
From:   James Morse <james.morse@arm.com>
Message-ID: <fe05554f-74a5-175b-73d5-ff20b8d3abde@arm.com>
Date:   Fri, 11 Jun 2021 19:03:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YL3UpAZ6wZi6GyAx@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

(CC: +Catalin and Will)

On 07/06/2021 09:11, Borislav Petkov wrote:
> (not trimming the mail so that ARM folks can see the whole thing)
> 
> On Mon, Jun 07, 2021 at 01:39:21AM +0000, tarumizu.kohei@fujitsu.com wrote:
>> Hello
>>
>> I'm Kohei Tarumizu from Fujitsu Limited. 
>>
>> Fujitsu A64FX processor implements a vendor specific function, the HPC extensions[1].
>> A64FX has some registers for HPC extensions.
>> We would like to use the register IMP_PF_STREAM_DETECT_CTRL_EL0 for tuning the hardware prefetch, but it's not accessible from userspace.
>> We are considering to implement a kernel common interface via sysfs as a way to control IMP_PF_STREAM_DETECT_CTRL_EL0 from userspace.


>> FYI, A64FX also has registers (e.g. IMP_PF_INJECTION_*) to control the behavior of the hardware prefetch from the software using "HPC tag address override", but this time we don't considered.
>>
>> [1]https://github.com/fujitsu/A64FX/tree/master/doc/
>>    A64FX_Specification_HPC_Extension_v1_EN.pdf

While this is initially about sysfs, don't you need the 'HPC tag address override' to be
enabled for this to be useful? I don't think that feature can be managed by a driver:

'HPC tag address override' changes the top byte of all user-space pointers from being
ignored (as they have been since day-1 on arm64) to having implications for the hardware.
If I've read the document correctly this affects the prefetch mode and where in the L1/L2
such accesses will be allocated.

This would impact user-space that is using the top-byte for their own purposes.
For example hwasan uses this field as a tag it allocates itself:
https://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
Enabling 'HPC tag address override' for all user-space is going to have weird performance
effects.

To make this work, I think you'd need a per-process opt-in, and __switch_to() would need
to toggle your IMP_FJ_TAG_ADDRESS_CTRL_EL1.TBOx bits. Because its an
implementation-defined feature, but the controls can't be confined to a driver, I don't
think enabling 'HPC tag address override' is viable.

Is the sysfs information useful without it?


Thanks,

James
