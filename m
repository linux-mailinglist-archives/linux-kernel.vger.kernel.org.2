Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD0330DC8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhBCOUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhBCOUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:20:18 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F9AC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:19:37 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id l3so17923964qvz.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gdNxs8YaM69sWh4jREuvK0RFhtTc9iQ+3CErelD+Kuw=;
        b=mapOjrW3gKFKnloS39F2W/uU3TREbERLKqranHIMK4eMaLBf9/3W3R/SSpftpGEZmX
         v/mRBr3ytvTjl0sEkgsidsX/VDNWn/k1P/l0e3MfQgqHgtMUcTBpqKAKHaBoL7Nq4kHj
         wFL3UWu/k8cMoyiGQwsIIeUMRoKQoSYr2i+qhXKvL/AKFFA8+qszCNQzfHVFjnmVe4jJ
         tzHoSa3TdvGCDOGbg9U2CvbX94ij2yFbQiqLTa2BGRO1XYbWIw+xuAk6P26e9K/gxA4w
         5jWtkfQKy3/4xt+RUgH8l+8yT96jc/AWbu1WzuDjD2o+w1/e8y0E3Ix7JOiOSctW1+yq
         7tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gdNxs8YaM69sWh4jREuvK0RFhtTc9iQ+3CErelD+Kuw=;
        b=OpFwSOdsmh7mOvLW/WlorLfmIBN1gk+OzLPz5Mzk5dlbYR0zjOrm+NgjGDoTVEw122
         Swi6vknp7bJ9CVxwIapAgU9rpFRDHbG7Q8hpFmMQGEdmaB/P5fi9P4ARZUJoPyYW5sUG
         KVOfQCLh9TEDLxBdaQbfFIZHSvevwNZea5+j/0FR4e2Ckyf0xaDTN7ysaFO5EW/CQ9RL
         t6XhKw8j9ra0VPRn0nOVtqsCG39jHEFNZDtgaeldUGMCki1R4rh4jP0yK69aBC+mbc1Y
         uYXeGIFukRTaPTNG0sls6fyg3jPGnFzW8qjJmNoDe4MwNuam40bOp/esuQdTbzdAvxZ3
         PYmQ==
X-Gm-Message-State: AOAM533k+EPKlu1/goLw1gA1B+nZNakoT04+jc0a6zyiT7SYxBRgDygP
        T06VLTBa9WS88pfzFIHmIiSuoc/vdgdS
X-Google-Smtp-Source: ABdhPJzB8Ow/F/CZOHVjcn9iuSTID9Tc1GsdyyhMrHAiA0JbUl8qtRteULcOWo7SJFI+fo/OhTgbHaHKfLBI
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:83a4:: with SMTP id
 k33mr3010478qva.1.1612361976798; Wed, 03 Feb 2021 06:19:36 -0800 (PST)
Date:   Wed,  3 Feb 2021 14:19:30 +0000
In-Reply-To: <20210203141931.615898-1-qperret@google.com>
Message-Id: <20210203141931.615898-2-qperret@google.com>
Mime-Version: 1.0
References: <20210203141931.615898-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 1/2] asm-generic: export: Stub EXPORT_SYMBOL with __DISABLE_EXPORTS
From:   Quentin Perret <qperret@google.com>
To:     arnd@arndb.de, maz@kernel.org, catalin.marinas@arm.com,
        will@kernel.org
Cc:     james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, ardb@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is currently possible to stub EXPORT_SYMBOL() macros in C code using
__DISABLE_EXPORTS, which is necessary to run in constrained environments
such as the EFI stub or the decompressor. But this currently doesn't
apply to exports from assembly, which can lead to somewhat confusing
situations.

Consolidate the __DISABLE_EXPORTS infrastructure by checking it from
asm-generic/export.h as well.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 include/asm-generic/export.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 365345f9a9e3..07a36a874dca 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -33,7 +33,7 @@
  */
 
 .macro ___EXPORT_SYMBOL name,val,sec
-#ifdef CONFIG_MODULES
+#if defined(CONFIG_MODULES) && !defined(__DISABLE_EXPORTS)
 	.section ___ksymtab\sec+\name,"a"
 	.balign KSYM_ALIGN
 __ksymtab_\name:
-- 
2.30.0.365.g02bc693789-goog

