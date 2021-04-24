Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB2236A070
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbhDXJHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbhDXJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6BDC06134F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g9so34664275wrx.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rCpiiCQz4n2K9iobxaVb23hXxM/13FWIKgaoFavgS9Q=;
        b=BIf/Rognnm34C02Z28qf991UuikYFjyn96QushrO1E3l7bgqs8Rv6xNo51X0iIa2A8
         J9I/XMWDFY2fYMAa8HrbUeRhWuDgT7nEdH1HwA1Gcxuw5AfXqYrGEV2Bye05i4mLCSbC
         S5o8JF7kD7upLRSAVpga62f/UmJr/tKSdBUW/Cu+s3wK0DfpHrzFP4/M+W22KzB1se8V
         aJ/BGumwxj73CZX3FK8+kRfyFWsiZVvaGeePbwE41ip82es10CXu+M6IVf1xzhBAzkhr
         KXjVfBA2/3pQ+q7nt/PhMQDvEffeC+fgFDDzKV5j00RMH46yiZahH2haOzCkDvctpS1P
         sezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rCpiiCQz4n2K9iobxaVb23hXxM/13FWIKgaoFavgS9Q=;
        b=gVhL3m39advqmA2/xvUKCbA7BZruNR5O4tYG4iGfB1c3pAejSeFex+tiaJU3SwD3Hs
         A596Ffx1orrJSY1AiQZSaLFpN/b19CJakR+jgZHEOseAfOckW6CEEb1x+JLvd9hY+zJs
         c37jB04EjbtWTyZOa0s9NM0ZwAA3nvLUm+cxMHgMQQngz6ipXVEl+K9NUyPRE7/0NTk9
         Y/Oia1v/tk7zuAjp3sMntaXCq6HLhr85E/n3fMpdF2CXmDGGXQQmEkLOkPxBZLwxsvWD
         mEDgaHGyx9DOIMFxbBXipSFEeRlaUJp0QWWoM0zwJ/K3qpe/YuZOA1IGh1p4j76Iw6VD
         8NRw==
X-Gm-Message-State: AOAM5312AWyFBXUN3dNziu+VBbhwhuEy1+PX+AHcR89EIk6MdID0Z/7X
        YpHifbwzh52wGWxDg7OEJN8BEQRm1cvXmw==
X-Google-Smtp-Source: ABdhPJxGPC4ApYau7PQBxhEYUbjlKjECjmNiAPpfp5fyU9UuIZVQGiaB4iYnjISGEnuelwQpmY+yng==
X-Received: by 2002:a5d:460b:: with SMTP id t11mr10042424wrq.310.1619255032723;
        Sat, 24 Apr 2021 02:03:52 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id p3sm767511wmc.9.2021.04.24.02.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:52 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 46/50] staging: rtl8723bs: remove unused debug macro definitions
Date:   Sat, 24 Apr 2021 11:02:29 +0200
Message-Id: <02f0a7ad7ad00dbafeaee1796f62f8f2e921d772.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macro definitions.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index cde4b1d6a4b7..ad96fe1de971 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,11 +7,8 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define	_module_rtl8192c_xmit_c_ BIT(28)
-#define _module_hal_xmit_c_	BIT(28)
 #define _module_efuse_			BIT(29)
 #define _module_rtl8712_recv_c_		BIT(30)
-#define _module_rtl8712_led_c_		BIT(31)
 
 #undef _MODULE_DEFINE_
 
-- 
2.20.1

