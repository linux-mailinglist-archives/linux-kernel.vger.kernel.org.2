Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411B936FD02
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhD3O6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhD3O6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2ABC06138F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n2so105691080ejy.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXGJ6BJNTyxC31APtHNNGgHRV6GpZZQxSZgzKX376VM=;
        b=tqWuGh+IcIutJjY340lBdNQf7hFWM7L+H/WDKtguyuNk4uzusyF+YKIuTi6Ucw3nVM
         +UWk8D4PavSiERnS5jeSK4iRgMHLsYTAN3hy7wMyoVnAV/d5K5cGI0Zz8su9gQoGcS87
         mCtMo7Nz/FcR3elhXfZhtYdkKknZgDrb9s4cwrQygSKWJsfstFN7lvCJi6fx3Fdfhtj4
         YN+qyaOcKlusxvqWecvfQnmim2YmAeioP9PSXqAGTQDm0k94V+cLtyNLGF9lANZhrjz7
         KcPNYDAnuLOFOfH0z9zmOIcwe/nR32XZodL7XaJaeAC57IugRauUBYQPtyTlpVxOsmK4
         wYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXGJ6BJNTyxC31APtHNNGgHRV6GpZZQxSZgzKX376VM=;
        b=GE75LYTEk3lSCcsr07x+QMB7/x9yYmsBoddU94rWD/Byw1lxo7edzUToKGmYt2TYgS
         fFPGqkxj1TO7o8uyNHzywgvi4fc64tTw2yvcadvz4Baq8hj8ZpgCbqam7OWrgeQqy/g8
         0DdN7AdI1TolJ8OWRzsLedDQV5mNmngygg2T026ckHKA0TXfUfHPoy/hlr2uWrp8nESb
         S6VTIIZUOAt5hawJQ5Rf1cWtC07ZRQWgxI+nmKKYQkAppn5mVyZWw4Jy2dPl18aEUGbS
         qFl5Q4IX6KlqQOMEhlR8t3zjyt6J2CNj+6gGjnl227Je+C9bw5td1kZPi+EkyEdL5ghB
         PhJg==
X-Gm-Message-State: AOAM531i1YCMtqVrtw9qZ29xf7XeVDseLCemRv9FWhbVbaDAUKhld/fS
        VxYesEfn8tXpUVtnlkMFc3uLzwL7Ot0=
X-Google-Smtp-Source: ABdhPJwilUl0DvCCKJZUaBjlbuGCKgdiKtaRQ/m7SG8KYhhIGcHS23PTXogrVBF1qzUtwTXwEcFRbQ==
X-Received: by 2002:a17:907:397:: with SMTP id ss23mr4648537ejb.298.1619794641719;
        Fri, 30 Apr 2021 07:57:21 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id z4sm2113322ejw.54.2021.04.30.07.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:21 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/43] staging: rtl8723bs: replace ODM_RT_ASSERT with netdev_dbg()
Date:   Fri, 30 Apr 2021 16:56:31 +0200
Message-Id: <3f172aaefb84aaac639f1850c5eb45678578e393.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace ODM_RT_ASSERT with netdev dbg.

Marco ODM_RT_ASSERT wraps a raw prink and prints a message
everytime second argument is false. This occurrence prints
always, so replace it with netdev_dbg()

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 0027ce211619..fcd3f97e7df5 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -552,7 +552,8 @@ bool ODM_RAStateCheck(
 		break;
 
 	default:
-		ODM_RT_ASSERT(pDM_Odm, false, ("wrong rssi level setting %d !", *pRATRState));
+		netdev_dbg(pDM_Odm->Adapter->pnetdev,
+			   "wrong rssi level setting %d !", *pRATRState);
 		break;
 	}
 
-- 
2.20.1

