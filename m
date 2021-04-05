Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BDF354608
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbhDER3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 13:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbhDER3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 13:29:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56BAC061788
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 10:29:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x7so11531919wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IbHMPTLRe24Pd8+2GD6131LEb5Zqf3YCRdiVTSad8Sw=;
        b=aXAtIKMkdOIlTW0pk1jTMcs3R5NHHI/lXeyz5J78WNSh+wZeZeAv/Xlo+p8LdsOOV2
         KsMMe4Apk4g1YpUkEqWya8nOb8HMBkzJcXMK8WvFJeAwq3kRWPpk1wr3TxR5GppLcnr0
         +LwEF9yzSWv8T0O+qlX7mwqaWYYObJsU1T83m5Nm1vueaUTU5vnMF/5vOEo7Irgsl0dv
         dYB+9WLxVpaLHshwE9izHFfVLJjdAYLzQETjnnUJbVo/L0F41Fffqw5qNVoCkjALYUcQ
         M1PXiYKFiLh3mHYC7JqxI+HLPKPFoXukmuAswOkT6wJoa0GYY3A1uP4Ddhp26pOXQhPx
         9N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IbHMPTLRe24Pd8+2GD6131LEb5Zqf3YCRdiVTSad8Sw=;
        b=TAWbfegy1VjQHi5PyuYLBR/uOT1XYnzpapWsEtWTeDQKn5RV2yE+6zTYbvQvZV+z/o
         nTm7Czv0JoyyDwOYciwZ/Ga0Mr/E6Y5GDBimeAaM8fdydlKAam+aQzC9pC+GjMQj4kme
         IzbHExKVxlD/huK7tDf46eAJIiG5vayvbVq5S54YCifbfoUvwg0Sng4liAB1l2cXqlWN
         CrX5e/VJZJqPj3PLg44YUF0xoSCkTfaLo5wKyWBF/g6UlJ0YKS+f6vl6l2DREA5khpYF
         P5WHv83iHxUVQ2SR/THfQmtPBw7UXUz8MnJ+xu0wRp5lCN07Ob/RZVAduTQjvRoSmUvJ
         5gww==
X-Gm-Message-State: AOAM532X808dTxZCNWgsdGTlcjwx9l34gSUDqCZNTE9C79AjFRTex/CW
        yuf9CdsWYsFSPwodykxh510=
X-Google-Smtp-Source: ABdhPJxrXhiHQRU1bmAtbQNqHJTO63OR3QV1f7PuSiW8C29QPUx0aXqxJks3k4+2K+xiYY0+cinpdA==
X-Received: by 2002:adf:9243:: with SMTP id 61mr17346672wrj.11.1617643763484;
        Mon, 05 Apr 2021 10:29:23 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:9a5b:98e6:2174:bf29])
        by smtp.gmail.com with ESMTPSA id x1sm17858699wro.66.2021.04.05.10.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 10:29:23 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 1/4] staging: rtl8723bs: core: Removed extra blank line
Date:   Mon,  5 Apr 2021 18:29:17 +0100
Message-Id: <b2961b2d354722d063e05f92bef5df431b8e7898.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up check of "Blank lines aren't necessary before a close brace '}'"
in rtw_ap.c

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index dc56477eb084..81acc6bcb092 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -910,7 +910,6 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 		/* issue beacon frame */
 		if (send_beacon(padapter) == _FAIL)
 			DBG_871X("issue_beacon, fail!\n");
-
 	}
 
 	/* update bc/mc sta_info */
-- 
2.25.1

