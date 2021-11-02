Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715F0443208
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 16:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhKBPy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 11:54:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57796 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhKBPyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 11:54:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8D178212C3;
        Tue,  2 Nov 2021 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635868303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Jn3BaAn3lExYJcPf9xUO6RYJ/5roELy886njRhgwJY=;
        b=wB/1cmf5b6RnbrrA20EJZzimJvULePq1Q91n5m9al5Y+o5W4DDQbL8KMqNyXnCMDaYU96Q
        /+bUednnEYrxG1wgF4oLwOcQzWohrJAUwmenR3R9lK1YOmhDdcj8FuvxpV6Bo2+/mkBZjO
        TNcHox+RD6VMaQx3xdVqpQ7S8PO2iBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635868303;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Jn3BaAn3lExYJcPf9xUO6RYJ/5roELy886njRhgwJY=;
        b=x2VoycqqmoqL5TlYQH6i+IRqs0XEjjGWxwkvnjIbVdtXTSaETvxlUhmsd1EGjdaPacL46G
        3Dx5fVZr7FId6aDQ==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id 80F14A3B81;
        Tue,  2 Nov 2021 15:51:43 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 666894431CC; Tue,  2 Nov 2021 16:51:43 +0100 (CET)
From:   Andreas Schwab <schwab@suse.de>
To:     linux-riscv@lists.infradead.org
Cc:     Saleem Abdulrasool <abdulras@google.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux@googlegroups.com
Subject: [PATCH] riscv: fix building external modules
References: <20210804173214.1027994-1-abdulras@google.com>
X-Yow:  An INK-LING?  Sure -- TAKE one!!  Did you BUY any COMMUNIST UNIFORMS??
Date:   Tue, 02 Nov 2021 16:51:43 +0100
In-Reply-To: <20210804173214.1027994-1-abdulras@google.com> (Saleem
        Abdulrasool's message of "Wed, 4 Aug 2021 17:32:14 +0000")
Message-ID: <mvma6imr1ww.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building external modules, vdso_prepare should not be run.  If the
kernel sources are read-only, it will fail.

Fixes: fde9c59aebaf ("riscv: explicitly use symbol offsets for VDSO")
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 arch/riscv/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 0eb4568fbd29..41f3a75fe2ec 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -108,11 +108,13 @@ PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
 
+ifeq ($(KBUILD_EXTMOD),)
 ifeq ($(CONFIG_MMU),y)
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
 endif
+endif
 
 ifneq ($(CONFIG_XIP_KERNEL),y)
 ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN),yy)
-- 
2.33.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
