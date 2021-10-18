Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A306B43299B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 00:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhJRWPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 18:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRWPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 18:15:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A5AC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:13:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o20so44067674wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kRNm4UtdNQv+PW99X+CVETEWwDBlU3O2UZG+/c3QddE=;
        b=fjddBJEW/OkoB4qQL4Ro5vzCDwC5h26o38XOXzIXpMrj+5Y94xMarSYrsvrtNgpqzV
         ky9pUmp3W3Udw9FlAxLn3WpiOvedgGeXEBYOrUsozjpKd0ClhQQ0vkpdKLY9a+CyxTgt
         FTqE3vknxO5C0UrpM2NNTLi0E3smsUkapmlnge7HbaPwEgdr0cT2r49+aQBsHBJ38dmx
         Y7qHre0tRD/ZlaOucPUdVZSe5kmU3COgtyoC1mbbh/1PRfsx64wKXlMFeYSDuQh6aKGT
         yywRXTU/GrwD1q+HVLtiCZJ/n1cd9YkbcoDpIAbg88qOGO54RVH2QiOTH1PhGn6cWIVb
         xF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kRNm4UtdNQv+PW99X+CVETEWwDBlU3O2UZG+/c3QddE=;
        b=4elafx974KAj73le5Qvz88I4BBwpQ32GXxeWR8s+zMGyST6FiBVrvFnh94slhwLFGC
         No32233W42Sk3ZizgmjW1BrBSnLj9YniMG7RxQyYUYCh3E5S1IQ8U73T/7x6QpcXTYux
         ArRtoszGKrvn/zFxjmiuHGB17HvDxwZ7/S1VJNbSdVeEdM80zeoqg/VLhFcXi85pXU1z
         2zqPQGndhDofolvuSWo19tg8QFq3Xs5OOZBHnQixm2E28nKvIkIfgLLI4yaAPUawyEdT
         a5znyFnQ1CcnX6NyiQ2eznTRE3nh4LZUJnqVK8MPyriszVdsz0ZK25wdtxI2jnv75oAx
         1f5A==
X-Gm-Message-State: AOAM533rqaC8bGlKnR+l6YQYtmSra1m6OGpb72xIP9pvM2rzIj8+RjKA
        Nyd39EzUfkXufQTEhMQUIhw=
X-Google-Smtp-Source: ABdhPJylOQCdtsGopOI5UCn+0xnPACYs2rc0/Oh50iHHgDQ72g983PEMwdSlggVivRWyGD0vdyWw1Q==
X-Received: by 2002:adf:f60e:: with SMTP id t14mr18554206wrp.373.1634595207440;
        Mon, 18 Oct 2021 15:13:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3de4])
        by smtp.gmail.com with ESMTPSA id k8sm683484wmr.32.2021.10.18.15.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 15:13:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: fix a gcc warning
Date:   Tue, 19 Oct 2021 00:12:31 +0200
Message-Id: <20211018221231.7837-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace strncpy with strlcpy to fix the following gcc warning.

drivers/staging/r8188eu/os_dep/ioctl_linux.c: In function 'rtw_wx_set_enc_ext':
drivers/staging/r8188eu/os_dep/ioctl_linux.c:1929:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
 1929 |         strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The destination buffer size is IEEE_CRYPT_ALG_NAME_LEN and the length
of the string to copy is always < IEEE_CRYPT_ALG_NAME_LEN. So strlcpy
will never truncate the string.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 51f46696a593..4f0ae821d193 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1926,7 +1926,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 		return -1;
 	}
 
-	strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
+	strlcpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
 
 	if (pext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)
 		param->u.crypt.set_tx = 1;
-- 
2.33.0

