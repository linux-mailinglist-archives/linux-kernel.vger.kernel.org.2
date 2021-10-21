Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BE6436BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhJUUBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 16:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhJUUB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 16:01:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6F8C061243
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:59:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so3965753pji.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BbvyX6jPLK5zSg2NVxfybp0y/nnILy7522O+U1Y7hXo=;
        b=PuDZ/KAlnQ8ek2j/6dOR9sHRIIrOPuC3UXhSPavRp5Xm7jfSoPhMLeNzU5ShysHefZ
         Vguxz2bCtQxm/JbeKX9z80UqVV463tJOmbodktoV8sDVrX6hz8BbsN0GA4Zhzdp6stZ3
         p/uNRKKxD10DtUNu3hMc128tbP8dSU1DRKKtCcn0a7ozgEwNIOwdCJ8gBx7skR2hQYhM
         zRDNs7CEsb9oYDtFFZhcdqTJNPrsvVU2oQHTtirderms5swugJigQMIJFqkdwxUH+hZD
         dKNrK0+AbesMeLmngEgPBPQXESrQ7hFncycjAeiN4VPXdajfAvx2y/9jKsuM/6JgozNl
         incg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BbvyX6jPLK5zSg2NVxfybp0y/nnILy7522O+U1Y7hXo=;
        b=przpXXC54L6dDRbvDwqHEPz7kRARlL/0jU/m/X1WvV4xAPLZjXoXvQpgYn0GUDJJIg
         vSv0r966m2kgJBzlugYlhZfOpPqf1U+lixz2dWG8e4mvFhllI3VgDj6r25bwG3y/zcSN
         a0hpGcbBu48QcOn5JYLyIdFJhBiOGfy5L68+gzMW+ks/Zm9OU2YKg8v1vWCe0qBiDeJx
         fHoQVHUHWThaAL7HihNw925t7Rx8FFE8uQm3iuI5V8JMFrH0JApmRpds00s2aFjs7cqC
         124OrjcGfy0tO187tLEJP7sqShOCgJ3jqa/oBBMdI+fwBmSv54ickFAU+H0xFOJnRt5R
         jdKw==
X-Gm-Message-State: AOAM531DVaGEJqeSNosU1/V6nQTA8D/ETS+n8HkaF0WM//rJw5uJjoaU
        TGpfgHOcUZpBy7qlkfGlA2uaPjfVgBpBCA==
X-Google-Smtp-Source: ABdhPJwIIPbNTkKHDoOLQuWXGA9lHyPcMuT+g/z8z3MFZg/tsD8OSlfh6l+vhOUqCZmvM54PhIsaWw==
X-Received: by 2002:a17:902:758b:b0:13f:974a:959f with SMTP id j11-20020a170902758b00b0013f974a959fmr7091047pll.40.1634846352200;
        Thu, 21 Oct 2021 12:59:12 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1fee:e3e7:7dfb:56c1:efef:3c0f])
        by smtp.googlemail.com with ESMTPSA id v9sm7198898pfc.23.2021.10.21.12.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:59:11 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     fabioaiuto83@gmail.com, kushalkothari285@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 4/4] staging: rtl8723bs: core: Remove unnecessary blank lines
Date:   Fri, 22 Oct 2021 01:27:53 +0530
Message-Id: <f6d2ba1d544c70519bad5c04f012cba0214b379a.1634845504.git.kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634845504.git.kushalkothari285@gmail.com>
References: <cover.1634845504.git.kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless blank lines

Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index fce3256cc275..690e4627663c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -316,8 +316,6 @@ int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	return _SUCCESS;
 }
 
-
-
 int rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 {
 	int res = _FAIL;
@@ -367,7 +365,6 @@ void rtw_free_cmd_obj(struct cmd_obj *pcmd)
 	kfree(pcmd);
 }
 
-
 void rtw_stop_cmd_thread(struct adapter *adapter)
 {
 	if (adapter->cmdThread &&
@@ -735,8 +732,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	}
 	/* for ies is fix buf size */
 	t_len = sizeof(struct wlan_bssid_ex);
-
-
+	
 	/* for hidden ap to set fw_state here */
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE|WIFI_ADHOC_STATE) != true) {
 		switch (ndis_network_mode) {
@@ -1080,7 +1076,6 @@ u8 rtw_reset_securitypriv_cmd(struct adapter *padapter)
 
 	/* rtw_enqueue_cmd(pcmdpriv, ph2c); */
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
-
 exit:
 	return res;
 }
-- 
2.25.1

