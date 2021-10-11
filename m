Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1A74297FE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhJKUOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbhJKUOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:14:30 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6520C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 13:12:29 -0700 (PDT)
Received: from dslb-188-097-046-226.188.097.pools.vodafone-ip.de ([188.97.46.226] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ma1er-0004mk-Jz; Mon, 11 Oct 2021 22:12:25 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/8] staging: r8188eu: remove LastMinUndecoratedPWDBForDM
Date:   Mon, 11 Oct 2021 22:11:55 +0200
Message-Id: <20211011201159.10252-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211011201159.10252-1-martin@kaiser.cx>
References: <20211011201159.10252-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LastMinUndecoratedPWDBForDM in struct dm_priv is not used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtl8188e_dm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_dm.h b/drivers/staging/r8188eu/include/rtl8188e_dm.h
index 0dec2828a3a6..4a0608313f7a 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_dm.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_dm.h
@@ -26,7 +26,6 @@ struct	dm_priv {
 	int	EntryMinUndecoratedSmoothedPWDB;
 	int	EntryMaxUndecoratedSmoothedPWDB;
 	int	MinUndecoratedPWDBForDM;
-	int	LastMinUndecoratedPWDBForDM;
 };
 
 void rtl8188e_init_dm_priv(struct adapter *adapt);
-- 
2.20.1

