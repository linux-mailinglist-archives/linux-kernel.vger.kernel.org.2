Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E153A347F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhCXRen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbhCXReL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:34:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18FC0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kt15so24777945ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQ98DqDCgp3VpW9J5G14oAPOoDjqdZPJlI/Mwh4Jc20=;
        b=A/dLEQ9uqTQQWDf+7m1HxFqs9w2URyTdEjwP4HueRVEUEatZ8pYoCvHmFemsWVs9d7
         i/DOxyZUkBOR2x9Tp9Oxx2iUas5mjtYD+WtHclWhipLhDzuX6kQiMNqlBiuBttAssi2/
         3fkSdK2UqkJsS1XgsxuzwQH8GSmuJ788TgPlQE2All5vCLHGoFzxQGzCPs21YgGt6yZE
         OENgn3K7kKtgFXgccsbt4RKXlVvbsIL3brWTgpYq6ciFhPtpN6iam1J8cXdy5JOon7/r
         ILH7NlB3ivsps1WTPT9VZBpr/TpPKE6etLm9d5/8QPpWR7E6CurDEAbyjtAXsKqQCxGN
         1F5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQ98DqDCgp3VpW9J5G14oAPOoDjqdZPJlI/Mwh4Jc20=;
        b=Iz73iuVHdJyw3oYHffua1jKCfTtc3z3Z+0LIGJch91JRim5eBD/HDwyUx0dY5A2vjo
         xFYLykI57+bUcloZgF8KEqhEq+W03Ir2bXsKfGZ1Yjid1gBwNZqhxQ+tZHQ3ZKbQ3ALa
         NNJyF/3Yofh3KUzxRMJpPtImIUoZqoZMHTeCALnX5CeNexyq88bfuW3QfoXHnghREFzm
         eCPiA7guHw8JIih4zv3FoqIwgrieLX1GHEvyRMqNLPNNoE2C5jB/JRdmEcGMA43SAzLE
         BKp7/WNIyGOC2u0r8mB5y1kcat16HZZIaBtZZ1hg7/Mr+SrjNKGO+DWBrCk+H1lsAoGz
         pYuQ==
X-Gm-Message-State: AOAM5319oiA9MajvkriQpKrt5aXSMsckxFaFqAMsMXw1X75CJGGWsVgb
        kzReF2iehApnuhH83HXbUexkyQ==
X-Google-Smtp-Source: ABdhPJxYd5PUfyNZIS4zpjgDLCdEncag5+bFQ6PaVo8gsvofMOve1KaZeAUJPzuvz6cPq6tcBPXTEg==
X-Received: by 2002:a17:906:938f:: with SMTP id l15mr4872399ejx.15.1616607250150;
        Wed, 24 Mar 2021 10:34:10 -0700 (PDT)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id p19sm1466367edr.57.2021.03.24.10.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:34:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Drubin <daniel.drubin@intel.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 02/25] HID: ishtp-hid-client: Move variable to where it's actually used
Date:   Wed, 24 Mar 2021 17:33:41 +0000
Message-Id: <20210324173404.66340-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/hid/intel-ish-hid/ishtp-hid.c:11:
     drivers/hid/intel-ish-hid/ishtp-hid.h:24:21: warning: ‘hid_ishtp_guid’ defined but not used [-Wunused-const-variable=]

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Daniel Drubin <daniel.drubin@intel.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 5 +++++
 drivers/hid/intel-ish-hid/ishtp-hid.h        | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 0f1b5283bab42..24599280105d8 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -11,6 +11,11 @@
 #include <linux/sched.h>
 #include "ishtp-hid.h"
 
+/* ISH Transport protocol (ISHTP in short) GUID */
+static const guid_t hid_ishtp_guid =
+	GUID_INIT(0x33AECD58, 0xB679, 0x4E54,
+		  0x9B, 0xD9, 0xA0, 0x4D, 0x34, 0xF0, 0xC2, 0x26);
+
 /* Rx ring buffer pool size */
 #define HID_CL_RX_RING_SIZE	32
 #define HID_CL_TX_RING_SIZE	16
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.h b/drivers/hid/intel-ish-hid/ishtp-hid.h
index 5ffd0da3cf1fa..e2423f7d2b547 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.h
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.h
@@ -20,11 +20,6 @@ extern void (*hid_print_trace)(void *unused, const char *format, ...);
 #define hid_ishtp_trace(client, ...) \
 		(hid_print_trace)(NULL, __VA_ARGS__)
 
-/* ISH Transport protocol (ISHTP in short) GUID */
-static const guid_t hid_ishtp_guid =
-	GUID_INIT(0x33AECD58, 0xB679, 0x4E54,
-		  0x9B, 0xD9, 0xA0, 0x4D, 0x34, 0xF0, 0xC2, 0x26);
-
 /* ISH HID message structure */
 struct hostif_msg_hdr {
 	uint8_t	command; /* Bit 7: is_response */
-- 
2.27.0

