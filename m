Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E40C3F58F9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhHXH2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbhHXH2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:28:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C20C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:27:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v19so18169978lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eP/fzaCJf83R5w9CDsCe7nt2TiaRQKPHnE9dwKIQjLo=;
        b=TaY/dGFNh66ahf0u939KNhrEWvSqy+kTfCR5FtPemYu5CsIDh9EsyvyDMirGEd+Feh
         A9jGi5paDcg9YC8WGRbKhJTfMkMSy4knUPer6hNjegoMNBzoLs0OgadeWmj8b1s+tTNp
         kr26B4XpXhhbf0xajGkKVyW0qJkgzuh1GQyN61NqPcfHlq+rMMPN1i1zgcYlLd+EfgbQ
         nQWQA7+XCYLOgLQjVSKkVS37YXNvEHNnffPyJf8bsuap7wFKNFGpsCYmUglD2Sp+SS/5
         oc3pEGCovIFnIZHwcFW13VP9F4ADKxe3k11lW5gOA4X62pHpT9N2I1jRO3Jdgff1wfgo
         o+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eP/fzaCJf83R5w9CDsCe7nt2TiaRQKPHnE9dwKIQjLo=;
        b=cElWAKFc9YfmS+Hd/mrRtz6JynTN3Ze2ln/jCYeBS2I/ehvCUekTfW5Be0e/eVd3y/
         daGYm5rrHWMY2/w1Kr4EiQt+CD6Zje6OEi441KmgJ6l+BnhcLLRkviqTLb6D8SgM4P7Q
         OPqbWbl/FVTeobsFPibGBZYVhCIL1fNPrnzFWRf5n8xmePgk/IK0JiMmxkBE6BTTT9dl
         xSmUKaEEw6Se2g/o2OpsBLg8+25L1qJDhHA9QedNPLWXqI4xKz5mtoFPoDabgeB5PL3r
         4uwTezOv0vDH60blxavDpQtvafjDM/Uexqt2KhsGJtiAtNd77HzTS0ORHZ5rn2VaU0+9
         Aizw==
X-Gm-Message-State: AOAM533bU/VfUlu5asXFAkhRgj9/DcHvmRxZxj5i3jOQ3+oqKcLtcO/H
        9lpH5GIchUfPYh42axIqPuQ=
X-Google-Smtp-Source: ABdhPJwLQ68d1LIl+AbK49RoUxCf2VKbXG/iTsjl4UsgYEvDwhhLIlV1N2RMd+Hw+LogsZ3I5rtwjg==
X-Received: by 2002:a05:6512:ac3:: with SMTP id n3mr27759041lfu.583.1629790043067;
        Tue, 24 Aug 2021 00:27:23 -0700 (PDT)
Received: from localhost.localdomain ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id a22sm1672127lfl.259.2021.08.24.00.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:27:22 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v3 2/6] staging: r8188eu: add helper macro for printing registers
Date:   Tue, 24 Aug 2021 10:27:20 +0300
Message-Id: <84e388b0eaaf3c56f575216b0571318ed799a4d2.1629789580.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629789580.git.paskripkin@gmail.com>
References: <cover.1629789580.git.paskripkin@gmail.com>
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

