Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F9B356DD6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352653AbhDGNuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347714AbhDGNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA873C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f6so11986858wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FH/YcO2sYbbsIWneREzRnpYXkAOrBtR1NQ4JZO3sLEw=;
        b=Hu0+gVGRqG0vp+AeBiAVtaFIn6cW+wxkmPhpWEiIssVRTuRY2Z6MazWrYa1AR9SLlL
         agIGq2Mm/IHWr+txF3y4F0GC4aE5V/uYIzozmgguUih4uB4drp0cU+pChCG74+Y+jpdD
         s7VUXa8PRD7euZADEhHXYLYclLk6yGPMzoev7qUYTMJYZz5v0EfgBbLQobQuvRcCXax4
         jVRoM5Yc/X3w/L+JrIrVms8bMno+ygiZ4u9vEpYcI7nHoqYuxDjJPaa6Kd4MjaqyALdD
         LGmIo/Y9PrTB5p5Anx1eRphvRHZ5SyWJ05D7lLi63H2+7xNFrNvAqsb9qFTXknkS0xSe
         VpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FH/YcO2sYbbsIWneREzRnpYXkAOrBtR1NQ4JZO3sLEw=;
        b=cmeBFLSXXUY7pmfdkt1okbsfpPq2FbWZhEsv/fkaoflVoEX0lIztskaRz0w0ftEo0d
         jCoajOb7f5+qHTdpnTGdq9TqBaCgwHYoFW23C41KEPbsFCKLWtMMoN90rw8aofevUtxb
         BCkgJLLW6mgKZdIa73JR0o03kB47zeWLyni+1Ufyz6ArrklLkPqbb/Kg6RQAwHSE0G9/
         sq7XwjSkM0LFBUeFcP4rUXPpAWTJJFfELYMFfLsl5dXzVaQO0eCnVsaql8hWbDPxCx4B
         biDPwXtewF4Q56uyOwefgvJ90ZQrU7VraBWnAm79RC23rcMAFpNiTo8HGWyMiftxCmP7
         /aGg==
X-Gm-Message-State: AOAM531OKcnkDFej0KiQNGErFJnPOXBnkqFGVwFgEO5M03WrmTf8MuQ+
        pVUQzRoNvQrnHKoHLmQa8oG52ZXxPJ68Eg==
X-Google-Smtp-Source: ABdhPJxeMxG4MKLNCd/LkTegHOL7lGdOUrmKukaLI+DBbtE0Ajoaj4OVQQpc3SIodFUkMxsNdiIl9A==
X-Received: by 2002:a5d:4d89:: with SMTP id b9mr4555867wru.356.1617803408779;
        Wed, 07 Apr 2021 06:50:08 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id m25sm5812899wmi.33.2021.04.07.06.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:08 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 08/19] staging: rtl8723bs: put constant on the right side in if condition
Date:   Wed,  7 Apr 2021 15:49:32 +0200
Message-Id: <41c98d13d5c74b1329ae125f097b780745cf8246.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post-commit hook checkpatch warning:

WARNING: Comparisons should place the constant on the right side of the test
683: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2204:
+	if (_SUCCESS != rtw_set_chplan_cmd(padapter, channel_plan_req, 1, 1))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 2392eb2b0458..2f6516283248 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2199,7 +2199,7 @@ static int rtw_wx_set_channel_plan(struct net_device *dev,
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	u8 channel_plan_req = (u8)(*((int *)wrqu));
 
-	if (_SUCCESS != rtw_set_chplan_cmd(padapter, channel_plan_req, 1, 1))
+	if (rtw_set_chplan_cmd(padapter, channel_plan_req, 1, 1) != _SUCCESS)
 		return -EPERM;
 
 	return 0;
-- 
2.20.1

