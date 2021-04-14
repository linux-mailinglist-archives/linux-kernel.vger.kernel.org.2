Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8335FA8D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352903AbhDNSOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352382AbhDNSMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DA9C06138D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id e14so32779262ejz.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gsRq4XrCIbEI1Y0MYbckaGY82KlEcKihUFnkf/W4oNw=;
        b=ZbkeJ08q7zC/ZxOElHjCdRmwEFpf1itx0NinXxj4Yo/0c1IvB5WaV7ygdcFet977iR
         +qFlbo/pkGO8DATNKVR1wrIuAZznJHXNqYTGkn1lSiXRv/CLabOHKNITTClNDDFlc5bZ
         ldvlxc/Mhf3uq0QC6iuooGs6tCbowyDu00++p146uK8cZGnY1iDmeHxbTclPVuAP212A
         k2Gowlzbx+wT2Fc4bCmGAJRUEkQ0KzqQtsfkwcAAJo7in4Iapjfd9ki6KiXXsY7srFLw
         UgijUdXAA1E2PKpJlI+2syD6bm+ofsQaNKFg29VJhanVDwNnFQKVJMPUPuDWTWlepCE5
         JxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gsRq4XrCIbEI1Y0MYbckaGY82KlEcKihUFnkf/W4oNw=;
        b=o5czx+aAjtXb9yDtxlU8b7a7hs5WPXwEZH8QuG6jYplREXW1v3WwKTSP6zGMQmwR8d
         bXn9HeD0+NkgGVxGygcqUSiE2DupMBWTYjKM+othoVwFFYErhnNYItPbZSmMeREMJWP3
         +VlavrIJNwY8nGt81v/64jbpc2lmLHtoHr9ZmD8eJpthFEW8XJT/gE6AWOmkYZ+T2S/C
         ycCf7xy/hEo2egDEJ32zo1TpzAvZhjskdjFv/aBgUw5QxFwoBFV89cQlcsBNKdaQI2zI
         Vn2QHKlt4YVCVHmn4ZBahdWpN38NbGWUXu3EgPj/r668e7igD4ch7zyRG3Gd2TkJblU9
         jFDA==
X-Gm-Message-State: AOAM533bIwf86gmPdN2+S/TqLt1ubVJ1OC+zkKvlUp8nsIrPmsJ5UT0Q
        qldSDfQf9tFeReLN+5piiUMF0w==
X-Google-Smtp-Source: ABdhPJxXteaIGyMyGsDbjsvVQnCFGeuHLu4HK7WaS1kHjo2XpkFunpBo/YsvXSB2mX0tfMnor94Ovw==
X-Received: by 2002:a17:907:1c01:: with SMTP id nc1mr132058ejc.283.1618423928040;
        Wed, 14 Apr 2021 11:12:08 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 32/57] staging: rtl8723bs: core: rtw_mlme_ext: 'evt_seq' is only used if CHECK_EVENT_SEQ is set
Date:   Wed, 14 Apr 2021 19:11:04 +0100
Message-Id: <20210414181129.1628598-33-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c: In function ‘mlme_evt_hdl’:
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:6004:5: warning: variable ‘evt_seq’ set but not used [-Wunused-but-set-variable]
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c: In function ‘issue_probersp’:
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:2543:1: warning: the frame size of 1096 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index d1dbf234e9e02..f708e7b9f8fc8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5980,7 +5980,7 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 
 u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
-	u8 evt_seq;
+	u8 __maybe_unused evt_seq;
 	u8 evt_code;
 	u16 evt_sz;
 	uint	*peventbuf;
-- 
2.27.0

