Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B54428F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhJKN4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:56:19 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:49485 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237711AbhJKNyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:54:16 -0400
Received: from [192.168.0.2] (ip5f5aef5a.dynamic.kabel-deutschland.de [95.90.239.90])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9BD1461E5FE33;
        Mon, 11 Oct 2021 15:52:15 +0200 (CEST)
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, Borislav Petkov <bp@alien8.de>
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de>
 <YWQ3963xcO3xbFo5@zn.tnic> <87d93314-ba3e-464f-d051-84a8de674b06@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <139ed784-d622-b0d2-3650-736b42e624f0@molgen.mpg.de>
Date:   Mon, 11 Oct 2021 15:52:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87d93314-ba3e-464f-d051-84a8de674b06@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Tom,


Am 11.10.21 um 15:27 schrieb Tom Lendacky:
> On 10/11/21 8:11 AM, Borislav Petkov wrote:
>> On Mon, Oct 11, 2021 at 03:05:33PM +0200, Paul Menzel wrote:
>>> I think, the IOMMU is enabled on the MSI B350M MORTAR, but otherwise, 
>>> yes
>>> this looks fine. The help text could also be updated to mention problems
>>> with AMD Raven devices.
>>
>> This is not only about Raven GPUs but, as Alex explained, pretty much
>> about every device which doesn't support a 48 bit DMA mask. I'll expand
>> that aspect in the changelog.
> 
> In general, non-GPU devices that don't support a 48-bit DMA mask work 
> fine (assuming they have set their DMA mask appropriately). It really 
> depends on whether SWIOTLB will be able to satisfy the memory 
> requirements of the driver when the IOMMU is not enabled or in 
> passthrough mode. Since GPU devices need/use a lot of memory, that 
> becomes a problem.

How can I check that?


Kind regards,

Paul
