Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE0140AD43
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhINMPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhINMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:15:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC7AC061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:14:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t8so14803000wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSOSsriq+ikZA4mrzrbiyfyFu2Bj3tXb4d5edmqNKB4=;
        b=q70A9tlWOBPLy1DiAfiSONQK7Sw1+AW/aaL4siomehOjHGn0VgZkP/qoGVyBhPYldj
         fHE1wChINyLhDfdIKrtuLCnvTwEoJvK6t+GCGu7IH+kxNMLB0R3cshL2DKevdWbgf86C
         c6piviBnczb+GDkuAM35WaOZKoBqNhhwbsPB2y+/a42dODfV0tEqXAixp4sDhJ5qKhXO
         aW7MKYiv8aPUOhKzi2w3FoxzFLi31dvMLhfwpNbMzfIHl/Esm0G2/UZtAA/AeO6P0nH9
         wmnvOhrPnyw8r7x9YULJ/w0Wkm1XtjdxuvOgBtyrZPuR68e1uqYEMFDZ0KdBoCHuhaIT
         BmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSOSsriq+ikZA4mrzrbiyfyFu2Bj3tXb4d5edmqNKB4=;
        b=r/u8VD2d7Bnn92ewkAm8LTaW2KCiFIz5y1HxmMQkrOjrG2QgtO3vO5Jix1F58j8wq7
         ZRPBMbXknP2sQ1T9ZBhUSMTIsMBFDJxdNsvrO9nvQCH0JleX90gGuOvYsNzsKkY6rRT7
         d52/wJNS9bx1Z5Uo8qMaQFdwOTgaf8mEIEwvhpjuSKTqNiyKpKyW7p8aNujuNhkASgmk
         /2s8ZJsPfwQHbt/x3+FrohGdW5UVNMbqAfWHWpPHPCJRTQBgljJhrSUTVSlw5Rh5I1+p
         vg0J90ta3etcEdJT/TAQR6CFUl8m0CiKlSAmoPY9rHqrcO1geVPTvtlxXoBmBbcVndjZ
         /efw==
X-Gm-Message-State: AOAM532aGGLe17uZaDdD4W0iqs95urN/YloMNBYz9tqrPNlTHAythnS0
        mxiPgMecqHWsslXZyu5biyg=
X-Google-Smtp-Source: ABdhPJwr9vRCEnsCKAXJFzsbqAbtHD1/njk0Rbl4uW+ULWc/VzV7RFguKM6ix7w3Oi+nvsbMes1hsA==
X-Received: by 2002:adf:e810:: with SMTP id o16mr14205084wrm.219.1631621645909;
        Tue, 14 Sep 2021 05:14:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id j19sm10028100wra.92.2021.09.14.05.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:14:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: r8188eu: remove unused field from struct hal_data_8188e
Date:   Tue, 14 Sep 2021 14:13:52 +0200
Message-Id: <20210914121352.26052-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914121352.26052-1-straube.linux@gmail.com>
References: <20210914121352.26052-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Field BluetoothCoexist of struct hal_data_8188e is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 17913dcc9fbe..e7e7064dd356 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -289,7 +289,6 @@ struct hal_data_8188e {
 	u8	CrystalCap;
 	u32	AntennaTxPath;			/*  Antenna path Tx */
 	u32	AntennaRxPath;			/*  Antenna path Rx */
-	u8	BluetoothCoexist;
 	u8	ExternalPA;
 
 	u8	bLedOpenDrain; /* Open-drain support for controlling the LED.*/
-- 
2.33.0

