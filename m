Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A373334AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCJFDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCJFDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:03:34 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227A8C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 21:03:34 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DwKjG3XrVz9sRf;
        Wed, 10 Mar 2021 16:03:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1615352611;
        bh=mFLZjQ07eWZBJbT4TD+7HDL1AcSUtc853P+SoEFe69o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pIMNXI7upzAjuxRm7/c2WODG/A1MmxvsNttA9zpdwiyzRzQ6gjo6wwcBiH5otoQ5L
         38iYWfcq8EArgdhHjMrlbh1prxOuLvyVQwsZychqcxgXdEWNx85Q88bZ2ciWT4Kuee
         bGu1IDFWYxhnkjdeqIsRJqinjnooL1UR+Eh9AURjW3IirWe8sjJuo5JJ0QYWaPMCc3
         ZyszTXO/BrzohKGrBSOTM+rHjbSm0JHdsFYSM+cVei1UGI1yFInVOwOREkqeXSWkMO
         SrmyDoXWyqSIgl9sf1+2zhUo0RElqnMG6nCFKEG2iGTTLKYOeXiYR+HrWcwAsEmkLd
         UnQPZ4h/FJM5Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] powerpc/kexec_file: Restore FDT size estimation for
 kdump kernel
In-Reply-To: <CAL_JsqJatxTwSbM8a0PB2ievO_fRFeYJ8ZtBN0pRfnEjSXyUkg@mail.gmail.com>
References: <20210220005204.1417200-1-bauerman@linux.ibm.com>
 <CAL_JsqJatxTwSbM8a0PB2ievO_fRFeYJ8ZtBN0pRfnEjSXyUkg@mail.gmail.com>
Date:   Wed, 10 Mar 2021 16:03:27 +1100
Message-ID: <87a6rbr468.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
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
>>  arch/powerpc/include/asm/kexec.h  |  2 +-
>>  arch/powerpc/kexec/elf_64.c       |  2 +-
>>  arch/powerpc/kexec/file_load_64.c | 26 ++++++++------------------
>>  3 files changed, 10 insertions(+), 20 deletions(-)
>
> I ended up delaying the referenced series til 5.13, but have applied
> it now. Can I get an ack from the powerpc maintainers on this one?
> I'll fixup the commit log to make sense given the commit id's aren't
> valid.

Thanks for handling it.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
