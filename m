Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815BD321E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 18:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhBVRkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 12:40:08 -0500
Received: from marcansoft.com ([212.63.210.85]:59694 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhBVRj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 12:39:58 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 453DA41982;
        Mon, 22 Feb 2021 17:39:13 +0000 (UTC)
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <20210219113904.41736-8-mark.rutland@arm.com>
 <20210219172530.45805-1-marcan@marcan.st>
 <20210219182641.GB84857@C02TD0UTHF1T.local>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 7/8 v1.5] arm64: Always keep DAIF.[IF] in sync
Message-ID: <8c955dd3-8f40-3837-da33-7e117b357a35@marcan.st>
Date:   Tue, 23 Feb 2021 02:39:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210219182641.GB84857@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2021 03.26, Mark Rutland wrote:
> On Sat, Feb 20, 2021 at 02:25:30AM +0900, Hector Martin wrote:
>> Apple SoCs (A11 and newer) have some interrupt sources hardwired to the
>> FIQ line. We implement support for this by simply treating IRQs and FIQs
>> the same way in the interrupt vectors.
>>
>> To support these systems, the FIQ mask bit needs to be kept in sync with
>> the IRQ mask bit, so both kinds of exceptions are masked together. No
>> other platforms should be delivering FIQ exceptions right now, and we
>> already unmask FIQ in normal process context, so this should not have an
>> effect on other systems - if spurious FIQs were arriving, they would
>> already panic the kernel.
> 
> This looks good to me; I've picked this up and pushed out my arm64/fiq
> branch [1,2] incorporating this, tagged as arm64-fiq-20210219.
> 
> I'll give this version a few days to gather comments before I post a v2.
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/fiq
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/fiqA

Thanks! Any chance you can do a rebase on top of torvalds/master? Since 
Marc's nVHE changes went in, we're going to need to add a workaround 
patch for the M1's lack of nVHE mode, which is going to be in the next 
version of my M1 bringup series - but right now that would involve 
telling people to merge two trees to build a base to apply it on, which 
is sub-optimal.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
