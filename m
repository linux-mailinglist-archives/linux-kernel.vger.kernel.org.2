Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB072361DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhDPKaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDPKaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:30:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44105C061574;
        Fri, 16 Apr 2021 03:29:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i10so8089096lfe.11;
        Fri, 16 Apr 2021 03:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+WTwEnsnZdl0Xn6pZHhjD5+FhzVUFjaFGV4P9UC5Io=;
        b=gU/7d4rj3ccFeJAYLjQWUhJFldBn5Vim/dpg226TJc5qD+/hboUZvsG7BsVCI5bcHA
         h3LWmR8B1/NfB8DpKiz3GcPnBG+tAKZthn2gpVLdnc5LJxTSywpAHPGJI9ai/YpqLvSo
         fmIQ2bCPylp079maHG2qgqxozQyroMQkCALgxGX6j+TiXNtOljo7rMZSNlon+LE50CIJ
         HA6J37KpfC1a3QAFjpzMsdr1e7SpAyx3nYddxwv1Whp+AuM4nkYC96RSy8WMtEjW1tda
         4Jt/EgIMUUv/HGYL1O4nCpLGCuJ8aXGruX3lvCecbP3MDlirowlJSY6kKq1Pm0jfktL7
         HNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+WTwEnsnZdl0Xn6pZHhjD5+FhzVUFjaFGV4P9UC5Io=;
        b=VYr/YnTW2YkHn+4TZ5PTHhMz7ui0jKEgRaYA+GKJqg+DrFq4FWkPSs5zC5kep9nW1r
         rCjWrK89pp7wu02QMTFZK6YPGHNylFnh3D4yUcjkcQHKSq7XDtGHhQP8tNjWINBo4mHi
         y+JvdR8PgH1s/APrLOkmzYwH33WGTszzktcve6bzcUPdRnyqUKrIBWt3Qt6hraKgrKLy
         lV97es31z2mOtgN8je9Z0hege4BjoMSzvYETUoOrcTs5TZrgj0KHnonDUnEyuIsS1dOm
         QTvJDSCyxovq1tkLxg/uAsI1TjVThpibkGG4G/Drepw4QKy9gsDd7IK5PSzzj6QDL29I
         /LuQ==
X-Gm-Message-State: AOAM530fjErwvsmSSaj7f6ry32mviJqRWkrSW1C/K4d0EvXd9J39dYEQ
        5BzPrGGyLByGAQqEeC8r9v3CtDyEWuQ=
X-Google-Smtp-Source: ABdhPJyViVvAEZ+cE1s1imtQjOXoo0Dj/nMYskeLBWn/9e5xIEoNEgnbnwLqkNoWeUxrSIPvT8d/xQ==
X-Received: by 2002:ac2:442e:: with SMTP id w14mr2386463lfl.285.1618568988830;
        Fri, 16 Apr 2021 03:29:48 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id c27sm956173lfv.149.2021.04.16.03.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 03:29:48 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 13GATjFR013669;
        Fri, 16 Apr 2021 13:29:46 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 13GATiB2013668;
        Fri, 16 Apr 2021 13:29:44 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Paul Fertser <fercerpav@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: pmbus: pxe1610: don't bail out when not all pages are active
Date:   Fri, 16 Apr 2021 13:29:04 +0300
Message-Id: <20210416102926.13614-1-fercerpav@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <3612b78a-8e43-289b-ff0f-6c995995eeb0@roeck-us.net>
References: <3612b78a-8e43-289b-ff0f-6c995995eeb0@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain VRs might be configured to use only the first output channel and
so the mode for the second will be 0. Handle this gracefully.

Fixes: b9fa0a3acfd8 ("hwmon: (pmbus/core) Add support for vid mode detection per page bases")
Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---

Notes:
    Changes for v2:
      - Use more imperative style

 drivers/hwmon/pmbus/pxe1610.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwmon/pmbus/pxe1610.c b/drivers/hwmon/pmbus/pxe1610.c
index da27ce34ee3f..eb4a06003b7f 100644
--- a/drivers/hwmon/pmbus/pxe1610.c
+++ b/drivers/hwmon/pmbus/pxe1610.c
@@ -41,6 +41,15 @@ static int pxe1610_identify(struct i2c_client *client,
 				info->vrm_version[i] = vr13;
 				break;
 			default:
+				/*
+				 * If prior pages are available limit operation
+				 * to them
+				 */
+				if (i != 0) {
+					info->pages = i;
+					return 0;
+				}
+
 				return -ENODEV;
 			}
 		}
-- 
2.20.1

