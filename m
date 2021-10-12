Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C725542A03C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbhJLItF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235039AbhJLItE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:49:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07B1E61074;
        Tue, 12 Oct 2021 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634028423;
        bh=Hoyx77R22q5IX0XiaVREEQtYYo7Kfz7nZGxc1v7TI38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rF2ynH36OwDV/tb5Q3PVtxwtTNEu2CT6noIkV97YlgeXTNCyPJQwFImCtUzOCmDfb
         8NUKqSydkPSlHlM96xLIiIuY9XzhkYM239qZGVVo8dS4ANirx8zPLG5SCYTnsaBUOY
         1DNJrxsT7BBrgfQgpW6jJJnxOxDlmgN/xKEaQrjRLAtLhVj0mIOlSV4mbi10P6Qf9Q
         yk2NwrgptSXMYQKXfRnHsoPSsiI/BqOVnFeiZ9D0nLVsPSFffm1CC3uG4XDYLBmpQj
         Hh7OrC3Z8pa5QxXlCxHKqk1n8ys/bV6MkAp7raXYVeFltOBQvsAYpkvlCaJfP+OORu
         B5GnE4XisCWGw==
From:   Will Deacon <will@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: asm: setup.h: export common variables
Date:   Tue, 12 Oct 2021 09:46:55 +0100
Message-Id: <163402695385.2334253.12056283203009658910.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211007195601.677474-1-anders.roxell@linaro.org>
References: <20211007195601.677474-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 21:56:01 +0200, Anders Roxell wrote:
> When building the kernel with sparse enabled 'C=1' the following
> warnings can be seen:
> 
> arch/arm64/kernel/setup.c:58:13: warning: symbol '__fdt_pointer' was not declared. Should it be static?
> arch/arm64/kernel/setup.c:84:25: warning: symbol 'boot_args' was not declared. Should it be static?
> 
> Rework so the variables are exported, since these two variable are
> created and used in setup.c, also used in head.S.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: asm: setup.h: export common variables
      https://git.kernel.org/arm64/c/1dfde0892b32

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
