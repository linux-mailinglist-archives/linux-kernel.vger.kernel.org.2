Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAE33C5C11
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 14:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhGLM11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 08:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhGLM11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 08:27:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5FA460FF3;
        Mon, 12 Jul 2021 12:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626092679;
        bh=39UDyHmtvOvV95HVEQniIReLPUgxxMG9Orayrb4XS8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M8SaYHYX0KXistxYO3gZheS3K/a4uVcqEH2wWVz2vMpyzLtMehlRP79auLe2mEFrB
         ZMwbOO7bzHqn/qf4AO+Dlp4WuZ2XicziQRZ4iMI7Gp/bNLjVyXoR6bnbbxULDhImhT
         5i4afyquJqZ6l/knqLSeWzeYssEL9mYtdBmDH+4Ke5Xdb9LkEmdf38BlpiGURyMoy9
         uywuS6JjqM4sPnU4Qq+DFfZavJt3pHR8MBc7vUtYmHzvjhjCSW/EPDdjdnrsyGGNag
         XkbsOKyJNv91V/Kq7986IYUKdRPxuzWv2KIivt5RQWSYDW0IrX1PQISNXJ6ANlB6YA
         b2PVVAfIeEIDg==
Date:   Mon, 12 Jul 2021 13:24:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: Restrict ARM64_BTI_KERNEL to clang 12.0.0 and
 newer
Message-ID: <20210712122433.GA28536@willie-the-truck>
References: <20210709000627.3183718-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709000627.3183718-1-nathan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Thu, Jul 08, 2021 at 05:06:27PM -0700, Nathan Chancellor wrote:
> Commit 97fed779f2a6 ("arm64: bti: Provide Kconfig for kernel mode BTI")
> disabled CONFIG_ARM64_BTI_KERNEL when CONFIG_GCOV_KERNEL was enabled and
> compilign with clang because of warnings that occur because LLVM was not

Typo: "compilign"

> emitting PAC/BTI instructions for compiler generated functions.
> 
> This was an adequate fix to avoid the warnings with allmodconfig until
> commit 51c2ee6d121c ("Kconfig: Introduce ARCH_WANTS_NO_INSTR and
> CC_HAS_NO_PROFILE_FN_ATTR"), which prevented CONFIG_GCOV_KERNEL from
> being selected with clang 12.0.0 and older because it does not support
> the no_profile_instrument_function attribute. As a result,
> CONFIG_ARM64_BTI_KERNEL gets enabled and there are more warnings of this
> nature.

I'm half asleep today, but I'm struggling to follow what GCOV_KERNEL has
to do with the warnings here. Prior to 51c2ee6d121c, you could still go
and turn that option off and so wouldn't the same warnings be triggered
in that configuration?

In other words, I think there are two aspects to this patch:

	1. Removing the (now useless) !GCOV_KERNEL dependency
	2. Requiring Clang >= version 12

but the commit message doesn't really say where these warnings are coming
from or why Clang 12 gets rid of them.

Thanks,

Will
