Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397CA32C001
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580666AbhCCSeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:34:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236310AbhCCRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cECYFHQXW6ZC2a1gqf4nDPpPZL2JkTjaxDe2H/4YEM=;
        b=H7oci9efCQQe8UfpPhj3ng3pqoQeCeTurqhbgHvjOhr8800zrYxaJXK2v55ozzp4sqAvEr
        /PTP2BQNo9SLwatMrS9x4XHjC5R8+9nX1DRfDg2JPsJUrXXq6D3EIyyJ/MSYxRZzh8ntyg
        MGIgdko2fHFNYaPV8AMInBOr3uZecTc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-K94w8fx9NT6wvBDQMAcxtA-1; Wed, 03 Mar 2021 12:09:59 -0500
X-MC-Unique: K94w8fx9NT6wvBDQMAcxtA-1
Received: by mail-wm1-f71.google.com with SMTP id 73so3238814wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8cECYFHQXW6ZC2a1gqf4nDPpPZL2JkTjaxDe2H/4YEM=;
        b=lUanlm3WBxd7eaDMzGQfvFmcgqLrmx3ZTZwHJe2PLzM9T7oI+KXQ0bigQLq7IogyON
         /7teL7FN71GSg1oRutRIM71q9BGSI8fAxLMpTmgnu5INx6zrqIbKJagxhqQlMpod/3SJ
         EIXdDyaSuwJkUo2XV7vFPWNxguLzCuOBiA8aoR2HuyCzQj3NGJcmrJ2xP98JjtQaxb6Q
         uXoXFlYPUi+OCmIfV5WC32LnyYN4Yb1uYdFTpalAo+5/+3drjXWnfEyG9M34JnIzv8fT
         5CwGVWIfSGVZT8TaEZc/zRhyChkwYjdZWKZCRMeDd18zJq/HL7v1hENmmS83uzTdhgZM
         T23Q==
X-Gm-Message-State: AOAM532VPB8XhxhbOXA/gebFca5SSpAkF7uN6IZbv1A4LBpfchWMwz4W
        7LAV0oBSPZCSejObwpGKYJSsJSTwx2/nZ4sbrZsz70c16T97VWKUQBh99F68Wh8GT7U/BqoZGhL
        b++fOWSvKAyds28GyD0fBermfZbp2mcuK0PGm1uL7mrRzgul/q9SFh7wNVdcG0p3SVccuzTegl7
        iF
X-Received: by 2002:adf:d84d:: with SMTP id k13mr28964847wrl.164.1614791397394;
        Wed, 03 Mar 2021 09:09:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVvvF8AoBPMoaVRWSl4ebWzlC+SRuerfrx4Hs3SxLXgle7eZ1Bx/KLr8ThmWLeoi7Z3fvifw==
X-Received: by 2002:adf:d84d:: with SMTP id k13mr28964820wrl.164.1614791397215;
        Wed, 03 Mar 2021 09:09:57 -0800 (PST)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id r7sm33066226wre.25.2021.03.03.09.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:09:56 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        ardb@kernel.org, masahiroy@kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, ycote@redhat.com,
        Raphael Gault <raphael.gault@arm.com>,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH v2 13/13] objtool: arm64: Enable stack validation for arm64
Date:   Wed,  3 Mar 2021 18:09:32 +0100
Message-Id: <20210303170932.1838634-14-jthierry@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210303170932.1838634-1-jthierry@redhat.com>
References: <20210303170932.1838634-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Add build option to run stack validation at compile time.

When requiring stack validation, jump tables are disabled as it
simplifies objtool analysis (without having to introduce unreliable
artifacs). In local testing, this does not appear to significaly
affect final binary size nor system performance.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/arm64/Kconfig  | 1 +
 arch/arm64/Makefile | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1f212b47a48a..928323c03318 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -187,6 +187,7 @@ config ARM64
 	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
+	select HAVE_STACK_VALIDATION
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 5b84aec31ed3..b819fb2e8eda 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -136,6 +136,10 @@ ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
   CC_FLAGS_FTRACE := -fpatchable-function-entry=2
 endif
 
+ifeq ($(CONFIG_STACK_VALIDATION),y)
+KBUILD_CFLAGS	+= -fno-jump-tables
+endif
+
 # Default value
 head-y		:= arch/arm64/kernel/head.o
 
-- 
2.25.4

