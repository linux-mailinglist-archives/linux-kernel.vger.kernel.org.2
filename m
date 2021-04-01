Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258F235202E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbhDATzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbhDATzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:55:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F01C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 12:55:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c8so2906114wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 12:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8S3Uh23H+gQhsf7YASK94vXEdzHi8M0NhOcwtIIfD7A=;
        b=FhBhCegfx9/JsWqLF1NrB74XyOFOPKGNuaiYUD+JF/Zj93OlXZR4UpVjGkZMDsBgPD
         E5ePdeCeKbf5jfa72arvobZIwCXXaklwXo+i8gVdj/7TgseX6xjTXMtlYJmyXdnEW9mE
         R6RLUZlv3qnOhLaoeTeRfSXiibcxF6/3YvT0v/xv/Fm7tS4kx6jNy+GyjPbuXeDoIFgO
         254MlEJ6mPlN16Sfya+TpS+K/4k6zISSYVkeut7cdZ0CGB+6piNc7+rQwPgQNDZBXoB0
         47Pb5zIq4aMpWr7iFOBeBFeYmbMq82piF6TwdPSN9Z9eqTCh+7JLQy+K0IwGBr7751Bm
         dwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8S3Uh23H+gQhsf7YASK94vXEdzHi8M0NhOcwtIIfD7A=;
        b=CsmOhsUVhpkVbgHL58Rb5x7VIHLXRwyPG91fPwNKQGdzXy4aSMsnZ6r1UtZ+7DdUv3
         99DnfisaN19vvFfU5tnfjxt1yAuvz5plg1KOhV//2HZrfnSMWBM1zmA8Sa9m/tEVlnuv
         Wlne6xwD9GucWqeverUW9NFyN7UebYrTsUpT2Z18IKJnptvGCUeJgHMo9Bzlj+1SnPPD
         5tROOBndSoF7g5ULjho0L832ZdVIhkPojOYqrQYJDLD9bdhZoZTKCguaFjgdNHoJtR/j
         oyZ0xIq9szj1CytlOPKvtpGlzXuc2SbzjfxVb7s87p8q+23bua+6zj7+Wq4rRER9ZBRX
         QIgw==
X-Gm-Message-State: AOAM532I0SACvLf2REB/oAexk3hmcJjKFqjawpQGyINXlza2dGEyvpH+
        amNq+CzQzQntOKbcNFfjIiU=
X-Google-Smtp-Source: ABdhPJw9bgeLnJNYJeVIVw3MDkoM4Wqo9MBHU865z+GZRI/p9r6gGaG4WUhqGjNpKXiYVvpD+Re/+w==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr11730071wrs.94.1617306900074;
        Thu, 01 Apr 2021 12:55:00 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:a182:b5f0:9f7c:c891])
        by smtp.gmail.com with ESMTPSA id s8sm11097662wrn.97.2021.04.01.12.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 12:54:59 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: emxx_udc: Ending line with argument
Date:   Thu,  1 Apr 2021 20:54:57 +0100
Message-Id: <20210401195457.24512-1-martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up check of "Lines should not end with a '('"
with argument present in next line in file emxx_udc.c

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 741147a4f0fe..20f53cf6e20f 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -1073,9 +1073,8 @@ static int _nbu2ss_epn_in_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
 		i_word_length = length / sizeof(u32);
 		if (i_word_length > 0) {
 			for (i = 0; i < i_word_length; i++) {
-				_nbu2ss_writel(
-					&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
-					p_buf_32->dw);
+				_nbu2ss_writel(&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
+					       p_buf_32->dw);
 
 				p_buf_32++;
 			}
@@ -1225,8 +1224,7 @@ static void _nbu2ss_restert_transfer(struct nbu2ss_ep *ep)
 		return;
 
 	if (ep->epnum > 0) {
-		length = _nbu2ss_readl(
-			&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
+		length = _nbu2ss_readl(&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
 
 		length &= EPN_LDATA;
 		if (length < ep->ep.maxpacket)
@@ -1462,8 +1460,7 @@ static void _nbu2ss_epn_set_stall(struct nbu2ss_udc *udc,
 		for (limit_cnt = 0
 			; limit_cnt < IN_DATA_EMPTY_COUNT
 			; limit_cnt++) {
-			regdata = _nbu2ss_readl(
-				&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
+			regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
 
 			if ((regdata & EPN_IN_DATA) == 0)
 				break;
-- 
2.25.1

