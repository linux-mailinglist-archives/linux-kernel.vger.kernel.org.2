Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4706B3A82BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhFOO2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231495AbhFOO1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:27:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5FA761483;
        Tue, 15 Jun 2021 14:25:41 +0000 (UTC)
Date:   Tue, 15 Jun 2021 15:25:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Fix ttbr0 values stored in struct thread_info
 for software-pan
Message-ID: <20210615142539.GJ26027@arm.com>
References: <1623749578-11231-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623749578-11231-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 03:02:58PM +0530, Anshuman Khandual wrote:
> When using CONFIG_ARM64_SW_TTBR0_PAN, a task's thread_info::ttbr0 must be
> the TTBR0_EL1 value used to run userspace. With 52-bit PAs, the PA must be
> packed into the TTBR using phys_to_ttbr(), but we forget to do this in some
> of the SW PAN code. Thus, if the value is installed into TTBR0_EL1 (as may
> happen in the uaccess routines), this could result in UNPREDICTABLE
> behaviour.
> 
> Since hardware with 52-bit PA support almost certainly has HW PAN, which
> will be used in preference, this shouldn't be a practical issue, but let's
> fix this for consistency.

I'm ok with fixing this for consistency. We should never hit those paths
unless someone built hardware with 52-bit PA (8.2) but without PAN (8.1)
and it would not be architecture compliant.

I'll leave it with Will for 5.14, it's no a fix that needs urgent
queuing.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
