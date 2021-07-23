Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1117A3D379B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhGWIk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 04:40:26 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42016
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231994AbhGWIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 04:40:24 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id AC9993F255
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627032057;
        bh=aTDeZwBMgFtKPnWXdcaT3ED7J8vSM5/RBLMh7ZrqdvU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=LTu56HzuohgJhGJku3TsWRyTXyPZ1s6e0k0WnkA8sCEfd30pteFrgPS7cKQ7LQejw
         i1SuxxcxG5m3c3dm3GF0/bI7al4Y6jbsjwZq6x+ndD0dnSKO34ZV7i4Y13CYm0VxnK
         OPBxCDvnekdwlW7TSi2AYE6CcOaRVeCgkFoCVfIKrjQdxYr8D4sZWn132T447ehbz7
         yuhSVFYVDtsLoSRw6QgkeZCuOXvftR2m5JGsCeVssyiSGrfjjPS2xeAPbOiXTJVtbh
         H54+erW+hJ3zy2D5P5g1OLSjEycLHyoY2yogm9k78Io3JRSMOqMPmDVyceAn0DkH6Q
         QPCMmtb0EtmnQ==
Received: by mail-ed1-f72.google.com with SMTP id z15-20020a50f14f0000b02903aa750a46efso431021edl.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aTDeZwBMgFtKPnWXdcaT3ED7J8vSM5/RBLMh7ZrqdvU=;
        b=beCTKkSkBUeMW3ueY5S30NTxu2Ko/YY1EZ452rPR2+86FOfnz+LzHSGPZbNDbgjVMS
         jaPx1fzVlGbOjO1/uz2M16gQJcoTwUwkNXSYcN6UkGoS9ASemdHh/qIm7HjTp2nayC+m
         W4jGL2nTsJgdq190aZyIBia6YDUBM/zDjzH0tIaqfXERRYN4SL7HshBkK4yBzZiT8Ho3
         DGWY3oK5NghAlRU1Yh8WfEu/0QbMUdrYONOfo1ZDGrOdhGk8XnRRPBtOy8rqKbblBY26
         GQ6spGoPumAebaJLZ0cvA9ykDFLUlKfzxYM8DUsTCDaRFz41Pvujr+KM1JVfMpZYlOrc
         cQFQ==
X-Gm-Message-State: AOAM533yR+0MKVm/9n/FnQn+d3f6KwYMihIP/I5bPlwYKOcpmZfbISbt
        exBxFoaZWiW5Hu+geEMxKIJavKY2dPiGlEEc1rXeji5CNkgN3T1wH4WSKHO7e0oU3+2DSneNdbj
        mA6ChIkyzFRPGjO9q11WLmCe345r/6gewGSNAlOYR7g==
X-Received: by 2002:a05:6402:48f:: with SMTP id k15mr4410253edv.262.1627032056930;
        Fri, 23 Jul 2021 02:20:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFWvw+F1lJTRxbZaqbZ3+elmi1lpNeFCfvGnWOh7b792sBrPXWzm9q8WmpJaHOZKdNudcPWg==
X-Received: by 2002:a05:6402:48f:: with SMTP id k15mr4410243edv.262.1627032056837;
        Fri, 23 Jul 2021 02:20:56 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id p23sm13602536edt.71.2021.07.23.02.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:20:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfc: port100: constify protocol list array
Date:   Fri, 23 Jul 2021 11:20:34 +0200
Message-Id: <20210723092034.22603-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File-scope "port100_protocol" array is read-only and passed as pointer
to const, so it can be made a const to increase code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/port100.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index ee9429997565..217c5dfa8549 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -217,7 +217,7 @@ struct port100_protocol {
 	u8 value;
 } __packed;
 
-static struct port100_protocol
+static const struct port100_protocol
 in_protocols[][PORT100_IN_MAX_NUM_PROTOCOLS + 1] = {
 	[NFC_DIGITAL_FRAMING_NFCA_SHORT] = {
 		{ PORT100_IN_PROT_INITIAL_GUARD_TIME,      6 },
@@ -391,7 +391,7 @@ in_protocols[][PORT100_IN_MAX_NUM_PROTOCOLS + 1] = {
 	},
 };
 
-static struct port100_protocol
+static const struct port100_protocol
 tg_protocols[][PORT100_TG_MAX_NUM_PROTOCOLS + 1] = {
 	[NFC_DIGITAL_FRAMING_NFCA_SHORT] = {
 		{ PORT100_TG_PROT_END, 0 },
@@ -1130,7 +1130,7 @@ static int port100_in_set_rf(struct nfc_digital_dev *ddev, u8 rf)
 static int port100_in_set_framing(struct nfc_digital_dev *ddev, int param)
 {
 	struct port100 *dev = nfc_digital_get_drvdata(ddev);
-	struct port100_protocol *protocols;
+	const struct port100_protocol *protocols;
 	struct sk_buff *skb;
 	struct sk_buff *resp;
 	int num_protocols;
@@ -1287,7 +1287,7 @@ static int port100_tg_set_rf(struct nfc_digital_dev *ddev, u8 rf)
 static int port100_tg_set_framing(struct nfc_digital_dev *ddev, int param)
 {
 	struct port100 *dev = nfc_digital_get_drvdata(ddev);
-	struct port100_protocol *protocols;
+	const struct port100_protocol *protocols;
 	struct sk_buff *skb;
 	struct sk_buff *resp;
 	int rc;
-- 
2.27.0

