Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09248394117
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhE1Kk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbhE1KkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:40:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A140C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:38:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jt22so4637514ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/SoT+1SWGTsxMqTiV2xoAlXSkh7qhcMepCQ/DP40UY=;
        b=HC3PSx0gMRIJ1vyroJY8aSH8wkXeIkCxUBwG40bfIoKA5TporB1fTMXQ6Jo2/QwCs5
         tQ0d6pm5XH9t7U8Mk/TnL4bcuZFRhXLHdOjYwjJfWCwhYCKUw8alsT9xRwEGZZ3X6J0O
         XzcxTlc2C8dZk1Lf+18M3mmQZtjsRYrtv7Y6V0IQblGh5hScp8VLoaYAcyg8mzo5Q4Z6
         Q+w/bjama9XLPXP5+dg8uNvUiM0xayJuGZki48AqzgD7I7q7mJDosbdHdfubyp9qtlKS
         I+nxgwK/8DTnYsYO+D3WHejEz51aPNbIvC4tRPoTu8m11zx4bEXvGwbWIyM0QLJu8eZp
         05ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/SoT+1SWGTsxMqTiV2xoAlXSkh7qhcMepCQ/DP40UY=;
        b=qL8ERIkIquIdbq+i9999fQD3ItayCJdQSpKt4J2xz9tkcYVAeFvu/z28hcIlb5gE6C
         gePyWWxuHNayqZadzZjKtYMAXM9Nv4csan7+xg30TSfuZspS/RlhPzPzzGvNlhCZfWs9
         6bY0v/RsIYkwwOqq1fso5phWN47TfuiLhWQd+aCQb+UVeobS1af8sDo6xKonBfF3G87o
         h+OPO44KiK/Bab9q91w41Kmx5WZBGnsE+AT62E+20Hskxxgp9keoemAOR9a7Zf2YNTWJ
         ihaTWnY/MDGeC8GDUAMZIrL0UUbucuTk2qjx0amCRAMqjIF6uFd+WqZVpv2YeM0oAPR9
         hk9w==
X-Gm-Message-State: AOAM532OwJ9QAd1/nBvX5GsIG2qtxyMJMSBADMoZ20+ik/ZLsUSh7vvG
        W+wf/v8sVLEUHJfc5u7kFkLcVA==
X-Google-Smtp-Source: ABdhPJzzlw1vrY/6KZz4b5DnJHsFLDoqZ1+bjpyJiKN6yb0U3K7Ib8TAkhF/J3bs5VLGkDV+s3VoSQ==
X-Received: by 2002:a17:906:a451:: with SMTP id cb17mr8507930ejb.510.1622198319086;
        Fri, 28 May 2021 03:38:39 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-158.xnet.hr. [88.207.97.158])
        by smtp.googlemail.com with ESMTPSA id jw9sm2192446ejb.77.2021.05.28.03.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 03:38:38 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Jonathan.Cameron@huawei.com,
        alexandre.belloni@bootlin.com, sst@poczta.fm, krzk@kernel.org,
        alexandru.ardelean@analog.com, devicetree@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 3/3] MAINTAINERS: Add Delta DPS920AB PSU driver
Date:   Fri, 28 May 2021 12:38:28 +0200
Message-Id: <20210528103828.53320-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528103828.53320-1-robert.marko@sartura.hr>
References: <20210528103828.53320-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers entry for the Delta DPS920AB PSU driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Drop YAML bindings

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3c3e2177349d..d12cac63689e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5103,6 +5103,13 @@ F:	Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
 F:	Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
 F:	drivers/gpio/gpio-tn48m.c
 
+DELTA DPS920AB PSU DRIVER
+M:	Robert Marko <robert.marko@sartura.hr>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/dps920ab.rst
+F:	drivers/hwmon/pmbus/dps920ab.c
+
 DENALI NAND DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.31.1

