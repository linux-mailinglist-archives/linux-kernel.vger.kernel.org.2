Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA2E31A12C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhBLPKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:10:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhBLPKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:10:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5847764E70;
        Fri, 12 Feb 2021 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613142600;
        bh=k731R4Ul6UKTKtCgFca3L2FMVqQFKspI8tFGRTMpX9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7ffahHrls/V+BKwdGEjH0nw2dMGXFX4vD4J+4HDjEkrJfn7A+Iit3nqim0umEqGg
         lrZzaCCKvFPXGZTk93rdU0Ks5T6Wt8cFVFWuXxpGMucxQ4TupUB2X49Rocio8QqiWg
         9WZdy65piPAs6SLREtg3FyzkLMEUFfP/fl59lu6Z9PN7zwKPikEnxuGi0a4NdGk64d
         h6/RXRz9AifU3WIMz9+kUlGARFPTs8i5/ruIH6KzkCdCTdyTaeJX6/b1vv2vU+R6JX
         IWj+zZdU2sRtgIyVM3nt9whehyFDrp8ePHXLMa4tpAZALBgAOTi7FwOj9jbVA1m00l
         frBpPkiHNRKjQ==
From:   Will Deacon <will@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>, mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
Subject: Re: [PATCH] drivers/perf: Replace spin_lock_irqsave to spin_lock
Date:   Fri, 12 Feb 2021 15:09:53 +0000
Message-Id: <161298304279.2372115.11035796889461732110.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1612863742-1551-1-git-send-email-liuqi115@huawei.com>
References: <1612863742-1551-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 17:42:22 +0800, Qi Liu wrote:
> There is no need to do spin_lock_irqsave in context of hard IRQ, so
> replace them with spin_lock.

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: Replace spin_lock_irqsave to spin_lock
      https://git.kernel.org/will/c/8ee37e0f97ec

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
