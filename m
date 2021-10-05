Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26331422EF6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 19:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhJERTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 13:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234938AbhJERTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:19:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C0406124C;
        Tue,  5 Oct 2021 17:17:27 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Pingfan Liu <kernelfans@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCHv4 0/3] arm64/irqentry: remove duplicate housekeeping of rcu
Date:   Tue,  5 Oct 2021 18:17:25 +0100
Message-Id: <163345423700.2001694.5653085141940230637.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001144406.7719-1-kernelfans@gmail.com>
References: <20211001144406.7719-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2021 22:44:03 +0800, Pingfan Liu wrote:
> When an IRQ is taken, some accounting needs to be performed to enter and
> exit IRQ context around the IRQ handler. Historically arch code would
> leave this to the irqchip or core IRQ code, but these days we want this
> to happen in exception entry code, and architectures such as arm64 do
> this.
> 
> Currently handle_domain_irq() performs this entry/exit accounting, and
> if used on an architecture where the entry code also does this, the
> entry/exit accounting will be performed twice per IRQ. This is
> problematic as core RCU code such as rcu_is_cpu_rrupt_from_idle()
> depends on this happening once per IRQ, and will not detect quescent
> periods correctly, leading to stall warnings.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/3] kernel/irq: make irq_{enter,exit}() in handle_domain_irq() arch optional
      https://git.kernel.org/arm64/c/db795cf55b21
[2/3] arm64: entry: refactor EL1 interrupt entry logic
      https://git.kernel.org/arm64/c/ad0d5cfb9535
[3/3] arm64: entry: avoid double-accounting IRQ RCU entry
      https://git.kernel.org/arm64/c/12074b059fdc

-- 
Catalin

