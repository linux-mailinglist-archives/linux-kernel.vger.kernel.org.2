Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C43320AE5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 15:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBUOFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 09:05:25 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:45126 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhBUOFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 09:05:22 -0500
Received: by mail-pl1-f175.google.com with SMTP id w18so2840697plc.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 06:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FJwLUK5Y+uvXnv0u3F+27KKfrXN2CvtQs9gB7otpFhU=;
        b=H1KIhyBIUPCBAj6V4mckrs5fAQBcXCYR6fj4FhasF3vsz+lg0J8j20w1s/K8oeGJw/
         zEhwjI7lL4M/sqqnA5BJ9gYnurhPmBxmugr9XyVm2A6A6GL28+TxrT9LXWxSBzSx85RB
         0ItxV1n+uPRwlYgHYHCnVjNMQtt5ZQ+m67xKogNyPiDamYoN7maliRJ5CjmJov+2aS55
         f2xrXTcHGcjEOZH3lviN8S0RGKkYceYR8JPVD/mNRUYgbIp1zHQWZHdkOUJepTtiqLng
         LsnmbDkdkTJZ94n4mxqnLnIQa/ErmJRh524zCcBD9FCVb7vvWhX3euuGcDHaG+R8zcgX
         9giA==
X-Gm-Message-State: AOAM532efk9CmRxa0jMEmgKNOIkWvcOZ/6q/0oVd0ZMT5fNJ74n2vKUj
        zXBVXiPXYU25ckgMJa7QCEQ=
X-Google-Smtp-Source: ABdhPJzM4qUUFeS6ZUr+JAN81oTo6QqGklFnV8wcN2n0WY95XUQcinTlFV5uAAmr3dDD7JS5aAoyVA==
X-Received: by 2002:a17:902:e551:b029:de:8dba:84a3 with SMTP id n17-20020a170902e551b02900de8dba84a3mr17649066plf.8.1613916281512;
        Sun, 21 Feb 2021 06:04:41 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.12])
        by smtp.gmail.com with ESMTPSA id j3sm14770700pgk.24.2021.02.21.06.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 06:04:41 -0800 (PST)
Date:   Sun, 21 Feb 2021 19:34:37 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: wimax/i2400m: convert __le32 type to host
 byte-order
Message-ID: <87f93e091f736cb422f1d557fa5a2ac752f057a8.1613915981.git.mail@karthek.com>
References: <cover.1613915981.git.mail@karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1613915981.git.mail@karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix sparse type warning by converting __le32 types
to host byte-order types before comparison

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

