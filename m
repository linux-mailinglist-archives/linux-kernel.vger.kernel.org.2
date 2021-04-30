Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE8C36F6A2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhD3HrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhD3Hpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF39EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r12so103837965ejr.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esklRFhcv92jAvcOLhHGS3GTMlKhQ0QkDSmO8wy1pRY=;
        b=DEmJypMjFobuOJ5XvhfnQZxA/esaVQyTR6yeWPnguY9pNzbHanD/tLLGrLbG1UGIks
         y9Mgd5AxPMDaKgzIfuSfpP8XDLNFJDY8XCgIWQGWpru9Xks0WSvAbhqSB+Q84iumQWZz
         Pf/gw2LFTJYRVtx+Sv1rMCqvKTCsy7PagZ5+yhMzVSpn+GZRRu3Nnh8lyOprAEGQcIDK
         IkP23cwgPhI5aA6qf7iqwg2iW737XzDIITh6cHFdJ9KAnrcX9I4g6LjziH3ZAbBVOrua
         GHs2CorUzxsM/lk/zEdGTHowgP6jPdp/u1/u8axH79PSXpmgs346p21Ex81Nw9vQf2Dy
         cwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esklRFhcv92jAvcOLhHGS3GTMlKhQ0QkDSmO8wy1pRY=;
        b=pbbqg8WwcAxE0EKX7OK/gAlKaob0YVBdGW/rDi7PH5IxDjN5gGv5qrw45Mthcwo2yh
         JImvHTPNe+QUjP/GxcX5n5TJlXUjNT2zXASjK2Tnlv1TTRpqIpindKis39nEwp3/+Rt4
         5zVk3/nXqFGOzMLCnIvjS7Z2isqkUk27PUy1Quo5Rl7Atm4PngHlAqbZ4aM9VXBD7xFZ
         dzzf6APGV4UGZiiWBK3xsS58/L4IqE0ppAM5fia36YUHD3ubc7I1gsgI0aL2Guhf5a6X
         T1hZqM4SWhhQrECRcpTCxnZx2Vu9pAXDGkm9LbbHRNjle+NsYGt8O0Zbcz+nx1otOLwD
         A37Q==
X-Gm-Message-State: AOAM533SUw+kpfaEC04yT3HuW0F2iqevmepQ9Rz9VJlq+NBqmku32AAw
        y2iY5kSosginQzJBngqFaJOzeO+LUGoSVg==
X-Google-Smtp-Source: ABdhPJwU1vbd6lj4zVUm60cea18MSzq0YMBZ3IoSjLRGzRBSS+aXfUvXO4vdpXsrhGQEfziQ+xqZdA==
X-Received: by 2002:a17:906:49d3:: with SMTP id w19mr2917343ejv.116.1619768700325;
        Fri, 30 Apr 2021 00:45:00 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id hg24sm220684ejc.99.2021.04.30.00.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:45:00 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 33/43] staging: rtl8723bs: remove unused enum
Date:   Fri, 30 Apr 2021 09:43:51 +0200
Message-Id: <61b92c9d686c28c77c591a82b18c44a85d2d4c8a.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused enum.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index c5444f965699..c4616a69425d 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -78,12 +78,6 @@ enum {
 	BTC_CHIP_MAX
 };
 
-enum {
-	BTC_MSG_INTERFACE	= 0x0,
-	BTC_MSG_ALGORITHM	= 0x1,
-	BTC_MSG_MAX
-};
-
 /*  following is for BTC_MSG_INTERFACE */
 #define INTF_INIT	BIT0
 #define INTF_NOTIFY	BIT2
-- 
2.20.1

