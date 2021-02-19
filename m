Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777B631FDD1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 18:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBSRZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 12:25:19 -0500
Received: from marcansoft.com ([212.63.210.85]:43000 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBSRZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:25:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1A8B941EF0;
        Fri, 19 Feb 2021 17:24:33 +0000 (UTC)
Subject: Re: [PATCH 7/8 v1.5] arm64: Always keep DAIF.[IF] in sync
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <20210219172145.45264-1-marcan@marcan.st>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <d64dbb13-426a-37f7-f581-721a7b207ebb@marcan.st>
Date:   Sat, 20 Feb 2021 02:24:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210219172145.45264-1-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2021 02.21, Hector Martin wrote:
> Apple SoCs (A11 and newer) have some interrupt sources hardwired to the
> FIQ line. We implement support for this by simply treating IRQs and FIQs
> the same way in the interrupt vectors.
> 
> To support these systems, the FIQ mask bit needs to be kept in sync with
> the IRQ mask bit, so both kinds of exceptions are masked together. No
> other platforms should be delivering FIQ exceptions right now, and we
> already unmask FIQ in normal process context, so this should not have an
> effect on other systems - if spurious FIQs were arriving, they would
> already panic the kernel.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> 
Argh, sorry, I botched the trhreading. Got caught by git send-email 
prompting me on the dry-run, but not after I added a --to... Resending.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
