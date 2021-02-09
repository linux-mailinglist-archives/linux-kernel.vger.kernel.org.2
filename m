Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108283151CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhBIOha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232138AbhBIOge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:36:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AC9664E4F;
        Tue,  9 Feb 2021 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612881354;
        bh=q15tb5Wse3+G/2RjaIWhqAW8TuE4mKJ7jPy9N1Jo2c8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXPdjrRdxWjfqoMzCaJEoNTF90EnkX+imFMJ0BS6NKV/ZwcWUJMaC9BeymSgZc384
         QxWOReNr4BjGweHdZeeAL/4bJI7SkmDmSORGwIY/7Tx4VXDv69fHGvwbc4n1pIZnaM
         4sAGe3BB27XQKEI3RqlV1vpxUPI0YEnsa2en4Sj1yWa0nBqvypfNn3HBoQcX1BrPMA
         MpxDeSq1/GZrT+cRoOyEPA2ydyVXIhUWpRwad/cAwI4MyIm94zXlJBnaJZVywcFJ/h
         vI7c30VxVvWi+VYxqUXlO8YcCX8hH7PjVLh9ex8qn78OcDj7en/Xzh+IkFs6AAMM0t
         ESNkM70d2t6Hw==
From:   Will Deacon <will@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Make CPU_BIG_ENDIAN depend on ld.bfd or ld.lld 13.0.0+
Date:   Tue,  9 Feb 2021 14:35:46 +0000
Message-Id: <161288087156.126822.7923858337003340850.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210209005719.803608-1-nathan@kernel.org>
References: <20210202022441.1451389-1-nathan@kernel.org> <20210209005719.803608-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 17:57:20 -0700, Nathan Chancellor wrote:
> Similar to commit 28187dc8ebd9 ("ARM: 9025/1: Kconfig: CPU_BIG_ENDIAN
> depends on !LD_IS_LLD"), ld.lld prior to 13.0.0 does not properly
> support aarch64 big endian, leading to the following build error when
> CONFIG_CPU_BIG_ENDIAN is selected:
> 
> ld.lld: error: unknown emulation: aarch64linuxb
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Make CPU_BIG_ENDIAN depend on ld.bfd or ld.lld 13.0.0+
      https://git.kernel.org/arm64/c/e9c6deee00e9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
