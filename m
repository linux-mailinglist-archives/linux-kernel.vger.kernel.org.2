Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C5434D00D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhC2M3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230214AbhC2M3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:29:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 904A061554;
        Mon, 29 Mar 2021 12:28:58 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     wangkefeng.wang@huawei.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chen Lifu <chenlifu@huawei.com>, dbrazdil@google.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, maz@kernel.org
Cc:     johnny.chenyi@huawei.com, weiyongjun1@huawei.com,
        heying24@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH v2 -next] arm64: smp: Add missing prototype for some smp.c functions
Date:   Mon, 29 Mar 2021 13:28:56 +0100
Message-Id: <161702092523.22277.7957866135843338237.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210329034343.183974-1-chenlifu@huawei.com>
References: <20210328172147.GA19252@arm.com> <20210329034343.183974-1-chenlifu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 11:43:43 +0800, Chen Lifu wrote:
> In commit eb631bb5bf5b
> ("arm64: Support arch_irq_work_raise() via self IPIs") a new
> function "arch_irq_work_raise" was added without a prototype.
> 
> In commit d914d4d49745
> ("arm64: Implement panic_smp_self_stop()") a new
> function "panic_smp_self_stop" was added without a prototype.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: smp: Add missing prototype for some smp.c functions
      https://git.kernel.org/arm64/c/a52ef778ff28

-- 
Catalin

