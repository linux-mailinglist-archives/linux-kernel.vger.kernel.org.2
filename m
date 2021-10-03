Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51748420175
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 14:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhJCMRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 08:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhJCMRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 08:17:20 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2425C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 05:15:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m21so13872313pgu.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GISa/5YWim1dL4gwKmc0fTZB94/Tkhhvffj3A4gtCN4=;
        b=YtuExd2hljo/eVPf5MDPEXB9sfmS1N0rJz9fbit3XIyKWwBHvpKC/Mbna6CIZtdAzJ
         loZ55T5I1hqsXuWVEsLOhBXPvAazBQUTe5IxKTm8P/c0ZH+yiyHHUEESz34gcF0Aar+l
         ZwHvdhh9S5qa8QtPFQkhJuM4CAf9Us4wu7udZpCwTrmXgZuo1mXjxuylNKYce01hLkAD
         cQiNw665YcuEI6fFKJY6IL7+cZnGv0FqwABYxo0tV7xEegv2GdqaSsIqhsx4+csxeL7K
         s4f8nXHP3ipC7KGvqaPLezIqfQPIwfquIZNmJTftoI9qhfg2IeaSo2u7X1LBLpZohyYp
         e6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GISa/5YWim1dL4gwKmc0fTZB94/Tkhhvffj3A4gtCN4=;
        b=SBNUhLEcL4v+tevojc9urBkT/YpPqOpHXttf79On/wjCofCLnz8+LgfEyNMHmrC37j
         x2K4vjPL6SXFqiRyTNzUFYm70WhM41BPqDNiSvZjPHlK1yjjYKrb0yMne9LFFNi2v89i
         U2nx9BOi62iiOgxnYwd/ISWout6daYoJf2G1bCIFGj/S7Uykz2noha/jK+NULdLiD737
         DQs8zs46hhqvmFsUS2vMExRxmxZgOK2LU0yCZZYOxRnuQXeNEMblt2jIS2Sv30t3FY1l
         I9SssC7Fwx+enH2HeGQrh16oMwwjK60oUNNUviJZ1BCmow4egaP6BR+7K7y6LnFZksHT
         D3AQ==
X-Gm-Message-State: AOAM531GauZG/Dc94cpmhCU/yc92JEM56wbimuZFrwqxRattCzxbYws0
        XQpvefGJESqwpdNFZ2O3ZQWTea8rjnE=
X-Google-Smtp-Source: ABdhPJyZwLdjjb7qfu6aCgCoxk/5yYeqIjvYnhu03K8VaD8JxNm41YGMBAosllXfs9qOQ07497+I6g==
X-Received: by 2002:a05:6a00:c8c:b0:447:bddb:c83 with SMTP id a12-20020a056a000c8c00b00447bddb0c83mr20853105pfv.1.1633263333250;
        Sun, 03 Oct 2021 05:15:33 -0700 (PDT)
Received: from user ([223.230.43.197])
        by smtp.gmail.com with ESMTPSA id g22sm13519394pfj.15.2021.10.03.05.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 05:15:32 -0700 (PDT)
Date:   Sun, 3 Oct 2021 17:45:27 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        nathan@kernel.org, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove duplicate condition check
Message-ID: <YVme3xtnCHN/hOjS@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the same expression (!memcmp(pIE->data, BROADCOM_OUI2, 3))
on both the side of "||" .

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 3d1d8c198e53..8db68cf1e11c 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1271,7 +1271,6 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 				DBG_88E("link to Artheros AP\n");
 				return HT_IOT_PEER_ATHEROS;
 			} else if ((!memcmp(pIE->data, BROADCOM_OUI1, 3)) ||
-				   (!memcmp(pIE->data, BROADCOM_OUI2, 3)) ||
 				   (!memcmp(pIE->data, BROADCOM_OUI2, 3))) {
 				DBG_88E("link to Broadcom AP\n");
 				return HT_IOT_PEER_BROADCOM;
--
2.32.0

