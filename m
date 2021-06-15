Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3143A896B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 21:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFOTUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 15:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhFOTUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:20:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E52816128B;
        Tue, 15 Jun 2021 19:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623784708;
        bh=ca9Sc+rxoyLPOWWFAh7QNdfr30TMin90DzEKvgvpyyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAkgoE0NeMQBMOXfzIVbJ82cj+fdzsct9R/KTRi+Z278nCFQGeVetd5J3K2/re0e8
         X0kGe9sClg9K5eJjEX7sl+jbZmYs7AJ/KqxZlFi3TTQo856mIROGLZykDSOhTJdIpD
         zjtiiaPdbzQd/R0kua8PabWlqIT76dVi6CKqP6KXGYl0W6DGqijng2NHoleNe4covK
         t7+/0fE/oMpGvZUCj4n78pfOOw1Gwzg76yNNCOXsFu6ie5VsodHrCdN02v0Q42C5wL
         j6zzmmCBzqhfiS8eUF7in4EynUsZG7LUKuRW41l+wyZ+1yrDOlZUcikw5GVXsmoOT+
         rxGH406f8pnTw==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
Subject: Re: [PATCH] arm64/mm: Fix ttbr0 values stored in struct thread_info for software-pan
Date:   Tue, 15 Jun 2021 20:18:21 +0100
Message-Id: <162378020482.22871.14339302272957309916.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623749578-11231-1-git-send-email-anshuman.khandual@arm.com>
References: <1623749578-11231-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 15:02:58 +0530, Anshuman Khandual wrote:
> When using CONFIG_ARM64_SW_TTBR0_PAN, a task's thread_info::ttbr0 must be
> the TTBR0_EL1 value used to run userspace. With 52-bit PAs, the PA must be
> packed into the TTBR using phys_to_ttbr(), but we forget to do this in some
> of the SW PAN code. Thus, if the value is installed into TTBR0_EL1 (as may
> happen in the uaccess routines), this could result in UNPREDICTABLE
> behaviour.
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Fix ttbr0 values stored in struct thread_info for software-pan
      https://git.kernel.org/arm64/c/9163f0113030

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
