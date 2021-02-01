Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B0B30A73F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhBAMIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:08:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231219AbhBAMHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:07:20 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2174D64E2A;
        Mon,  1 Feb 2021 12:06:39 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l6XyX-00BGJG-1M; Mon, 01 Feb 2021 12:06:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Feb 2021 12:06:36 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, kvmarm@lists.cs.columbia.edu,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH v2 4/8] KVM: arm64: Generate hyp relocation data
In-Reply-To: <20210201104251.5foc64qq3ewgnhuz@google.com>
References: <20210105180541.65031-1-dbrazdil@google.com>
 <20210105180541.65031-5-dbrazdil@google.com>
 <20210129214325.GA195322@roeck-us.net> <87r1m2lets.wl-maz@kernel.org>
 <20210201104251.5foc64qq3ewgnhuz@google.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <12ccab367048c0df8c6bf1bf7e7d0c4f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, linux@roeck-us.net, kvmarm@lists.cs.columbia.edu, mark.rutland@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, will@kernel.org, ardb@kernel.org, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2021-02-01 10:42, David Brazdil wrote:
> Thanks for writing the fix, Marc! There are no corner cases in this 
> code so
> if it boots, that should be a good indicator that all BE inputs were 
> converted.
> 
> Just one little thing I noticed below, otherwise:
> Acked-by: David Brazdil <dbrazdil@google.com>
> 
>>  arch/arm64/kvm/hyp/nvhe/Makefile     |  1 +
>>  arch/arm64/kvm/hyp/nvhe/gen-hyprel.c | 57 
>> ++++++++++++++++++++--------
>>  2 files changed, 42 insertions(+), 16 deletions(-)
>> 
>> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile 
>> b/arch/arm64/kvm/hyp/nvhe/Makefile
>> index 268be1376f74..09d04dd50eb8 100644
>> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
>> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
>> @@ -7,6 +7,7 @@ asflags-y := -D__KVM_NVHE_HYPERVISOR__
>>  ccflags-y := -D__KVM_NVHE_HYPERVISOR__
>> 
>>  hostprogs := gen-hyprel
>> +HOST_EXTRACFLAGS += -I$(srctree)/include
> This should be $(objtree), autoconf.h is generated.

Ah, well spotted. I build things in place, so it obviously never showed 
up.
Now fixed and pushed out with your Ack.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
