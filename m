Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC144304C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhKBO0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhKBO0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:26:18 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB372C06120C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:23:39 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z187-20020a6233c4000000b0047c2090f1abso12006120pfz.23
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eKW1MHsHQDoXENEgPhRYyUnBRHGSJfmJzWx+eKoMHHI=;
        b=hN5ApV6fAKbY1X/1kLS6N4R8Fn6gxuxQgit5pkn/H7KDDISaXwUZMN3sudewY1r3nq
         SLy2d/RCriMBir9LjSfcf6XsC41QATE1SO/5PnJbDjXnBP08a7FqHORaDdfhhhxhmEY9
         Y9YnV9ml/zJatIT0jOnAOVxEef2gCHSyYDsbhS6ouoxYfEkqq6fr9wVtuyzXYXwcDSD6
         PDs7ql4oP7CJ3iyfnsK+/YpkTvEpgQvujr8O2H0LbleKqwqUkb/USrKMOq1KqXtMORdy
         EE/7LTWVIZDHIUAYfDIcM4niNkpsShvhRS4tQP9P7uQdhZ+0o+///xjzwTuWSxPBv0kS
         QXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eKW1MHsHQDoXENEgPhRYyUnBRHGSJfmJzWx+eKoMHHI=;
        b=Q1/upZrqKhg4XhIvO/q/bz942JSgTFYGhQoNXmulKeVHy5eGA9wjNpvaA/qgvBrGdZ
         18TrufcDKWKPDPOd1AkMiyPsYfmmwwwH5JRagmySGrufscWkHROabW008/kinjfTPNrv
         rVi83sfqz9dDPuv558a7o82zrnEzXFIJryOvtoeCfzxXEutnZxbGrnBz9xE6gzm4V+Pc
         C2CPzA5wtJosKv9cIv4oXzZPccb5Ur49hZPjsJpNGkyjQN83VO2sJB7U2IlWuOXc3MQs
         v5eaOP5UWewm2xN1ilyTihVoUiR3bh5YPHe5LhkroqBFMqYN2fk2sXBdqMrjphF7gV7A
         feXA==
X-Gm-Message-State: AOAM533mh6m3Mv/vjFwA1AwJmPizyyuPRD1dUK6gEb4ZFqQPyYYDQNSi
        dZe+JDWKlRm+d9PEy+sKSnIkF3wiUTI=
X-Google-Smtp-Source: ABdhPJxS9KO380TsnTeSwizEoAhyC7xPnb22rfVT3Wny3ufjxSSsiS2U5MvlRugjtsPi2jVw2ip60IjP4l0=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:3109:8497:f59d:9150])
 (user=pgonda job=sendgmr) by 2002:a17:902:7ec2:b0:13d:b563:c39 with SMTP id
 p2-20020a1709027ec200b0013db5630c39mr31705058plb.14.1635863018600; Tue, 02
 Nov 2021 07:23:38 -0700 (PDT)
Date:   Tue,  2 Nov 2021 07:23:30 -0700
In-Reply-To: <20211102142331.3753798-1-pgonda@google.com>
Message-Id: <20211102142331.3753798-4-pgonda@google.com>
Mime-Version: 1.0
References: <20211102142331.3753798-1-pgonda@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH V3 3/4] crypto: ccp - Refactor out sev_fw_alloc()
From:   Peter Gonda <pgonda@google.com>
To:     thomas.lendacky@amd.com
Cc:     Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates a helper function sev_fw_alloc() which can be used to allocate
aligned memory regions for use by the PSP firmware. Currently only used
for the SEV-ES TMR region but will be used for the SEV_INIT_EX NV memory
region.

Signed-off-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Acked-by: David Rientjes <rientjes@google.com>
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
 drivers/crypto/ccp/sev-dev.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index e4bc833949a0..00ca74dd7b3c 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -141,6 +141,17 @@ static int sev_cmd_buffer_len(int cmd)
 	return 0;
 }
 
+static void *sev_fw_alloc(unsigned long len)
+{
+	struct page *page;
+
+	page = alloc_pages(GFP_KERNEL, get_order(len));
+	if (!page)
+		return NULL;
+
+	return page_address(page);
+}
+
 static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 {
 	struct psp_device *psp = psp_master;
@@ -1076,7 +1087,6 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
 void sev_pci_init(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
-	struct page *tmr_page;
 	int error = 0, rc;
 
 	if (!sev)
@@ -1092,14 +1102,10 @@ void sev_pci_init(void)
 		sev_get_api_version();
 
 	/* Obtain the TMR memory area for SEV-ES use */
-	tmr_page = alloc_pages(GFP_KERNEL, get_order(SEV_ES_TMR_SIZE));
-	if (tmr_page) {
-		sev_es_tmr = page_address(tmr_page);
-	} else {
-		sev_es_tmr = NULL;
+	sev_es_tmr = sev_fw_alloc(SEV_ES_TMR_SIZE);
+	if (!sev_es_tmr)
 		dev_warn(sev->dev,
 			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
-	}
 
 	/* Initialize the platform */
 	rc = sev_platform_init(&error);
-- 
2.33.1.1089.g2158813163f-goog

