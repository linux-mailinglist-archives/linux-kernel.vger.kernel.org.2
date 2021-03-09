Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F88C332153
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCIItw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:49:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhCIItt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:49:49 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEF4A64F69;
        Tue,  9 Mar 2021 08:49:48 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lJY3m-000V3c-Js; Tue, 09 Mar 2021 08:49:46 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>,
        James Morse <james.morse@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] KVM: arm64: Don't use cbz/adr with external symbols
Date:   Tue,  9 Mar 2021 08:49:42 +0000
Message-Id: <161527976376.3767092.1284147699058848340.b4-ty@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305202124.3768527-1-samitolvanen@google.com>
References: <20210305202124.3768527-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: samitolvanen@google.com, james.morse@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, will@kernel.org, keescook@chromium.org, nathan@kernel.org, ndesaulniers@google.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 12:21:24 -0800, Sami Tolvanen wrote:
> allmodconfig + CONFIG_LTO_CLANG_THIN=y fails to build due to following
> linker errors:
> 
>   ld.lld: error: irqbypass.c:(function __guest_enter: .text+0x21CC):
>   relocation R_AARCH64_CONDBR19 out of range: 2031220 is not in
>   [-1048576, 1048575]; references hyp_panic
>   >>> defined in vmlinux.o
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: Don't use cbz/adr with external symbols
      commit: dbaee836d60a8e1b03e7d53a37893235662ba124

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


