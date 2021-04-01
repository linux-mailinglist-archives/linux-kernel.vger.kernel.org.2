Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D353511DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhDAJWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhDAJV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEDFC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o19so1165023edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FiriAVBN/K4zFoUiIgg5H+KCI+lUplIfvn+b2uqWN5o=;
        b=cW45/t5M+7irjQG6v19jtTLjNvVYjoAn3oUD4lUCeqXWTspxSYLnvVUSbkQYB35orr
         kU1RC6jCvQGh9a84/9T5A3kknJk+zxMxviWes0I5LZe2k3iOUhVJGgh+mFrIr7ZmGbo7
         5V6p1l7F703Qz5hff5v9mMGrVnNFgZGR4ZuSd23Mx9MUe/TJmideeLJ6pEfSNO+WzeM4
         D64CmQDMIHTIkhhPcyY+iODvx3CtPjbRFh+2EntDbzmrqeYQw7l87F6qbMzraxXSbg1r
         Gds2hIum7xdjUsuIZzwG8YUTM48n5vGls9XF+kjf/cYnSLC7rkOVG5xjQn7AE5RInzsO
         2m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FiriAVBN/K4zFoUiIgg5H+KCI+lUplIfvn+b2uqWN5o=;
        b=LBJcY+WlOh+mYEEpCndOLvH/5hzOuHXlo3EzlIlRhtef3AijYOOp68SE8iW83HMaU2
         3J8UPNGo1r+wJ+4iGKrXDHAxubzrmkT7jW5Mj2PLpK38T9+HmeHNAYZVLGkjBorH6iIu
         R1pUZQAH8QLjH+jyq+QfpHNUvdx27OjpMrq/uhrEILPrgxAFgl+GkZ5mYla8Rm3E+WjT
         K2hi1HOv45vd+KSTAEqaYbze21oRB3coTRffllVxEWUh7DfxqxIach0xVPcH2Kb/azE9
         C8l3nmTA0m8j2IO7Q8rky6/vs3gEtQ+yoquyOAa3R3KrF3ojGRBT70bc9cCVfy/7iZrM
         GL7g==
X-Gm-Message-State: AOAM533bUBzEZiuQ3AwSSdX5wND9cp1sN/DxeKvhZnw9Eqc5W4JEcgYP
        FfPSIGoVBHATsZR68BaoT/M=
X-Google-Smtp-Source: ABdhPJxklvXLyC8rnfpt+YIduNy3C2DYAvjupKcbzaAMRPOJM+7dxwcUAFY7tyJtBklc6nImjxTWHg==
X-Received: by 2002:a05:6402:b31:: with SMTP id bo17mr8683612edb.113.1617268886411;
        Thu, 01 Apr 2021 02:21:26 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id 90sm3726324edr.69.2021.04.01.02.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:26 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 02/49] staging: rtl8723bs: remove empty else blocks
Date:   Thu,  1 Apr 2021 11:20:32 +0200
Message-Id: <f966fcc0621ce79fff5bd3b49d699ade7cf34c13.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty else blocks

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 05aec2ee5a0b..d8e4e7cff377 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -867,7 +867,6 @@ static s32 xmitframe_swencrypt(struct adapter *padapter, struct xmit_frame *pxmi
 		default:
 				break;
 		}
-	} else {
 	}
 
 	return _SUCCESS;
@@ -1140,7 +1139,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 			ClearMFrag(mem_start);
 
 			break;
-		} else {
 		}
 
 		addr = (SIZE_PTR)(pframe);
@@ -1783,7 +1781,6 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 		pxmitpriv->free_xmitframe_cnt++;
 	} else if (pxmitframe->ext_tag == 1) {
 		pxmitpriv->free_xframe_ext_cnt++;
-	} else {
 	}
 
 	spin_unlock_bh(&queue->lock);
-- 
2.20.1

