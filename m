Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749723B48CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 20:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFYSce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 14:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYScd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 14:32:33 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A505EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 11:30:11 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id g4so20196030qkl.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ahjwf9HqwEUWxfT27RhcaX1vAqu39xvQmFxCmdymgYk=;
        b=bcJmnLILLrzdC40glkAg3vuavgVVrwsOURCkguA1DaLF+T+a8GL3UNaz8hq0BiHr4Z
         8EtWMIOGbouieDhHgj2gB+A2jWssbCAz7y/BuZT3gSxxzMIyrDtfu4gdP4N/D2ETMSN1
         nxoMA4BLlmOPprt4k6b7PaeJLZgiUInRZq6v0DyB8lUozh4pQrBPfmFWefCkYrivekv5
         xCfCBEycYSQ4yjxtthonW/rGCTB1lHysVh8O8hYIA+qaVfGu1pQPOwRYe6pTZ3axggdU
         VrzNwuS6CQqDGQMK40TbKn2xOfGufayiZBj6CxAfE+uaBduxRkmFaDbduq4Pu7/UljyK
         L6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ahjwf9HqwEUWxfT27RhcaX1vAqu39xvQmFxCmdymgYk=;
        b=K2KWQAVd1lKsZG1daGcfAoxQEjaSH6OSt1OJvaNNLPr8Rvf3ZU9azVM/9N+8poQIJm
         JIG+CqRbzDioRimoUUHdMnR7ZNMzmw5ujvh96LVQYkhSO2DonPBQrGrnAWCOSMU+A5zW
         0foLgY7xIE6wBxbG5YpAblDZ/+rXanaDQMeXPcjW/xfjO8yF7eo15xIlqdqos5Dcmrq/
         O44YXNVW3Wc+vI3xPzPFxy/aW7ayHimKadic04oTaIhOIhpimRS4STNTiuvVSlQchEAE
         EcjF5+AO4kz3gcT+qGNViprTd6dwOdUtyl9epITlqc4JVdmaUcanep/O6rIYQobbZMfb
         UsSg==
X-Gm-Message-State: AOAM530PgWslfQG/jM7DQxKP5Z4/T94K/U3L5PtylrgLga/ctUbGNls6
        Lk9AWU2T3Od8kpidJNeDgMyFbg==
X-Google-Smtp-Source: ABdhPJx447qGBHdeQmiSJ8K60QjlehV4Ec4hD8sNWp3QYYcv21yKlryC3Z9/n8ORV/uPsantb0hF5Q==
X-Received: by 2002:a37:44f:: with SMTP id 76mr13025187qke.161.1624645810318;
        Fri, 25 Jun 2021 11:30:10 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id l1sm974449qkc.93.2021.06.25.11.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 11:30:09 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: rtl8188eu: remove set but unused variable from rtw_get_sec_ie
Date:   Fri, 25 Jun 2021 19:30:07 +0100
Message-Id: <20210625183007.7065-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set but unused variable 'sec_idx' from the rtw_get_sec_ie
function inside core/rtw_ieee80211.c, to fix a kernel test robot warning
introduced by recent removal of erroneous debug statements.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index e431914db008..ce82b866c633 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -465,7 +465,7 @@ int rtw_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher, int *pairwi
 
 void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie, u16 *wpa_len)
 {
-	u8 authmode, sec_idx;
+	u8 authmode;
 	u8 wpa_oui[4] = {0x0, 0x50, 0xf2, 0x01};
 	uint cnt;
 
@@ -473,8 +473,6 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 
 	cnt = _TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_;
 
-	sec_idx = 0;
-
 	while (cnt < in_len) {
 		authmode = in_ie[cnt];
 
-- 
2.31.1

