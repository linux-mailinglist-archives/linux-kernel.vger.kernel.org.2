Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E7A314E82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhBIL6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:58:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:51646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhBIL4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:56:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB61664E3B;
        Tue,  9 Feb 2021 11:55:35 +0000 (UTC)
Date:   Tue, 9 Feb 2021 11:55:33 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v12 6/7] arm64: mte: Save/Restore TFSR_EL1 during suspend
Message-ID: <20210209115533.GE1435@arm.com>
References: <20210208165617.9977-1-vincenzo.frascino@arm.com>
 <20210208165617.9977-7-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208165617.9977-7-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 04:56:16PM +0000, Vincenzo Frascino wrote:
> When MTE async mode is enabled TFSR_EL1 contains the accumulative
> asynchronous tag check faults for EL1 and EL0.
> 
> During the suspend/resume operations the firmware might perform some
> operations that could change the state of the register resulting in
> a spurious tag check fault report.
> 
> Save/restore the state of the TFSR_EL1 register during the
> suspend/resume operations to prevent this to happen.

Do we need a similar fix for TFSRE0_EL1? We get away with this if
suspend is only entered on the idle (kernel) thread but I recall we
could also enter suspend on behalf of a user process (I may be wrong
though).

If that's the case, it would make more sense to store the TFSR* regs in
the thread_struct alongside sctlr_tcf0. If we did that, we'd not need
the per-cpu mte_suspend_tfsr_el1 variable.

-- 
Catalin
