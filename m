Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF23447E24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbhKHKlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238634AbhKHKkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:40:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68B8561352;
        Mon,  8 Nov 2021 10:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636367882;
        bh=f8IcxxwmybYdOmf89gmB2EsKekBVDlzdBwxzr82JZ4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+bKJ2ebn3vcuWa2o9AhZJ17AhHYfVlfNIoG/GNJvnloUOoWcOJ+jKTD8rTo16Bdv
         PTs8uCx+8NbaqA/722RIqrJ682quHzonZOs+9+7oDnobrGQHdykywYQqNOWe0n2VeW
         ItlmJ3ygXqimGPJEP4tYs+QSJGTy6U8Lt3kP36UyFDW6/w/S8k8O/M8OAf0Zm0YGpw
         ZcGLyt7+UlzDG13yGn79AwWB2SfiwJi4sUXOWyOlCgX8b2PQSs2OnlgsvhbYbnYgtl
         d1WZXGelmiruICuE14EdNdRRcMu4+coheKvHP/VqJIWHbNdEx8704G+iZTWgn6k3Ba
         WUq6krP5dxi8A==
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] arm64: vdso: remove -nostdlib compiler flag
Date:   Mon,  8 Nov 2021 10:37:50 +0000
Message-Id: <163636577786.14627.11162131514345192373.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211107161802.323125-1-masahiroy@kernel.org>
References: <20211107161802.323125-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2021 01:18:02 +0900, Masahiro Yamada wrote:
> The -nostdlib option requests the compiler to not use the standard
> system startup files or libraries when linking. It is effective only
> when $(CC) is used as a linker driver.
> 
> Since commit 691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC)
> to link VDSO"), $(LD) is directly used, hence -nostdlib is unneeded.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: vdso: remove -nostdlib compiler flag
      https://git.kernel.org/arm64/c/34688c76911e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
