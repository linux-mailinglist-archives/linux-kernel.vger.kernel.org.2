Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12F330B933
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhBBIFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:05:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:59868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhBBIFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:05:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 925E164EEE
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612253091;
        bh=HA1oDXGCJxu9Glv25heLCkXDw2HKLAWYDLwD3J37ABw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HUXG68XseUPvE+ml32U2sD1sEQR2GPeDFbFFBv263YJeeEFdtnzKicowpoUTYRbaI
         NLqrNh+YOw74vXeqBGfJvHJq7BPrmQeh6C3Qnct75aferyDOSf1r7mtvB+emXI4hJr
         oRYyELEYQyjMaFRNdVWhJfTvCtK9lXUj/quieO4PlKv5jgvVmGu3oUY+ylqA2PQJwY
         e0rLZV82LPiSrFH3uFVxKRIgMWSySbE+eVIAqHKY4V4n/wqrOUMHOX1g6o2bT5lXt5
         E0K9s1fCOqMfPLOfa9ZwLat0/VBXybD0Of7bJdlrNBOTHqL1fNl/qMCd9gd3v+hH7F
         E+ZeILS0tzM/A==
Received: by mail-ot1-f47.google.com with SMTP id n42so19003996ota.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:04:51 -0800 (PST)
X-Gm-Message-State: AOAM531TvCq0QZGj7sOVAHUxq7B2N7epidW8lXKCvxPjyUcpHxjaClM1
        ICUen/RXiGPkJ41E2LNx0Z0hden4HVn1uMWlr0Q=
X-Google-Smtp-Source: ABdhPJw39Q3RUD6safr+5ByEW89VpY/DyeiocJ8/R3PNwoQ5ppmdGcWAIyjioRK1qG42ibb3Uk5BktCYXZ73KHjVQoA=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr14502963otq.305.1612253090768;
 Tue, 02 Feb 2021 00:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20210202022441.1451389-1-nathan@kernel.org>
In-Reply-To: <20210202022441.1451389-1-nathan@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 2 Feb 2021 09:04:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2864oSVkhaYynoadyYMcYDh0LvDDFSJ2D8OTHSszuSQA@mail.gmail.com>
Message-ID: <CAK8P3a2864oSVkhaYynoadyYMcYDh0LvDDFSJ2D8OTHSszuSQA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Make CPU_BIG_ENDIAN depend on !LD_IS_LLD
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 3:25 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Similar to commit 28187dc8ebd9 ("ARM: 9025/1: Kconfig: CPU_BIG_ENDIAN
> depends on !LD_IS_LLD"), ld.lld does not support aarch64 big endian,
> leading to the following build error when CONFIG_CPU_BIG_ENDIAN is
> selected:
>
> ld.lld: error: unknown emulation: aarch64linuxb

While this is the original error message I reported, I think it would be
better to explain that lld actually does support linking big-endian
kernels but they don't boot, for unknown reasons.

I can send a patch to address the build error and mark big-endian
as "depends on !LD_IS_LLD || COMPILE_TEST" to reflect that
and help with randconfig testing.

        Arnd
