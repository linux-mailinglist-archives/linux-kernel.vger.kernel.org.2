Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E2C310AE0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhBEMHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:07:00 -0500
Received: from marcansoft.com ([212.63.210.85]:50440 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232135AbhBEMCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:02:36 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7297B42056;
        Fri,  5 Feb 2021 12:01:48 +0000 (UTC)
Subject: Re: [PATCH v6 05/21] arm64: Initialise as nVHE before switching to
 VHE
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jing Zhang <jingzhangos@google.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Ajay Patil <pajay@qti.qualcomm.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20210201115637.3123740-1-maz@kernel.org>
 <20210201115637.3123740-6-maz@kernel.org>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Message-ID: <1dbffcd4-5b20-404c-94af-c985a96785e2@marcan.st>
Date:   Fri, 5 Feb 2021 21:01:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210201115637.3123740-6-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2021 20.56, Marc Zyngier wrote:
> As we are aiming to be able to control whether we enable VHE or
> not, let's always drop down to EL1 first, and only then upgrade
> to VHE if at all possible.
> 
> This means that if the kernel is booted at EL2, we always start
> with a nVHE init, drop to EL1 to initialise the the kernel, and
> only then upgrade the kernel EL to EL2 if possible (the process
> is obviously shortened for secondary CPUs).

Unfortunately, this is going to break on Apple SoCs, where it turns out 
HCR_EL2.E2H is hard-wired to 1 - there is no nVHE mode. :(

 >>> mrs(HCR_EL2) & (1<<34)
0x400000000
 >>> msr(HCR_EL2, mrs(HCR_EL2) & ~(1<<34))
 >>> mrs(HCR_EL2) & (1<<34)
0x400000000

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
