Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25553F3FC9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhHVOgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 10:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbhHVOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 10:36:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DAFC061757
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:35:44 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s3so26364833ljp.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eP/fzaCJf83R5w9CDsCe7nt2TiaRQKPHnE9dwKIQjLo=;
        b=gqb6BIVO+Td/48zr8iVCss+idcNfZQjpHS4sUQk28yZPnfprPYY9OhyoXENORpwvcU
         HT8xD81CfQCdRZGlUDu0BOcOo9fCZCu7t0p2cfuh8V/AdwbMJCVhqf4M3eZM2NkQfAMy
         HmaPuTyy7p5Y44zTgRQ0zg/oasr+YS/UnC77SZeB5jp35u5nKTcqX4G7nfNkww2WOFOf
         8X6+kipIxJicPizjWnKEU2rSmTDYETAyV0LcWnB2IFqz62de5EmhqTebyKmDsTDCXMHN
         0RX7v6EwMEuBKQka8cFpKAlBSdiVjdD10AQ3kBJb3tUhXUbA7eOF/FwqiuiUJ5Wr2UJZ
         rVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eP/fzaCJf83R5w9CDsCe7nt2TiaRQKPHnE9dwKIQjLo=;
        b=P4P9gSDRYepkSTyMy3wtNwhULJ0c0T3ski+Tgu/ZwYJ2eim1lXXu7X5AAJHd+jBYMW
         Rm44B0Fu+JSqvqRTET5/hzoUIrNouTzjLJk86ix3oSNm8I3iN3bELZuoAxFYyc0wics9
         8TzUQLZiRLdH4f0beVz7TbCElNyGFbmkWg0w8Cr1RnlOp5Mptm4A7EvqwOSAMXHXZYoI
         AG1n4KEFiZ5XOIB6E+irE0JDW00/HxEFFzu0R4w9GKbcpWUAT6uAf8XR6v2U/QD3SLlh
         d7sxIRBZ0X59PkzSqiTVrWcyIJmE7eki+1GJwu3zBtVpgXchQkVt6veEG5UQTUClQAsq
         ortg==
X-Gm-Message-State: AOAM531+9ZE1U0WSS5bbHRrgRtItEmgX79u18beEk0RHvGmdkdzZTd2p
        Kdqciqt3bDn3QN7nU9fnI+M=
X-Google-Smtp-Source: ABdhPJyfp4MxhDarGVbzJswfS9l5IidvhlkpJb8VDlZlSigNCiyKALeaMfT9wjbVYlH2T5nvh4nujA==
X-Received: by 2002:a05:651c:509:: with SMTP id o9mr22787653ljp.449.1629642942919;
        Sun, 22 Aug 2021 07:35:42 -0700 (PDT)
Received: from localhost.localdomain ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id y4sm1207899lfl.38.2021.08.22.07.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 07:35:42 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH RFC v2 2/6] staging: r8188eu: add helper macro for printing registers
Date:   Sun, 22 Aug 2021 17:35:41 +0300
Message-Id: <84e388b0eaaf3c56f575216b0571318ed799a4d2.1629642658.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629642658.git.paskripkin@gmail.com>
References: <cover.1629642658.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a lof of places, where DBG_88E() is used to print register
value. Since following patches change _rtw_read*() family
prototypes, we can wrap printing registers into useful macro to avoid
open-coding error checking like this:

	u32 tmp;
	if (!rtw_read(&tmp))
		DBG("reg = %d\n", tmp);

So, added DBG_88E_REG{8,16,32} macros for printing register values.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_debug.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
index 3c3bf2a4f30e..059647b9cd3a 100644
--- a/drivers/staging/r8188eu/include/rtw_debug.h
+++ b/drivers/staging/r8188eu/include/rtw_debug.h
@@ -72,6 +72,19 @@ extern u32 GlobalDebugLevel;
 			pr_info(DRIVER_PREFIX __VA_ARGS__);			\
 	} while (0)
 
+#define __DBG_88E_REG(fmt, adap, reg, size)				\
+	do {								\
+		u##size __tmp__;					\
+		if (rtw_read##size((adap), (reg), &__tmp__))		\
+			break;						\
+		if (_drv_err_ <= GlobalDebugLevel)			\
+			pr_info(DRIVER_PREFIX fmt, __tmp__);		\
+	} while (0)
+
+#define DBG_88E_REG8(fmt, adap, reg)	__DBG_88E_REG(fmt, adap, reg, 8)
+#define DBG_88E_REG16(fmt, adap, reg)	__DBG_88E_REG(fmt, adap, reg, 16)
+#define DBG_88E_REG32(fmt, adap, reg)	__DBG_88E_REG(fmt, adap, reg, 32)
+
 int proc_get_drv_version(char *page, char **start,
 			 off_t offset, int count,
 			 int *eof, void *data);
-- 
2.32.0

