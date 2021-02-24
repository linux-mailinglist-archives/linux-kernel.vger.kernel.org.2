Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D381324099
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbhBXPPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:15:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233489AbhBXOct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:32:49 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 307BA64ED6;
        Wed, 24 Feb 2021 14:32:08 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lEvCv-00FhNi-Tm; Wed, 24 Feb 2021 14:32:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Feb 2021 14:32:05 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st,
        tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 0/8] arm64: Support FIQ controller registration
In-Reply-To: <20210224140656.GG50741@C02TD0UTHF1T.local>
References: <20210219113904.41736-1-mark.rutland@arm.com>
 <87a6s0orm7.wl-maz@kernel.org> <20210224140656.GG50741@C02TD0UTHF1T.local>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <f69e51e4161f48442933c0c5296b313d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, james.morse@arm.com, marcan@marcan.st, tglx@linutronix.de, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-24 14:06, Mark Rutland wrote:
> On Fri, Feb 19, 2021 at 06:10:56PM +0000, Marc Zyngier wrote:
>> Hi Mark,
>> 
>> On Fri, 19 Feb 2021 11:38:56 +0000,
>> Mark Rutland <mark.rutland@arm.com> wrote:
>> >
>> > Hector's M1 support series [1] shows that some platforms have critical
>> > interrupts wired to FIQ, and to support these platforms we need to support
>> > handling FIQ exceptions. Other contemporary platforms don't use FIQ (since e.g.
>> > this is usually routed to EL3), and as we never expect to take an FIQ, we have
>> > the FIQ vector cause a panic.
>> >
>> > Since the use of FIQ is a platform integration detail (which can differ across
>> > bare-metal and virtualized environments), we need be able to explicitly opt-in
>> > to handling FIQs while retaining the existing behaviour otherwise. This series
>> > adds a new set_handle_fiq() hook so that the FIQ controller can do so, and
>> > where no controller is registered the default handler will panic(). For
>> > consistency the set_handle_irq() code is made to do the same.
>> >
>> > The first couple of patches are from Marc's irq/drop-generic_irq_multi_handler
>> > branch [2] on kernel.org, and clean up CONFIG_GENERIC_IRQ_MULTI_HANDLER usage.
>> > The next four patches move arm64 over to a local set_handle_irq()
>> > implementation, which is written to share code with a set_handle_fiq() function
>> > in the last two patches. The only functional difference here is that if an IRQ
>> > is somehow taken prior to set_handle_irq() the default handler will directly
>> > panic() rather than the vector branching to NULL.
>> >
>> > The penultimate patch is cherry-picked from the v2 M1 series, and as per
>> > discussion there [3] will need a few additional fixups. I've included it for
>> > now as the DAIF.IF alignment is necessary for the FIQ exception handling added
>> > in the final patch.
>> >
>> > The final patch adds the low-level FIQ exception handling and registration
>> > mechanism atop the prior rework.
>> 
>> Thanks for putting this together. I have an extra patch on top of this
>> series[1] that prevents the kernel from catching fire if a FIQ fires
>> whilst running a guest. Nothing urgent, we can queue it at a later 
>> time.
>> 
>> Thanks,
>> 
>> 	M.
>> 
>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/fiq
> 
> IIUC for that "invalid_vect" should be changed to "valid_vect", to 
> match
> the other valid vector entries, but otherwise that looks sane to me.

Err, yes. I though I had fixed that, but obviously didn't.

> I guess we could take that as a prerequisite ahead of the rest?

Sure, that's mostly independent anyway. And it would make more sense
for an unexpected FIQ to crash the host at at the point where we
handle interrupts rather than in KVM with very little debug information.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
