Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF21137000E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 19:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhD3R6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 13:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhD3R6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:58:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 285A961449;
        Fri, 30 Apr 2021 17:57:55 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Bill Wendling <morbo@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@google.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/vdso: Discard .note.gnu.property sections in vDSO
Date:   Fri, 30 Apr 2021 18:57:53 +0100
Message-Id: <161980533328.3085.7369684692351119549.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210423205159.830854-1-morbo@google.com>
References: <20210423205159.830854-1-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2021 13:51:59 -0700, Bill Wendling wrote:
> The arm64 assembler in binutils 2.32 and above generates a program
> property note in a note section, .note.gnu.property, to encode used x86
> ISAs and features. But the kernel linker script only contains a single
> NOTE segment:
> 
>   PHDRS
>   {
>     text    PT_LOAD    FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
>     dynamic PT_DYNAMIC FLAGS(4);               /* PF_R */
>     note    PT_NOTE    FLAGS(4);               /* PF_R */
>   }
> 
> [...]

Applied to arm64 (for-next/core). Thanks Bill and Szabolcs for
clarifying the need for this patch.

[1/1] arm64/vdso: Discard .note.gnu.property sections in vDSO
      https://git.kernel.org/arm64/c/388708028e69

-- 
Catalin

