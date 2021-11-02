Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D5A4435D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhKBSnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbhKBSnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:43:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9231C061205
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 11:40:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t11so151992plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXw6r8OwYfTq33ELj55YCs9jKPuVtDt4Fh+PISCMrrw=;
        b=f2h7f/vYmLN+UZ9czpcLC3O52WrxCV22IPzJC1zoR10W9CvHXi2vYuIa4edpjYDfr0
         v00CulTRVhN1sjgSdo8klPh5rN+3z0WE2yTF4ov/99SFGmJ1OKAl0bLm6PB9PjFHJP/9
         /OGDlWfouawkxDHp8p5urWyluFWK7mAeqfO6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXw6r8OwYfTq33ELj55YCs9jKPuVtDt4Fh+PISCMrrw=;
        b=HZWYxxUbKg7ojfnhLLl9UAHmiTkmEAbKaoZ5KddudN7I0LRRiwhEDNN4RXgATkGIrx
         6EvU4N1AaupC2Gwc992AgaU5P179nLs3n3Xkb/Sk8eaGLpkQS0OZ4GKSMQc8+0U+wMru
         7zvL3qaXAwdXg5JYn32bozYhFBMVXdqET5I6Xyt0VyjcDkDRc0WTSoAwtjPbAd0K6odZ
         b4AsbcKpDvxzYMRQeCIrPhjEZMRZdy0b7k8S1I4vkm5PrgATT/WrDEkngrnaJLwbKezK
         BxhIpQ0s6bo7aSKrsRGCw/qOEtqg16LM2gL6kWZGwMecxtLtRf7S1cs/Ecdd/L/aPygA
         p/fQ==
X-Gm-Message-State: AOAM531wtreQ83n4zLGXSsmLU5BPTZotboQD3MHH+qC0LZC39MVAjLC3
        V3X4vwIgl32YsTXVWw/C9ml8uQ==
X-Google-Smtp-Source: ABdhPJyZNs8g12zXsaKnLuGtxMDQlO53LpWL47lM0JyvTOk1Xc0+CZdy90R1IqzNJGm5XYJld0yNwQ==
X-Received: by 2002:a17:90b:4c88:: with SMTP id my8mr8706139pjb.49.1635878433294;
        Tue, 02 Nov 2021 11:40:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:ed8a:42c4:80bb:9a91])
        by smtp.gmail.com with UTF8SMTPSA id f11sm9114357pfe.3.2021.11.02.11.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 11:40:32 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Jim Broadus <jbroadus@gmail.com>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] HID: i2c-hid: Report wakeup events
Date:   Tue,  2 Nov 2021 11:40:25 -0700
Message-Id: <20211102114017.1.I16ef7b761c8467be2106880e9b24ce304ae2b532@changeid>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-hid driver generally supports wakeup, bit it currently
doesn't report wakeup events to the PM subsystem. Change that.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/hid/i2c-hid/i2c-hid-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 517141138b00..68d9a089e3e8 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -522,9 +522,12 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 
 	i2c_hid_dbg(ihid, "input: %*ph\n", ret_size, ihid->inbuf);
 
-	if (test_bit(I2C_HID_STARTED, &ihid->flags))
+	if (test_bit(I2C_HID_STARTED, &ihid->flags)) {
+		pm_wakeup_event(&ihid->client->dev, 0);
+
 		hid_input_report(ihid->hid, HID_INPUT_REPORT, ihid->inbuf + 2,
 				ret_size - 2, 1);
+	}
 
 	return;
 }
-- 
2.33.1.1089.g2158813163f-goog

