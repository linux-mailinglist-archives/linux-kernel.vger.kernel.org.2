Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D24320575
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 13:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBTMxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 07:53:24 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:41767 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhBTMxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 07:53:18 -0500
Received: by mail-pl1-f172.google.com with SMTP id a9so4902126plh.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 04:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=I2x/1eBHyF4wxSC0+Ir6eONCS4VYMPs0yre9gwyu+Xo=;
        b=GZMKUKmlEiw7BeyBcMHvgBKsszBApOe4YHmJE5zInc6ihBRGFpy0GnTPri8FC8depc
         bEyJJgW7atlBazZSphA2ghklewT2OF9MrOgQEQTLD1EHUyuf4XkTiz74948YuWKyTZT9
         AH/Ihb5wOLEbGxNCo/TOyVimdBuE3qmztyrDk1jVYyegTTp7o9cIWQNfTse0ds0gJHD1
         2G+qzVXequ80tooKBctMXVTyan0YsrSwAssfvIB4n72xcj1dD/pHmCXk8ftK7nlcDBHk
         LVrB5Pt9O4PGRqCB7qmGtXFYFzdtzEXQSWA2WZXFLtR/bLVSAnIhRYOUrYW+ZbTpRj4P
         f35A==
X-Gm-Message-State: AOAM532Kf/uoHYHfwHudLamw8wbvzI9UA79LCgeLqSVlpOn2b/9J2Ym5
        dlyRd0Ra7RO0mfF2awgCF5rS4Y+GafEbbA==
X-Google-Smtp-Source: ABdhPJzAjU5pE8VJGJgJCT8/48g7vz75+OPdFzZb8QRXU51H4wAg3VgWIx1CATA+2OZymwJwbsTuJw==
X-Received: by 2002:a17:90a:5793:: with SMTP id g19mr14264823pji.32.1613825557024;
        Sat, 20 Feb 2021 04:52:37 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.84])
        by smtp.gmail.com with ESMTPSA id i15sm7826309pjl.54.2021.02.20.04.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 04:52:36 -0800 (PST)
Date:   Sat, 20 Feb 2021 18:22:31 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wimax/i2400m: fix byte-order type issue
Message-ID: <YDEGD7pFyTi+CTXy@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix sparse type warning by converting le32 types to
host byte-order types before comparison

Signed-off-by: karthik alapati <mail@karthek.com>
---
 drivers/staging/wimax/i2400m/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wimax/i2400m/fw.c b/drivers/staging/wimax/i2400m/fw.c
index 92ea5c101..f09de1810 100644
--- a/drivers/staging/wimax/i2400m/fw.c
+++ b/drivers/staging/wimax/i2400m/fw.c
@@ -511,7 +511,7 @@ ssize_t __i2400m_bm_ack_verify(struct i2400m *i2400m, int opcode,
 			opcode, i2400m_brh_get_response(ack));
 		goto error_ack_failed;
 	}
-	if (ack_size < ack->data_size + sizeof(*ack)) {
+	if (ack_size < le32_to_cpu(ack->data_size) + sizeof(*ack)) {
 		dev_err(dev, "boot-mode cmd %d: SW BUG "
 			"driver provided only %zu bytes for %zu bytes "
 			"of data\n", opcode, ack_size,
-- 
2.30.1

