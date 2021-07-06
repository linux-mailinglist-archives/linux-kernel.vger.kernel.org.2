Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EFD3BC444
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 02:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhGFAFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 20:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhGFAFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 20:05:07 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D7DC061574;
        Mon,  5 Jul 2021 17:02:29 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w22so14287331pff.5;
        Mon, 05 Jul 2021 17:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95PtUIXWzpZKDW8NIcz9RQDC3InVaREqk384N+eGCSg=;
        b=CAKRy4pK/onTJRDkqpy70aIlAXg67EjOtE90zOsMudvEEtK32FlSFcniTgZX4LzxNs
         COagw7O69V1c2GjRI9rB1e+qN6WNvCgQ3H6h+Sb004uWHdPaEBPcuYRa0zLjMDjc1j+z
         J/rtv8lNmoCS9On85+iWWryxcPzLpOY+2vIK/UM+B3Cmf9L2uG6wGtDUzXDhGqo52q4N
         4trg4pIwyEJlLmlyHtHuYmJBCH1LJ96LNU6f5THRnYSeQ748NjuaSrIMf6Msbmsoym/7
         yfiWNrbhHhphUrz3vV2f6dppH1UJQUS4xCiTbeKHIYvFMiEmSgIVDft/9tbliUUrSBpq
         vFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95PtUIXWzpZKDW8NIcz9RQDC3InVaREqk384N+eGCSg=;
        b=hWcmdq0OYdN0aVYOYb7+f81s6Fk/STkbr0lXv6pAWMmmossjQPyciLgE54QMSZ4e3b
         wSYT12Vw6JA5pH9HYLSJvOVThRMAsyPDwQtXgFJ1KhF/Ig182VX3zU/AHuPasNBLehfd
         wiTc+HsV2GFqWg5upnXUUHsKrhBORWGdRTnajkSfsrZvOh//gSMx8bFa7y0bGfIkyVHF
         qTh5hE+vf5h6sHILPHKV+drqS0fdVqxXJTb0pzZNyj/8k44cZf9aZADcibKo8gjjP2L2
         h9pK/3nWxLeSFgFpUc/KwtEIzEGulWs2R26p1RQdXuNPgF+lh59tVyaeFnwv+xd9fn9v
         msMw==
X-Gm-Message-State: AOAM532FMDU1uOOy+m9rspb/pP6jAD+zDkAhw5nW4ZOiWamfZ2FXpTst
        7VYsDltPnqZbbycjYxznCm0=
X-Google-Smtp-Source: ABdhPJzP2I2P6bujLq9KL8pQ2NqJkviilk2O6Q110UXkmONegTAjnVy83CY/x8EmgDPuGymQJ2QFNw==
X-Received: by 2002:a05:6a00:1a4b:b029:315:77ff:b5c3 with SMTP id h11-20020a056a001a4bb029031577ffb5c3mr17564978pfv.21.1625529748760;
        Mon, 05 Jul 2021 17:02:28 -0700 (PDT)
Received: from localhost.lan (p1284205-ipngn14601marunouchi.tokyo.ocn.ne.jp. [153.205.193.205])
        by smtp.gmail.com with ESMTPSA id t5sm16704139pgb.58.2021.07.05.17.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 17:02:28 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id E63AC900904;
        Tue,  6 Jul 2021 00:02:25 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: [PATCH 1/3] mfd: da9063: Add HWMON dependencies
Date:   Tue,  6 Jul 2021 00:01:55 +0000
Message-Id: <1182ccb1b0bac9276967f4a11d971bd135c611f2.1625529219.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>

Dependencies required for DA9063 HWMON support.

Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>

Directly set da9063->t_offset.
Let MFD probe succeed even if DA9063_REG_T_OFFSET cannot be read.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
Originally submitted by Steve Twiss in 2014:
  https://marc.info/?l=linux-kernel&m=139560864709852&w=2

 drivers/mfd/da9063-core.c       | 8 ++++++++
 include/linux/mfd/da9063/core.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index df407c3afce3..14c2a8df9ae3 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -197,6 +197,14 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 		}
 	}
 
+	ret = regmap_read(da9063->regmap, DA9063_REG_T_OFFSET, &da9063->t_offset);
+	if (ret < 0) {
+		da9063->t_offset = 0;
+		dev_warn(da9063->dev,
+			 "Temperature trimming value cannot be read (defaulting to 0)\n");
+		ret = 0;
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index fa7a43f02f27..c0c57c6f6230 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -85,6 +85,9 @@ struct da9063 {
 	int		chip_irq;
 	unsigned int	irq_base;
 	struct regmap_irq_chip_data *regmap_irq;
+
+	/* Trimming */
+	int		t_offset;
 };
 
 int da9063_device_init(struct da9063 *da9063, unsigned int irq);
-- 
2.32.0

