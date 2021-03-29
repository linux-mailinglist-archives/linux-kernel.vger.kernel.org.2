Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3009034CFD4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhC2ML3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhC2MLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:11:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90201C061574;
        Mon, 29 Mar 2021 05:11:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id l123so9727037pfl.8;
        Mon, 29 Mar 2021 05:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8rbrNA2DMWFVv62Fqnm4Yc2a4037zO3cB4baJDc6bEc=;
        b=qoSs0FMzNCVEbDg6NUQJg9n4d/xYpPF1W9NejWfJWh5K5dR0NxrUnigbJ+U98eVlvR
         q5Dh3O48xlqs9MgLbEmJXjPWj/p14/tfSchx6hwM8WUuRhI8d8dbv0capAwaXsnR94EZ
         KPt/1YKrybPEOjUuC0/4m1ddq9zrn7Sk8FgRoEr8UVHkCB1WK3Ro+5jAZnB8hjwaXopt
         jMGebC/DQn17C+vvObyNkOKMxzgXoFWj079sCBpgsrMgF3ra9AslzTM/TeVLJ7vSGDuE
         uThCqlWqAMSz+7jdLq60GagsIA0suOGRG/mVDw1KRJyP5m9FWZwHo3lhP6+61opllTi+
         cgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8rbrNA2DMWFVv62Fqnm4Yc2a4037zO3cB4baJDc6bEc=;
        b=fbYTTSc+wqGYe5d/cC5xdaQkwXHHYOkzQs+VztP6sZ0QNAI39EdNbJMa7y65RRUvV6
         h8omUHkyyicDJUqqRXsWviPwOMJSikKZf1hjfHNnuiYULVVDh2WxOvtQ2sPiK51OwhEM
         7hCdB8fGk3+wYq0BDY+amgzhOIoTXnzUDQh/h/yw2SboFVvHnO8J9/zDrQWGOlo7vV7Y
         8ZNA+9Y5Emj+AIWlQrUBUU4f5brGTlgjfljr4v8RyJOpTOMXivZ0YHDW/pd3v5R74Jwr
         6SEtu9gxpmappqBjXZodt5bbOCeSK5JRZUfkTu0u3mf5/YE+HqJTV+AACCcynP/P4uPw
         9wzA==
X-Gm-Message-State: AOAM531gmqI1hcSVb5g2O1EVdq5ExEOHdESC9e9P05e/o64Jr4Nvfcas
        fbtfCPohbfJS5rrS9PgR9M9ldD88jlFZcg==
X-Google-Smtp-Source: ABdhPJyl85VK5ySg2j2c2AXwiguB6VVIepe85EWSVIu8DMrHzDo6vXI0+CLG6GUwDa7E1cR7IUUnSQ==
X-Received: by 2002:a05:6a00:7c5:b029:21d:2ea5:a684 with SMTP id n5-20020a056a0007c5b029021d2ea5a684mr24431242pfu.36.1617019861811;
        Mon, 29 Mar 2021 05:11:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a089:4ed:8f53:adc7:b574])
        by smtp.googlemail.com with ESMTPSA id s17sm15012322pjn.44.2021.03.29.05.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:11:01 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, rdunlap@infradead.org,
        gustavoars@kernel.org, ojeda@kernel.org
Subject: [PATCH] lib: fix incorrect kernel-doc comment syntax in file
Date:   Mon, 29 Mar 2021 17:40:54 +0530
Message-Id: <20210329121054.20474-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
There are certain files in lib and lib/zstd, which follow this syntax,
but the content inside does not comply with kernel-doc.
Such lines were probably not meant for kernel-doc parsing, but are parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warnings from kernel-doc.

E.g., presence of kernel-doc like comment in lib/zstd/compress.c at
header causes these warnings by kernel-doc:
"warning: cannot understand function prototype: 'const U32 g_searchStrength = 8;  '"

Similarly for other files too.

Provide a simple fix by replacing such occurrences with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210326

 lib/win_minmax.c         | 2 +-
 lib/zstd/compress.c      | 2 +-
 lib/zstd/decompress.c    | 2 +-
 lib/zstd/error_private.h | 2 +-
 lib/zstd/mem.h           | 2 +-
 lib/zstd/zstd_common.c   | 2 +-
 lib/zstd/zstd_internal.h | 2 +-
 lib/zstd/zstd_opt.h      | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/win_minmax.c b/lib/win_minmax.c
index 6bdc1cd15f76..ec10506834b6 100644
--- a/lib/win_minmax.c
+++ b/lib/win_minmax.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * lib/minmax.c: windowed min/max tracker
  *
  * Kathleen Nichols' algorithm for tracking the minimum (or maximum)
diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
index b080264ed3ad..42604785c4f2 100644
--- a/lib/zstd/compress.c
+++ b/lib/zstd/compress.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2016-present, Yann Collet, Facebook, Inc.
  * All rights reserved.
  *
diff --git a/lib/zstd/decompress.c b/lib/zstd/decompress.c
index 66cd487a326a..b28f10f21a6c 100644
--- a/lib/zstd/decompress.c
+++ b/lib/zstd/decompress.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2016-present, Yann Collet, Facebook, Inc.
  * All rights reserved.
  *
diff --git a/lib/zstd/error_private.h b/lib/zstd/error_private.h
index 1a60b31f706c..f7dfa4a18f27 100644
--- a/lib/zstd/error_private.h
+++ b/lib/zstd/error_private.h
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2016-present, Yann Collet, Facebook, Inc.
  * All rights reserved.
  *
diff --git a/lib/zstd/mem.h b/lib/zstd/mem.h
index 93d7a2c377fe..97d92eb431a5 100644
--- a/lib/zstd/mem.h
+++ b/lib/zstd/mem.h
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2016-present, Yann Collet, Facebook, Inc.
  * All rights reserved.
  *
diff --git a/lib/zstd/zstd_common.c b/lib/zstd/zstd_common.c
index a282624ee155..ebf848c1f348 100644
--- a/lib/zstd/zstd_common.c
+++ b/lib/zstd/zstd_common.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2016-present, Yann Collet, Facebook, Inc.
  * All rights reserved.
  *
diff --git a/lib/zstd/zstd_internal.h b/lib/zstd/zstd_internal.h
index dac753397f86..5f02411bded1 100644
--- a/lib/zstd/zstd_internal.h
+++ b/lib/zstd/zstd_internal.h
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2016-present, Yann Collet, Facebook, Inc.
  * All rights reserved.
  *
diff --git a/lib/zstd/zstd_opt.h b/lib/zstd/zstd_opt.h
index 55e1b4cba808..b4a02b9f76d8 100644
--- a/lib/zstd/zstd_opt.h
+++ b/lib/zstd/zstd_opt.h
@@ -1,4 +1,4 @@
-/**
+/*
  * Copyright (c) 2016-present, Przemyslaw Skibinski, Yann Collet, Facebook, Inc.
  * All rights reserved.
  *
-- 
2.17.1

