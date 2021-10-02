Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84541FD19
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 18:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhJBQgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 12:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbhJBQgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 12:36:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8045DC0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 09:34:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s55so9699061pfw.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 09:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wLb2A0PtJlB17tyLyjs2uzTuOP43MV6eb3/hU3RQqhE=;
        b=QHB5X2UHQEkRlzsC39y2neBg6czGLrOigMaMM0ZU/KthuJ132gk2nQSZOn8QGiO8R5
         4tGvRCpYKKxuKdIXyDldB/YZkvWscrj5eJGq4jDCYW1eq2Gn+6mDj/F6POynyNgOhkNc
         Sqvskuu8sYxenRuSjPx5SnvM15QH0DwxAONHIoJzrmeBYtCM4WM7czjTLRuJVrR/+iDs
         uA9U731NC4TWDHsqN86Ie4x2nIorq3SasLVV2XHbebP82K1V0733EsSwIQ2bpwSBrptt
         kBPS9PCNlcHlgEqIutxMhaboWioceLctW00/klC6NB7fTBNk0KBIrhROMoO2R0rDpy0c
         XMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wLb2A0PtJlB17tyLyjs2uzTuOP43MV6eb3/hU3RQqhE=;
        b=ZTCT1wysDPZ0qSgS2S0bmeK4VAIZjZH0iilsDl258XBS/FNElkEESaLWpwClGl4d0m
         hoNWD6r3O9KXwflZnAb2oLIesO/Z79Yvb5K3R0YOs705CxaPWmfMNWWRDHcN1z2cmZUw
         UaKcXrh8EBbCGjZAi9zAgORIs/cR2jugMzdXV+PQoAP9PT70nujCgY1GNzxfxol1C2xF
         mv2faVD/ovYHfvkiLxjVBpjnfAYxYwdKeLN1lp8LRzzQKeAps4CL0Q8570t9M1/OjALj
         7+9AXPUveNYXYtEbP8dvjcWEt/KV86TAbGOwwefTe+d8jqSmcTtvFRfAYy8of+KdO9hN
         KtYQ==
X-Gm-Message-State: AOAM5335xxzWDS7DDwgHZ08rlrI4aYypMdZLcxkmQdQ6BUtx9GWavsEC
        A6w7DBRql9rMTjUNL4ZGjCDXS4ABsVg=
X-Google-Smtp-Source: ABdhPJx2qUsUSk9/7hEBy2obN0pznxb2BpCV+tjFYypJVOO/yl8M+7NPeZmfH7YpiQJUSO3piuOQDA==
X-Received: by 2002:a63:d64c:: with SMTP id d12mr3502461pgj.186.1633192468617;
        Sat, 02 Oct 2021 09:34:28 -0700 (PDT)
Received: from user ([223.230.105.60])
        by smtp.gmail.com with ESMTPSA id p2sm9874131pgd.84.2021.10.02.09.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 09:34:28 -0700 (PDT)
Date:   Sat, 2 Oct 2021 22:04:23 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH v2] staging: r8188eu: core: remove unused variable pAdapter
Message-ID: <YViKDzqX5isFX+gv@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable pAdapter in Efuse_Read1ByteFromFakeContent.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---

ChangeLog V2:
	-Remove unneeded line break on Efuse_Read1ByteFromFakeContenit().

ChangeLog V1:
	-Remove unused variable pAdapter in Efuse_Read1ByteFromFakeContent.

 drivers/staging/r8188eu/core/rtw_efuse.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 801887f497cf..225ebdee21c1 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -28,9 +28,7 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */

-static bool Efuse_Read1ByteFromFakeContent(struct adapter *pAdapter,
-					   u16 Offset,
-					   u8 *Value)
+static bool Efuse_Read1ByteFromFakeContent(u16 Offset, u8 *Value)
 {
 	if (Offset >= EFUSE_MAX_HW_SIZE)
 		return false;
@@ -96,7 +94,7 @@ ReadEFuseByte(
 	u16 retry;

 	if (pseudo) {
-		Efuse_Read1ByteFromFakeContent(Adapter, _offset, pbuf);
+		Efuse_Read1ByteFromFakeContent(_offset, pbuf);
 		return;
 	}

@@ -134,7 +132,7 @@ u8 efuse_OneByteRead(struct adapter *pAdapter, u16 addr, u8 *data, bool pseudo)
 	u8 result;

 	if (pseudo) {
-		result = Efuse_Read1ByteFromFakeContent(pAdapter, addr, data);
+		result = Efuse_Read1ByteFromFakeContent(addr, data);
 		return result;
 	}
 	/*  -----------------e-fuse reg ctrl --------------------------------- */
--
2.32.0

