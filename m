Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3D34004C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbhICSTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbhICSTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:19:03 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A2BC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 11:18:03 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q21so172408ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iIMKPB8xrPOdYW5+xiv+opBoM2BrTB5ajbOBWpHHX88=;
        b=lggNLKE1qEAeMghLueW6o2pFaFiCzeh8Q+scXoiDXs1dTpbkuXX+6VLpRzSC4E7T0g
         92xbnKIhqf1GCvhmDXyWLj5o7CwjMRnT1hnnuQsWsZLKKvzkydaW6vygjJKa5prDIdru
         c83UJO3q3JPtlAoYdw+g6jLgtGLKcav71kptAUGwuD2x+acrDervNBe1j9ngTC2/0t9P
         OaBgIGEfelsx5qn8UchjH/vHjkqo8FGaEH7ndjCCHH9JMWbEdhIjgq2N1FatWRWksLdK
         eS6v+Nozqt+tOa5/fnEWKv5qR1auFhTLRyiAtPFnq0AE1UF/H06bmOvC2wJicGUzVcli
         3Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iIMKPB8xrPOdYW5+xiv+opBoM2BrTB5ajbOBWpHHX88=;
        b=KWBS4TYHh42tOj+DwqUU9p+cN2Poj0HZPxePZ01MqD9Ax8zEVub43eTj1watE1pWqe
         kGpp9wFBBU/C4RRH3cxrA3bFeGqbNR6YTps+ZaCLcMG6gn7BdvWN4PvaPnlIr+IPYgbJ
         LX1e8fkhoEiyrvPJjLs7LckXSntiGJwBIK77NxN+Q0BP0ysCfeP8CTnGm21WoIzVPxIY
         YlSuqkXjMbuQup/X0MlKnniPwobmrQ9S8baOp/kKr/E8ifmEAVJWoMIl1c8UyvbC5zpZ
         XOM+QSB00I2mX6bQEh0Il3bNliR3o+y2+nCf3xcC9PfNa+H75y72s5A43ER9E4fjwStC
         bI8Q==
X-Gm-Message-State: AOAM531qzGLxLqt7hDDPI+JR2wntTNH6o8od/H4Txoua5suSkJje0bWO
        +vr7ptZIXsr+JRHuWE+IegaHPYiKoXValn77
X-Google-Smtp-Source: ABdhPJw0f9f1EoPPij9K99CG+t/HAmm47ZwTEHOtHfVx/E/bpVNIJLAcySoiUHZI2ya9gsIZ9bMmlw==
X-Received: by 2002:a05:651c:102d:: with SMTP id w13mr225761ljm.229.1630693080643;
        Fri, 03 Sep 2021 11:18:00 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.70])
        by smtp.gmail.com with ESMTPSA id o22sm15349lfr.32.2021.09.03.11.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 11:18:00 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: fix memory leak in rtw_set_key
Date:   Fri,  3 Sep 2021 21:17:52 +0300
Message-Id: <ee783fbb71abb549505b84542223be7a7c905eea.1630692375.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before returning with an error we should free allocated buffers, since
they are not assigned to anywhere.

Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 1115ff5d865a..bd991d7ed809 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1722,6 +1722,8 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 		psetkeyparm->grpkey = 1;
 		break;
 	default:
+		kfree(psetkeyparm);
+		kfree(pcmd);
 		res = _FAIL;
 		goto exit;
 	}
-- 
2.33.0

