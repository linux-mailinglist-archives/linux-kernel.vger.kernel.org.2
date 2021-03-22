Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD66334474C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhCVOdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhCVOc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:32:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1103EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:29 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e7so19553920edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4BEr+U22XVWAeunLqffU23P7ZmiKVWme3aB7fB0BhsU=;
        b=vRgM409JQtnaRPNCwgrkhaPbRUwTSPN7dO4zkE0qRY7n4AVs4z/J05XI3BUQCIJmM/
         mGJTKIqdpDgogPfs6603CGeQgY0E1HV69uMBNkPAKfgbjYiYkZaZfXQUFzNzNMBHrqPm
         oe2jZGqRxVebAp/b6Q9F45Fd4mz2nATSnHJUq/yaLUysOAH/FmWGaHJZjRdOnWdoQ6Wv
         LciAueRc7O52PqBAFxfqjC/Nz3papznAA0+Qb8VHouGFGwwLuz9XAiE5U4LnV3X9swDT
         IIkdKNQ1uPR398m2nlqhakxKbrc9LppnqfErieu6SfJ2tajNYUdOMm+s63w145DlIC5h
         wK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4BEr+U22XVWAeunLqffU23P7ZmiKVWme3aB7fB0BhsU=;
        b=MzYp61v+0VPc/NpcBdE3ZKwRhdiX0It9FFEmg0sGS3IZJ4mAXuW4jUu8E6PCRcP+cP
         CY0fu66hvcHPHtAHeChTv+KFuqhPOwXUdmDkL0lyirLtKf4by1rF7R8s0vxBkDahaHgd
         U+evzf6D9ynhTkCzaaTddF1OOUAOpcAmRXgmBP31O25iP/daRmTvEXwcxxIEiF+hWNqc
         +VniSq1SYLD7ErCaPz2/wLOCyaVTtdPgC4kfuX3GLww3D8On0FC3VpKg2L+N7fxa/ODC
         +jT93LGf0C2c5Cx1+asuTzc0OrkUTnQJUVJ8dZLo1bAqo+6qqwUaxD8wSHR+DnBOfmwx
         TVFw==
X-Gm-Message-State: AOAM531DRpCr1ykvn2gV8LhZH/8FU+VT/F51rQqj1ZG+GD1E3uxcen/7
        N5pJuKv4VEL3L8AOcAgLUZA=
X-Google-Smtp-Source: ABdhPJyPBriehihrYHP4J6IqMkH+J388wKRJBSIJkfPlD/9VgyKvBz8dBo5mY6zis1Ypdk35A021RA==
X-Received: by 2002:a05:6402:438f:: with SMTP id o15mr26161782edc.123.1616423547888;
        Mon, 22 Mar 2021 07:32:27 -0700 (PDT)
Received: from agape ([151.57.176.11])
        by smtp.gmail.com with ESMTPSA id t12sm11828460edy.56.2021.03.22.07.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:32:27 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 07/11] staging: rtl8723bs: delete extern declarations in core/rtw_wlan_util.c
Date:   Mon, 22 Mar 2021 15:31:45 +0100
Message-Id: <8dcec67cedad47b2e7d54ad90507658b1c5747ce.1616422773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616422773.git.fabioaiuto83@gmail.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch issues:

WARNING: externs should be avoided in .c files
28: FILE: drivers/staging/rtl8723bs/core/rtw_wlan_util.c:28:
+extern unsigned char RTW_WPA_OUI[];
--
WARNING: externs should be avoided in .c files
29: FILE: drivers/staging/rtl8723bs/core/rtw_wlan_util.c:29:
+extern unsigned char WPA_TKIP_CIPHER[4];

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index bfd55a0356f5..760b0ea4e9bd 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -25,9 +25,6 @@ static unsigned char AIRGOCAP_OUI[] = {0x00, 0x0a, 0xf5};
 static unsigned char RSN_TKIP_CIPHER[4] = {0x00, 0x0f, 0xac, 0x02};
 static unsigned char WPA_TKIP_CIPHER[4] = {0x00, 0x50, 0xf2, 0x02};
 
-extern unsigned char RTW_WPA_OUI[];
-extern unsigned char WPA_TKIP_CIPHER[4];
-
 #define R2T_PHY_DELAY	(0)
 
 /* define WAIT_FOR_BCN_TO_MIN	(3000) */
-- 
2.20.1

