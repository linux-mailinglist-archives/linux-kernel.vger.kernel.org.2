Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFACF35E23F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345831AbhDMPFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345677AbhDMPFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:05:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59072C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:05:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r9so26475549ejj.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0xoku/gJZVifospo6o1WZ6Sg1aj10S84grdNkCx2C9U=;
        b=OqO69w81Xg78+Yg0PKNTUy5lhRRTv55K3xIP+2wpLNf6aoNyj65s9aDl+EfNz5FAZj
         lokQ+1koIWlndO5ZgnqKwEuO0sPxthTNiMd0tDwsrRcY29v8PpL59hn9iwqkCYW4eRp4
         GMwpTNqls1vwDO3tjCQ3C25pZQ7lPrwiM+cLl1Y91YX/qLN2sT4HXjzV+WnroSNDHaS/
         FymL1SocfkRLXCWHe7hctEoy890ucotx/E2pan7eEMplNJr+DJL30cVAROuWfTJZqLNg
         a2XwW4eUNcz/F120dcCdkqiBDhHktew8M7ilJyH7W2Nr5pj7hAv/2DMDfkFtnBEswujV
         k8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0xoku/gJZVifospo6o1WZ6Sg1aj10S84grdNkCx2C9U=;
        b=TWkkNDvqF2gH3YEc08jK24VebA/W2xqnEvMIThdxQ+gFliSge4Cl3J0cDnHKJE9zOF
         R8Bmx965LZQ0aTCt3BYY1mask3RLCJx5zBRFgH8wZkWFMHsiG1F6Shnbx32+6XbJus01
         GkNsxKbufobyHtzo55jMpUPZFfkN3bCcnOhU4KK3h22/N1xxXgv4hrWntGhiinqf0Gr7
         mZHq+uqi+SUhFe6ip9rMHh1d6qQd07vWgGmYcrYowZVNltiJ9EouHPous1Uwk2CtpZQ7
         cJ4mMOh+oDJCiRRUh6TpL3GPNJumOMvXIVp3nHNKcGIhuYaY0sXSvpmfd0n7BsZAYjCM
         1Y3w==
X-Gm-Message-State: AOAM530todOB0YlEwg+Ejy2gH7qyzuaLubC8nVYuVNnbIWFgByVtzhnH
        VWEM2dyRf9l1DqUIirhydLQ=
X-Google-Smtp-Source: ABdhPJyr1MXST1Y1PDIDxsCuqGEiSF5meOf84ayVkS4Gc4mwVsAkK+Kd5EnSQNKM4K6VjofV4VN/zw==
X-Received: by 2002:a17:907:33cb:: with SMTP id zk11mr16188048ejb.231.1618326322074;
        Tue, 13 Apr 2021 08:05:22 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id t1sm9681085edy.6.2021.04.13.08.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:05:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH] staging: rtl8723bs: core: Remove unused but set variable
Date:   Tue, 13 Apr 2021 17:05:17 +0200
Message-Id: <20210413150517.12533-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed "ledBlink_param" because it was set to the value of "pbuf" but was
never reused. This set was made by direct assignment (no helper had been
called), therefore it had no side effect to the location pointed by "pbuf".

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index f19a15a3924b..440e22922106 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -6191,12 +6191,10 @@ u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
-	struct LedBlink_param *ledBlink_param;
 
 	if (!pbuf)
 		return H2C_PARAMETERS_ERROR;
 
-	ledBlink_param = (struct LedBlink_param *)pbuf;
 	return	H2C_SUCCESS;
 }
 
-- 
2.31.1

