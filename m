Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F223A7D78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFOLrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhFOLrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:47:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B247C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d7so2613080edx.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7jrpi+t4sVD1nYvrQmw+SBUyW0PXTVnWtUAU8H138ng=;
        b=FG53mXxub3xZBLj0vJOM1Ndtjrx1Hr8RSDgtXWMdP2zav657MXOBB06v/0bbfBX+zv
         BgzphCXrpJmZNu9i71RtsjLN8sQa1MTHtajSoHKGvMXHiVYhRe8UO30XiGswpxrcc9GJ
         ruljlLy5n/TlWdboufAxTQB3tRDU8H+sA3x5MiocLtfYDuS3VDmLb0WtJ0osCTUghMmL
         wB6fiiEEoyzfXTV+hNcP9kxqbQFU5yCa/DJ6tprN8l3lwYVxWhwhsQkMAwxVqYVvHr2f
         PDP9KM2+3tHR7/tx0xFQFWx+xakjZzoVAvofT/kh+E2YekLv1Vqcj4injPBfT6SLCZOF
         EIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7jrpi+t4sVD1nYvrQmw+SBUyW0PXTVnWtUAU8H138ng=;
        b=g2fm/lRZ6RZ9JzcKlEKB4erWGSYInHkHLTJDzs+y86MxVQ9We+UCXcMdxZ5H9KLVeN
         aFHBfBonxC9p726NI+U22+zYlfSBx4aRZiT5IKaKhq39GEHfE42gwdvwOOemtEhVBUHb
         2nP9JZho69dHhGpNvQk50vmxv+K/xDz2+gxTKgz6tqtqwEMz+EWr9N3kAyuElxNTLo21
         w9zdnfj2Oeg9288LGH6dbpnN/rkHWlaYEaVVvrh/K1Fh+Vd1ippCdACLb4Crv5ZL7j21
         q1OoUsyhMgPbaBq54xfS2pn4ynnaBUdTzTmG1f1emgoGUyfsyCOCp0G0fozzXbOzOkqp
         ODSQ==
X-Gm-Message-State: AOAM533rKiIsCbG5q5zD628J2hP71NXfmEnFKJZPw5L/m5Gekwt22z3Y
        UAwNCokbP9S8rZU1ALPBy8Ferm+v5+u1Lw==
X-Google-Smtp-Source: ABdhPJxK4PT9BOtXrU8Y9e5VHM1CGzwOmSRj37nkLhrzJkzNPPGpgptmWdiYoKMTzoDLUHAwUI9xpQ==
X-Received: by 2002:a05:6402:14d5:: with SMTP id f21mr23544838edx.307.1623757543071;
        Tue, 15 Jun 2021 04:45:43 -0700 (PDT)
Received: from agape ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id w17sm9952726ejk.112.2021.06.15.04.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:45:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] staging: rtl8723bs: remove unneeded comments
Date:   Tue, 15 Jun 2021 13:45:32 +0200
Message-Id: <4c1ea0e7ddceebba1afe1485662c204db5dfa9c7.1623756906.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1623756906.git.fabioaiuto83@gmail.com>
References: <cover.1623756906.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded comments in include/autoconf.h

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/autoconf.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/autoconf.h b/drivers/staging/rtl8723bs/include/autoconf.h
index aeb9479d1327..4b2cf86b8aa4 100644
--- a/drivers/staging/rtl8723bs/include/autoconf.h
+++ b/drivers/staging/rtl8723bs/include/autoconf.h
@@ -4,15 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-
-/*
- * Automatically generated C config: don't edit
- */
-
-/*
- * Functions Config
- */
-
 #ifndef CONFIG_WIRELESS_EXT
 #error CONFIG_WIRELESS_EXT needs to be enabled for this driver to work
 #endif
@@ -39,6 +30,3 @@
  * Platform dependent
  */
 #define WAKEUP_GPIO_IDX	12	/* WIFI Chip Side */
-
-/* define DBG_XMIT_BUF */
-/* define DBG_XMIT_BUF_EXT */
-- 
2.20.1

