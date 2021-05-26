Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548C5391790
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhEZMl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:41:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56621 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhEZMlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:41:17 -0400
Received: from mail-vs1-f71.google.com ([209.85.217.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llsp6-00007i-Fy
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 12:39:44 +0000
Received: by mail-vs1-f71.google.com with SMTP id m15-20020a05610206cfb0290248aedd0e0dso182320vsg.16
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:39:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gN2u9zXldM21EHt67+sMR5HlACJwh4tvgZXmS6a8P94=;
        b=b5NR+eO/CoH3IAJy0b6uJDuuXdtqV856gtKrgXsctgkVK1eynq+CiIptV8v674SPUY
         SZbRYmIfW4Q0GZoL4CzBkRLEgWMeEStR4bqNTDuwt6Iy8K+mPOOd677uXuAWpzOZY6b4
         LymXiYJ3Ku+pATqlWd5VaE9J5ebGbu37NwfL/yqw/VJ3K2li7EBIgLOTCsYKKKUeuwKi
         B5+t7HKGqinsKcrtJgR3MB2PO/2MeV49ve4PKVW/3MZHCT4a4kj53gUp4H6sul0/tX6j
         JzCBxMuzRWipWeoI1X8ur9gtU95MYcdDHbygJD2Miae2x2kvxWYC1mAvWt10sDaMcDxq
         XT5A==
X-Gm-Message-State: AOAM533USKui21rq6XrY/NfKtjW2t7XTIOTLrF8zEueeXGt7GLuaSIwP
        5zNyWxGEAb3QvSrY9oUSehIKNbC0no69yoe+c4r99DEd+IJ/Cm/0ZoLDGiYWPtk5KtDmpiy21MO
        mMDOqcAKAjp0btSN8/LE5r6uoaEjkayUyWWM4vyGNzA==
X-Received: by 2002:ab0:5acf:: with SMTP id x15mr32137314uae.132.1622032783580;
        Wed, 26 May 2021 05:39:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/SfZLr/bmF5flVczWQ9oLy5YTXK6WvySQPDkCj5uV/aFtLdOjVhbvV6qeYmmthiflkK7Q7Q==
X-Received: by 2002:ab0:5acf:: with SMTP id x15mr32137298uae.132.1622032783424;
        Wed, 26 May 2021 05:39:43 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.4])
        by smtp.gmail.com with ESMTPSA id n77sm1693475vke.24.2021.05.26.05.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:39:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [RESEND PATCH] i2c: s3c2410: fix possible NULL pointer deref on read message after write
Date:   Wed, 26 May 2021 08:39:37 -0400
Message-Id: <20210526123937.22958-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt handler processes multiple message write requests one after
another, till the driver message queue is drained.  However if driver
encounters a read message without preceding START, it stops the I2C
transfer as it is an invalid condition for the controller.  At least the
comment describes a requirement "the controller forces us to send a new
START when we change direction".  This stop results in clearing the
message queue (i2c->msg = NULL).

The code however immediately jumped back to label "retry_write" which
dereferenced the "i2c->msg" making it a possible NULL pointer
dereference.

The Coverity analysis:
1. Condition !is_msgend(i2c), taking false branch.
   if (!is_msgend(i2c)) {

2. Condition !is_lastmsg(i2c), taking true branch.
   } else if (!is_lastmsg(i2c)) {

3. Condition i2c->msg->flags & 1, taking true branch.
   if (i2c->msg->flags & I2C_M_RD) {

4. write_zero_model: Passing i2c to s3c24xx_i2c_stop, which sets i2c->msg to NULL.
   s3c24xx_i2c_stop(i2c, -EINVAL);

5. Jumping to label retry_write.
   goto retry_write;

6. var_deref_model: Passing i2c to is_msgend, which dereferences null i2c->msg.
   if (!is_msgend(i2c)) {"

All previous calls to s3c24xx_i2c_stop() in this interrupt service
routine are followed by jumping to end of function (acknowledging
the interrupt and returning).  This seems a reasonable choice also here
since message buffer was entirely emptied.

Addresses-Coverity: Explicit null dereferenced
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Reason for resend - the patch did not get necessary testing however I
think it is correct, therefore resending without "RFT".
---
 drivers/i2c/busses/i2c-s3c2410.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index ab928613afba..4d82761e1585 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -480,7 +480,10 @@ static int i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 					 * forces us to send a new START
 					 * when we change direction
 					 */
+					dev_dbg(i2c->dev,
+						"missing START before write->read\n");
 					s3c24xx_i2c_stop(i2c, -EINVAL);
+					break;
 				}
 
 				goto retry_write;
-- 
2.27.0

