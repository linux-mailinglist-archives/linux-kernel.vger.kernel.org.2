Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE7133A615
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhCNQ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 12:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhCNQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 12:29:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20436C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 09:29:03 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y67so5119123pfb.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hydLbPF22FI/ZF8uslyDviDv0PrF8iR8m5/0Mq6/P6M=;
        b=FCuJtbzWMCWrvSWLvY75rmop6z2gMBBiyLSJf/cqIBQy+Gprqxw1pXtRNm1xtRzd8S
         ALAH7Y9MzZshLWhNUjcTw5uUulVl2kpGwQubQgGvQGuIulJ3Em4UwjApoQGsqzfkLEyL
         qELMwExn+qs8KGNRXcOT/KlIoXXbOWhNmSftnbWvSP0QwvIJMM0bi/uY8PbdRcwJ6WEn
         n9muf/dKbenmXgIzVCnD3P2CJwI0ET2t9TRDBGXGEwwOy6Ads7/BYJ1Lp10ObFlJrkhZ
         3ELBfehttkizJYYOOSx8xIV2QMpjmtppV07VfhkHiyw9wK383eeccWr7qxXi8ru/IrDB
         ZtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hydLbPF22FI/ZF8uslyDviDv0PrF8iR8m5/0Mq6/P6M=;
        b=N3umABnAV/93XScq6SefjbezjBRSFORMm6l+Rskclf1Y4OGtpus5LY6uIjbxNHazxa
         7LemqBOzgGoMyTV3Inb0U6WGSbI0UzrxPWIUeuL4U67gGzldff4QO8JdTLgcWyWsXgBF
         orsfsxfCffG9tQTEc/Qy1KhD2UkMbJR5BGlcOhbiDnzxBkYISaTaIZIViuh9guziaqAY
         Pr6VuxzzN0xJsrrqcpg6yzOJ4u2ia/bEqLqgd4EU3qXiYUfk5emG61ly8gXoY88+g/aQ
         RcgpOoq3lMYuZamCZz6Y0YdU6ctEH4MIMG7cqQ/u6H35XhOccvBPTCYPw2CPE8Kir7er
         Kptw==
X-Gm-Message-State: AOAM532mCoRUfLAun1giVb9Z5hVu/u8P2UOW7x86g+Fw2gFu0JNzQVNY
        x+i8O3+4sOK0Tsc3QKoI8XCXkNQmwR9ThA==
X-Google-Smtp-Source: ABdhPJxEG+4j7++O5YaLFVtrTxJ29LHCevC3P3na5ul5UAEWrhQzSAkwL8emWLa7hbM/EwNrZ//SZA==
X-Received: by 2002:a63:f311:: with SMTP id l17mr20241828pgh.349.1615739342736;
        Sun, 14 Mar 2021 09:29:02 -0700 (PDT)
Received: from shreya-VirtualBox ([122.172.225.2])
        by smtp.gmail.com with ESMTPSA id w203sm11142769pff.59.2021.03.14.09.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 09:29:02 -0700 (PDT)
Date:   Sun, 14 Mar 2021 21:58:55 +0530
From:   Shreya <shreya.ajithchb@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        d.straghkov@ispras.ru, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, bkkarthik@pesu.pes.edu
Subject: [PATCH v2] staging:rtl8723bs:core:rtw_wlan_util:fixed indentation
 coding style issue
Message-ID: <20210314162855.GA2002@shreya-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the indentation of the else part of the conditional statement.

Signed-off-by: Shreya <shreya.ajithchb@gmail.com>
---
v1 -> v2:
Changed name in signed-off-by to match name in From

 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 975f2830e29e..4b5afaeac916 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1760,7 +1760,7 @@ void update_wireless_mode(struct adapter *padapter)
 
 	if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
 		update_mgnt_tx_rate(padapter, IEEE80211_CCK_RATE_1MB);
-	 else
+	else
 		update_mgnt_tx_rate(padapter, IEEE80211_OFDM_RATE_6MB);
 }
 
-- 
2.25.1

