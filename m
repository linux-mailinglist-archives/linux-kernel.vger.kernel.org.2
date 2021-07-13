Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD803C763A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 20:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhGMSLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 14:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhGMSLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 14:11:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26DB361370;
        Tue, 13 Jul 2021 18:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626199743;
        bh=46YcJlTPBE+sL8Lgj1YV5aLfzsrVPPnMADD+cqOOecw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFCii6I1OZidIYlYzJdhPSeCEeQ9BzEd6fzP0a+dNoAR64RxxUE0DmzPENw2ApSXf
         A7klDLWqb7EcKkLBQyk1xMkdUlceugxc313NDjhjJVGzVaVl+XsFVwDyR2reF9cpnr
         yIIjWm8Q4O/24MX7U3CCnfD6dmoCnejETM0jUxfrOTp4isEi/HDfC0SWffFe/FlXvQ
         dMxfz8NlBvU1+WW4Lht4HxkbZKzm01M6LGbfSxpDObLvtL9btPrPGnnNJwHlJcqLXS
         DEr7lB/CIs500mACx+mY0hw9k4ORTBtqEhJDqXaR15PN0uohR1NlQBj9666qABV/Wk
         aBj11/A/djSSA==
From:   Will Deacon <will@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Restrict ARM64_BTI_KERNEL to clang 12.0.0 and newer
Date:   Tue, 13 Jul 2021 19:08:56 +0100
Message-Id: <162619029187.3095121.267075671742631551.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210712214636.3134425-1-nathan@kernel.org>
References: <20210709000627.3183718-1-nathan@kernel.org> <20210712214636.3134425-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2021 14:46:37 -0700, Nathan Chancellor wrote:
> Commit 97fed779f2a6 ("arm64: bti: Provide Kconfig for kernel mode BTI")
> disabled CONFIG_ARM64_BTI_KERNEL when CONFIG_GCOV_KERNEL was enabled and
> compiling with clang because of warnings that were seen with
> allmodconfig because LLVM was not emitting PAC/BTI instructions for
> compiler generated functions:
> 
> warning: some functions compiled with BTI and some compiled without BTI
> warning: not setting BTI in feature flags
> 
> [...]

Thanks Nathan for turning this around so quickly. The new commit message
is much better.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Restrict ARM64_BTI_KERNEL to clang 12.0.0 and newer
      https://git.kernel.org/arm64/c/8cdd23c23c3d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
