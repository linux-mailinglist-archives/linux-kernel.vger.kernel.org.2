Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFC134F394
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhC3Vbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhC3Vaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:30:35 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5C1C061764;
        Tue, 30 Mar 2021 14:30:34 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h25so12664846pgm.3;
        Tue, 30 Mar 2021 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z5Pwgcx5jldQHTjihKz5LQ36Y/UBnw6DyXH2bNjldL4=;
        b=UGG9UGBn4yDKVdheETHJU7898bNJ/rOuhIOxBtRrO5s7lVCtAFCACSWJtixvuDw64V
         avttHcBLJfEOaTetoOchdDeXmg0e/gnTTNc2CAUmr2qFiBqbvq+y3GI/BXAGLoZ+/3Ha
         sNQx0aUpHlWBg46RtfrfkgktB7PCDcDfyy1H9egsSNoshINTjQgFHy7WkdS1FMaFP3KM
         fLzvEYZp+VpSkB/yc9qXQ6DDR7xWj1AR9pb2m4o+Nd4wKAyD4xOe663Rh/LWfcpv528Z
         z2VaP3/CoRKF+g/ttZgVDUG6w37MCDne5WFQEAbAjg2vSRCgjr9bOXYaEx7wAFkjScE7
         Kv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z5Pwgcx5jldQHTjihKz5LQ36Y/UBnw6DyXH2bNjldL4=;
        b=j3naOb1vsDtc+eBE2twJ2+DjGakDqJwKsRa9Act9SgnrHE1pD0rbGAOGjH3YKy8Lio
         bmdQKErUoBzSzieH0DfjxDW2+Gbtp/8/PFHIxSnW2isIJaiJhhDLIIpr5aQWhOliRgV1
         ltf+TA9Q7eAbpwEsCoAMV9LF1Bas9r94j/iHT/IsMLlCJzDXKWZmApMTiGKTZ9Qbo5Lf
         jB+xa2RHBYoQjsfIXWWR9CxS3GDES3HRd41CHgI7ZSFh+96crIdzKulVum7WXl7fMJeE
         X+uDw8g1Hkjc9EVA6hJhfyifPM15xctk7L8x9zf3mC7C8e5Z+CAl1MHb5dy1BQ8/KY6m
         1CtQ==
X-Gm-Message-State: AOAM532uYh9mhtStI/te/dgZDpsGG2wIR3m5BhQK0hM+xFI9EHSUpCwu
        G6TQe4lN99gAG6X/G2AjZCFUz3bsubXDk2UL
X-Google-Smtp-Source: ABdhPJzHUE6m7pRCZgtHJX31O2SfZcliToVP6diuEqC05Weo1MXgQ7Ug5Zw6trKkMAWPqAgGvlDy8w==
X-Received: by 2002:a62:764c:0:b029:1ef:20d2:b44 with SMTP id r73-20020a62764c0000b02901ef20d20b44mr30852603pfc.45.1617139833611;
        Tue, 30 Mar 2021 14:30:33 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:d1c0:d79d:e260:a650])
        by smtp.googlemail.com with ESMTPSA id i10sm8332761pjm.1.2021.03.30.14.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 14:30:33 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org, dvhart@infradead.org, andy@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH] x86/platform/intel/quark: fix incorrect kernel-doc comment syntax in files
Date:   Wed, 31 Mar 2021 03:00:22 +0530
Message-Id: <20210330213022.28769-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
There are certain files in arch/x86/platform/intel-quark, which follow this
syntax, but the content inside does not comply with kernel-doc.
Such lines were probably not meant for kernel-doc parsing, but are parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warnings from kernel-doc.

E.g., presence of kernel-doc like comment in the header lines for
arch/x86/platform/intel-quark/imr.c causes these warnings:
"warning: Function parameter or member 'fmt' not described in 'pr_fmt'"
"warning: expecting prototype for c(). Prototype was for pr_fmt() instead"

Similarly for arch/x86/platform/intel-quark/imr_selftest.c too.

Provide a simple fix by replacing these occurrences with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210326

 arch/x86/platform/intel-quark/imr.c          | 2 +-
 arch/x86/platform/intel-quark/imr_selftest.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
index 122e0f37b1f5..d3d456925b2a 100644
--- a/arch/x86/platform/intel-quark/imr.c
+++ b/arch/x86/platform/intel-quark/imr.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * imr.c -- Intel Isolated Memory Region driver
  *
  * Copyright(c) 2013 Intel Corporation.
diff --git a/arch/x86/platform/intel-quark/imr_selftest.c b/arch/x86/platform/intel-quark/imr_selftest.c
index 570e3062faac..761f3689f60a 100644
--- a/arch/x86/platform/intel-quark/imr_selftest.c
+++ b/arch/x86/platform/intel-quark/imr_selftest.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * imr_selftest.c -- Intel Isolated Memory Region self-test driver
  *
  * Copyright(c) 2013 Intel Corporation.
-- 
2.17.1

