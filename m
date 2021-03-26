Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC04534A3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhCZJKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhCZJJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:09:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9ACC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p19so2589632wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tjZ69b9hxFcbktSVpwV434OeU24igr5zjHI3bGPYJis=;
        b=OH7MgcVz9FM55iQRiRxGIQClKespOVCuKfxJ7xc7GYQLdg+zzffre5JvtyQ92F8RLX
         Eszta5Ytn2/YJWjhmX51LQQQxkRottUxlTWAnSRffNjM+1vdV3qlZtF+8iK96vbTuv7v
         9f+KwmxsNz1YK9r8AXn+2wk3F1My9YHrHPs9t/P2+zfC7aTwpF96XF5IbbIg3X2IfH7z
         umGWsLpHBeILZ3y+L0xc4fFLrTYYGOHkA1d4Dn9PyoXEbwuYo6UQCi1ThU+Ko+H82SHL
         f0eTNpuRZVqtM3qN3V2W6W2/XinaMrcipr+qsEi1fHNOTp67aOv53/nsNVk1jX7RvsLj
         qRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tjZ69b9hxFcbktSVpwV434OeU24igr5zjHI3bGPYJis=;
        b=UQY3ur5fy3guem9OJ96WssxbP1BIjlfifWplmRk/Ab2s9AD37rMPc/0EpQUcu9tr6r
         zGegblfNZreyk3mLUA+BWaITmKOueU0ZxnvYbdvypW/VRbsD1tgrSdSoTETwY/5yDiq0
         UIk4yLmTvm9AtnA5iCt0sBPOrqVcTJvhbm9vSeHbkvy1UV/ZPtSs89+UeSUQs6R+ilJj
         ZaFSaUAW6SdqDMrELY+CQOES2r+6fgq6mxeH51vrBKfTPKiksYX9+k0NgVEh4LKYfbCD
         f8JJhvm98aiqxssd44LbBSaJ7usv8ZZ8Qnj12pcz2NqlYKZH/QpLopuE2z7mUILqx2R/
         bUUg==
X-Gm-Message-State: AOAM531vxnv2/smb3LGumPASHvNpUqhKRnJr777lo4q4OzHIjiYz1t6h
        fG1AEhhjpGPyvV4ZZEqIxYs=
X-Google-Smtp-Source: ABdhPJz5OidpHOTwbywGpTvzXE+xAdqUuLYuORVr8mHw0pE6SenXsPS3WQbRcuJK03T/+ZaFakCLuQ==
X-Received: by 2002:a1c:7ed4:: with SMTP id z203mr11437608wmc.89.1616749796741;
        Fri, 26 Mar 2021 02:09:56 -0700 (PDT)
Received: from agape ([5.171.81.75])
        by smtp.gmail.com with ESMTPSA id o11sm10933234wrq.74.2021.03.26.02.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:09:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 10/15] staging: rtl8723bs: put parentheses on macros with complex values in include/ieee80211.h
Date:   Fri, 26 Mar 2021 10:09:17 +0100
Message-Id: <f0cc55b99577f28f4f08bc9c0346ec97997320c3.1616748885.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616748885.git.fabioaiuto83@gmail.com>
References: <cover.1616748885.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warning:

ERROR: Macros with complex values should be enclosed in parentheses
823: FILE: drivers/staging/rtl8723bs/include/ieee80211.h:823:
+#define CHAN_ARG(channel) \

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 8a10bca876b8..80df24c1c6ed 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -823,8 +823,8 @@ struct rtw_ieee80211_channel {
 #define CHAN_ARG(channel) \
 	/*(channel)->band*/ \
 	/*, (channel)->center_freq*/ \
-	(channel)->hw_value \
-	, (channel)->flags \
+	((channel)->hw_value \
+	, (channel)->flags) \
 	/*, (channel)->max_antenna_gain*/ \
 	/*, (channel)->max_power*/ \
 	/*, (channel)->max_reg_power*/ \
-- 
2.20.1

