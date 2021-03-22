Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD8E34458D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhCVNXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232973AbhCVNUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:20:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1AFF61974;
        Mon, 22 Mar 2021 13:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616419211;
        bh=ZL0Ib9tIyr9gwbUMkek1V9uldkKpGqeOMoXCzaApFpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLV9HsPSXeFeRsXvisTCy6Ixq18nx3I3vXI+PxhXbxgPx87xA8NnoAsRpx82SQ28Q
         fJ3AH0CrbjgtXwLe9JofWRvFLbslk2CSVkoLPaI0RAlvfO63473WiUZL9oMsADWJDS
         CnMvMcq6mOQjI7pMnipEj8zbJKr96yTxg8IJ39YNSsOFhdAWTgvLfBPCJqVvUajr3E
         L9XohRW+HIFExCgve1qNl1ff4rFxezCoDs+LFeg9UMyqzZZ01fYdYxkbJCIM5JRrSq
         jDC6RG6JFishytHiBW1deDRvBZVKbFKAXSJzzYIRTmgnlY/aF+j3me/Twyg3sBskWu
         46TglIr7Fwt9Q==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Marco Elver <elver@google.com>,
        Chen Jun <chenjun102@huawei.com>
Subject: Re: [PATCH] arm64: stacktrace: don't trace arch_stack_walk()
Date:   Mon, 22 Mar 2021 13:19:56 +0000
Message-Id: <161641697038.3900410.16800195752008718733.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210319184106.5688-1-mark.rutland@arm.com>
References: <20210319184106.5688-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 18:41:06 +0000, Mark Rutland wrote:
> We recently converted arm64 to use arch_stack_walk() in commit:
> 
>   5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
> 
> The core stacktrace code expects that (when tracing the current task)
> arch_stack_walk() starts a trace at its caller, and does not include
> itself in the trace. However, arm64's arch_stack_walk() includes itself,
> and so traces include one more entry than callers expect. The core
> stacktrace code which calls arch_stack_walk() tries to skip a number of
> entries to prevent itself appearing in a trace, and the additional entry
> prevents skipping one of the core stacktrace functions, leaving this in
> the trace unexpectedly.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: stacktrace: don't trace arch_stack_walk()
      https://git.kernel.org/arm64/c/c607ab4f916d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
