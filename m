Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D34318417
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 04:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhBKDvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 22:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKDvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 22:51:46 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A448DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 19:51:06 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id r13so1974759qvm.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 19:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1JRQPi8afvmid+3tRo/OzmXqnSbsfD3pYZ5yNHooWxM=;
        b=VISLrZvRaUhLOCLe2FGu+m++fW0mPaeRO6FDmdrtpO4knZ0+Cw+CPoRGsugGvmvi6c
         CIWbKX0wL46o6YO93Fh4hzxDkzHX8b3NCS4i90aryGvnDrN6z1r2NwyTHOiG4KdSlGrK
         Ln3GnyavinLKAEfnmUjgmqhBP+ASXjkG/LJYKYE+C9pFdPFdTEEGUpe4zp2mVLDQwxhJ
         5HFOms/1LAMHoDD1XZv+IhoeWUKjNyZgzkLnlRakHDkr3OBzhgIqv5s9YaZVUQXQY7Kp
         Mi3Z8j8uPDOYcxBDafQrqRWZFzhIRfMe5Pd4JNq/Lh67Ys42wyVtdUSzc0Z4sRgOcpRF
         aaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1JRQPi8afvmid+3tRo/OzmXqnSbsfD3pYZ5yNHooWxM=;
        b=JWwER1h0DLQhEWQzp+YUxN6S1uw+gXftw/bkzlxTXAzkkoShiIbJSCYQb1UQd7j+EM
         65z82zhrJV6NmsAMEoZhPNDTrvMY+xEuLzu829l6/t5tF+jw9cvFed7+WXkF0vZ3fP8X
         PTinc9x49IOtJP9miBUWMZ3trBfKG58ot/SG/XOBKoT/T0VCVvwKQAvqpcgA3pFh+tUn
         HQCMRRumekQBPhNtd5/EdLqlJ8S8NhEB3gbKfsZC4LyIcIgmuMLRS2QknHBDSmGcRk0y
         BMEhHR8Iosr2dEcxnix+pgowVukljG9A2tRNeFTTNHEXM8WSGb6kv7H49LyPowCgvxEL
         YrOQ==
X-Gm-Message-State: AOAM5336HF0DxiL+gzEVtvwpF6j/qMkvROU0zKqg8hoqY3qynd90GPci
        up9DAyIQQHf6X0n99crdluUhGw==
X-Google-Smtp-Source: ABdhPJzBDe0KgR7/3d35o57TM5AYMimUMDR1QvYuUfnCiXBC5iAfSjEXVE1zSy/exg6rIO54wTYeNg==
X-Received: by 2002:a0c:e98f:: with SMTP id z15mr6125183qvn.25.1613015465926;
        Wed, 10 Feb 2021 19:51:05 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id x49sm2809945qth.95.2021.02.10.19.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 19:51:05 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
        FRAMEWORK)
Subject: [PATCH] regulator: qcom-rpmh: fix pm8009 ldo7
Date:   Wed, 10 Feb 2021 22:49:35 -0500
Message-Id: <20210211034935.5622-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct name to avoid ldo7 commands being sent to ldo6's address.

Fixes: 06369bcc15a1 ("regulator: qcom-rpmh: Add support for SM8150")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/regulator/qcom-rpmh-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 05f1b4e150f4..043dc2fd39eb 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -937,7 +937,7 @@ static const struct rpmh_vreg_init_data pm8009_vreg_data[] = {
 	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l4"),
 	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l5-l6"),
 	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l5-l6"),
-	RPMH_VREG("ldo7",   "ldo%s6",  &pmic5_pldo_lv,   "vdd-l7"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo_lv,   "vdd-l7"),
 	{},
 };
 
-- 
2.26.1

