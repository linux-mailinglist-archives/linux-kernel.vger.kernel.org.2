Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113813E270C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244461AbhHFJRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244195AbhHFJRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:17:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850CDC061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 02:16:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l18so10200839wrv.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 02:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yiquJn/INQmy4EXg5mRduxYtbDZF0r2NCJii+WrbH0Y=;
        b=CTsTQ5CdR0fxHvvCIoS9tNDA0sUK84/WUyUlnqDsq8r5oi/5Lmtqvy6WOoe1PnqaTs
         SPpc51eVB3nsqE69kNwJq+4XOyLSiwF3cQhZwLZFYqTviCPGIU+zRiRdrJAl6ASz1Hpl
         2s48XrQvUirUV+y0yhnA8yqPflmipPsr3DQRxk5dCtPLFqmujhLWoE4V7RETLpfVkTSH
         Vqqwc/Ftv8aH4tb9rZwo/X6V7lesM+XgO828GL28gOlfPMnq8yPuF7RFZlTFD9B/J3ts
         uB3gsZuipYzN+bDmHUBF5E8qdnkYwx7t7YmSp67ddwL3GhMkF6H9qXM5kpXJVzqEIUnq
         9aIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yiquJn/INQmy4EXg5mRduxYtbDZF0r2NCJii+WrbH0Y=;
        b=NtGq0CYwp3l/SvCBeiYQa2JMAyMGK9YjG/aDqreFUuqSpx+S1DvczfkgOJ2OAFdTWT
         jXACqMnRaVxmfkhIAt8maco0iU8z5q+HbgO3KvRMSxYGiDw6ni3cm8EbE1nw9BWaLlIF
         YmFq+t+Vu8vfQ6ROgnQivBbnR9ZyX5BnDwWcf01afirrLeAg21YZIEXcyY5db7Z57xWQ
         WW1t9q7Flu7gVB0VOpHpq9HYbEpd9E9lf22Ceukv9ZqlsLa5wfDznBGRcUXHxu2kyKhr
         ucNp42Vuc92sXYMAWi5CGkIZtzGuRcTfLMNnLbNHWJ9pw73jbI3kTG3W3dHw/8iUcnMW
         FglQ==
X-Gm-Message-State: AOAM53041MA0NEm1vUysemnivPlOtpHlxLbt5L2OTMKOUOM1UR9h5L7I
        m3cEMh/JYAwqpfkFzMmbI7PTVhUtC9yOdA==
X-Google-Smtp-Source: ABdhPJzMiJXVo4UygT4EJ6ayOmL4ITceN2HLpTyDMavW3RElN8yHhXMGCDfNxxAyBqfX/maX3RdTqQ==
X-Received: by 2002:a5d:4dc7:: with SMTP id f7mr9899726wru.118.1628241407222;
        Fri, 06 Aug 2021 02:16:47 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id w3sm7811760wmi.44.2021.08.06.02.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 02:16:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 2/4] slimbus: messaging: check for valid transaction id
Date:   Fri,  6 Aug 2021 10:16:37 +0100
Message-Id: <20210806091639.532-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210806091639.532-1-srinivas.kandagatla@linaro.org>
References: <20210806091639.532-1-srinivas.kandagatla@linaro.org>
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
Cc: <stable@vger.kernel.org>
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

