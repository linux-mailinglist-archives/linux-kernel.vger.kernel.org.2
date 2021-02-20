Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F3D320571
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 13:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhBTMvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 07:51:11 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:52018 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTMvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 07:51:08 -0500
Received: by mail-pj1-f44.google.com with SMTP id gm18so527851pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 04:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=P7iI9/EJrbgUCd/aOy3wmx9rsH4xpDQgbuaNBtBhFZo=;
        b=tvz+fwT9m92ff6YaC7mjnp0dlJAyMhN429iOQPVY0lvYWvFdklhIsTRS8zxE6HGY0u
         2R0ZXuI9nA/LiC9eCqDpdoCfbRzr4Q0FjBDsotv98Ui+K1Rh1z1DGir87JL4uOUOmrmk
         HyXGvuHPeYwiZ28tVfdBHQwrud/m1jqFJbvzt8cdUB9FM/k1Q4njQERhEcgaIxBRvWIs
         XhJKzzdJNHqpmcDsueVckCGMGhDM7aii88eaHgPxudcvVCTAILGM3W7/gM7bR67TZdtt
         CFZTbgUF+DMs5gX3jxzpAJQNOZSWPQDvGHfq4zy6oUVKb7SOV4xHY++TTcMkZauFtmjL
         cyUg==
X-Gm-Message-State: AOAM531fl45Rv8t0OmaEdrQNfYI9s+xjJ9QYEnlb8plXsxSfEe8MXxKx
        Ke28uW3rLPVOAqagI4VDFjs=
X-Google-Smtp-Source: ABdhPJxRWBdRrr3yKro3940h7u3PwT/qpbTupiSCdfC6zm4CKg2jXJR9Wi0+swVHEGynInqgKNEbAw==
X-Received: by 2002:a17:90a:5d8a:: with SMTP id t10mr13575016pji.144.1613825427737;
        Sat, 20 Feb 2021 04:50:27 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.84])
        by smtp.gmail.com with ESMTPSA id m16sm13248646pfd.203.2021.02.20.04.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 04:50:27 -0800 (PST)
Date:   Sat, 20 Feb 2021 18:20:22 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wimax/i2400m: fix byte-order type issue
Message-ID: <YDEFjrFvEEQ3XEef@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix sparse type warning by converting le32 types to
host byte-order types before comparison

Signed-off-by: karthek <mail@karthek.com>
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

