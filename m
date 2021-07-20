Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F123CFEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 18:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhGTPc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbhGTP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:27:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC1DC061787
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 09:08:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c15so11636674pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJQlCsE07lUcHWxp+SqEVtxXbwI1qVhseuzBIbE4s9o=;
        b=aah3byr5l7ysi3eRrhX+vLvuZk2/uvwgIc078RaQJqMypWHGyj8JTz+uA403X0sCh4
         TvDY760OfOfvfR69IFlQMu/DW7ttgsrjlrO31GNY82TnoW1QNIQAwjt6L1mk+T6o2puI
         mzCdqi6e9vrOc/9B0DYIquAkMSt0B1RRtSoVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJQlCsE07lUcHWxp+SqEVtxXbwI1qVhseuzBIbE4s9o=;
        b=M9jx3a6PllJICFYGWOL6KGO64T/Ifoqo1O8kGQMLeOomu7Sri5RX/PybB3jwz+feHe
         T1AWa+R2/vbvIYDj8kuho3WxqqJSojvITuZT1cnYBE9l97/f8XH3FbzqxiId0s1zP/ti
         q1CPwMZrctGcNVItcF72Jl+fp6EY5gVNTnVozCj+SaKWB4vg4mVL8cg8HbiFhmSXIK3B
         RPSGs6G4L2YXGVASVEYXQOwlnac/K5AC9cNlklXYry1M6lW0xO9NoVT08ykJgz4HCHH5
         yCXMXXJrXH/cVHBCN81U7i3sDRypUzl5soiPI959yDwSumGrruJ4etH42s8tCG9/IIl3
         IpHA==
X-Gm-Message-State: AOAM530PO4W8LlBgu9Wab9QizhEv7qkODQR9tGGTYs/qVzHIJeEhDtuC
        BoZJfdB+lyUG/ReIfAxEVYjzeQ==
X-Google-Smtp-Source: ABdhPJxX0v5I5TjjNBymCDBalC7ggAVi8GV2ei6MQrgctbG/4AETRH7BmSko8YmTRKF7qmfrWGTlKw==
X-Received: by 2002:a17:902:9688:b029:129:183a:2a61 with SMTP id n8-20020a1709029688b0290129183a2a61mr23812097plp.27.1626797293805;
        Tue, 20 Jul 2021 09:08:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:a3c3:c989:fdd2:555f])
        by smtp.gmail.com with ESMTPSA id o3sm3132961pjr.49.2021.07.20.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 09:08:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: i2c-hid: goodix: Use the devm variant of regulator_register_notifier()
Date:   Tue, 20 Jul 2021 09:07:49 -0700
Message-Id: <20210720090736.1.Idc6db7d0f2c2ecc6e533e5b918a651a66f337b2f@changeid>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 18eeef46d359 ("HID: i2c-hid: goodix: Tie the reset line to
true state of the regulator") I added a call to
regulator_register_notifier() but no call to unregister. That's a
bug. Let's use the devm variant to handle the unregistering.

Fixes: 18eeef46d359 ("HID: i2c-hid: goodix: Tie the reset line to true state of the regulator")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
index 31a4c229fdb7..52674149a275 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
@@ -132,7 +132,7 @@ static int i2c_hid_of_goodix_probe(struct i2c_client *client,
 	 */
 	mutex_lock(&ihid_goodix->regulator_mutex);
 	ihid_goodix->nb.notifier_call = ihid_goodix_vdd_notify;
-	ret = regulator_register_notifier(ihid_goodix->vdd, &ihid_goodix->nb);
+	ret = devm_regulator_register_notifier(ihid_goodix->vdd, &ihid_goodix->nb);
 	if (ret) {
 		mutex_unlock(&ihid_goodix->regulator_mutex);
 		return dev_err_probe(&client->dev, ret,
-- 
2.32.0.402.g57bb445576-goog

