Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BD9374971
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbhEEU2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbhEEU2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:28:06 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E18C061761;
        Wed,  5 May 2021 13:27:03 -0700 (PDT)
Received: from dslb-188-104-057-152.188.104.pools.vodafone-ip.de ([188.104.57.152] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1leO6m-0003aS-0o; Wed, 05 May 2021 22:27:00 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/6] staging: rtl8188eu: remove padapter from struct mlme_ext_priv
Date:   Wed,  5 May 2021 22:26:22 +0200
Message-Id: <20210505202622.11087-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210505202622.11087-1-martin@kaiser.cx>
References: <20210505202622.11087-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct mlme_ext_priv is an element of struct adapter. Use container_of
to get a pointer to the enclosing struct.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c    | 4 +---
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 50d3c3631be0..25118ca08562 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -4017,8 +4017,6 @@ int init_mlme_ext_priv(struct adapter *padapter)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
-	pmlmeext->padapter = padapter;
-
 	init_mlme_ext_priv_value(padapter);
 	pmlmeinfo->accept_addba_req = pregistrypriv->accept_addba_req;
 
@@ -4041,7 +4039,7 @@ int init_mlme_ext_priv(struct adapter *padapter)
 
 void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
 {
-	struct adapter *padapter = pmlmeext->padapter;
+	struct adapter *padapter = container_of(pmlmeext, struct adapter, mlmeextpriv);
 
 	if (!padapter)
 		return;
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 03d55eb7dc16..fcf366f9be90 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -383,7 +383,6 @@ struct p2p_oper_class_map {
 };
 
 struct mlme_ext_priv {
-	struct adapter	*padapter;
 	u8	mlmeext_init;
 	atomic_t	event_seq;
 	u16	mgnt_seq;
-- 
2.20.1

