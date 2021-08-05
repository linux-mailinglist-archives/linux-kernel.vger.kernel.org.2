Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5E23E1BE6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbhHES7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242107AbhHES7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:59:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31F1460F01;
        Thu,  5 Aug 2021 18:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628189925;
        bh=IqXLzr/OLEXLF6zqTtqsk+B9+EiwaEbC1W4SSsIHGbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWLNpI6bhAYguYTIQlQYzBZMdJBcsm4IqY+fuRonMlyBqdFvEEQ0gBr5TrgbEDhnp
         j7L6VeeNWuOOoIzJ7qSB0fkKEruZktIoytGmvw/I3CriKPvjqXPDHbJLt+ycGe2X7B
         qh2XdyltJCTvJvwDYJgzOOptlXHH7LxAaPSEehpTOHf8uvVmBK0h2X9pGwvBxh97sq
         KfyE0NsSn8NUwFOqztp6sf215ukakymtn8dZtllUVpJ+Fuz2apCzDorNrEvwAzW0SH
         b/T1Q4CpO8CiLakpMFTOK818jjUoVauUGlpbScwOfGBLL0IhJOqXApd1Nr5o30eDUn
         hh8mjjS5lXOEg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 3/3] staging: r8188eu: Remove pointless NULL check in rtw_check_join_candidate()
Date:   Thu,  5 Aug 2021 11:58:07 -0700
Message-Id: <20210805185807.3296077-4-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc0
In-Reply-To: <20210805185807.3296077-1-nathan@kernel.org>
References: <20210803223609.1627280-1-nathan@kernel.org>
 <20210805185807.3296077-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/staging/r8188eu/core/rtw_mlme.c:1629:28: warning: address of
array 'pmlmepriv->assoc_ssid.Ssid' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (pmlmepriv->assoc_ssid.Ssid && pmlmepriv->assoc_ssid.SsidLength) {
            ~~~~~~~~~~~~~~~~~~~~~~^~~~ ~~
1 warning generated.

Ssid is an array not at the beginning of a struct so its address cannot
be NULL so remove the check.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index e3d5a721d25c..95b952871e67 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1622,7 +1622,7 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 	}
 
 	/* check ssid, if needed */
-	if (pmlmepriv->assoc_ssid.Ssid && pmlmepriv->assoc_ssid.SsidLength) {
+	if (pmlmepriv->assoc_ssid.SsidLength) {
 		if (competitor->network.Ssid.SsidLength != pmlmepriv->assoc_ssid.SsidLength ||
 		    memcmp(competitor->network.Ssid.Ssid, pmlmepriv->assoc_ssid.Ssid, pmlmepriv->assoc_ssid.SsidLength))
 			goto exit;
-- 
2.33.0.rc0

