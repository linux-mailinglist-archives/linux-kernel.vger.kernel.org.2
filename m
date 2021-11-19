Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC954574A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhKSRAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbhKSRA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:00:29 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1244EC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YIQ9WrkdiklqyfvXemUBHZq4BEwet3x3d5wKAJIwu1M=; b=au0No7CP2PSr/uV/iEJ42BN863
        jfP63IXXYju4/98fw5PKPRVhXHkPSfL+7b1Ue45lzRWWoVpMTLWsxwjc5nTNrELdf//sZxqVCIkjn
        yLoOznLE01TS5SJ2e9SYPlRgIaAsuucl5h8KFwClQuuejwpnIK4wnKFn/Raybbu1RMJsyiXHAMZXV
        TCH1W+p5ljZkT0dJY6UYliwytLNKuqQOetxQB+ytdGQdl29CzRtG1l6QUwgyRgRT29Al9zry846yr
        YRsNf1ZaP6irBvWBAdRsg3XD86URT4D6JWbrrvvOZwi6dWCYQOAdQip8hvZUR9et9Vw8wBWdgLdOU
        6NctJXbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mo7CP-00GwUw-RY; Fri, 19 Nov 2021 16:57:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B934730030B;
        Fri, 19 Nov 2021 17:57:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9E82B2CA10EB1; Fri, 19 Nov 2021 17:57:16 +0100 (CET)
Message-ID: <20211119165630.219152765@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Nov 2021 17:50:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        keescook@chromium.org, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, mark.rutland@arm.com, will@kernel.org,
        ndesaulniers@google.com
Subject: [PATCH 1/3] x86: Move RETPOLINE*_CFLAGS to arch Makefile
References: <20211119165023.249607540@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently RETPOLINE*_CFLAGS are defined in the top-level Makefile but
only x86 makes use of them, move them there. If ever another
architecture finds the need, we can reconsider.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Makefile          |   11 -----------
 arch/x86/Makefile |   11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -688,17 +688,6 @@ ifdef CONFIG_FUNCTION_TRACER
   CC_FLAGS_FTRACE := -pg
 endif
 
-ifdef CONFIG_CC_IS_GCC
-RETPOLINE_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
-RETPOLINE_VDSO_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-inline -mindirect-branch-register)
-endif
-ifdef CONFIG_CC_IS_CLANG
-RETPOLINE_CFLAGS	:= -mretpoline-external-thunk
-RETPOLINE_VDSO_CFLAGS	:= -mretpoline
-endif
-export RETPOLINE_CFLAGS
-export RETPOLINE_VDSO_CFLAGS
-
 include $(srctree)/arch/$(SRCARCH)/Makefile
 
 ifdef need-config
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -12,6 +12,17 @@ else
         KBUILD_DEFCONFIG := $(ARCH)_defconfig
 endif
 
+ifdef CONFIG_CC_IS_GCC
+RETPOLINE_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
+RETPOLINE_VDSO_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-inline -mindirect-branch-register)
+endif
+ifdef CONFIG_CC_IS_CLANG
+RETPOLINE_CFLAGS	:= -mretpoline-external-thunk
+RETPOLINE_VDSO_CFLAGS	:= -mretpoline
+endif
+export RETPOLINE_CFLAGS
+export RETPOLINE_VDSO_CFLAGS
+
 # For gcc stack alignment is specified with -mpreferred-stack-boundary,
 # clang has the option -mstack-alignment for that purpose.
 ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)


