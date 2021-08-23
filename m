Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53683F4390
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 05:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhHWDHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 23:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhHWDHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 23:07:35 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C880C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 20:06:53 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id f7so8928893qvt.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 20:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v5fKUirlI0ToxpLo9nwyWF9xy/b07uS0bu8mkFdXJJ4=;
        b=erFyBgVd6uxfFcX3HaP8t0NV9C6E9+O9C3zq036nMZmOJeE28l8RhqShZNWLiExlv4
         B7lhIdJbRlqm88xklXIFutvI1WUZD0MSU9r8uZz2Kujayh5RFGAp/rmXtCylpm50uh5X
         U8ZqW85w1t4F7Z8OqlPZ6vvgKPEZf68kYvQUl6OAMBViieV2bEsgypEvvIwCEC68ogXW
         uvdU9oYM5GY9TQIGCtQtqyINJhs0I5yvUcrN19Eymu+yk3ePxFv4mW+dBgMbOQTH7306
         Apa9LWKvSsCyLrQBz3uFydR99dPBWM4P+6jcIx21kAorYhGLcoLazisNLfnmlfJwMtV+
         EpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v5fKUirlI0ToxpLo9nwyWF9xy/b07uS0bu8mkFdXJJ4=;
        b=AbK58iu9oyxcFiT8GYh8AVCv8n1G6IxA9pJPQBIm3NzEjh0LohrW7Yynnr/iCRMABr
         Scl6U7G0amudmcgZhejIlbuxcDhM8pkvSjLPHByJ2TyJmm/mak8hASA+Ptnks7fkBCLj
         g3DwBmQs0gq4lFMvdLn3pvAVKJQJT8I+V437J+sX00nobDJkN/LlK/1lA4LhkTQ1/d6C
         EI9jIyov4KWnMh4dm330+DYvHfK+dEvtzXZXlr/UnUPbG6367PnB9BJ8O+myIPsDnDaD
         KxcCILH+2OIGnx7Bks0LHdok2x8BuxOUHwTJMjTyaClueZXDqeGw1oparfy1x8m3VaOs
         3aIQ==
X-Gm-Message-State: AOAM5329ObzcdvbSMuy7oQtKyR79WEeb0ijrMbbrG3R2aWzZ4WWF4BnM
        pRF51fXvHUj82JvcYulix3c=
X-Google-Smtp-Source: ABdhPJzRsbKxQw9ePN3HS0BDfYjIn+EEf9EgHyOKBXJe/2rwM6YTMtOvUOmTjsPOe8ROkRKup5VqYg==
X-Received: by 2002:a0c:b216:: with SMTP id x22mr31272965qvd.55.1629688012820;
        Sun, 22 Aug 2021 20:06:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j18sm7858882qkg.31.2021.08.22.20.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 20:06:52 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH Linux-next] ioctl_linux: fix a potential NULL pointer dereference bug
Date:   Sun, 22 Aug 2021 20:06:31 -0700
Message-Id: <20210823030631.45517-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

The pointer might be NULL, but it is dereferenced.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index a3e6d761e748..ce4ce9190f5f 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4389,7 +4389,8 @@ static int rtw_dbg_port(struct net_device *dev,
 				pregpriv->rx_stbc = extra_arg;
 				DBG_88E("set rx_stbc =%d\n", pregpriv->rx_stbc);
 			} else {
-				DBG_88E("get rx_stbc =%d\n", pregpriv->rx_stbc);
+				if (pregpriv)
+					DBG_88E("get rx_stbc =%d\n", pregpriv->rx_stbc);
 			}
 		}
 			break;
@@ -4401,7 +4402,8 @@ static int rtw_dbg_port(struct net_device *dev,
 				pregpriv->ampdu_enable = extra_arg;
 				DBG_88E("set ampdu_enable =%d\n", pregpriv->ampdu_enable);
 			} else {
-				DBG_88E("get ampdu_enable =%d\n", pregpriv->ampdu_enable);
+				if (pregpriv)
+					DBG_88E("get ampdu_enable =%d\n", pregpriv->ampdu_enable);
 			}
 		}
 			break;
-- 
2.25.1

