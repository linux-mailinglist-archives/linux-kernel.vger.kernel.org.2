Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8B3E4189
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhHIIZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbhHIIZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:25:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A902C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 01:24:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso13897597wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yiquJn/INQmy4EXg5mRduxYtbDZF0r2NCJii+WrbH0Y=;
        b=cBC+piznjrG893DpUbCLAQausCChPmbITmrt3rP7kIziQb9lP52gK1mDqwHpTzWv7h
         RVrsQui3bODCdnS6ZJ4paATX8ASIpfcMnGRbr7/PaLveD/wLoo1pi3p8v9aJibtFr9iO
         Du+9O6zo38Z2o3pm5QOlb2F5SvrQZxXqU8ITYEfBT+dH7RGAmTLk4r0TWo7toZ4aV3sE
         w7jO3YkW+A7m3IAiK1x9E1V/rX6EUAvEPhwMfylQUrkkBSjW5i8ywr7nYe3wbeMK/qid
         pVYXc9jY2cumYmwO0dz1mHhAqe36bIr0HLmodqCZUnMK7Zt4jfBGj2Wv36E7Dby5SppN
         /cRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yiquJn/INQmy4EXg5mRduxYtbDZF0r2NCJii+WrbH0Y=;
        b=iIQsbNim+tBoKwS2VBw5fU70SxfziWjrDWan9ikHfBsf5u1KiAXIGEDn8qf0RR8sm8
         Inil80qjHEnLW0k6xMZFtONQ1kjtildvr9m1YWvri0BdlK9bjehS0a0Bb4K7L7VAHWdX
         SyytNiL4N7a3ECtIsvWnP5t02MbFLehKHy1Gr6xe6P9hrNBR/lW0CIE9igFEvrAva15J
         985AMxSSd7m6vAEdJlcQqQwzrP+plQ/b3NQC992EgU2niuAlr2uqN7Kmrw7J+PiW4i9I
         cJ6vRcljGdm5Ba2LonNnpcBmHxde50dHBmwv/Whfp3v0Tg/ujYK1LTp7yQ1WT2qqIAna
         jJRw==
X-Gm-Message-State: AOAM530LcOCBh4V9l0fVum8l9GjaetXsiW8d/ouFfOedu0LHysEtT9+3
        gLTIGzrRL707cv7LEkJb5N/ejg==
X-Google-Smtp-Source: ABdhPJysEOSOM8T6H7uLSOxCDFZSh5m9+gspIzsPuu4OTAvirrjTz8fynd9u73g3RHQsEzXMbHY1Ug==
X-Received: by 2002:a05:600c:3b8f:: with SMTP id n15mr10274591wms.155.1628497481789;
        Mon, 09 Aug 2021 01:24:41 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id t15sm18036371wrw.48.2021.08.09.01.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 01:24:41 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        stable@vger.kernel.org
Subject: [RESEND PATCH 2/4] slimbus: messaging: check for valid transaction id
Date:   Mon,  9 Aug 2021 09:24:26 +0100
Message-Id: <20210809082428.11236-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210809082428.11236-1-srinivas.kandagatla@linaro.org>
References: <20210809082428.11236-1-srinivas.kandagatla@linaro.org>
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

