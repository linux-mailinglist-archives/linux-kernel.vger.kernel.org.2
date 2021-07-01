Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC7F3B943F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 17:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbhGAPtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 11:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbhGAPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 11:49:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC9CC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 08:46:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u8so8824179wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LnVmENkMzBPYFYRO7NPCY2zA2KVOkF51h3Z74m5eLEA=;
        b=NMeu16Su6dWBjbvi8soHdm25qUAZlr3uAaWX7w4pd2h0vH2er/oD8fvef5hThRdtpN
         3rwce683xdcOKO2VgWkD5H3Fte6Z/VKCTi5A9XXIeaSWoX7hJIhVgPRn01A6mFu7SaHJ
         jBCjl+8WZZlnuAtvQaX5WBuZG5OQZoshYoETmW2oVnIur8E1rHFZ5uoniFKLXE7wKcbU
         9uNaLXKqRt67i0dZ0ufPnAm5H3e6KzxMPXfI/ojaIUNTbkBR25Av6eiXFp5cFVqzzAfW
         UFw9+PAYyYErmH+Fe0nz3NA+FfDr1OULGy4khwDk7x7c9LhpZFcYSSlgBqt3pVr4hf7G
         CvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LnVmENkMzBPYFYRO7NPCY2zA2KVOkF51h3Z74m5eLEA=;
        b=SLYqI1fgtsNQ+GkoDEgiNr2GV2OQcPTASMzUmQo26KPLHumfZ1RDxD54xsv/Fu5yqk
         aDKUTx10VsThNjXVva4vbWYxiyz9OWkqM1OBsDAJoXHAQDhl9Kh0MXLSDDCPCeUVSwfl
         ntJHsRBDO3Qb+oJKoBn2E0jeyIwDlJaH5GgXAvaUSliTJMcCvc6tx+Z7JNcH7vzoVoWd
         z6j8JMA/l6fLtEACj7yXqyQPiWt6PN0NIIRTpY1MW7oMPnEfyj6HnX9eptH0bhH1A0/W
         cJ3VQUhgpU7PlMD/WgO2/iKyk5WBEQhgOOEtXcoFH6uCG5CWbjcPHX3+THG5wzF4i3/o
         PY6g==
X-Gm-Message-State: AOAM531Bt8+EUTlNun3x1dojhy2XIcJMKl4AvQZa1Uk63eG+Z5xk/0jI
        NUmQzzSF4RFfsCTY60crrng3y/6FZcGUig==
X-Google-Smtp-Source: ABdhPJy8kfxl9RnPkdTVZwCLnkBmWwMsdlNumF3X0wt8s37N3rGVNZUXwXY057azXU7qhElAFUptiA==
X-Received: by 2002:adf:ef8b:: with SMTP id d11mr368471wro.346.1625154411339;
        Thu, 01 Jul 2021 08:46:51 -0700 (PDT)
Received: from linux.local (host-80-181-152-252.pool80181.interbusiness.it. [80.181.152.252])
        by smtp.gmail.com with ESMTPSA id o11sm309807wmq.1.2021.07.01.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 08:46:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: rtl8188eu: core: Remove set but unused variable
Date:   Thu,  1 Jul 2021 17:46:47 +0200
Message-Id: <20210701154647.18975-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable sec_idx because is set but unused. Issue detected by
GCC with -Wunused-variable.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
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
2.32.0

