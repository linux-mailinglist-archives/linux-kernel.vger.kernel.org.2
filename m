Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73A73076CB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhA1NKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhA1NKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:10:35 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A32C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 05:09:55 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id s18so6230655ljg.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 05:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7LZ22+oyphnUi5mVFQCXWwH/H/OEMXyG0FmJuE7rMk=;
        b=1NaX3Fx5vR3LylPGpehoAVK9/R5LQc1yFDM+xUNseADsOEUXVW5Q9LXSQ2+IdagFWT
         g17CQRs0VwFP0a2tL1bXhujKOqEM6lkUZDVODU6Hw2R7p2QCqsBUETrCvjQymrwYUahS
         nfxtjx/NVhn+h5LYjNPtGBROa2P10ty/VpG8g0XIO7HmIXaz6pt1auwsFavdNz/gl79a
         +tQk2xmBhQw3M0eMvwVbWXv+494isqb6hUZK9WaCrGlqMCdU4c/npKP0+UucOuOWSFce
         GaLbtmUHIYAlUNkZThHrs9x+SlYFzHSQxudMKdLs5XCeIdBvAboJ1LqE/6aI9N/ud6qf
         SViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7LZ22+oyphnUi5mVFQCXWwH/H/OEMXyG0FmJuE7rMk=;
        b=byE7gOIh+9VCQ0OzdTEM8845nqRC7MKmGZ737sf+gQRQ9GCuPFzRtu6aeNjkUINMPE
         rhJB5X01k6JQG1ZjiVNsJejpFcQmnbeiqPsPeqM8NDNRem5zv4FEiTiNGD3vjr87/lRL
         5yId8vz0Gd/BTp5XWbbmWva4pd3mUUxOYYX+czGj/ATajyS32Xg9YSdnXzWKN0OAga8n
         FFkxihmI//tgrZuHW2dFzPOKNyuxZZ9An+joe6N5L/NKvDGbJhZEIMcjSjZ7LHrsQgZs
         pLYfb2iBW11xa5HyyicMO96Ppfkdc7Xhu5cYsaOGIkbtKj+Cc/SQHxYPie9c+fho7mHT
         RfnQ==
X-Gm-Message-State: AOAM532YZcB39leTpmu8UJ7ZcGyLXTL9Ec0KzB96GSXw0Od0+UuRE45f
        CTPVnormoj2JFcGz0+u3ofsomQ==
X-Google-Smtp-Source: ABdhPJwX9m/KtjKAA/+SzyVBGo91thnSD/C7o9Qt3wssfmXp+di+H9MEh0o1WqvjA7v9uFmxgxaNPA==
X-Received: by 2002:a2e:9055:: with SMTP id n21mr4142030ljg.377.1611839393676;
        Thu, 28 Jan 2021 05:09:53 -0800 (PST)
Received: from localhost.localdomain (89-70-221-122.dynamic.chello.pl. [89.70.221.122])
        by smtp.gmail.com with ESMTPSA id m10sm1632458lfk.2.2021.01.28.05.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 05:09:52 -0800 (PST)
From:   Lukasz Majczak <lma@semihalf.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Tj <ml.linux@elloe.vision>, Dirk Gouders <dirk@gouders.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: [PATCH v2] tpm_tis: Add missing tpm_request/relinquish_locality calls
Date:   Thu, 28 Jan 2021 14:07:53 +0100
Message-Id: <20210128130753.1283534-1-lma@semihalf.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210123014247.989368-1-lma@semihalf.com>
References: <20210123014247.989368-1-lma@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a missing call to tpm_request_locality before the call to
the tpm_get_timeouts() and tpm_tis_probe_irq_single(). As the current
approach might work for tpm2, it fails for tpm1.x - in that case
call to tpm_get_timeouts() or tpm_tis_probe_irq_single()
without locality fails and in turn causes tpm_tis_core_init() to fail.
Tested on Samsung Chromebook Pro (Caroline).

Signed-off-by: Lukasz Majczak <lma@semihalf.com>
---
Jarkko, James, Guenter

I’m aware about the other thread, but it seems to be dead for a few months.
Here is the small patch as fixing this specific issue
would allow us to unblock the ChromeOs development. 
We want to upstream all of our patches,
so the ChromeOs will not diverge even more,
so I'm hoping this could be applied, if you see it neat enough.

Best regards,
Lukasz

v1 -> v2:
 - fixed typos
 - as there is no need to enable clock, switched to
   use only tpm_request/relinquish_locality calls
 - narrowed down boundaries of tpm_request/relinquish_locality calls
 
 drivers/char/tpm/tpm-chip.c      |  4 ++--
 drivers/char/tpm/tpm-interface.c | 11 +++++++++--
 drivers/char/tpm/tpm.h           |  2 ++
 drivers/char/tpm/tpm_tis_core.c  | 12 ++++++++++--
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ddaeceb7e109..5351963a4b19 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -32,7 +32,7 @@ struct class *tpm_class;
 struct class *tpmrm_class;
 dev_t tpm_devt;
 
-static int tpm_request_locality(struct tpm_chip *chip)
+int tpm_request_locality(struct tpm_chip *chip)
 {
 	int rc;
 
@@ -47,7 +47,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
 	return 0;
 }
 
-static void tpm_relinquish_locality(struct tpm_chip *chip)
+void tpm_relinquish_locality(struct tpm_chip *chip)
 {
 	int rc;
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1621ce818705..69309b2bea6a 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -243,8 +243,15 @@ int tpm_get_timeouts(struct tpm_chip *chip)
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		return tpm2_get_timeouts(chip);
-	else
-		return tpm1_get_timeouts(chip);
+	else {
+		ssize_t ret = tpm_request_locality(chip);
+
+		if (ret)
+			return ret;
+		ret = tpm1_get_timeouts(chip);
+		tpm_relinquish_locality(chip);
+		return ret;
+	}
 }
 EXPORT_SYMBOL_GPL(tpm_get_timeouts);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 947d1db0a5cc..8c13008437dd 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -193,6 +193,8 @@ static inline void tpm_msleep(unsigned int delay_msec)
 
 int tpm_chip_start(struct tpm_chip *chip);
 void tpm_chip_stop(struct tpm_chip *chip);
+int tpm_request_locality(struct tpm_chip *chip);
+void tpm_relinquish_locality(struct tpm_chip *chip);
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
 __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 void tpm_put_ops(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 92c51c6cfd1b..0ae675e8cf2f 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -754,9 +754,17 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		return tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
-	else
-		return tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
+	else {
+		ssize_t ret = tpm_request_locality(chip);
+
+		if (ret)
+			return ret;
+		ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
 				  0);
+		tpm_relinquish_locality(chip);
+		return ret;
+	}
+
 }
 
 /* Register the IRQ and issue a command that will cause an interrupt. If an
-- 
2.25.1

