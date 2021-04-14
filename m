Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1F635FA7D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhDNSNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349425AbhDNSMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5516C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id v6so31524697ejo.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mMvMZ7W6bZe0+bru0DQKOTFCdHX7bB5LkX0PxyNngz0=;
        b=RB81IZeLdw++N+5RqtrSsU+EVFSVnlpI3rTQfiAy4UZQ3kRbOZxtNOn4A0BC/Oy5nK
         iMI2AEbkx+KoA+bmmBGAME5O/sWkkaJOiwCpypH5JjyXd9AvI+GmxURUiVgaSNwOVi9R
         UNfIOigJTbIu5il8TG1dWCavk0zHoi4JDqeO4tfHkqg1j9H+p7Wq5xb99IlTLCVywKZL
         VCwxfGuIHTWLo6sv6Rngm21t2wVh4ktEylzurbQCNHCfMsg0GF2s5tcI88oQkdznLTC1
         JFNX59uVNGL7SY5ySDNOWLOzDd14ZabwxXSt4NBPvDHsp/tOMpWEFXiJa3na3q/n0zWw
         7/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMvMZ7W6bZe0+bru0DQKOTFCdHX7bB5LkX0PxyNngz0=;
        b=lcWskhLfV8ZSWo5BZhIMXY6bwlSmHXHd2zHGyhiEs3HYuMaeHZyMjz7InLo1FKNay1
         caeUzAWeWTgoOtwYnZ7tWazGE2y1tANG7AArpFTRjNUZhc1+6wNzYnwyxpORpPrREIp7
         dyc4s00gON1epgZWLD6BI82TOqlXXQRi5dceEs7GleVIWEHD5d4x1TqhXMkdJXKsYOgh
         eJBSoe6rjaeewxalCT9ElgwB8MRms8Ya+KXjFcGNHEgp+hQhk2tYpQViPrUsxP9KUWPg
         AT1KkrUPR6hRgHj8RWQ3xdqNJ8G5KrCaJYVpoE5szSSb/8GirODm2eJFeEANeEswx45g
         ox4w==
X-Gm-Message-State: AOAM530XmpGjb9YYhTQ/kALoVPdwMh4mOs2NLypPnhwQQOCmfFfrWpYY
        75TV0gk2gxQfvdkugPE43D9ftw==
X-Google-Smtp-Source: ABdhPJwCCWJs9HpQKyyzwnABRonUB4rQx1O7GfRR0qVQNDUoWDgVnOiO3Ll+OBzIkRWGWN70YX4Ogw==
X-Received: by 2002:a17:906:3455:: with SMTP id d21mr145260ejb.11.1618423914456;
        Wed, 14 Apr 2021 11:11:54 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 19/57] staging: rtl8723bs: core: rtw_wlan_util: Remove unused variable 'start_seq'
Date:   Wed, 14 Apr 2021 19:10:51 +0100
Message-Id: <20210414181129.1628598-20-lee.jones@linaro.org>
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

 drivers/staging/rtl8723bs/core/rtw_wlan_util.c: In function ‘process_addba_req’:
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1774:11: warning: variable ‘start_seq’ set but not used [-Wunused-but-set-variable]
 from drivers/staging/rtl8188eu/core/rtw_wlan_util.c:12:

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index c1b893451788b..3bd62567dec50 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1711,7 +1711,7 @@ int update_sta_support_rate(struct adapter *padapter, u8 *pvar_ie, uint var_ie_l
 void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr)
 {
 	struct sta_info *psta;
-	u16 tid, start_seq, param;
+	u16 tid, param;
 	struct recv_reorder_ctrl *preorder_ctrl;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct ADDBA_request *preq = (struct ADDBA_request *)paddba_req;
@@ -1721,8 +1721,6 @@ void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr)
 	psta = rtw_get_stainfo(pstapriv, addr);
 
 	if (psta) {
-		start_seq = le16_to_cpu(preq->BA_starting_seqctrl) >> 4;
-
 		param = le16_to_cpu(preq->BA_para_set);
 		tid = (param>>2)&0x0f;
 
-- 
2.27.0

