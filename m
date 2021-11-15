Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4187845169D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 22:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348846AbhKOVfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 16:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241304AbhKOSTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:19:24 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48AFC03D78A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:41:13 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id s16-20020a170902ea1000b00142728c2ccaso6471061plg.23
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XSnFrX4vOBH2CiIU/qHkztLKN4fBQ+SvI2DExgQ65r8=;
        b=oNtjj4Rl89EzGdss6oJFKeeEMRAKCgllqF3g/xxcRcmaRgtZPkc0ckLqauurmQNhO0
         xqpz7utjM3iOsEOeDt4zNgefRE1HqUxvSX6GAoGTx+OZmUslswylSbT1IAQULIMfjTsL
         LMcvKS1Liqb0NyP+drCjf5OrwQpR6Ef5OgOtLONPGRo4xKMjo91JQStddMwCugfJ/F7p
         7eRyWWGnmP5JJl3ysZQ6qeIL07/Cz7tE7BETJQxgZoLHhBOC5tM2K4h+ZJgz1BagxBIn
         5Eq6SPV37YJPgyqDxufGq8EuYUUap0QG7JoTEitIICk6ICI4wl8cQlTX7N0p5qZBYqJM
         Z9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XSnFrX4vOBH2CiIU/qHkztLKN4fBQ+SvI2DExgQ65r8=;
        b=R5VRbLHf/GPb4HYZTYM7rT/Gt6L8tctMZN9WFrybaQCB3l2IqDm0GGh2Zey2+6wN3b
         3RESJ2TDypmi68Ay5B35FIA97OfcLFEZuVxayeFqP9Te3kUYFerUvG31xcETAM0Jyawj
         2Tt1uomRvLG+IJxoW7Q+Awd+I8w1Jzl6Ca7R3QWncUvzANk9WNLSqo36NsVvutWz9hnJ
         vYn8NNwfyBiMrMQB+ccdkTrMMZTXBbUud9xrgEX1praRmhQK52ohVS3RUSFqC8sUbnAE
         GfitbO/JEDpoAVCYvAHzkVo4knYK+ks3UukX1UIZ8sBGg+wtVPNTZ4i4GDpmhfUIE/Ox
         lBGA==
X-Gm-Message-State: AOAM530GpziDvJxO/gf5xB2FCooXO5J2EyflPlmP7/nShVG8ub4cp7jh
        iiqwAjPoNVsYjq+QPleyuYgpsERaUQw=
X-Google-Smtp-Source: ABdhPJxXi5Va595+O/8kWGjwRtPpapuz5Zzqs44PTGrMRvnQ5wx8aTXov/8IBSk0O+opYJ8FCyhYUAzVukc=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:9fb:192e:3671:218c])
 (user=pgonda job=sendgmr) by 2002:a05:6a00:158a:b0:49f:be86:c78f with SMTP id
 u10-20020a056a00158a00b0049fbe86c78fmr34728768pfk.56.1636998073159; Mon, 15
 Nov 2021 09:41:13 -0800 (PST)
Date:   Mon, 15 Nov 2021 09:41:01 -0800
In-Reply-To: <20211115174102.2211126-1-pgonda@google.com>
Message-Id: <20211115174102.2211126-5-pgonda@google.com>
Mime-Version: 1.0
References: <20211115174102.2211126-1-pgonda@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH V4 4/5] crypto: ccp - Add psp_init_on_probe module parameter
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     Peter Gonda <pgonda@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marc Orr <marcorr@google.com>, Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Rientjes <rientjes@google.com>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add psp_init_on_probe module parameter that allows for skipping the
PSP's SEV platform initialization during module init. User may decouple
module init from PSP init due to use of the INIT_EX support in upcoming
patch which allows for users to save PSP's internal state to file. The
file may be unavailable at module init.

Also moves the PSP ABI version log message to after successful PSP init
instead of module init in case this new parameter is used.

Signed-off-by: Peter Gonda <pgonda@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Rientjes <rientjes@google.com>
Cc: John Allen <john.allen@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/ccp/sev-dev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 8e388f6c9b05..ee9f194d460e 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -43,6 +43,10 @@ static int psp_probe_timeout = 5;
 module_param(psp_probe_timeout, int, 0644);
 MODULE_PARM_DESC(psp_probe_timeout, " default timeout value, in seconds, during PSP device probe");
 
+static bool psp_init_on_probe = true;
+module_param(psp_init_on_probe, bool, 0444);
+MODULE_PARM_DESC(psp_init_on_probe, "  if true, the PSP will be initialized on module init. Else the PSP will be initialized on the first command requiring it");
+
 MODULE_FIRMWARE("amd/amd_sev_fam17h_model0xh.sbin"); /* 1st gen EPYC */
 MODULE_FIRMWARE("amd/amd_sev_fam17h_model3xh.sbin"); /* 2nd gen EPYC */
 MODULE_FIRMWARE("amd/amd_sev_fam19h_model0xh.sbin"); /* 3rd gen EPYC */
@@ -305,7 +309,10 @@ static int __sev_platform_init_locked(int *error)
 
 	dev_dbg(sev->dev, "SEV firmware initialized\n");
 
-	return rc;
+	dev_info(sev->dev, "SEV API:%d.%d build:%d\n", sev->api_major,
+		 sev->api_minor, sev->build);
+
+	return 0;
 }
 
 int sev_platform_init(int *error)
@@ -1110,16 +1117,14 @@ void sev_pci_init(void)
 		dev_warn(sev->dev,
 			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
 
+	if (!psp_init_on_probe)
+		return;
+
 	/* Initialize the platform */
 	rc = sev_platform_init(&error);
-	if (rc) {
+	if (rc)
 		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
 			error, rc);
-		return;
-	}
-
-	dev_info(sev->dev, "SEV API:%d.%d build:%d\n", sev->api_major,
-		 sev->api_minor, sev->build);
 
 	return;
 
-- 
2.34.0.rc1.387.gb447b232ab-goog

