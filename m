Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69AF353869
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhDDOLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhDDOKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A58C0617A7
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f6so2688441wrv.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOPIpaHeGrNbOqM1ya170ZvKPsGM35hLd1i5IH2Aa80=;
        b=JvePyQqv1HYJpeKtI5iLV4MpnNmMIafB/e40mTFVzoI7xvuvVGVDrNCYjNBetkt6Ug
         F/RUGTvkHIWla2Vg4URIvbaYxgCQoDHy75xx3D7t9QJwYicr1xdI36r8QxXxbvfGLwVI
         zXA+i6P4BAPwgHjjhv8gAxCma/+BCaxL8c3h0Ql0UNm30VmfEwMlmBpNwOcb2ltxF0os
         YRKB+FS5RRjBUlqjFNxgN1fWlsJVBLM5gj3xSFYuponnhluPRja/mkk5ioj9ZgMV+NEX
         QQWoCYQDk50zwdRNTfeDFZDtiYV7wUn1cr8Y5x3PNBb6dUu0p/oONDISSYMyhQ8xbWbz
         mGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOPIpaHeGrNbOqM1ya170ZvKPsGM35hLd1i5IH2Aa80=;
        b=hrJpKT454IdCcrWNjdWyI2qps3XZEShVOE0Jw4ezCH0MKVmCFSC6JT2REx3HCyNY2Y
         gt29bH9+7DqBEtDMqqolIftg56dsiYHoT5kb0S0du/1R5xfx3sbJVP5k4Ns/JSxfCPMa
         P1Ya7W9gxArrMaaFGVwjKqP7HiVD2KEGSjAVUhoXdf8CmzSLsVxFjmZNODxyFkFnVW3Z
         4El4r4z9bJg5tJleVa5wOGBufbm/IBEyOg7rFC7ESEYpDeGJX6jCoIEfkztLqF4XNdb5
         NPmt0XNvXKGWSgxwkfK6Lt68nyQsh6efueGqQ/zdhtxhJGdkRvGt9w12ue9oXy+ctcrw
         RGMA==
X-Gm-Message-State: AOAM533iC6UllrKzPdpHt3AxjBViLcr8m07dAc8p7vpdepkARKHrr62p
        UZq4ui5rQtquKPr32dZyPok=
X-Google-Smtp-Source: ABdhPJyL0aAn+LAMV5W7p6sdlpZOECbSkIlDaAbpSJvAhrvBBkF+2+8fQ/CxpJbUVQ941aHwQxOIzQ==
X-Received: by 2002:adf:ce83:: with SMTP id r3mr11185657wrn.144.1617545426948;
        Sun, 04 Apr 2021 07:10:26 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id f8sm323935wro.29.2021.04.04.07.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:26 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 22/30] staging: rtl8723bs: remove unnecessary parentheses in core/rtw_recv.c
Date:   Sun,  4 Apr 2021 16:09:38 +0200
Message-Id: <eab39c58913d799dc90efb8b234c2a7fdb61ba57.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit checkpatch issue:

CHECK: Unnecessary parentheses around
'psecuritypriv->bcheck_grpkey == false'
24: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:381:
+				if ((psecuritypriv->
				bcheck_grpkey == false) &&
+				    (IS_MCAST(prxattrib->ra)
					 == true))

and fix same issue on second comparison
(IS_MCAST(prxattrib->ra) == true)
^                               ^

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index c8a13d733c98..bf53695f9f7d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -378,8 +378,8 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 			} else {
 				/* mic checked ok */
-				if ((psecuritypriv->bcheck_grpkey == false) &&
-				    (IS_MCAST(prxattrib->ra) == true))
+				if (psecuritypriv->bcheck_grpkey == false &&
+				    IS_MCAST(prxattrib->ra) == true)
 					psecuritypriv->bcheck_grpkey = true;
 			}
 		}
-- 
2.20.1

