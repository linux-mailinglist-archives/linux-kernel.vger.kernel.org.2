Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CEE3ACF5C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhFRPpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhFRPpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:45:08 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B71CF61222;
        Fri, 18 Jun 2021 15:42:58 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1luGe0-008TnC-Er; Fri, 18 Jun 2021 16:42:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Jun 2021 16:42:56 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Steven Price <steven.price@arm.com>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v16 1/7] arm64: mte: Handle race when synchronising tags
In-Reply-To: <20210618144013.GE16116@arm.com>
References: <20210618132826.54670-1-steven.price@arm.com>
 <20210618132826.54670-2-steven.price@arm.com>
 <20210618144013.GE16116@arm.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <3551d8ea9c9464e982d75acdd5f855b4@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, steven.price@arm.com, will@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dave.Martin@arm.com, mark.rutland@arm.com, tglx@linutronix.de, qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org, drjones@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-18 15:40, Catalin Marinas wrote:
> On Fri, Jun 18, 2021 at 02:28:20PM +0100, Steven Price wrote:
>> mte_sync_tags() used test_and_set_bit() to set the PG_mte_tagged flag
>> before restoring/zeroing the MTE tags. However if another thread were 
>> to
>> race and attempt to sync the tags on the same page before the first
>> thread had completed restoring/zeroing then it would see the flag is
>> already set and continue without waiting. This would potentially 
>> expose
>> the previous contents of the tags to user space, and cause any updates
>> that user space makes before the restoring/zeroing has completed to
>> potentially be lost.
>> 
>> Since this code is run from atomic contexts we can't just lock the 
>> page
>> during the process. Instead implement a new (global) spinlock to 
>> protect
>> the mte_sync_page_tags() function.
>> 
>> Fixes: 34bfeea4a9e9 ("arm64: mte: Clear the tags when a page is mapped 
>> in user-space with PROT_MTE")
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> Although I reviewed this patch, I think we should drop it from this
> series and restart the discussion with the Chromium guys on what/if 
> they
> need PROT_MTE with MAP_SHARED. It currently breaks if you have two
> PROT_MTE mappings but if they are ok with only one of the mappings 
> being
> PROT_MTE, I'm happy to just document it.
> 
> Not sure whether subsequent patches depend on it though.

I'd certainly like it to be independent of the KVM series, specially
as this series is pretty explicit that this MTE lock is not required
for KVM.

This will require some rework of patch #2, I believe. And while we're
at it, a rebase on 5.13-rc4 wouldn't hurt, as both patches #3 and #5
conflict with it...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
