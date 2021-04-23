Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B437369804
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 19:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243157AbhDWRMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 13:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWRMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:12:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99F33608FE;
        Fri, 23 Apr 2021 17:11:28 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        vincenzo.frascino@arm.com, Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: vdso32: drop -no-integrated-as flag
Date:   Fri, 23 Apr 2021 18:11:24 +0100
Message-Id: <161919777113.6013.4451539814173734627.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210420174427.230228-1-ndesaulniers@google.com>
References: <20210420174427.230228-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 10:44:25 -0700, Nick Desaulniers wrote:
> Clang can assemble these files just fine; this is a relic from the top
> level Makefile conditionally adding this. We no longer need --prefix,
> --gcc-toolchain, or -Qunused-arguments flags either with this change, so
> remove those too.
> 
> To test building:
> $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
>   CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 LLVM_IAS=1 \
>   defconfig arch/arm64/kernel/vdso32/

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: vdso32: drop -no-integrated-as flag
      https://git.kernel.org/arm64/c/ef94340583ee

-- 
Catalin

