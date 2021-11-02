Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461D8442927
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhKBIPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKBIPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:15:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0CCC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:13:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g11so7428608pfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 01:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=6BWDcbdqy5JG3JwyFHsYETyMufKhQtLqc84w/fEE4Y4=;
        b=GwV1jui6Nkkqsy06UF83v23ARLTHNbSyfAFmH/gOcYu29UO1Y7B+qMHEwEPnU1PbX/
         zqcPq+L1TxCu6oUSwIQ+nftz5Snj0xXO+E/zIiPMIiz2Yo60N+kZ5NS8peaa3RhAyyr5
         W2rF9k/ymjfAc2XbL+dE2zXM7ZGGZWzq9oJnxlCFlqwOljnwNSG7XwYCENmSANYja62v
         TXWP+pfOIuB5JkvB6+IRY3fAF0JDWUJ+HFSSX+TOu1ovpeqFIn1UV46uhqRnmGvE7UPT
         O5nj7ARix335JIZaO3yqbXHOMlZi7a2syEvH7icJounOtfOTazMsAclv83hOMlgmAAG8
         crrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=6BWDcbdqy5JG3JwyFHsYETyMufKhQtLqc84w/fEE4Y4=;
        b=j7uvcCH1fYh5qBzzXTjBrnko7m2vbsVVaEfBedW78DBjgStLa7LRiYM9RgFS6ZEkIA
         G9hKRomTl6jlrI3iz+N1Zm9ff0ndmVTd29i7/RCbjsNX3EHZTw9eokJNnX9caFSopGxN
         Z2/6UL69g4bwvwCAbRPyug72kfiSEpIQdW+MyV9Caxcq4fF4ebcbUHKw77ghQA1awKUD
         bIrkkuNuW1cYp8ASwZOhkBXRSny7hnTKacwlELvEkg8OeUWxJwoJ2WDGRRUe2YInQGoK
         ZsL7h1gysTetk8j+ASvL3CaQkb2LjjaMcL1213zje5lDeOoIGGGGvrgNXG0qGEzmbcjl
         XcEw==
X-Gm-Message-State: AOAM5336M1jWXXWd3Zu/tLZW9lC8FW7uNALl74P1ov3ZY7zeQ91rANr0
        SrinQEPQ2YqR8cUZayUsbu0=
X-Google-Smtp-Source: ABdhPJwYCo0cMv9SqRxKPalxKe8bMUf5UMYhaqsKJSCxxkXC7SRQIRjcC7tf2/BMObIqn5jyZjpizA==
X-Received: by 2002:a63:b002:: with SMTP id h2mr26316295pgf.464.1635840794991;
        Tue, 02 Nov 2021 01:13:14 -0700 (PDT)
Received: from surfacebook2-fedora.ncku.edu.tw ([140.116.1.141])
        by smtp.gmail.com with ESMTPSA id b13sm1762097pjl.15.2021.11.02.01.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 01:13:14 -0700 (PDT)
Message-ID: <6180f31a.1c69fb81.7f7e.541c@mx.google.com>
X-Google-Original-Message-ID: <20211102081259.55598-1-Hoshinomori-Owari>
From:   hoshinomorimorimo@gmail.com
X-Google-Original-From: Hoshinomori-Owari
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Hoshinomori-Owari <hoshinomorimorimo@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Remove redundant indentation
Date:   Tue,  2 Nov 2021 16:12:59 +0800
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoshinomori-Owari <hoshinomorimorimo@gmail.com>

Remove redundant indentation in
drivers/staging/rtl8723bs/core/rtw_ap.c:1139.
Issue found by checkpatch.pl

Signed-off-by: Hoshinomori-Owari <hoshinomorimorimo@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index a76e81330756..4345dca1b552 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -1137,7 +1137,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		}
 
 		if ((p == NULL) || (ie_len == 0))
-				break;
+			break;
 	}
 
 	/* wmm */
-- 
2.31.1

