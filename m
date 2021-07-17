Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6604D3CC3E8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhGQPAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbhGQO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 10:59:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092D0C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m2so15572202wrq.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fT5Y9stI377JiGQTrPWu01El/WyM/6HS75JSxSKNB0s=;
        b=QxJ/luhbkkJygBIo4suCYX/OfevpiVIrNvQwIaddzSDpndy+f9gK2DG2+0G1N4/hio
         NJVcky+wtSazDDo3nz6RoSnmBQjxlhRB69w3TgQqlJb+aQGLJ1HeYWF7hshgQp6BkfhF
         W5R1T4qVPkxdbzOgEUAhoT10hhASFS1JuHJDrI1M9Vc0PaY6iuCbP7ZyN3ueQwkhV8yz
         C7auy9EN6ctbJu9MRJ3UrSaCI5R64GZ5QPpPmXoCApyiH+D0d4WgZasgKLxGTZDWAY7b
         prsTXeUdfAz+rSsGLXSpYfOswC6lRV7sdXcQd7nYhZfdmh52cKr5bc2sXZ53+BQgngWY
         Hiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fT5Y9stI377JiGQTrPWu01El/WyM/6HS75JSxSKNB0s=;
        b=hVFAjiuqq/Gk7nyWQ9TIpZbCvWxm85YfPiB+kwDACUOYnEe0+e/2ZQvcTFR1lVS3kr
         WwWjT12+8wjcMM1Fg01k14QkbVY5XbU42vY/8I9BX15Lb8yHJd4Na0fGvGFcE/LZBMEM
         IaX8ppNzVWyyRyx8aVIWhrp7WiHdbuDUsZpFM82fVEJ5vXZCNG3GkWedlvnrISMtwwRw
         6R7lA+fNvKt2GxMy/QpGR9wC+FdQ1gPntrZkDNfrWkpT14g4yxWjUwEChcj/LD6EtfnM
         7XmNML6bzbRAgItpPd58iUQ6ppBSDjQej8At915NP24Ul+yiun4c0nZ30ETrZRHZA0fK
         Us0A==
X-Gm-Message-State: AOAM530QfYafMFje/Dd+TUK2uPkdRrsWaOq+p8rWr5A2OduGsQ+elUEh
        iIJACcxppxQURc62HalNtrfLTxoAmpY=
X-Google-Smtp-Source: ABdhPJxAHSCWSfio4IHuKDEegmCGxQ4QZmgoEHwQnI4iJxFtMW9N6Xi3kF6ZbeklpQLTEH9BGyt0DA==
X-Received: by 2002:a5d:46d1:: with SMTP id g17mr19618815wrs.2.1626533820546;
        Sat, 17 Jul 2021 07:57:00 -0700 (PDT)
Received: from agape ([5.171.72.101])
        by smtp.gmail.com with ESMTPSA id e11sm17189340wrt.0.2021.07.17.07.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:57:00 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] staging: rtl8723bs: fix camel case in argument of macro is_legacy_only
Date:   Sat, 17 Jul 2021 16:56:46 +0200
Message-Id: <404028e00ca4a32bfaed753d5927d9b673e6058d.1626533647.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626533647.git.fabioaiuto83@gmail.com>
References: <cover.1626533647.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix camel case in argument of macro is_legacy_only

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index ea1800de3ef8..343d077d9c76 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -154,7 +154,7 @@ enum network_type {
 
 #define SUPPORTED_24G_NETTYPE_MSK (WIRELESS_11B | WIRELESS_11G | WIRELESS_11_24N)
 
-#define is_legacy_only(NetType)  ((NetType) == ((NetType) & (WIRELESS_11BG)))
+#define is_legacy_only(net_type)  ((net_type) == ((net_type) & (WIRELESS_11BG)))
 
 #define IsSupported24G(NetType) ((NetType) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
 
-- 
2.20.1

