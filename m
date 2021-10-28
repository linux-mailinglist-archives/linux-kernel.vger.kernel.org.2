Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F6B43DDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 11:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhJ1JXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 05:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhJ1JXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 05:23:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A85861106;
        Thu, 28 Oct 2021 09:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635412853;
        bh=Fn8bsQjWvC/Gs3ZL/gJFubl+W3359yuP4t4KAm0iG4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DR+e1gYeoMgq5eryI2eXEuYixpeQ2WTIQOYr41u/LHISd3lgtarBkUZIqOC7sY/bG
         S1yJGIUSROwiwzdr2RqRCWllxmz1/65Vx6j9vMJDOmH2ZBRcPGO2N84gyug7xFWAAr
         PBy1DurNvr8f5+umK0RP30fXSWqFX/K5KF/EaVHSFsCewFHzh9djllpKai6pIVM7bT
         VGRsoun7Q6xXQsFtJ/5tNmI2jFKnjYvGacRMSPWzAfaiS3ODDzyK245A3XWEGbXOb6
         I8A8nAYvQGVb66byS1a2h4n6OQH0vV5qoznJLkMDxNRKqhJeZtSuRO4UJ+fwccLm70
         Y8potYA8UhXGA==
From:   Will Deacon <will@kernel.org>
To:     tglx@linutronix.de, Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Select POSIX_CPU_TIMERS_TASK_WORK
Date:   Thu, 28 Oct 2021 10:20:47 +0100
Message-Id: <163540984338.3796555.9507472460040267677.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211018144713.873464-1-nsaenzju@redhat.com>
References: <20211018144713.873464-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 16:47:13 +0200, Nicolas Saenz Julienne wrote:
> With 6caa5812e2d1 ("KVM: arm64: Use generic KVM xfer to guest work
> function") all arm64 exit paths are properly equipped to handle the
> POSIX timers' task work.
> 
> Deferring timer callbacks to thread context, not only limits the amount
> of time spent in hard interrupt context, but is a safer
> implementation[1], and will allow PREEMPT_RT setups to use KVM[2].
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Select POSIX_CPU_TIMERS_TASK_WORK
      https://git.kernel.org/arm64/c/a68773bd32d9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
