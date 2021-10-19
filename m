Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7418A433FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhJSU0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhJSU0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:26:31 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59328C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 13:24:18 -0700 (PDT)
Received: from dslb-178-004-168-180.178.004.pools.vodafone-ip.de ([178.4.168.180] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mcveg-0003ho-3Z; Tue, 19 Oct 2021 22:24:14 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: fix memleak in rtw_wx_set_enc_ext
Date:   Tue, 19 Oct 2021 22:23:56 +0200
Message-Id: <20211019202356.12572-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free the param struct if the caller sets an unsupported algorithm
and we return an error.

Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 4f0ae821d193..4e51d5a55985 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1897,7 +1897,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 	struct ieee_param *param = NULL;
 	struct iw_point *pencoding = &wrqu->encoding;
 	struct iw_encode_ext *pext = (struct iw_encode_ext *)extra;
-	int ret = 0;
+	int ret = -1;
 
 	param_len = sizeof(struct ieee_param) + pext->key_len;
 	param = kzalloc(param_len, GFP_KERNEL);
@@ -1923,7 +1923,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 		alg_name = "CCMP";
 		break;
 	default:
-		return -1;
+		goto out;
 	}
 
 	strlcpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
@@ -1950,6 +1950,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 
 	ret =  wpa_set_encryption(dev, param, param_len);
 
+out:
 	kfree(param);
 	return ret;
 }
-- 
2.20.1

