Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9195438D5C8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 14:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhEVMV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhEVMVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 08:21:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C49BC061574;
        Sat, 22 May 2021 05:19:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id s4so10780348plg.12;
        Sat, 22 May 2021 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hIV8EDbMmCN8KJbthhTgUYXX854FbNW5ORmyIMd/TCU=;
        b=TXuk5PaTbqbVchbt02kcbrBC0GDveMFebGMhRJzuPdUIH62CvOj4SpVkXc9b7LNpgX
         kI8kzdn+/Ce4AGlLZIDgkIgMP0o9/AuDmB9b4BJimU9k4RtfWBnfBsjD4anAw5jyo+aw
         mytxyrSAD3ycHMvIHeiydy/HCm0nzC5VhzBM2BrZ6jWaKJNNKNt9yIjteQt2WF7M3oRM
         BzoejR5NSm93dNBgeXA5VEyTV+JAAUg5hrkkZ2cQADmKvsKPRBwahSXb3hRNcY4/bAdS
         cSXNXkrWiJnSRDGPvivL9AcG51U+6ZgkHUAPSJgOP4IiSeAfsM1D1FriBbPnUVG09+Z3
         FEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hIV8EDbMmCN8KJbthhTgUYXX854FbNW5ORmyIMd/TCU=;
        b=Y/ubOhoLIjT0x4UKyJNrB5dqq55dQMun4l9vVmlJQVlsNivcVkAqmaCCODKqN+1rUj
         aiwEVP3l5NpSRlfNkKusbhp/fTY9Gd0goU6j4prt32+KGY6WmMOwTa5Em58X3gxsJuad
         w/JeLWpRyyLfDTHHfmycG2lqPsVrmKV2NYCB0YKZ1HhW89uRfLzHknQStPZQAy55vQVi
         KfqkBZ1uVWjOA72Z0ceByUJfIariGrl0jD6F7XfFryRdYXE9326VxboaNKye21fubWPI
         YUIPqcoh0vvHtL6NIsBlevxfsdB6vt05uKAcHz6NssVVsRSRasoA4HQNyforO/iwWLMJ
         0L1A==
X-Gm-Message-State: AOAM531WzxlIkw2qnClBrM9lRsoQk4J0iHzDMQzwtPVJakuoNGkPhSeQ
        Yls4/AtBR8lUl45fXc4tWU0=
X-Google-Smtp-Source: ABdhPJzXIf0ow7VfJ33E3E6pz3x4L8UegaDBVhHmjb2taTs2wjE8bH3RqCcZF2EVDAS4LS/a37hqHQ==
X-Received: by 2002:a17:90a:6782:: with SMTP id o2mr13524175pjj.1.1621685997896;
        Sat, 22 May 2021 05:19:57 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a93f:d9c2:4477:9177:8c76])
        by smtp.googlemail.com with ESMTPSA id 23sm6057515pfn.192.2021.05.22.05.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 05:19:57 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     siglesias@igalia.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jens.taprogge@taprogge.org, gregkh@linuxfoundation.org,
        industrypack-devel@lists.sourceforge.net
Subject: [PATCH] ipac: ipoctal: fix kernel-doc syntax and remove filename from file headers
Date:   Sat, 22 May 2021 17:49:44 +0530
Message-Id: <20210522121944.11182-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
The header for drivers/ipack/devices/ipoctal follows this syntax, but the
content inside does not comply with kernel-doc.

This line was probably not meant for kernel-doc parsing, but is parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warning from kernel-doc.

For e.g., running scripts/kernel-doc -none on
drivers/ipack/devices/ipoctal.h emits:
warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * ipoctal.h

Provide a simple fix by replacing this occurrence with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Also remove the redundant file name from the comment headers.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 drivers/ipack/devices/ipoctal.c | 4 +---
 drivers/ipack/devices/ipoctal.h | 6 ++----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
index 3940714e4397..2a3a94f72dfb 100644
--- a/drivers/ipack/devices/ipoctal.c
+++ b/drivers/ipack/devices/ipoctal.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
- * ipoctal.c
- *
+/*
  * driver for the GE IP-OCTAL boards
  *
  * Copyright (C) 2009-2012 CERN (www.cern.ch)
diff --git a/drivers/ipack/devices/ipoctal.h b/drivers/ipack/devices/ipoctal.h
index 75f83ba774a4..773dc41bd667 100644
--- a/drivers/ipack/devices/ipoctal.h
+++ b/drivers/ipack/devices/ipoctal.h
@@ -1,9 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
- * ipoctal.h
- *
+/*
  * driver for the IPOCTAL boards
-
+ *
  * Copyright (C) 2009-2012 CERN (www.cern.ch)
  * Author: Nicolas Serafini, EIC2 SA
  * Author: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
-- 
2.17.1

