Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC261333324
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhCJCbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:31:35 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44204 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhCJCbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:31:05 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 60413208CF3F;
        Tue,  9 Mar 2021 18:31:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60413208CF3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1615343465;
        bh=zyAxx9X7db3xy7R9k6SWK3OhsYY9Ys/qYCIMIrLY89E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JfvW/B6Ap41tfrrlv+LoSg0oGUs//FcsYMmOIlOHbyKRKcIRKhmr1aGlZtWTwMeng
         nwBXYR51wSX2e9X3Woow1jwfWw8WzLLmLNKexwZiE5WKjMz3j8S6O0hw5/Wfq640km
         lUQdoGC6XBVovEBLOGZJdldX/8TQUB3+jD719qm8=
Subject: Re: [PATCH v2] powerpc/kexec_file: Restore FDT size estimation for
 kdump kernel
To:     Rob Herring <robh@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210220005204.1417200-1-bauerman@linux.ibm.com>
 <CAL_JsqJatxTwSbM8a0PB2ievO_fRFeYJ8ZtBN0pRfnEjSXyUkg@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <7d0c6062-ca73-f183-110d-f5b75ae91d10@linux.microsoft.com>
Date:   Tue, 9 Mar 2021 18:31:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJatxTwSbM8a0PB2ievO_fRFeYJ8ZtBN0pRfnEjSXyUkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 6:08 PM, Rob Herring wrote:

Hi Rob,

> On Fri, Feb 19, 2021 at 6:52 PM Thiago Jung Bauermann
> <bauerman@linux.ibm.com> wrote:
>>
>> Commit 2377c92e37fe ("powerpc/kexec_file: fix FDT size estimation for kdump
>> kernel") fixed how elf64_load() estimates the FDT size needed by the
>> crashdump kernel.
>>
>> At the same time, commit 130b2d59cec0 ("powerpc: Use common
>> of_kexec_alloc_and_setup_fdt()") changed the same code to use the generic
>> function of_kexec_alloc_and_setup_fdt() to calculate the FDT size. That
>> change made the code overestimate it a bit by counting twice the space
>> required for the kernel command line and /chosen properties.
>>
>> Therefore change kexec_fdt_totalsize_ppc64() to calculate just the extra
>> space needed by the kdump kernel, and change the function name so that it
>> better reflects what the function is now doing.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   arch/powerpc/include/asm/kexec.h  |  2 +-
>>   arch/powerpc/kexec/elf_64.c       |  2 +-
>>   arch/powerpc/kexec/file_load_64.c | 26 ++++++++------------------
>>   3 files changed, 10 insertions(+), 20 deletions(-)
> 
> I ended up delaying the referenced series til 5.13, but have applied
> it now. Can I get an ack from the powerpc maintainers on this one?
> I'll fixup the commit log to make sense given the commit id's aren't
> valid.

I checked the change applied in linux-next branch and also Device Tree's 
for-next branch - it looks like v1 of Thiago's patch has been applied. 
Could you please pick up the v2 patch?

thanks,
  -lakshmi


