Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E9D4335D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhJSMXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235671AbhJSMXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:23:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F9B660F25;
        Tue, 19 Oct 2021 12:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634646056;
        bh=H3khuVYDiaupUZyOWzK/AXtJDMJOmnC4bzkYQyyRWRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/tsJgESF6CbrvmsCIQqF2C48YQD0/aFTlohjyEmzSvkm+0bh0dusLC2DoNEmvrwF
         E4QnvjN0fxFE+wgO5dMQaHM7xcbGGEikG9hAO/QYuNd40YsyaMlF7uzik4ShV8811Z
         C3EsuSYHRBfHHYJS+Kx43PFjuGhgnBXyN0bgPvwTjXDzxXJHF+UDix6BXOoxCQgThb
         LQAJRY9jDUqsEH14qtGwa1Z4oA3JhnS4c17lqgc5vowjAMixmkzSE74JPUJPxtbt7G
         KwlRSAVgbwT0wVvtuQXhIJME8Gm0PxzNlSnCtmhn/jGwLdaFmNrAhzrseJR+ttMyPb
         S4jxROl+7Uosw==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v4 00/17] clocksource/arm_arch_timer: Add basic ARMv8.6 support
Date:   Tue, 19 Oct 2021 13:20:50 +0100
Message-Id: <163463738200.1805973.16833903783921788275.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211017124225.3018098-1-maz@kernel.org>
References: <20211017124225.3018098-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2021 13:42:08 +0100, Marc Zyngier wrote:
> This is v4 (final?) of the series enabling ARMv8.6 support for timer
> subsystem, and was prompted by a discussion with Oliver around the
> fact that an ARMv8.6 implementation must have a 1GHz counter, which
> leads to a number of things to break in the timer code:
> 
> - the counter rollover can come pretty quickly as we only advertise a
>   56bit counter,
> - the maximum timer delta can be remarkably small, as we use the
>   countdown interface which is limited to 32bit...
> 
> [...]

Applied 14-17 to arm64 (for-next/8.6-timers), thanks!

[14/17] arm64: Add a capability for FEAT_ECV
        https://git.kernel.org/arm64/c/fdf865988b5a
[15/17] arm64: Add CNT{P,V}CTSS_EL0 alternatives to cnt{p,v}ct_el0
        https://git.kernel.org/arm64/c/9ee840a96042
[16/17] arm64: Add handling of CNTVCTSS traps
        https://git.kernel.org/arm64/c/ae976f063b60
[17/17] arm64: Add HWCAP for self-synchronising virtual counter
        https://git.kernel.org/arm64/c/fee29f008aa3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
