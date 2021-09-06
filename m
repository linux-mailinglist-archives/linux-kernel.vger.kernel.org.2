Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA305402001
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343602AbhIFS4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244934AbhIFSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246E4C0613C1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g22so10582614edy.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qc2GV8eyLuBArlRm4HdaZBsA+XfwTyg8ciFIuh8ckds=;
        b=BBvISXC/hjQIUxoiVwgZ4IzQyBPyYRVIok97v4SZciNcflbGha+RJ/gs6NtDBZ9bEK
         cmDsKlvyupc6nnr1z5g8kFWiGe+fWMkm+//qQdCjIy8K9gRSfE8viuUrTQ7nFtrjBOhl
         d3JGZC7SzZboZgVxv+Id99VAwlJgMfn9caIjXlb4fNl+pcaL9mUabatYbXsQ2DWYuO0X
         +TIYYH5cwKhqQSfAJVzuX65Zw2iADBxVeVplYrvWeGRpQvRUlv6jMbXdS7/jJN9zwmNP
         /gTL1P+ypWIFLgcidTHy3i/t6nRsp13RPKMTQDYvKoBxO++aJSkc3tQ0hGUpcsmweZ4Q
         nL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qc2GV8eyLuBArlRm4HdaZBsA+XfwTyg8ciFIuh8ckds=;
        b=tlAVudL0wyU5UnrcA0T631BXmRMUWMJhnCdeme9paiQP/KFyqUJU6yuK+mQKfknGI5
         IrCW6nKq7N0DFsu2HhMo0LMnq7qt2F5ka2yKFdQUg/QsfuC4RYd2kBVtGkdYGYZC2x2q
         qFQXMMaXAutUG7LD+ZV7TRWMxhHNyBgFGzRtHn8AMekD/efus8BpilT6C975EvRc1If3
         5Wqhg/v+VdcMOKRKNhNSodo8LBxObN7gaovhvCSVxM1O+hpIjRsOYJJllBlURc3PloWh
         ztqtM4LKgT5lHJ37+K4+NXvL7wU4aF5f9rdoKFDO4p7yk0YvhnTax95b3S8nYQ3HzpoW
         +2NA==
X-Gm-Message-State: AOAM533p21TuDwWutu7c46xhjbLTrCJz9Sbbjq9VmOysrV8ZtssQ3y/A
        fo+KSaMbJACt9l+WrigdUUw=
X-Google-Smtp-Source: ABdhPJzoUMMA5XZhOxmjdygO1T1KJZOpggz3zegqXVS9b/YD5VOr9vtyGwazat0WZ00InPpJzH5Dsw==
X-Received: by 2002:a05:6402:2792:: with SMTP id b18mr14655396ede.173.1630954458768;
        Mon, 06 Sep 2021 11:54:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 22/40] staging: r8188eu: rename hal_EfusePowerSwitch_RTL8188E()
Date:   Mon,  6 Sep 2021 20:53:09 +0200
Message-Id: <20210906185327.10326-23-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename hal_EfusePowerSwitch_RTL8188E() to get rid of a wrapper.

hal_EfusePowerSwitch_RTL8188E() -> rtl8188e_EfusePowerSwitch().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index c7edb9ba4085..b5d0cd332165 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -707,11 +707,7 @@ hal_EfusePgPacketWriteData(
 		struct pgpkt *pTargetPkt,
 		bool bPseudoTest);
 
-static void
-hal_EfusePowerSwitch_RTL8188E(
-		struct adapter *pAdapter,
-		u8 bWrite,
-		u8 PwrState)
+void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
 {
 	u8 tempval;
 	u16	tmpV16;
@@ -757,11 +753,6 @@ hal_EfusePowerSwitch_RTL8188E(
 	}
 }
 
-void rtl8188e_EfusePowerSwitch(struct adapter *pAdapter, u8 bWrite, u8 PwrState)
-{
-	hal_EfusePowerSwitch_RTL8188E(pAdapter, bWrite, PwrState);
-}
-
 static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
 	u16			_offset,
 	u16			_size_byte,
-- 
2.33.0

