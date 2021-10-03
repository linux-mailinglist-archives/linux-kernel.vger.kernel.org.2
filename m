Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D89420161
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhJCLoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 07:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhJCLoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 07:44:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918AC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 04:42:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c29so1666640pfp.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 04:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xXApb6NRig/lg8urEyRo67pliSVusKbNvAl4dBAOwkk=;
        b=W4kG1o9WxPZBYouKnHpaaJj59/XRZq4qTuO6fHHAlbk46x/7LF4eGO1fxOULiTtzXr
         QC4Xb5b5PHZa2o0R/IH5PILzpaI/yB3POLNLbVm2J/aBRIE6dDCj7aKnH3D9skqoz0C+
         F/Eix/0VxcLShWD1CQSm6d6MNtCN/KbBn2hMCrvxxV3SKwgVRJg9iGpG5B44e13c/XaD
         pYJDUkZX41hgzK1HHyy9YPl40FQsgx4wooPngVurQx5QrbRkNozFTCedOaHZGt6CI7Z/
         Tu4IIP0HqNtCq9iH4AaoucY2Tij7go2lUA0OloU0DZ9R51xuaBOQN8eTlrgOw1ZQZlvt
         GGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xXApb6NRig/lg8urEyRo67pliSVusKbNvAl4dBAOwkk=;
        b=x6OQHze2CI3yVoGvfuTH+UJdVUqQyDB5VIpsGWsFyu1cDGkBfnsx8BVKANh9KtSWH6
         X1+UNdadTdRscMbaKWqIyRd+Gy/RUxCNjPkl7kz1RdH2DStceGGU1PT/nmOpFoFMUKnl
         lnC7QjJHjs7tTOXPzf/CVPpUHSHx0l8glKh2QwmbUu8IOIHh6TvoF6qV/NAqzJNC8aMM
         NEtd9vd5o4vgOrSyFKDCawhzv8b2hEyFE0+baVEUQqZgwYoqKt1GPPNt4EOTE+Nvey7C
         JADPJvKi6pw3HWTIMD6ERIFv471BUCwicRk5Hk4/Xg0nUgejnUW9ipAYrEhIQlWbCg/B
         b1Kw==
X-Gm-Message-State: AOAM533FHP9uBJoYls9hXIDiS7IDrh90wqPidoRYf9HOmOP8q3nXtFlh
        ZlhnJPlkfe3jLnRzLz9X3GQ=
X-Google-Smtp-Source: ABdhPJx6dmSQ7zrR1f4sK6ixw8q7sHk5qXAm5WkmvdzgdoI9gbKUBF3OdLLp7LSEm3c95H9y126Lzw==
X-Received: by 2002:aa7:93c9:0:b0:43c:f4f5:aac2 with SMTP id y9-20020aa793c9000000b0043cf4f5aac2mr19054960pff.11.1633261354624;
        Sun, 03 Oct 2021 04:42:34 -0700 (PDT)
Received: from user ([223.230.43.197])
        by smtp.gmail.com with ESMTPSA id b142sm5962282pfb.5.2021.10.03.04.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 04:42:34 -0700 (PDT)
Date:   Sun, 3 Oct 2021 17:12:28 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: hal: remove assignment to itself
Message-ID: <YVmXJFSCCU3cvG6y@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove assignment of 'pHalData->TRxAntDivType' to itself.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index ef165ad98269..bb92bebc63bc 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -2101,7 +2101,6 @@ void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool
 			pHalData->AntDivCfg = 1; /*  0xC1[3] is ignored. */
 	} else {
 		pHalData->AntDivCfg = 0;
-		pHalData->TRxAntDivType = pHalData->TRxAntDivType; /*  The value in the driver setting of device manager. */
 	}
 	DBG_88E("EEPROM : AntDivCfg = %x, TRxAntDivType = %x\n", pHalData->AntDivCfg, pHalData->TRxAntDivType);
 }
--
2.32.0

