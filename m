Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF3835386B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhDDOLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhDDOKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA56C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j18so8771052wra.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0bzab+wyS6KvStbR7zDn+0HIWgAiRTCX8kg+zp342XE=;
        b=cQ0C3c1FFb7y/npDqi+I3jvpdHV2HB+7QNhTGR2aDuGRck0hQyPP8vKaeMlx01R42q
         Vh8q27Sw2rcwPqeEp/Jlmm3G8U+wWJOpYQc1U5D4Wum1AXOPeAywRoHjCjqrjVKlaOcI
         myQHsCRHVXOq5WgkFbI4FURv2Czqc9JugJ6I0kQQ6fKjbPJO51aBzosuOm8genrPcP/8
         cOLpQmFMf+Dctl+0cBK1WgwgEVrPMT+v8fpKUVlH9Ppnve8aRToGAd0R8KdGhyuncLc6
         xFGikJymo2TfooRW8PBiIBSWRJqlwzSnM4Y2Xl3mKCou2fG207GzfIUSeJlSfXXh5qKc
         Sgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bzab+wyS6KvStbR7zDn+0HIWgAiRTCX8kg+zp342XE=;
        b=iIP0lyB49BB0TnY6ee+zzH6jHBw4i7sPbHVNPuEkmqNEtDIye5GIrIob/TpD8hZ8rp
         liVOE1aSoQS1X8mvaTlC2cuThmSaFb+sTuWyayNOts2ayEa1KfMFiO0jKaL3RmyNq04m
         NCnDrBRxMJtoq1wNDlYZYg6d3qUYWSQL6Q2H0v8VfRB3L2UZo9F1vgg32kwphC1iy19c
         hPvsvd1a6v2KILt7GKDXU+uZ3AFa/xmzlfyFOrW7Gm4eE3PqoMlzq+0X57PMlWjfVoTA
         SSyUvUAXTwGAFMU41oVhlHTf5I9kG6GzqwGeNKHsycvk4rPfMukjM6YY3OGiiNfmTLwz
         wCmQ==
X-Gm-Message-State: AOAM530kQr0UbbGmjFlYZZty6Tl/D6kRXoK11Kv9HeBJZu74Cg6VJjC+
        ahELpig6Uik0JvQONlQ3YTY=
X-Google-Smtp-Source: ABdhPJyOeot1wL6EQbSIPhMaKqNFy1G9lzJw/62wud5r2REdDMtd/dQhOlIRoKlPvPcCaZKMwdwkgQ==
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr25441303wrn.121.1617545430347;
        Sun, 04 Apr 2021 07:10:30 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id b131sm19629340wmb.34.2021.04.04.07.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:30 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 24/30] staging: rtl8723bs: remove commented RT_TRACE call in core/rtw_ioctl_set.c
Date:   Sun,  4 Apr 2021 16:09:40 +0200
Message-Id: <aae1227b56fb75c0b221a46b612aa4aeb6460feb.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove commented RT_TRACE call in core/rtw_ioctl_set.c

Remove all of the RT_TRACE logs in the core/rtw_ioctl_set.c file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 7d858cae2395..14eb01df69b0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -451,9 +451,6 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 
 		/* SecClearAllKeys(adapter); */
 
-		/* RT_TRACE(COMP_OID_SET, DBG_LOUD, ("set_infrastructure: fw_state:%x after changing mode\n", */
-		/* 									get_fwstate(pmlmepriv))); */
-
 		spin_unlock_bh(&pmlmepriv->lock);
 	}
 	return true;
-- 
2.20.1

