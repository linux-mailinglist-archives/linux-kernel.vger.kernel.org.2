Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F79356DD4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347749AbhDGNuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347705AbhDGNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE7AC061763
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f6so11986777wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JsWUwV7KAjqM45vzWaT6+SgSOJnPCweW1Y3r8QJzpE4=;
        b=aInYbfHYrC4Emn8AqHBaEY9mMpb5kEgClsYuxLEfC1iw1U0I5MNb3ykWb1qWZXnDI9
         2soS6Zql2mvgXY9rTClq7xYJyPfbyBsnUjAgp+QKBMutWtIUz2dFF7k9uQA1vbZKeOdo
         Tj2tEix+7RfXuCyNb3cN1iiaIJ/tOnNGoeIzKiJ8U7Eoq9GnP1n8r0voesDFlMkqg5jF
         1kyX2TOqE/7IXTJ2Yql2laRELQvjr7DY6xrjajfFQqfLCLdVodcXL5lKRM+tx/H7c0lR
         vcUzYeHWceMwGmlEcdxtjjHXZfm6+aRjgu7TQKCtLVpM45Ws7kUadAcniNf+ItMDzDwr
         OLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JsWUwV7KAjqM45vzWaT6+SgSOJnPCweW1Y3r8QJzpE4=;
        b=tAm7PFfKuNzTCnd0BakXStty4fdBbGZQakAoy6GCxwaQxzHLRA6fSLPV41Jy4sIxZ8
         cwgFg6iyYGmSSrmIGPt5/2s0IIte/xIPBMz3/Jm+up439mG9KKQDVUaaE/dEDdCMrqGP
         gw5nbUaZd99Vd1vk9EulaZGtxE7fIXxuac+RtxPeBRTt3sfKwjm0ULytm64qeV0qe5pk
         Ff4SHNt6oYiucr4c5amB+Q7+vuagTzCSyYdClSY8d+s9lLygmfyxLPLCbyjvfeX7K04g
         hb8dqwQVU8gIqQ8T2qAsEEGV4x/Y1yzUkDpfDBViLT4tSiaQeY6b/rEk2GE+rUrZugHC
         aXMw==
X-Gm-Message-State: AOAM531OwyCEZa91sJ3rm5VxyVll2RYthn9K4pqfCmM9J6fjRLz2Ai40
        OPLAy4scaxqcpif8cOWHMc8=
X-Google-Smtp-Source: ABdhPJzgS6Tu/2d3tjY5KJWe5t5vcuF1kCGzWgViKTqjNPXo1TU/1RgU/j9gdQJ0JMqgNaNhji22Tg==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr4614965wrr.58.1617803407262;
        Wed, 07 Apr 2021 06:50:07 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id y11sm18078310wrh.6.2021.04.07.06.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:06 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 07/19] drivers: rtl8723bs: rewrite comparison to null
Date:   Wed,  7 Apr 2021 15:49:31 +0200
Message-Id: <0c6d53c851d1b07eb0183108e0bad7b4f273f04b.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkpatch warnings:

CHECK: Comparison to NULL could be written "!psta"
97: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:2115:
+		if (psta == NULL)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 30afe9f4ceef..e7712391a87d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -2103,7 +2103,7 @@ void rtw_ap_restore_network(struct adapter *padapter)
 	for (i = 0; i < chk_alive_num; i++) {
 		psta = rtw_get_stainfo_by_offset(pstapriv, chk_alive_list[i]);
 
-		if (psta == NULL)
+		if (!psta)
 			continue;
 
 		if (psta->state & _FW_LINKED) {
-- 
2.20.1

