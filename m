Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DAD3FAF91
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 03:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbhH3B3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 21:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbhH3B3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 21:29:12 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED95C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 18:28:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so11099613pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 18:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X3SrLsuCe4juyzGE4LqoUUFGT9pNx1rNm2mTU/3y9og=;
        b=aKR25DYdFm6Sp8Z3gewF3tCnA3+j7tvKqkNfrDZe6Cg/w4/rhlgujAZLRWgNwbZF8e
         zLk+SP7KEOsLVdJVqcylGueMfw3pCr9+weJ6ZtiaUwcd6r6q5aWitq/X6IRddGaMXVcw
         NjdXM+WZxTi8Ox81gFk0cY70M9RJGbQO9cSx71M5qVmOpToGEqFSAZOveiZF+VundMES
         kjX9qit9IuGB0W6DOGJxosGFjAYZBrBt5FNIPoG16MDkRryYyd+tgofronVJpYAQN4oc
         QKgg9dzCnEnsCevxBZLJ3xDQobsUBXo2E9LZxs9ldMZiX9d4go3MPWytwDz+zR5EFpDu
         MO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X3SrLsuCe4juyzGE4LqoUUFGT9pNx1rNm2mTU/3y9og=;
        b=cgoojEQeq9WrnPVSWiRPwsqrmyzuRGkYhFl2n+F9wOopnHNifkNEh9MBFvidvaSfP+
         AmORF0mjNXiZizCaW/ArXeNgvSspYcDRBnaixh+ZA+GskETCkv8tR9PZvuO4V4jNv92h
         vhSrJTytVcg7uQiRqNxF4LeNdCcXwmPieUsXZkifiHVkvdSH4rRZmbuqOabzaE5w2Xkx
         BvU4oRuTZiowYxhFoOWvXzyvuJEDjDyhslPvSRc4VnDw4dhm2rTfidyrwTNWdfEtQGBb
         TB4hdQPirQM+PODMbhzc01BRAPTYPYxqkIVuufEpbvDoEPtifX1mZhex8DeQwjsiXcw7
         QvjA==
X-Gm-Message-State: AOAM530Qo9T2+WUlq9FV/z6Bt/iLcw/VAQFKJySF8hZ0Tv4aJJKyVxYv
        96YCHVaMafhUnVq2wFmNJJDyBjJxCS0=
X-Google-Smtp-Source: ABdhPJx3zQCY3/Nuk5XcDNwNmQlvbKMVdbrKD+be3wlQzQ7ph4BZhy5e7a0Nzglb2q9Gyzk1QKdjDA==
X-Received: by 2002:a17:902:d504:b029:12d:4cb3:397e with SMTP id b4-20020a170902d504b029012d4cb3397emr19893430plg.41.1630286899143;
        Sun, 29 Aug 2021 18:28:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g12sm12615322pjh.33.2021.08.29.18.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 18:28:18 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     phil@philpotter.co.uk
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] staging: r8118eu: remove useless parts of judgements from os_dep/ioctl_linux.
Date:   Sun, 29 Aug 2021 18:28:11 -0700
Message-Id: <20210830012811.3384-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Remove the check of the pointer 'pregpriv' that is impossible to be
NULL. There is no need to check if pregpriv is NULL.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Thansk-to: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index ab4a9200f079..d2f7a77357f1 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4340,11 +4340,10 @@ static int rtw_dbg_port(struct net_device *dev,
 			struct registry_priv	*pregpriv = &padapter->registrypriv;
 			/*  0: disable, bit(0):enable 2.4g, bit(1):enable 5g, 0x3: enable both 2.4g and 5g */
 			/* default is set to enable 2.4GHZ for IOT issue with bufflao's AP at 5GHZ */
-			if (pregpriv &&
-			    (extra_arg == 0 ||
-			     extra_arg == 1 ||
-			     extra_arg == 2 ||
-			     extra_arg == 3)) {
+			if (extra_arg == 0 ||
+			    extra_arg == 1 ||
+			    extra_arg == 2 ||
+			    extra_arg == 3) {
 				pregpriv->rx_stbc = extra_arg;
 				DBG_88E("set rx_stbc =%d\n", pregpriv->rx_stbc);
 			} else {
@@ -4356,7 +4355,7 @@ static int rtw_dbg_port(struct net_device *dev,
 		{
 			struct registry_priv	*pregpriv = &padapter->registrypriv;
 			/*  0: disable, 0x1:enable (but wifi_spec should be 0), 0x2: force enable (don't care wifi_spec) */
-			if (pregpriv && extra_arg >= 0 && extra_arg < 3) {
+			if (extra_arg >= 0 && extra_arg < 3) {
 				pregpriv->ampdu_enable = extra_arg;
 				DBG_88E("set ampdu_enable =%d\n", pregpriv->ampdu_enable);
 			} else {
-- 
2.25.1

