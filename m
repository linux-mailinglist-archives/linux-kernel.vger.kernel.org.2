Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C954B3DF1CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhHCPsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237000AbhHCPst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:48:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E72BE60EFD;
        Tue,  3 Aug 2021 15:48:33 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-kernel@vger.kernel.org, yee.lee@mediatek.com
Cc:     Will Deacon <will@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kuan-Ying.lee@mediatek.com, James Morse <james.morse@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        chinwen.chang@mediatek.com, Vlastimil Babka <vbabka@suse.cz>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Fuad Tabba <tabba@google.com>, Marc Zyngier <maz@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        nicholas.Tang@mediatek.com
Subject: Re: [PATCH v4 1/1] arm64/cpufeature: Optionally disable MTE via command-line
Date:   Tue,  3 Aug 2021 16:48:27 +0100
Message-Id: <162800569298.22283.5858826672578810642.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803070824.7586-2-yee.lee@mediatek.com>
References: <20210803070824.7586-1-yee.lee@mediatek.com> <20210803070824.7586-2-yee.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 15:08:22 +0800, yee.lee@mediatek.com wrote:
> MTE support needs to be optionally disabled in runtime
> for HW issue workaround, FW development and some
> evaluation works on system resource and performance.
> 
> This patch makes two changes:
> (1) moves init of tag-allocation bits(ATA/ATA0) to
> cpu_enable_mte() as not cached in TLB.
> 
> [...]

Applied to arm64 (for-next/mte), thanks!

[1/1] arm64/cpufeature: Optionally disable MTE via command-line
      https://git.kernel.org/arm64/c/7a062ce31807

-- 
Catalin

