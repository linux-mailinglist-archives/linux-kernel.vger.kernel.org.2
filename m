Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660DC3408D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhCRP1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhCRP06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:26:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA096C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:26:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so7111306wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qS9Nz47GTA8hTM4G9C1C/c06jObHEFBEpZEFEihqQM=;
        b=GHvqEhNZPk7En0bu8SNS4PHj7+qaRQIKk/GyeuFTF7DBSKZIVYJTS+0OeGN8PKdZsK
         hWv3avjboz6t+nLbeMZGu8BRrwQ5VTF8a4GPJytJ7aaOWXUQSaaOahvquWOgYXgLdH5P
         FDUNPbnimEMnOQyz3B2pp/sePtX0Do325iCaPbm4yBzTRryM5ExXQC74fv4wjrzosaMP
         jPJ/BRWREWLuhW06cqH2yvAPZMwqxtdeD6zwfj/8dxTYSSAXkp+BC+aOj418E3jlGRDH
         YDEdptLM3lTBLnNjJOA/c9JoOYWM8U8GCYP37FrheUcn/BGgSKGtMXFp+OC6tEmvMhW1
         YDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qS9Nz47GTA8hTM4G9C1C/c06jObHEFBEpZEFEihqQM=;
        b=TtT4XpXd5qIOx7sscdJPSIQ+5WRdJLtKna1RPMkjLFeAt9OIJgqhrnx0Y0x4wK3DLN
         JFSxjIcm86j/04EarcQN4qWtWaA4ge6yjYGM/E/g3+vR29NSh8ak2SanOqhS6cQpEdLy
         ZZukRqNjJDe3vuylTjfkG7TZ0aGk8yXhMwrzTlNy2jYxSxd0g3JYMCtFO0XzroKsnAXV
         l3oWKZ+hXG91eI8khjwGU4WafLl2IiDYJKum04NCg3AKeXM1MOz5rak8DGdlZsBhx35p
         EcyJCngzw/kDB0OHbbqhCL9qhrzmMV/9AZa2lUiOpQ0zwvYrc/90jt0n7FYWFM2C1MOT
         NfRQ==
X-Gm-Message-State: AOAM530HYTske/hlmqTvwHiMufvF/JiVWSnZenWcrEYMPxJj8MSdIkEA
        jQpGKXNq2VD+JM1k+U6UoCk=
X-Google-Smtp-Source: ABdhPJwiZkQjE8LoYd0zm415v3NGd4TK/aoNr2cdHbGBz7nBN+bhrv8Hfn+BheuvQNPal/gZ8+M7UA==
X-Received: by 2002:a05:600c:2053:: with SMTP id p19mr4143861wmg.87.1616081216478;
        Thu, 18 Mar 2021 08:26:56 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id e17sm4202947wra.65.2021.03.18.08.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:26:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 05/15] staging: rtl8723bs: remove unnecessary logging in core/rtw_wlan_util.c
Date:   Thu, 18 Mar 2021 16:26:00 +0100
Message-Id: <20210318152610.16758-6-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318152610.16758-1-fabioaiuto83@gmail.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1140: FILE: drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1140:
+	DBG_871X("%s\n", __func__);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 355e43c4cf9a..c267f1b546a4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1137,8 +1137,6 @@ void HTOnAssocRsp(struct adapter *padapter)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	DBG_871X("%s\n", __func__);
-
 	if ((pmlmeinfo->HT_info_enable) && (pmlmeinfo->HT_caps_enable)) {
 		pmlmeinfo->HT_enable = 1;
 	} else {
-- 
2.20.1

