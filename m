Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEAE3AA3F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhFPTLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhFPTLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:11:35 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B98EC061574;
        Wed, 16 Jun 2021 12:09:29 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id n17so5360951ljg.2;
        Wed, 16 Jun 2021 12:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qP0j6DhiUJIr/VXjNb28HuyGZ1YtPyQsbTbi/lJTwQs=;
        b=l/qBch27c62h4HHWiBlWC7/jJQU1idyXByXYYcrkPzcb8PyGzB5g6C7Zu6O3epPIVz
         SqvEe61LscB3tREgPgn9JttwDeY7Q30CDvFkugD/79ZU+w07FloRl/WC9gWC7F5P13ES
         SIouCMKh3UW9q8KBxoU1PL+e/pGVn0DwpXbXHw1a/soUawYae0eirijF7VKGT6xHKUkZ
         g5f34ehZIGHbcAheYWWBtxEKY9yl+sP0cOlg8RVLjtwrScgnI4ddBAVN9G2dRpRgPh6i
         C+KAnO4oTpLo5YziVTvirhVEplNQhWAV/4eF59iQflHtydE0Jg8nyE2zISU0IWFA0eW3
         QPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qP0j6DhiUJIr/VXjNb28HuyGZ1YtPyQsbTbi/lJTwQs=;
        b=FYf5thrCoemN/xDiVM9a6xI4JRTD3JMaRnTuu3VI9tPiG//tWQE1jBILl8M2nwBFWg
         a07exKLSRSssMd4RjlAW404cO0iP3dmB/qxWryi0E6tlMspgAvOeiMkAYIdff6pmANNX
         whWsSoiVAJe24jRSpcU5EkcBIabdSqmwhBiY7htgxM/lTJLn/rVRwR+aUKxhw9YW0ZdI
         /kuNfI7/HhTQ5dDVOjnHFaap37m/298hGy6y4PuHZdUZzyuttiHa7PDzFtw4XjpHEweU
         67LGAGAEz6MM6nLv2SYPJO3BzosgZCEBilMLpN2hOcHWRZv2jHRJuIetB7zj+EywEBS9
         nCcQ==
X-Gm-Message-State: AOAM5338wyE1yLbjunDUpvpAw6WxPsr57oLxkyd3+8rc/E60scll2aiQ
        VT3Gd492CmzbF6yMnusJqrk=
X-Google-Smtp-Source: ABdhPJwEM8TpfK6uV5py9JzlJH8sHbzPoVRWVf6/qmmbJ5mKZ88TEgg2UYn9UHtzFZN53SwQU/RQUQ==
X-Received: by 2002:a2e:a7c4:: with SMTP id x4mr1196810ljp.420.1623870567633;
        Wed, 16 Jun 2021 12:09:27 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id 9sm333126lfy.41.2021.06.16.12.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:09:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v1] hwmon: (lm90) Use edge-triggered interrupt
Date:   Wed, 16 Jun 2021 22:07:08 +0300
Message-Id: <20210616190708.1220-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LM90 driver uses level-based interrupt triggering. The interrupt
handler prints a warning message about the breached temperature and
quits. There is no way to stop interrupt from re-triggering since it's
level-based, thus thousands of warning messages are printed per second
once interrupt is triggered. Use edge-triggered interrupt in order to
fix this trouble.

Fixes: 109b1283fb532 ("hwmon: (lm90) Add support to handle IRQ")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/hwmon/lm90.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index ebbfd5f352c0..ce8ebe60fcdc 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1908,7 +1908,7 @@ static int lm90_probe(struct i2c_client *client)
 		dev_dbg(dev, "IRQ: %d\n", client->irq);
 		err = devm_request_threaded_irq(dev, client->irq,
 						NULL, lm90_irq_thread,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 						"lm90", client);
 		if (err < 0) {
 			dev_err(dev, "cannot request IRQ %d\n", client->irq);
-- 
2.30.2

