Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6195D30F6E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhBDPyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:54:41 -0500
Received: from de-out1.bosch-org.com ([139.15.230.186]:36274 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhBDPxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:53:17 -0500
Received: from fe0vm1650.rbesz01.com (lb41g3-ha-dmz-psi-sl1-mailout.fe.ssn.bosch.com [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 4DWjjY0PW2z1XLDR0;
        Thu,  4 Feb 2021 16:52:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=key3-intmail; t=1612453937;
        bh=fP74M6HwZDCum3+vzeaerJPkseKxvj4gZV75mefECbo=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=B27sxAAFJZ+CKX/rFvU4IzB6t1B3qDMl0ZI88cEbf8+Y08njZzbEIpcm1xpyGwdR1
         NPQiu0+9WfbnbMEKSWJj7KtWlRluSD1SpiKApuST0wUsF6Br6AAlFsEqKGyPTp0Hp5
         tdXur0eC0A4HEJKnIycuCEIwclQGiIvgOhk2BRFA=
Received: from si0vm2082.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 4DWjjY08K6z1CF;
        Thu,  4 Feb 2021 16:52:17 +0100 (CET)
X-AuditID: 0a3aad16-f87ff70000002214-d0-601c18307ec9
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm2082.rbesz01.com (SMG Outbound) with SMTP id 28.F2.08724.0381C106; Thu,  4 Feb 2021 16:52:16 +0100 (CET)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 4DWjjX6PWRz6CjZP5;
        Thu,  4 Feb 2021 16:52:16 +0100 (CET)
Received: from luchador.grb-fir.grb.de.bosch.com (10.19.187.97) by
 SI-HUB2000.de.bosch.com (10.4.103.108) with Microsoft SMTP Server id
 15.1.2106.2; Thu, 4 Feb 2021 16:52:16 +0100
From:   Mark Jonas <mark.jonas@de.bosch.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Adam.Thomson.Opensource@diasemi.com>,
        <stwiss.opensource@diasemi.com>, <marek.vasut@gmail.com>,
        <tingquan.ruan@cn.bosch.com>, <hubert.streidl@de.bosch.com>,
        Wolfram Sang <wsa@kernel.org>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH v2] mfd: da9063: Support SMBus and I2C mode
Date:   Thu, 4 Feb 2021 16:52:01 +0100
Message-ID: <20210204155201.120524-1-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsXCZbVWVtdAQibB4NonK4ul75cyW9z/epTR
        4vKuOWwWR/fcY7a4+ns9i8Xe1ovMFnf3z2V0YPdY8UnfY+esu+wem1Z1snncubaHzePzJrkA
        1igum5TUnMyy1CJ9uwSujGevprEWzJasaP9xhqWB8b5IFyMnh4SAicTSxmvMILaQwHQmiXWH
        0roYuYDsfYwSX2ZuZYRwtjNKXNq3mRWkik1AS+LmiR1gHSIC0RItX08wgRQxC3QzSWx7v4kJ
        JCEsYC1xcvERsCIWARWJb+3dYHFeAVuJ7Rs3MUKslpeYeek7O0RcUOLkzCcsIDYzULx562xm
        CFtC4uCLF8wTGPlmISmbhaRsFpKyBYzMqxhFizMNynKNDCyM9IqSUourDAz1kvNzNzFCwlZs
        B+P2rg96hxiZOBgPMUpwMCuJ8Ca2SSUI8aYkVlalFuXHF5XmpBYfYpTmYFES51Xh2RgnJJCe
        WJKanZpakFoEk2Xi4JRqYMp5H7jf1ml/aG/m7oUMtpsmMUT/cav/2dMTPak3c3LIPV0bOfO+
        y2djd4qZGXgkf571+0ju5m7fs5b3Fv4XPtslVyz70bfm1M+v38vkgg+fSr2zfoZnZ2HHi/lP
        zt/e3TWnqyDqlv9ErgM2njMasvolwnqLN3TVn3jRtO0Ps+X1y8YCZ4uCpnBfMj6d8O9e1GoB
        t91neHb3LWRPmKWetPe19BOlzNOhZiJaz6xfcO35cltVrpjzBcvaLysCJ1ptcxa2cA6qb12u
        IGu5a1r43J+Jq5p+/Jgg9mrDNR+LqTkf2MQtVPZ0zTjB3KJ2o/bp1rhf9dvmSgRdLNmyzcV+
        27nzQel84owaqzbu+ctUXarEUpyRaKjFXFScCAAcZ1dfygIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hubert Streidl <hubert.streidl@de.bosch.com>

By default the PMIC DA9063 2-wire interface is SMBus compliant. This
means the PMIC will automatically reset the interface when the clock
signal ceases for more than the SMBus timeout of 35 ms.

If the I2C driver / device is not capable of creating atomic I2C
transactions, a context change can cause a ceasing of the clock signal.
This can happen if for example a real-time thread is scheduled. Then
the DA9063 in SMBus mode will reset the 2-wire interface. Subsequently
a write message could end up in the wrong register. This could cause
unpredictable system behavior.

The DA9063 PMIC also supports an I2C compliant mode for the 2-wire
interface. This mode does not reset the interface when the clock
signal ceases. Thus the problem depicted above does not occur.

This patch tests for the bus functionality "I2C_FUNC_I2C". It can
reasonably be assumed that the bus cannot obey SMBus timings if
this functionality is set. SMBus commands most probably are emulated
in this case which is prone to the latency issue described above.

This patch enables the I2C bus mode if I2C_FUNC_I2C is set or
otherwise enables the SMBus mode for a native SMBus controller
which doesn't have I2C_FUNC_I2C set.

Signed-off-by: Hubert Streidl <hubert.streidl@de.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
Changes in v2:
  - Implement proposal by Adam Thomson and Wolfram Sang to check for
    functionality I2C_FUNC_I2C instead of introducing a new DT property.

 drivers/mfd/da9063-i2c.c             | 15 +++++++++++++++
 include/linux/mfd/da9063/registers.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 3781d0bb7786..a2245253f039 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -355,6 +355,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct da9063 *da9063;
+	unsigned int busmode;
 	int ret;
 
 	da9063 = devm_kzalloc(&i2c->dev, sizeof(struct da9063), GFP_KERNEL);
@@ -442,6 +443,20 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
+		dev_info(da9063->dev, "I2C mode");
+		busmode = 0;
+	} else {
+		dev_info(da9063->dev, "SMBus mode");
+		busmode = 1;
+	}
+	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONFIG_J,
+		DA9063_TWOWIRE_TO, busmode);
+	if (ret < 0) {
+		dev_err(da9063->dev, "Failed to set 2-wire bus mode.\n");
+		return -EIO;
+	}
+
 	return da9063_device_init(da9063, i2c->irq);
 }
 
diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
index 1dbabf1b3cb8..6e0f66a2e727 100644
--- a/include/linux/mfd/da9063/registers.h
+++ b/include/linux/mfd/da9063/registers.h
@@ -1037,6 +1037,9 @@
 #define		DA9063_NONKEY_PIN_AUTODOWN	0x02
 #define		DA9063_NONKEY_PIN_AUTOFLPRT	0x03
 
+/* DA9063_REG_CONFIG_J (addr=0x10F) */
+#define DA9063_TWOWIRE_TO			0x40
+
 /* DA9063_REG_MON_REG_5 (addr=0x116) */
 #define DA9063_MON_A8_IDX_MASK			0x07
 #define		DA9063_MON_A8_IDX_NONE		0x00
-- 
2.25.1

