Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6A138B5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhETSXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhETSXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:23:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62969C061574;
        Thu, 20 May 2021 11:22:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id k5so9583472pjj.1;
        Thu, 20 May 2021 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lpcKnO9tQEe0BuksEsXPkwREUyfxw2fzAVZOQGH8To8=;
        b=R1ox8Omaa5KTdyS7M07a8tB1wjyruLTadLN3eNZ85U/J7/uJPQ5FAAPd1Y6j3ZaYz1
         EeBX11PD5uNJE/2rGSSJV80k/SVwDho3dzRklg6HRloqr3KF2xoyEWXpVb+1lX3t7M8i
         lKWPH4jz3X/IhUrcmh5Yxjo3IhFb3GnIbUZ+i0HDZGqSpnFxw/3nUL+OrVl7Wh9YbKrJ
         b7BkXzs6MLqD8z8TfuwdylWyd12azPnf1tTW9se8gLcLQN0YhetMBn9z9FJQoBF4E1Uz
         fcu1HlDkcc2ACKBTj2XXaPtDmplTPQrF0w3NKw9l9HiOsw7ALu3I/kK36XFhuajMiYIz
         kzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lpcKnO9tQEe0BuksEsXPkwREUyfxw2fzAVZOQGH8To8=;
        b=gH/9IkKyRtilrnNgpH1HuYrTeyJB0JKEx5BQYpqRlq+7r7emzqlVUaMIAKuHCfc5mp
         t/kwoL5ciSpaYTjM1qtW3/ea+J6ZAdLLu89s/xpaD2I2O2zNPf07DQoSSvKiNE3st7g6
         pMj0xDuNYoHZlA1f+DGy0NcUeWhllarua92jXwNn0+SDiZQ1egs4J7XZL012hr5heoTM
         UKqutep7n58BFpT84xz4AqGJVA+WDyy303MRYdZgWl2P72y4EaDtoK4JYcMkptRPkuMo
         vgkv2Gc7zMMRvvU7i4oXCEbQiadJqe9ToloWAi/4xI1mCGS/+yuV7ybZ8jbpcLoSi+9E
         EuOg==
X-Gm-Message-State: AOAM531mqYjZ5ufBGAlTP+cHeeiOpcRI3w13nQuMemhbue1Y0ifvWX6r
        54bP/dpy6tPGucFPWpYUdz4=
X-Google-Smtp-Source: ABdhPJx5IJioORIThYoSAt1q0q1qSZkrfMObM6ASvt7sKGIXVBm3whG4VdKzWLBYun1RP6G/lVNO0A==
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr6509831pja.181.1621534929660;
        Thu, 20 May 2021 11:22:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a93f:4822:12f2:8c52:6d8b])
        by smtp.googlemail.com with ESMTPSA id q196sm2643751pfc.208.2021.05.20.11.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:22:09 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     courmisch@gmail.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Phonet: fix kernel-doc syntax in file headers
Date:   Thu, 20 May 2021 23:51:59 +0530
Message-Id: <20210520182159.31462-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
The header for include/*/linux/phonet.h files follows this syntax, but
the content inside does not comply with kernel-doc.

This line was probably not meant for kernel-doc parsing, but is parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warning from kernel-doc.
For e.g., running scripts/kernel-doc -none include/linux/phonet.h emits:
warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * file phonet.h

Provide a simple fix by replacing this occurrence with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 include/linux/phonet.h      | 2 +-
 include/uapi/linux/phonet.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/phonet.h b/include/linux/phonet.h
index bc7d1e529efc..09ecb1f94c5e 100644
--- a/include/linux/phonet.h
+++ b/include/linux/phonet.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * file phonet.h
  *
  * Phonet sockets kernel interface
diff --git a/include/uapi/linux/phonet.h b/include/uapi/linux/phonet.h
index a2f6b37a5937..6b873c460994 100644
--- a/include/uapi/linux/phonet.h
+++ b/include/uapi/linux/phonet.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/**
+/*
  * file phonet.h
  *
  * Phonet sockets kernel interface
-- 
2.17.1

