Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636CE33A922
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 01:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhCOArT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 20:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCOAq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 20:46:58 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4820C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 17:46:58 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id t16so6302916ott.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 17:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyZ6O3YiaYxzFmZQxJKT3OMafYwYaK1e74woeq3EBtc=;
        b=nMXk4Ve5Bz8QwKAwVDxcLjrze0dXxceif1jDO2cmG8P/Y6Z9rqoh5mNhyGr1iuX/9K
         MLoy9uOC73DMMUFqdz+0PqIAO7vHAGTxfANAJyToGA0pED72knryJ6meypJit1Yv+1Os
         QHo3FVJvRcufiWu7b8dsfo8L3MlZEOz0d98/Hb4kxqvmHMvP5JGfu1TpNVUIYaTDWpl+
         RoRRo+fUmkInjOTgo9BMdePSM5B0On4YaN0Q97TVEaqVUwjqPMXWUsfkMA27ObxfBj6Q
         7ru63BVVXaQ2NTbaG56zQouIg1a2fXsCp3lLSe0xc3M708C5Xn6qQDURU/ANAfgAqlot
         qQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vyZ6O3YiaYxzFmZQxJKT3OMafYwYaK1e74woeq3EBtc=;
        b=LrZCehPmBbtjmK6lTKA+m+HQguJ8ztXIQpUze4mV1PiVhXZXuJ2uaVkkJVjKm+j4jB
         n439DGhqSNU0hMQMjlS+ITZccF1ztbuP+q9B4FjBsLV53566VLWLFskNvLQaZWHGLHE4
         EO/9n+TYsdbJtC+mPTzWD/kq3uEzfM10fETe/itBiKZDy4MRvQ49gRQPDchxIT2cQax/
         vME5PNidGaMRMsgDFX9NpcAhcHj3jW5DIIFWy4ZYxUb/QJUE4ING3dFLyGuCyvsuNAjs
         A9PEh1QEPaz8EUdBuZixchR/tNirORDfiRIPTfCSxPLX89HydNZDJpd9RlyFVqpA5diz
         gjEQ==
X-Gm-Message-State: AOAM530hKdAZ40WCtruNUVbvX6KxKVvl23fP2+1PJet4QOLxZLYXouJz
        +XYRCzqrhWyT1fdIjlQIbm4=
X-Google-Smtp-Source: ABdhPJw0TxDavpLAYcvq4zJCbpxjxmJNmx0hCxtyvdbtZwA6xrGQxUYOqM0vrbzHRjgUqRxhJyS1ow==
X-Received: by 2002:a9d:760a:: with SMTP id k10mr12205341otl.23.1615769217941;
        Sun, 14 Mar 2021 17:46:57 -0700 (PDT)
Received: from madhuleo.lan (cpe-24-27-52-237.austin.res.rr.com. [24.27.52.237])
        by smtp.googlemail.com with ESMTPSA id p67sm5955294oih.21.2021.03.14.17.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 17:46:57 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        sbrivio@redhat.com, briana.oursler@gmail.com, rapiz@foxmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH v2] staging: vt6655: Rename two dimensional array declaration
Date:   Sun, 14 Mar 2021 19:46:41 -0500
Message-Id: <20210315004641.378933-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename two dimensional array declaration to fix checkpatch warning: Avoid
Camelcase and make the declaration more readable and understandable

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
Changes in v2: Improve commit message
---
 drivers/staging/vt6655/baseband.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 1aa675241599..d89163299172 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -52,7 +52,7 @@
 /*---------------------  Static Variables  --------------------------*/
 
 #define CB_VT3253_INIT_FOR_RFMD 446
-static const unsigned char byVT3253InitTab_RFMD[CB_VT3253_INIT_FOR_RFMD][2] = {
+static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] = {
 	{0x00, 0x30},
 	{0x01, 0x00},
 	{0x02, 0x00},
@@ -2002,8 +2002,8 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		if (by_local_id <= REV_ID_VT3253_A1) {
 			for (ii = 0; ii < CB_VT3253_INIT_FOR_RFMD; ii++)
 				result &= bb_write_embedded(priv,
-					byVT3253InitTab_RFMD[ii][0],
-					byVT3253InitTab_RFMD[ii][1]);
+					by_vt3253_init_tab_rfmd[ii][0],
+					by_vt3253_init_tab_rfmd[ii][1]);
 
 		} else {
 			for (ii = 0; ii < CB_VT3253B0_INIT_FOR_RFMD; ii++)
-- 
2.25.1

