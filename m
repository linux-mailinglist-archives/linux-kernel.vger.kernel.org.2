Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B57A435E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhJUKIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231741AbhJUKIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:08:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6177D6120F;
        Thu, 21 Oct 2021 10:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634810763;
        bh=9dHLzT9dyxG4Ac+xbm9Odo3IEuQuon0iJA/vxZgXkZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WseqPkhOFNQaRUL9OYeXCTR7gDKf3hn3zVV4+swzga3ateyI3dnCDHHSHcZ3OEvtL
         WThU4gS7QoQTXDei5utmJbRxr8YkBSsXfDLx868zt20Q/1pWK4BPSuresYqdL56ci9
         0CCDSP6bCRgDCcQRlB6tslBPbzHqjsz3B6VXJSU7MvxUnceF/QMYTuZA0ugJ8vhHza
         YLGmZsRo9v25p//RE/gvyTXrvwJpFrMU2pNahkRfizoh7r4RDdA4LQAom8xd6dpNxn
         S1VAHXyJO1WYDWbsH0vVZPnl/ZnMPTCg53XKmcJNCPjYJJyQwVmn3SvUF8Ypx4zrVL
         G4y1df/zKyS3g==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] compat vdso cleanups
Date:   Thu, 21 Oct 2021 11:05:49 +0100
Message-Id: <163480870098.3876753.5822557497525627978.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019223646.1146945-1-ndesaulniers@google.com>
References: <20211019223646.1146945-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 15:36:42 -0700, Nick Desaulniers wrote:
> Four fixes for compat vdso, the first three are related, the fourth is
> standalone.
> 
> The first three fix a warning observed for `mrproper` targets when
> $(CROSS_COMPILE_COMPAT)gcc is not in the $PATH.
> 
> The fourth makes is so that CROSS_COMPILE_COMPAT is not necessary to
> select COMPAT_VDSO when using clang+lld.
> 
> [...]

Applied to arm64 (for-next/vdso), thanks!

[1/4] arm64: vdso32: drop the test for dmb ishld
      https://git.kernel.org/arm64/c/1907d3ff5a64
[2/4] arm64: vdso32: drop test for -march=armv8-a
      https://git.kernel.org/arm64/c/a517faa902b5
[3/4] arm64: vdso32: suppress error message for 'make mrproper'
      https://git.kernel.org/arm64/c/14831fad73f5
[4/4] arm64: vdso32: require CROSS_COMPILE_COMPAT for gcc+bfd
      https://git.kernel.org/arm64/c/3e6f8d1fa184

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
