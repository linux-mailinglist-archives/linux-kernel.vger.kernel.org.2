Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C7D36A069
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbhDXJGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbhDXJEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9605EC061342
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so2421088wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwuVZ4DerzLqtKGB6gfK45URd5Glj/AwHPmshqzuvhg=;
        b=HjRemUUNvRl3hwTB1Llsc1JSydUodEc5HPftrFoNoAukh5l5N87NhpxisjR2ulTA7t
         NV4X+wzypDnT8jDgKbJAPndVhx4SPxY1mSE/nJzl32c8QkXC77feWGpvzON28N2Nycig
         lSYr+DBnUI5bu/o+M43vI1q94S508hVWdo/jGa/iYBLL61aPLFwHPA78xhtWO8OZyz0y
         ihOq8ZVS2yV6mAfR+39s5VHlEK0/l1KT0OeMkVAVxRuZHGRODkHeaHVrKPU1ZuDlhBkf
         1AlZKiygMSOt4GTjCU0FYJMec/6CJ2UMoG5z0I46zQRhOoqkK+CYZqf8QUMmygitbyn4
         db0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwuVZ4DerzLqtKGB6gfK45URd5Glj/AwHPmshqzuvhg=;
        b=qAaEG/Z7r65OnLZiT7y6yNxFVKuQBqagvNxRzI2zXWVtXRsJbBzSqa7TSfOJm3Tizu
         IJeOXusFFjBDBXFlBJuaOsa5ckemrtws8pkviEPDslSzYRgtmKPyMjsf/XAcd/DsqHLZ
         Kxj/4/62paib6xgfRT0w9xwaD8C6GaOP+GbNT5hb6SlFs5o694Ar6ZvIeCcaAM5r0qll
         FvRYC1ZlPWcV0OJuE/dCq5yNr6OEckDiydzhbQnZWwLpbyIX7n/7kj8WVU+1Wkwsc7+M
         w6k6ksjikFIpdA+8qcQ3Obig7pgn6WUDX4BBApPSOPweHWwTA9K4XkJjoKprOmb67/rq
         fiYw==
X-Gm-Message-State: AOAM530DC9vWvAEUgpTX5l5N8zosdYNuXap6QRirhgZbu+Y+3uroWKCf
        MFfMm6pB/r3/vcU3cTSRQw9YGCeRWxJhhw==
X-Google-Smtp-Source: ABdhPJyN0hknx8JZh2Feky5qyA2wl3lfl1svFqkVZ0rUcFeLwix6p+DEQQZQjmaH3oG+RXmg/lDWnA==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr8559624wmi.189.1619255024222;
        Sat, 24 Apr 2021 02:03:44 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id w22sm13448795wmc.13.2021.04.24.02.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:43 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 41/50] staging: rtl8723bs: remove unused _module_mp_ def
Date:   Sat, 24 Apr 2021 11:02:24 +0200
Message-Id: <9e8945a3f4f58b32eb2ed3e943f8cc0cd6c26823.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused _module_mp_ def.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 3e391a23ac8f..261317b07635 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_mp_			BIT(23)
 #define _module_hci_ops_os_c_			BIT(24)
 #define _module_rtl871x_ioctl_os_c		BIT(25)
 #define _module_rtl8712_cmd_c_		BIT(26)
-- 
2.20.1

