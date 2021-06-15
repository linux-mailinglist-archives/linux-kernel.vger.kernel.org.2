Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBC33A7D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhFOLsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhFOLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:47:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54864C0613A4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ho18so22066648ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xg4lh6FzY/x6mpAMMiRuRSWrAaG34s4GEztF8UfIitg=;
        b=ucMVTfLZZRtvzlrcYQcji6yqz4vgTroBuv6Z7GrUAH3bQQCdI9meMivVrhJjqcJqDm
         prEgw6+RtbdB9fxZWQUTwnhY5MdEvZY/hFw/iAglcqN01jhZAwBLR+sqghFcSedyx4a3
         nuSsfKtZiIO20O4a8LmqSoBIqxhDTE3QznrnocMkrCxm8iKogfmIJRe0e3K+CEZBiLFj
         mc9JainTmffKDqf3a/jOlsV5cVCLPGHmZ+SicKiaffngf9ysRP7YGDSJgSHKYg/p/A7h
         RzkENz2yUf0oVkMZ4fF/OHAnKSEl9g/Y74rzFJknTdptYwILLTfYO5wy/Ou8Z2k8sUwU
         L7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xg4lh6FzY/x6mpAMMiRuRSWrAaG34s4GEztF8UfIitg=;
        b=XX0YH9Y1Qe3aQtaHnRY1FHGU3S0jRrKRs5U5H3QQBb6nqIkyCxS2nTe6pcp4DfcupN
         mOXOWoBrhxtdZxEOzx0l0tffQ1HsS2cs1g35iayWwONMmwm15GnZGzB5VAAR1y7y4zL1
         WkuN+NX6sMsao4jJa97gkDYbLX28AWGgdhhLzUIdCZjwCvllHxTk80f8DAPutpIjvVNU
         /VN/61I+VftlYZWZJtPgcQX8NUZm8+psQpDVOMp8V0Klz1Tq0TPiZIC/ANY5Ru3Pxla/
         yfNORsUE1gV+t/vc9TprWQhBGksB6gyRH1wTwA9mNWjXUf57FUf7enYJxlZlRBcBq6LS
         4Xaw==
X-Gm-Message-State: AOAM5332chBvqtBdcy51dOWGNM1vODqYIKx2T9KG7jh+2HEvV2N4MhHW
        WVu0jXYaRhwloIKm3vYU8WhQSq4C++4ncQ==
X-Google-Smtp-Source: ABdhPJwgBEZX2GOeAWxZZpjCIY/R/gut+lHCeRDJpDujG75wREiLcDlcquAs6gnZbxQUXwW8EOLfpw==
X-Received: by 2002:a17:906:22c6:: with SMTP id q6mr20234786eja.275.1623757548819;
        Tue, 15 Jun 2021 04:45:48 -0700 (PDT)
Received: from agape ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id g11sm11864726eds.24.2021.06.15.04.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:45:48 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] staging: rtl8723bs: move LPS_RPWM_WAIT_MS macro
Date:   Tue, 15 Jun 2021 13:45:36 +0200
Message-Id: <5756b958b5d279f1cc8cea7887f50d003b17b94e.1623756906.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1623756906.git.fabioaiuto83@gmail.com>
References: <cover.1623756906.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move LPS_RPWM_WAIT_MS macro from include/autoconf.h to
include/hal_btcoex.h in order to empty unneeded
autoconf.h.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_btcoex.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8723bs/include/hal_btcoex.h b/drivers/staging/rtl8723bs/include/hal_btcoex.h
index eb9d0ba861a5..849fb90b43b7 100644
--- a/drivers/staging/rtl8723bs/include/hal_btcoex.h
+++ b/drivers/staging/rtl8723bs/include/hal_btcoex.h
@@ -9,6 +9,8 @@
 
 #include <drv_types.h>
 
+#define LPS_RPWM_WAIT_MS	300
+
 /*  Some variables can't get from outsrc BT-Coex, */
 /*  so we need to save here */
 struct bt_coexist {
-- 
2.20.1

