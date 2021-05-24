Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B811C38F605
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhEXXES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhEXXEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:04:16 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FCBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 16:02:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so12138739pjt.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 16:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2K+WKJ3vpA7C2LrXa46ye/XLfQ+biwashr5kGLcnpCU=;
        b=MELTgWmpzqD9lOsl7drJGEJRLciWdPOY36Fo4QCKRx2mCR3+YD3DlcWi7QMhlBWvZM
         FPMT7PvnvfPkRqhY4/WoQ36vJ32BM01kAlw2NTtC2AgN5SDm5MMovCpvZkSL2BUpTYUN
         YEXnzuoaj4AukVd0H8J1brlvpNMVbfwP9C9I5EyLltRF2PbPPwI70j2uuOOR9t5Srhr2
         z1OCVv92coQxZONWM4Mkdounzx2VBE3k1v3fKVFXwEEfmqOtjnqh4WNdO4rO2DcE9NFX
         hf41uFr02wzPWa9jEGnckWop3UO21C5qqzHXGBqMHyY+kHdvKuyg56T3bTuS4wOZF22m
         f5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2K+WKJ3vpA7C2LrXa46ye/XLfQ+biwashr5kGLcnpCU=;
        b=MGLGFkIi93B4cyOennEOiNJxztBJ45DHd9CgVWtVGkra73rSCEugvLWI/WBjCHalOL
         DWhNj1Rm0QRf/+RaPOqUrFFiTdPTVTgepZO8ZZcqELPc6h9UqcoHe3OZh4/yx8vblIO3
         gHsvk4cSv1NpCK5pTvgtGU8Rkf+c6OG5JAulecNcnmozRDM6y//Uqt0rUjwygUuNsceb
         1Jl58dADiprVNxGyhOMztcFWDUBrIiSOxy7xpLIPSIkoIW3sfoTNjLcYbc5BZuLEsjDg
         GxeieVhGeyCta3hX+P+/vUamcyThIQNM3nrcSzZ+wpmkbfBZRmWQDBWHnxHxqYDKCWML
         lUvg==
X-Gm-Message-State: AOAM531mLaMnZADxF6Fci/M1/9cYSJIoKh/RaXH0nAfjX+MvMmrnEygP
        xMUmwuBJsWbPbvaObvch42g=
X-Google-Smtp-Source: ABdhPJw8R9sF5yLV2FIXby0UALzabV346p8ZMxuRP5PfCl5Km9s8E27RJCoRRRuaMtp76HWbPfW9kQ==
X-Received: by 2002:a17:902:e851:b029:f5:372b:a70e with SMTP id t17-20020a170902e851b02900f5372ba70emr27444265plg.70.1621897367234;
        Mon, 24 May 2021 16:02:47 -0700 (PDT)
Received: from nhaiderx-mobl1.gar.corp.intel.com ([2409:4063:2309:9691:60bf:7a61:5dc3:9ca1])
        by smtp.gmail.com with ESMTPSA id p23sm408970pja.12.2021.05.24.16.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 16:02:46 -0700 (PDT)
From:   nizamhaider786@gmail.com
To:     laforge@gnumonks.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nijam Haider <nizamhaider786@gmail.com>
Subject: [PATCH v2 2/2] char: pcmcia: cm4040_cs: Fix failure handling
Date:   Tue, 25 May 2021 04:32:35 +0530
Message-Id: <20210524230235.571-2-nizamhaider786@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20210524230235.571-1-nizamhaider786@gmail.com>
References: <20210524230235.571-1-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nijam Haider <nizamhaider786@gmail.com>

Handled failure cases of device_create()

Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
---
V1 -> V2: Added description and changelog
---
 drivers/char/pcmcia/cm4040_cs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index d5e43606339c..526198be91fa 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -558,6 +558,7 @@ static void reader_release(struct pcmcia_device *link)
 static int reader_probe(struct pcmcia_device *link)
 {
 	struct reader_dev *dev;
+	struct device *dev_ret;
 	int i, ret;
 
 	for (i = 0; i < CM_MAX_DEV; i++) {
@@ -593,8 +594,14 @@ static int reader_probe(struct pcmcia_device *link)
 		return ret;
 	}
 
-	device_create(cmx_class, NULL, MKDEV(major, i), NULL, "cmx%d", i);
-
+	dev_ret = device_create(cmx_class, NULL, MKDEV(major, i), NULL, "cmx%d", i);
+	if (IS_ERR(dev_ret)) {
+		dev_err(&link->dev, "device_create failed for %d\n", i);
+		reader_release(link);
+		dev_table[i] = NULL;
+		kfree(dev);
+		return -ENODEV;
+	}
 	return 0;
 }
 
-- 
2.7.4

