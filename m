Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0C6360577
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhDOJSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhDOJSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:18:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70B2E611F1;
        Thu, 15 Apr 2021 09:17:46 +0000 (UTC)
Date:   Thu, 15 Apr 2021 10:17:43 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Jian Cai <jiancai@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: alternatives: Move length validation in
 alternative_{insn,endif}
Message-ID: <20210415091743.GB1015@arm.com>
References: <20210414000803.662534-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414000803.662534-1-nathan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Tue, Apr 13, 2021 at 05:08:04PM -0700, Nathan Chancellor wrote:
> After commit 2decad92f473 ("arm64: mte: Ensure TIF_MTE_ASYNC_FAULT is
> set atomically"), LLVM's integrated assembler fails to build entry.S:
> 
> <instantiation>:5:7: error: expected assembly-time absolute expression
>  .org . - (664b-663b) + (662b-661b)
>       ^
> <instantiation>:6:7: error: expected assembly-time absolute expression
>  .org . - (662b-661b) + (664b-663b)
>       ^

I tried the latest Linus' tree and linux-next (defconfig) with this
commit in and I can't get your build error. I used both clang-10 from
Debian stable and clang-11 from Debian sid. So, which clang version did
you use or which kernel config options?

-- 
Catalin
