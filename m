Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BC23ABF0C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhFQWlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232716AbhFQWkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:40:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3328613F0;
        Thu, 17 Jun 2021 22:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623969527;
        bh=vsL7NMNbpUi0a0GtGlHv6l88o9ybIXECaQOQai63XvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iuWiiTWUYp95/L4KxWLLzIh9hYgcMAC+eHFr1LtnLfL1bTVgN4PKpLnbRo1qr3t5C
         gRWMjcqJ5BnICIKR/d7mSzdn9CWpXtr4yDqe4fSOEgOP0wkDRUZyYNJeG7WcgExHZJ
         LTDg9NbBthg6PegLX3foYdQ4WA8+pSv7xyBljQZoEbY3pe31QVeTBYo9rhuKybkX3U
         y466X79gR3I+Vr2UYRZQJlU0T9KaNOLJxYmSvvLAeBkpei9AcshfvZFtk4rxOoOXYK
         /gR4mMQW0JBDxExGBw0AIBZWYNSbLHnx4ioPfn4u/46YTni6O2JuZAeGJ+U5AfkFJG
         Dj9IntYjqNW3Q==
From:   Will Deacon <will@kernel.org>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] perf/arm-cmn: Fix invalid pointer when access dtc object sharing the same IRQ number
Date:   Thu, 17 Jun 2021 23:38:36 +0100
Message-Id: <162395550334.941145.17283094312971235409.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623946129-3290-1-git-send-email-tuanphan@os.amperecomputing.com>
References: <1623946129-3290-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 09:08:49 -0700, Tuan Phan wrote:
> When multiple dtcs share the same IRQ number, the irq_friend which
> used to refer to dtc object gets calculated incorrect which leads
> to invalid pointer.
> 
> Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Fix invalid pointer when access dtc object sharing the same IRQ number
      https://git.kernel.org/will/c/4e16f283edc2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
