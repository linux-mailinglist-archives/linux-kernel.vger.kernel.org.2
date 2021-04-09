Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E4035A83B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 23:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhDIVJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 17:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhDIVJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 17:09:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2EFC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 14:09:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f8so8084661edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BE/sO/QIsgS08xgGIDAuaxu6FsfCPL2BQzsolVE0VXk=;
        b=N+1PFMh1b5oDM1cWje1O56dNuUpbnySeg/+x4JhSBYElqm2GJis7tCKQXTYMlihEaC
         lxEkreEjJyBA9OePPaoM9omphJL6pLZFnYb7klChJi18z8ScyansQ/QGwXjQIVt4qZGL
         8wfNW4VZCz4YBndTgP04sLfHODGAUCFXByG2LVPVDyJTpjqhQIz8L8A0unk3Lj7fZeE4
         vI4Ju4MdeMG8sTcG9mR1HByGt8acEVQeSGw4f6IJPvLMyEBdYPsxUnIdgQvof5EK/Un1
         r1HCCNLmJc5j4BzQt4EOj9Ec/aML2WMwi4Y9pWrNtxBj1d6hjnZwwKqWRvjFwvc6vo8+
         N4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BE/sO/QIsgS08xgGIDAuaxu6FsfCPL2BQzsolVE0VXk=;
        b=S6VdVm8eHT8cC7we6levI6uYbTXWKYuQT+9Wijyow1lYdgOFlu7p8B8qTJ24ItPwaX
         Apn77XbI5ZP7eFAEQalenahnYLmQFC9/ymzckU5t6ZZ0RwDVXDTEQBjzTVusYimhd5Xr
         K85/UYAc53+s9foP/j43pnaUkZ+61ZQ4vBvyaYYjRh3ja45VdTlZ4xRNlEQgy5FBmP2b
         hv+VKzvvrWcjIhz0RpFz5x8RtrGppDdWSKkV8Oau9J2QwhCS8b3RAXMpgVPvgMINBgvN
         XBx3DEmMG26J2xVBL9LHpGfA92CU9kfUBMsDEa3oBHjsbQvJaocfiFtCqqN44Adr40Kj
         9R+A==
X-Gm-Message-State: AOAM531EnjdnfKJrsvE2BHr0xcEYlTu/sKHspEVOdTOmaPMts7VruB8y
        rbaxB1poZ+ZhDMnEX+CnjOo=
X-Google-Smtp-Source: ABdhPJyZ3S3cbChUqr3ANaPVfAXGg5iiy/AmFVt6v3GWNfaEj9nrFdc47a9l6E6gcHDXJfHwnGWApg==
X-Received: by 2002:a05:6402:9:: with SMTP id d9mr19208090edu.67.1618002568153;
        Fri, 09 Apr 2021 14:09:28 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id hp12sm1738467ejc.46.2021.04.09.14.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 14:09:27 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH] staging: rtl8723bs: core: Remove an unused variable
Date:   Fri,  9 Apr 2021 23:09:18 +0200
Message-Id: <20210409210918.21432-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete local variable "u8 sec_idx" because is declared and set, but never
used.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 2af66a18200d..3fd8a4261ea2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -628,7 +628,7 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 
 void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie, u16 *wpa_len)
 {
-	u8 authmode, sec_idx;
+	u8 authmode;
 	u8 wpa_oui[4] = {0x0, 0x50, 0xf2, 0x01};
 	uint	cnt;
 
@@ -636,8 +636,6 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
-	sec_idx = 0;
-
 	while (cnt < in_len) {
 		authmode = in_ie[cnt];
 
-- 
2.31.1

