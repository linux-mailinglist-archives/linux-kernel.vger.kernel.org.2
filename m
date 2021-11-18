Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8330C4562F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 19:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhKRS5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 13:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhKRS5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:57:31 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857A2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=f2r6iS9GA+oKGMdKWDpWM5tA6VWX8qxI4EgZJwL5FHU=; b=XBgg9XCQfaEauRav8EXiPYaaXm
        KWRvNQFOb+L9OGOBwQlxwh0n2zCJNWrFZ290A2Yi4vfn/FBNI5p3a3zxwvzANr4ZxcXF6MnF7oRrW
        +fvIZ42umSEuREexR3Lb4tXiD8TCnOdloWhIT39/TwPx+P5V59aJtn9qcLV6ImneStw4/jeBcPTY1
        RwruFQDUhc0MVpaCk9fxFV1QhISlqb3IUfUPH+m6SwbTLbg51R7dE6Z4+ykgCyF69fhzu7ZnNm3VA
        gMbVvAmqptDn+6PCC3h5HQwHeweIKRikhuDrwYiNKfXRo9gaXsD9VFgJr/702JI/sCETZjPjZL7o7
        7KRrZKsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnmYA-00Gk3A-CZ; Thu, 18 Nov 2021 18:54:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B1479863CD; Thu, 18 Nov 2021 19:54:21 +0100 (CET)
Date:   Thu, 18 Nov 2021 19:54:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>,
        ndesaulniers@google.com
Subject: [PATCH] x86: Use -mindirect-branch-cs-prefix for RETPOLINE builds
Message-ID: <20211118185421.GK174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In order to further enable commit:

  bbe2df3f6b6d ("x86/alternative: Try inline spectre_v2=retpoline,amd")

add the new GCC flag -mindirect-branch-cs-prefix:

  https://gcc.gnu.org/g:2196a681d7810ad8b227bf983f38ba716620545e

to RETPOLINE=y builds. This should allow fully inlining retpoline,amd
for GCC builds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 9e12c14ea0fb..5fd5b5f091ae 100644
--- a/Makefile
+++ b/Makefile
@@ -690,6 +690,7 @@ endif
 
 ifdef CONFIG_CC_IS_GCC
 RETPOLINE_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
+RETPOLINE_CFLAGS	+= $(call cc-option,-mindirect-branch-cs-prefix)
 RETPOLINE_VDSO_CFLAGS	:= $(call cc-option,-mindirect-branch=thunk-inline -mindirect-branch-register)
 endif
 ifdef CONFIG_CC_IS_CLANG
