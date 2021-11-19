Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7444574A3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhKSRAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbhKSRAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:00:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9C0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2YP6XLGxR7QxmF0bXuj4LXd2Vkt6fpWQtG95iSsvpQk=; b=k7rLJHcyWV0jErPVat3Ph14Dta
        LjI+KPd4axpX+tBJWz+TRLgocPOihBspBj0swqb3MkftpUKYV7RFRq05gdo4NCsFz/0FAu5x1HeFU
        HyO2/UIwsnMfan8ZngE5fOnw2k3tuN1s+lqqFiRRVEZQAi85r2Xqk8yo/K2DAFKCcmnrZZmyZi5xB
        sPJVbcGmb5V9dOYyTzP7NnE1RQT/gHsG9yXs/LDL4bidHHv6sT/rr0/WWqfSaFCkVv3UpducJZ/LO
        eByAZxMSt084h1TEBVX4DvOC7TKTrSw/F8lDDKDWV6vlXR4j21hCXCkY3V9nTZePMFVogxylaRSp9
        FyiAOSUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mo7CP-00GwUx-RO; Fri, 19 Nov 2021 16:57:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB56F30070C;
        Fri, 19 Nov 2021 17:57:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A10AD2CA10EC0; Fri, 19 Nov 2021 17:57:16 +0100 (CET)
Message-ID: <20211119165630.276205624@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Nov 2021 17:50:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        keescook@chromium.org, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, mark.rutland@arm.com, will@kernel.org,
        ndesaulniers@google.com
Subject: [PATCH 2/3] x86: Use -mindirect-branch-cs-prefix for RETPOLINE builds
References: <20211119165023.249607540@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to further enable commit:

  bbe2df3f6b6d ("x86/alternative: Try inline spectre_v2=retpoline,amd")

add the new GCC flag -mindirect-branch-cs-prefix:

  https://gcc.gnu.org/g:2196a681d7810ad8b227bf983f38ba716620545e
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
  https://bugs.llvm.org/show_bug.cgi?id=52323

to RETPOLINE=y builds. This should allow fully inlining retpoline,amd
for GCC builds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -14,6 +14,7 @@ endif
 
 ifdef CONFIG_CC_IS_GCC
 RETPOLINE_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
+RETPOLINE_CFLAGS	+= $(call cc-option,-mindirect-branch-cs-prefix)
 RETPOLINE_VDSO_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-inline -mindirect-branch-register)
 endif
 ifdef CONFIG_CC_IS_CLANG


