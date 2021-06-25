Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6983B4B5A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 01:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhFYXwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 19:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFYXwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 19:52:37 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AD8C061766
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 16:50:13 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso11095162oto.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 16:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I34DkDhLMaQ/IyLbrDClxn0QZlzBHTfOEHBz/yqlVfc=;
        b=wfjj0O/BibC4pWY5gur3PvLflfcyoYaAOeM3UxN6Xisgx/cH6d2jktONw480QDdXUI
         M8qqhGDOFzE3l2kMi64/+1mtfaYabD7j4LGtbShPO9Zv8nt5+/nauNCnRmpyu2TSsc8I
         ZLwydVAWCbE6hqgfzg+ZqKZhr2zLykmHdtvE61I7a1FngDJvu6zkUNnSExnSEqbR58Dy
         jE+j6vrnpw8YYCDY2xYOGKByZmzviYoBTizD5CbPtuxb2gsTDaRz2V27Q/sNbddt5//Z
         yp1kOjzkMYIGvFxJjCrrqTOOJ2cmbtGZmhJ6fmuttGFzdGiRlufIlyiI4tGMSunbG2fs
         Yw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I34DkDhLMaQ/IyLbrDClxn0QZlzBHTfOEHBz/yqlVfc=;
        b=fm9pNWM2M40RHRQQEXcrsKocseja4zH3Sy1irpog0lL3b76blgXvSkGxqOLNzotA54
         FgED80MEjVmWJR8Iaa0sH9p4ckkai4Yw4AZ2BDo6xqkSsuuKg3wD8f1up62kL/opno+c
         +UuYtcrLOdRGiWiGm/mpna/KEC6Cl5f62W+Ouv6Xkw2nkoK6z4REd6KzgZzJ5szqeG1F
         6dPqnPsgNgvYU3xTCT2beZRfTGXGa5vWOmSJV0AUOeXrFnkiTlK9GcsuL1k3PITumE6B
         8rQ/gbAkU49dKydRX6e+1NgfBjlMjVk94seSPE6vYgtThFDS1ghwYhhzJwqKXQwMUj9i
         iosQ==
X-Gm-Message-State: AOAM533C2Sapf9XMV1Ox71ZekP+0OmKoA/GnUPc/PXzPlko/N416NU1r
        QHcJdDGxhAzcLSEQQY8lY9AsrQ==
X-Google-Smtp-Source: ABdhPJw9quTI7eTdpwwKWWqat+ZcFO8Ubt/qtPbjFl3A0ZlFwU3gkX0iv/Xy6pyGJtGQEYPY9RC8nA==
X-Received: by 2002:a05:6830:2112:: with SMTP id i18mr8342838otc.332.1624665012671;
        Fri, 25 Jun 2021 16:50:12 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c205sm1654814oib.20.2021.06.25.16.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 16:50:12 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: Sanity check that node isn't already on list
Date:   Fri, 25 Jun 2021 16:49:03 -0700
Message-Id: <20210625234903.1324755-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broken interconnect providers might add the same node multiple times or
in multiple providers, which causes strange errors as the provider's
node list is later traversed.

Detect that a node already has an associated provider, complain and
reject the addition of the node, to aid the developer.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/interconnect/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 8a1e70e00876..fcb5d8eefb51 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -959,6 +959,9 @@ EXPORT_SYMBOL_GPL(icc_link_destroy);
  */
 void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 {
+	if (WARN_ON(node->provider))
+		return;
+
 	mutex_lock(&icc_lock);
 
 	node->provider = provider;
-- 
2.29.2

