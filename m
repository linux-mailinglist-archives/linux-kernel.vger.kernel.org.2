Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388AC35AE27
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhDJOV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhDJOVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE71C06138E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f8so9782389edd.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4fG4J1055h70nJZ2wPuBhZ3bQDllQogeXLUfm2yN0o=;
        b=Nbb/1vCd/ly1TkQo38k9kjQzi56QtrkS6z47cLcvIpeFaTQy5s9MKXMGcEuHOlnuuB
         kDtZZg5RF7/DJdoqoMaWZqC8o+0avgOrRmS0Lpa6tWPbVk4WbfNHZbgTJJhAK2iCriFX
         Jefe+4aGtwSW3XmAJnvuFbl2R74/FDFTGgN50oLPq9bF2IzT7ZGW4KgsIACretidj5A2
         3O7qLDbDbhtcKkHp6m3V5Y3EFa5IUvYtE/VBJo4MxbYJbYTLY+IC02s97oYNBb1p7cV6
         QmGQSOk7Pr1VsTBzSdbgQBYG2/8/LqLwj++SGukAWzxzo6UUJHnyMYuDD9qwidPD5JTn
         yGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4fG4J1055h70nJZ2wPuBhZ3bQDllQogeXLUfm2yN0o=;
        b=SEJLgSlKlGKGVKIz5Ua0on2ou21h1VbbI8H/WqtanuVufeD7IIdex9N1Blm4ysJP80
         3666Lcp8e1faOvWr/tYqzv2ievH1GmJUcE25I0+5FgSRjspIefi88YgEwaLUiw+W3ZuG
         ul0gpV06ovH6VyxPFMjW33PGFEI5VByYWYtKs0VFrcpcLG8TeJjVy9FzBl/nd0Ar5wKh
         kR5piFJobyT7dpamtjtUw9DeAXdifMJ1KxserAG8KLObPulR6E9XiLQ/ZeyRvjZoDFjR
         0Z39I1nDwjiLWIeH2YQCWMVZEeebr7MF7OEFRKs+nx+Ndhcsrd24S/JVOyYPFBP2FStc
         D79A==
X-Gm-Message-State: AOAM533TkG3VDf1Qp/VWGcn3C10Z7P1gHhvqQSJ2Rj5XQp1HfXgcijZF
        xSQi55M7yOMahSRckzPbOlNXJnd1mt7wcw==
X-Google-Smtp-Source: ABdhPJyafHRgytUD2sLVZxZmcsdlVpr8OdoWELhbkI0FyocHA/7RZW+8s+Q1Wjp61PcB2gUnKWLwPQ==
X-Received: by 2002:a05:6402:518c:: with SMTP id q12mr22284661edd.11.1618064458204;
        Sat, 10 Apr 2021 07:20:58 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id q19sm2710034ejy.50.2021.04.10.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:20:57 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/25] staging: rtl8723bs: remove commented out SDIO_DEBUG_IO symbol definition
Date:   Sat, 10 Apr 2021 16:20:24 +0200
Message-Id: <7a45b1419bcf4eb2abc25d661acae77018432e46.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented out SDIO_DEBUG_IO symbol definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index 24e45f734bdd..a8d8fe54fea8 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -10,9 +10,6 @@
 #include <rtw_debug.h>
 #include <rtl8723b_hal.h>
 
-/* define SDIO_DEBUG_IO 1 */
-
-
 /*  */
 /*  Description: */
 /*	The following mapping is for SDIO host local register space. */
-- 
2.20.1

