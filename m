Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B702412298
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351274AbhITSQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:16:19 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:35254
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359090AbhITSKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:10:51 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F0B5B3F328;
        Mon, 20 Sep 2021 18:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632161362;
        bh=1MOw3pBn5yZn8i9TpCdyOmpabZHlCyzS2R0H6XOTRXI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=cVCLcvTM2TVoMt16SXlVJ71+YWdYtMotLXo0nRN7RYm++zX6WyllppDB/mzX4YSvv
         iY/oW26nPG3lA2FiQMr+Rwj1GsQqw8EP+/aUWT6wFjRzVS9VRfkGCGN9/BJ373g/+n
         mp2/uv+wQ/l3kmXH+2bKwpkt5XhNVDawgPJDzOsiPiU8aOBvBFfokch693AfrFnCxa
         TfYwfLIMMncYel61/1CNJ9CvZwoOS5IYojZz/H+OGyO/Dc1HrHZjLTZRuL7rSRRroC
         nnIBD7Mn6zV+Zw+ocFh5Q9mKPLUdXisCkcYa2mKxbSgSLBOO2w6h4uQZ3TrOTbfugp
         MGyjCRNxGTQrw==
From:   Colin King <colin.king@canonical.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Vadim Pasternak <vadimp@nvidia.com>,
        linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] hwmon: (mlxreg-fan): Fix out of bounds read on array fan->pwm
Date:   Mon, 20 Sep 2021 19:09:21 +0100
Message-Id: <20210920180921.16246-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Array fan->pwm[] is MLXREG_FAN_MAX_PWM elements in size, however the
for-loop has a off-by-one error causing index i to be out of range
causing an out of bounds read on the array. Fix this by replacing
the <= operator with < in the for-loop.

Addresses-Coverity: ("Out-of-bounds read")
Fixes: 35edbaab3bbf ("hwmon: (mlxreg-fan) Extend driver to support multiply cooling devices")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hwmon/mlxreg-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/mlxreg-fan.c b/drivers/hwmon/mlxreg-fan.c
index 35228ed112d7..feab9ec6a6ca 100644
--- a/drivers/hwmon/mlxreg-fan.c
+++ b/drivers/hwmon/mlxreg-fan.c
@@ -554,7 +554,7 @@ static int mlxreg_fan_cooling_config(struct device *dev, struct mlxreg_fan *fan)
 {
 	int i, j;
 
-	for (i = 0; i <= MLXREG_FAN_MAX_PWM; i++) {
+	for (i = 0; i < MLXREG_FAN_MAX_PWM; i++) {
 		struct mlxreg_fan_pwm *pwm = &fan->pwm[i];
 
 		if (!pwm->connected)
-- 
2.32.0

