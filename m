Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B670A309513
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 13:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhA3MRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 07:17:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhA3MRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 07:17:23 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE8A564E06;
        Sat, 30 Jan 2021 12:16:42 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l5pBA-00Ayge-MI; Sat, 30 Jan 2021 12:16:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 30 Jan 2021 12:16:40 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Brazdil <dbrazdil@google.com>, kvmarm@lists.cs.columbia.edu,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH v2 4/8] KVM: arm64: Generate hyp relocation data
In-Reply-To: <20210129214325.GA195322@roeck-us.net>
References: <20210105180541.65031-1-dbrazdil@google.com>
 <20210105180541.65031-5-dbrazdil@google.com>
 <20210129214325.GA195322@roeck-us.net>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <a2c65d97fb924bd78aae3cf5659c9adc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linux@roeck-us.net, dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, mark.rutland@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, will@kernel.org, ardb@kernel.org, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thanks a lot for the heads up.

On 2021-01-29 21:43, Guenter Roeck wrote:
> Hi,
> 
> On Tue, Jan 05, 2021 at 06:05:37PM +0000, David Brazdil wrote:
>> Add a post-processing step to compilation of KVM nVHE hyp code which
>> calls a custom host tool (gen-hyprel) on the partially linked object
>> file (hyp sections' names prefixed).
>> 
>> The tool lists all R_AARCH64_ABS64 data relocations targeting hyp
>> sections and generates an assembly file that will form a new section
>> .hyp.reloc in the kernel binary. The new section contains an array of
>> 32-bit offsets to the positions targeted by these relocations.
>> 
>> Since these addresses of those positions will not be determined until
>> linking of `vmlinux`, each 32-bit entry carries a R_AARCH64_PREL32
>> relocation with addend <section_base_sym> + <r_offset>. The linker of
>> `vmlinux` will therefore fill the slot accordingly.
>> 
>> This relocation data will be used at runtime to convert the kernel VAs
>> at those positions to hyp VAs.
>> 
>> Signed-off-by: David Brazdil <dbrazdil@google.com>
> 
> This patch results in the following error for me.
> 
> error: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.tmp.o: assertion
> elf.ehdr->e_ident[5] == 1 failed (lhs=2, rhs=1, line=250)
> 
> The problem is seen when trying to build aarch64 images in big endian
> mode.

Ah, big-endian. of course, the ELF header is in native endianness,
and the sanity checks explode (still much better than generating crap).

I'll have a look shortly. It shouldn't too hard to fix, just a
bit invasive...

Thanks again,

         M.
-- 
Jazz is not dead. It just smells funny...
