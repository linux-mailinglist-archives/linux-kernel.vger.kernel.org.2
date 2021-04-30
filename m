Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C918936FF91
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 19:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhD3Rdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 13:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230478AbhD3Rds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:33:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67D0E61462;
        Fri, 30 Apr 2021 17:32:58 +0000 (UTC)
Date:   Fri, 30 Apr 2021 18:32:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Subject: Re: [PATCH] arm64: stacktrace: Stop unwinding when the PC is zero
Message-ID: <20210430173255.GE18574@arm.com>
References: <20210429014321.196606-1-leo.yan@linaro.org>
 <20210429104813.GA33550@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429104813.GA33550@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 11:48:13AM +0100, Mark Rutland wrote:
> From b99e647b34b74059f3013c09f12fbd542c7679fd Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Thu, 29 Apr 2021 11:20:04 +0100
> Subject: [PATCH] arm64: stacktrace: restore terminal records
> 
> We removed the terminal frame records in commit:
> 
>    6106e1112cc69a36 ("arm64: remove EL0 exception frame record")
> 
> ... on the assumption that as we no longer used them to find the pt_regs
> at exception boundaries, they were no longer necessary.
> 
> However, Leo reports that as an unintended side-effect, this causes
> traces which cross secondary_start_kernel to terminate one entry too
> late, with a spurious "0" entry.
> 
> There are a few ways we could sovle this, but as we're planning to use
> terminal records for RELIABLE_STACKTRACE, let's revert the logic change
> for now, keeping the update comments and accounting for the changes in
> commit:
> 
>   3c02600144bdb0a1 ("arm64: stacktrace: Report when we reach the end of the stack")
> 
> This is effectively a partial revert of commit:
> 
>   6106e1112cc69a36 ("arm64: remove EL0 exception frame record")
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: 6106e1112cc69a36 ("arm64: remove EL0 exception frame record")
> Reported-by: Leo Yan <leo.yan@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

Thanks Mark. I applied it to for-next/core (couldn't figure out the
combination of b4 and git am + the scissors and not replying to the top
message).

-- 
Catalin
