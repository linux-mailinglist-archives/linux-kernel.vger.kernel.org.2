Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15BB35514F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbhDFK4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhDFK4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:56:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE6C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 03:56:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a12so3945948wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 03:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1OdVdRoE2zhBD6rueqcaxE65GfvXBrF/yJr7/CuoJo=;
        b=hH91VRw7grrA/ma+05HwprBB4SWH0PZOL2v6GaYzgcar6w8RimAebXwQ0r1WqEbU3F
         2LqKCCbqWQjEokmMQnzjO+k1KIwE3JhktahVYlWhKxIQ62dqTYIE+cirsW1MbpHs9que
         o94nVwOMtuN7jHkOZiA63gb2nere09fid76p6MaVjNI1G2g4GbCn3nZbkln7vZP9iDwV
         Lh5w2umCi+tjzA8XvAk+vbRn5+pa0aaQvxSEbSNir9qZjaSVEPtTXxR9iybi/Pp0niLA
         QbCYWtfk9oU6ElBYBTmMw4mRZQmDpJMlC1LoAhwH60zEQ5aNgZHTITjFNUk3LP70d+0U
         OYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1OdVdRoE2zhBD6rueqcaxE65GfvXBrF/yJr7/CuoJo=;
        b=h8l00JKTegt//R2fIhQ6h/DGEZYzX85nJoechNnpiJFQOxpkqKDXW47C4FvBRY6hDX
         NEvY9YDZexoFJcJrwrcDlk2TtKIlGO6I/1cdj4UUFT70P4UApjMOAxXfl7ADCYRD8i11
         Kg2thInRfR7Xa+zzR/kubbKoSq34E6xwSNqyGLI42ltXT9iPPCbGx9O34OxnQ6b2uPL7
         8VnxRtrotJk55sHKU4pJ8V2KwejRfdDoGg+q5a9jN2DI2py/K65PW9A/L9iuARMSTgPu
         VsDzv5F8C9xZp+Zw5oQrb39jco0sjBCHG+KqjqeK/bGWuNSmrqZuZ5Q01yCYumXVE8lt
         v0fQ==
X-Gm-Message-State: AOAM532DQdrz0bND24dbd4555CTgtP6bbvYiyH1SI6k6ZM4pVmoAPKXH
        s7r4MhM5Umr+0EPiQaFILpf8uQ==
X-Google-Smtp-Source: ABdhPJxrLzBsqhvzZyPqBM+u3AzvgfmTytgOO3UgoVYMi1dwP3EYYqHD4fx9yq+TjIxfwAEfUYinXw==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr34278705wre.183.1617706569128;
        Tue, 06 Apr 2021 03:56:09 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id x1sm20673504wro.66.2021.04.06.03.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 03:56:08 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     ross.schm.dev@gmail.com, fabioaiuto83@gmail.com,
        dan.carpenter@oracle.com, insafonov@gmail.com,
        marcocesati@gmail.com, pterjan@google.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove unused variable from rtw_os_recv_indicate_pkt
Date:   Tue,  6 Apr 2021 11:56:07 +0100
Message-Id: <20210406105607.1689292-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused 'ret' variable from rtw_os_recv_indicate_pkt function in
drivers/staging/rtl8723bs/os_dep/recv_linux.c as nothing is actually
done with it. A function return val is conditionally stored to it under
certain circumstances, but nothing is done with it after. Fixes a
warning from kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index fbdbcd04d44a..f6a9482be8e3 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -98,7 +98,6 @@ struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_L
 void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, struct rx_pkt_attrib *pattrib)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	int ret;
 
 	/* Indicate the packets to upper layer */
 	if (pkt) {
@@ -140,7 +139,7 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, struct sk_buff *pkt, str
 
 		pkt->ip_summed = CHECKSUM_NONE;
 
-		ret = rtw_netif_rx(padapter->pnetdev, pkt);
+		rtw_netif_rx(padapter->pnetdev, pkt);
 	}
 }
 
-- 
2.30.2

