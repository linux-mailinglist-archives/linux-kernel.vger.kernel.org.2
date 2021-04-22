Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358FF367EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhDVKgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235810AbhDVKgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:36:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4445A6145A;
        Thu, 22 Apr 2021 10:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619087769;
        bh=yV1m8sH8ngURE/dCEPKja+Gr7o61voE51grWKErDwE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nvc0O6tpmzit1Zr3TMY+F9SkbegxkadX4TsUrqWjHTTm3F9nuYD0ub+ubee/4Ktkv
         Ih8nNE0419hAa2YdjAcLKAbXV9oxtOSyd8vxTxoSSfElCfonrcJfkQ2M9LpBxLjDzD
         xNwcM1qI09aU9bO5HUKws8XWxqpdnCOxLeNLT5n7pV1PjlrAm+Lx1oPnFLAfoibOJk
         OtNt7nXVQOYS3De80Xk/9pBGSY8ZcEDPeVEHsp5AVGilvqOyGKkF/gPr6naNuUtzcm
         PE5UGQma1lYvB0VM960WGQeAa0tcrEtlY7jhcsp6t1Wz3lrQCWLinJKA+S62NT5V5c
         5d0JnplhNwdmg==
Date:   Thu, 22 Apr 2021 11:36:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com, Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3] arm64: vdso32: drop -no-integrated-as flag
Message-ID: <20210422103603.GB1442@willie-the-truck>
References: <20210420174427.230228-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420174427.230228-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 10:44:25AM -0700, Nick Desaulniers wrote:
> Clang can assemble these files just fine; this is a relic from the top
> level Makefile conditionally adding this. We no longer need --prefix,
> --gcc-toolchain, or -Qunused-arguments flags either with this change, so
> remove those too.
> 
> To test building:
> $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
>   CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make LLVM=1 LLVM_IAS=1 \
>   defconfig arch/arm64/kernel/vdso32/
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---

Acked-by: Will Deacon <will@kernel.org>

Will
