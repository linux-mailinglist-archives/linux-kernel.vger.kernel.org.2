Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC7031DB58
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhBQOVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhBQOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:21:27 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC592C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 06:20:47 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id t11so8568021pgu.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 06:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tkR3nWvQ+KA65XhBWc3ZlKt+YgDPlZLa5MC3BGSdyyQ=;
        b=jvUwXMP/BUoo0aubC202imi3Ptt9jD+nY4BVmsw1Juq/TtwA1c+qv+Q4/3kHKTSUid
         PHfvQ4Y4KaMSXs3FbbBeJA6ehOfOYo8EeW0/2oWhn4i2STe6GjnvGBH6y6MIJnBvGvi2
         jrNqAeBeSKGkqjRBzkHHen8shwj1Z4J9eevXJEq09A5wzQ1bj6PAUnrbkI8pnbXeuTeq
         GxP12dbmuxxUWTtXUc9BGR2ohigN1UZVt98j+Ln0AsIj58lB5/DFtX5pl1OI7Dzc23hN
         9l0vW9vpEWwqG8bcYONAFN/6pvKke8gfTVJ3haUOTrYhiTBgawbXOznN0VekO1yPMTCZ
         Zcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tkR3nWvQ+KA65XhBWc3ZlKt+YgDPlZLa5MC3BGSdyyQ=;
        b=t2yVZE8K7C2Km0nPXPO2Biy6P/T9GkkGTNlyfkNYbDLGjXaDhdJA1Tkzao+t/KzDfw
         JIu5vvsprTeaunzKKWQyQEk4QcLY4CGsdGCNKxnvKQYAReE1vrTZCpreyNKmVGF4PzOS
         in3ZT4w6A/kf8k7vFOLmVcnI2ove9Ia8035AF9S8k2oEsmqCSMRNfdo72MU2wIgGb4bw
         CbscsQuFG+4HixJk7xhOHAZf9uprLcwDvmiHdpD/fP/qpZkQIJbwOKMSsmnoKsNny/z3
         OLasQrFjpefw7Zs3Qv9HCxLsaUXBwS2OJh/vpk7Z4hdpkKHb7uiM7RWDiBG5Za3WmYFY
         NIGQ==
X-Gm-Message-State: AOAM530SinuSRjQGynbNLcwcWLrjhnPvIjm23oGglpsCnXRkI/5rcmvv
        e/DYsSetwXa1j7ztAa7NGD4=
X-Google-Smtp-Source: ABdhPJwCqI/M4I79QFL+Lt06dPO+AT9Bsbu9mQ8wmy9KrLsNWG2u5Zz4kfkQCYP0Xu4xUJgf0sdq1A==
X-Received: by 2002:a63:9314:: with SMTP id b20mr23841434pge.411.1613571647606;
        Wed, 17 Feb 2021 06:20:47 -0800 (PST)
Received: from rayare.domain.name ([106.51.141.71])
        by smtp.googlemail.com with ESMTPSA id w196sm2704814pfd.23.2021.02.17.06.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 06:20:47 -0800 (PST)
From:   chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     chakravarthikulkarni2021@gmail.com, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ethan Edwards <ethancarteredwards@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: staging: comedi: Fixed side effects from macro definition.
Date:   Wed, 17 Feb 2021 19:50:05 +0530
Message-Id: <20210217142008.29699-1-chakravarthikulkarni2021@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script.

Signed-off-by: chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
---
 drivers/staging/comedi/comedi.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
index b5d00a006dbb..b2af6a88d389 100644
--- a/drivers/staging/comedi/comedi.h
+++ b/drivers/staging/comedi/comedi.h
@@ -1103,9 +1103,12 @@ enum ni_common_signal_names {
 
 /* *** END GLOBALLY-NAMED NI TERMINALS/SIGNALS *** */
 
-#define NI_USUAL_PFI_SELECT(x)	(((x) < 10) ? (0x1 + (x)) : (0xb + (x)))
-#define NI_USUAL_RTSI_SELECT(x)	(((x) < 7) ? (0xb + (x)) : 0x1b)
-
+#define NI_USUAL_PFI_SELECT(x) \
+	({ typeof(x) _x = x; \
+	 (((_x) < 10) ? (0x1 + (_x)) : (0xb + (_x))); })
+#define NI_USUAL_RTSI_SELECT(x)	\
+	({ typeof(x) _x = x; \
+	 (((_x) < 7) ? (0xb + (_x)) : 0x1b); })
 /*
  * mode bits for NI general-purpose counters, set with
  * INSN_CONFIG_SET_COUNTER_MODE
-- 
2.17.1

