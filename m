Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40283CB5F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbhGPKZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbhGPKZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:25:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AAFC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:22:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r11so11468403wro.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjxLxmgZBDZkyIZTSdcwCO6eZCtubh4Qr/3hT9cegm0=;
        b=F0ZYk8ZGiCL5U+lH8QEtTnltPQiNIQnjz0z/c579UaUs+5wyoSP6EgvAQFOmjGinFe
         NAXuffXbmgEmrG89uz7iJd/A6IUZQQHGRq6pSrqW8h/pKNcIPs8nLZZxLSCnYkvPNt35
         GZqU7gm+Bm21IJqEBxlN8/7VXSSYakxIsr7/ekfMikyCi0juwf7+zjP87eLzK+OZPVv/
         CSC2iaeL/cSlC8OuBtprye/h6zYLEtSCnZyHenOf2yVccW6f5bStJe9tfQOfaoonhZgS
         zZxTqchQttzbX2LSxeJTv0S+riT0tMdFcjBXEHYW7cjJc9o1sNymDKhQtoxviN4PO0RP
         Cx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjxLxmgZBDZkyIZTSdcwCO6eZCtubh4Qr/3hT9cegm0=;
        b=fnSncm5/L4rOxk0vDHWEGEh4P6ixBMQFolN1iAVdKpBMo7fDmVwUo5MbVDmWCTfbBQ
         LoDbgec542eyRaVn9DNrSuc0QWjk5jWYf4iopM6XBHstR0O8UzzYR6LlIDQecEJlVyPp
         788phZ45zwmav0B+nIuP0TMoret5eZF2FOa8Bq9dSxLoooBy8u4Bh6/6Hhp4IjogDSH5
         JcLqCPzp2i90sl2myiME1iopJmZ5tOqjOETAZewjUL3a/2a5RuEaBfe9FZacwcPSt9/8
         pc7kG/kWWKSTaFneYEYy3R6z//hkgzuo7DeHLLPyqDPUcoo4aDl2Ii6GCSFQ0XgyY7c6
         Y+Qw==
X-Gm-Message-State: AOAM531C+ukThIGtpJRy1EXC+3IX9nPDRQo6DGPS8VZsNS6rUfBll2r6
        mwWuDHZutHzhgmAWk6Jv8fm1CQ==
X-Google-Smtp-Source: ABdhPJw/ypVuRpbiqTH/2yAp3WpRaCk+U4+ybol9ZhHDa803+5l610ecL9x5ZvNZgj0CtbSXVePB4A==
X-Received: by 2002:a5d:4b42:: with SMTP id w2mr11210193wrs.47.1626430957487;
        Fri, 16 Jul 2021 03:22:37 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g15sm7421796wmh.44.2021.07.16.03.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:22:37 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] slimbus: messaging: check for valid transaction id
Date:   Fri, 16 Jul 2021 11:21:21 +0100
Message-Id: <20210716102123.26861-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210716102123.26861-1-srinivas.kandagatla@linaro.org>
References: <20210716102123.26861-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some usecases transaction ids are dynamically allocated inside
the controller driver after sending the messages which have generic
acknowledge responses. So check for this before refcounting pm_runtime.

Without this we would end up imbalancing runtime pm count by
doing pm_runtime_put() in both slim_do_transfer() and slim_msg_response()
for a single  pm_runtime_get() in slim_do_transfer()

Fixes: d3062a210930 ("slimbus: messaging: add slim_alloc/free_txn_tid()")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 6097ddc43a35..e5ae26227bdb 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -131,7 +131,8 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 			goto slim_xfer_err;
 		}
 	}
-
+	/* Initialize tid to invalid value */
+	txn->tid = 0;
 	need_tid = slim_tid_txn(txn->mt, txn->mc);
 
 	if (need_tid) {
@@ -163,7 +164,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 			txn->mt, txn->mc, txn->la, ret);
 
 slim_xfer_err:
-	if (!clk_pause_msg && (!need_tid  || ret == -ETIMEDOUT)) {
+	if (!clk_pause_msg && (txn->tid == 0  || ret == -ETIMEDOUT)) {
 		/*
 		 * remove runtime-pm vote if this was TX only, or
 		 * if there was error during this transaction
-- 
2.21.0

