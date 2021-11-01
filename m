Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E68441F26
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 18:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhKARYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 13:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhKARYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:24:10 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1743C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 10:21:36 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id e4-20020a630f04000000b002cc40fe16afso1904576pgl.23
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eKW1MHsHQDoXENEgPhRYyUnBRHGSJfmJzWx+eKoMHHI=;
        b=mbTPTmCqWZ7agTm+pbsSTSzqn6BGOP9/WqBIhceK+w4I0w8YzrPHxWZxrccLQyDE+7
         13kUZA0UmRR13yb9mGPKk5cLudHd7D12K9P3KNxCYKePe++ylU/Y6RNhO0iKcmEj96mn
         48AEYjtt+MZT9rrNbHq4UBEf3WD48PhkWhFAqUg8I+XtQyOpSjkX2BzJzGzBYA32/sML
         sQpatz8kVfPxoHsln/Z6uEv3q61UtiXhNNzddEVP0SYjcA18J/PW70S2MSGFwFOtdpgj
         iMnlCHt/hqE+2BOj6HU5Lk6jSPOtCMa3Jid07CK/yjeyS2snAEqxTvqQGyoGP97Mygmv
         7J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eKW1MHsHQDoXENEgPhRYyUnBRHGSJfmJzWx+eKoMHHI=;
        b=EkusgXS9Xb5nbYFApce676Hobqu6HPmrwMtRSbTmmSa291oPR9Do7ZjmM4VIBV12bY
         9vfUH8qz5CpxvbhR+mKdK1WiCTCVNCqsLgSVhwQ0LyXQcKtX/uqZ8kL46MHbMha1LcSs
         ilT6738edWl5NezailRDV6/G07y2OZpxw1OVqn1c6Tsjd/g+C0SBF2crD+WTcauzyiv/
         hxy8VKniOvA/+MNTRU81s6o0CCvm9uEYcnanCCPbLxiJ9f8F7cMJ5r3fPU5Vpgms5vZ+
         9abEnlYUBYWwX9h3Q8XnTAleoTytVM5SMikwSraLpCg27Q/xspwxM+2iCHZiGNwVJioJ
         fZ2g==
X-Gm-Message-State: AOAM531j9FM1TbzpmP9+MM+7a9rxXl3OnrKXqp9O6Hw/xga+4i+YpZoG
        Mv2F0i8bRCh83Rrh71+ekbrG/gsGvBU=
X-Google-Smtp-Source: ABdhPJyvfEQVQhP2DYhkvJlM6Tz1Q3bBGVLsgE1iCbf9E32mJIkhTkC2sg3uK68QRIIvV3G+eRKMUV1zIYo=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:98c4:afe5:ed9f:d0db])
 (user=pgonda job=sendgmr) by 2002:a17:902:d395:b0:141:a913:1920 with SMTP id
 e21-20020a170902d39500b00141a9131920mr20874752pld.81.1635787296342; Mon, 01
 Nov 2021 10:21:36 -0700 (PDT)
Date:   Mon,  1 Nov 2021 10:21:26 -0700
In-Reply-To: <20211101172127.3060453-1-pgonda@google.com>
Message-Id: <20211101172127.3060453-4-pgonda@google.com>
Mime-Version: 1.0
References: <20211101172127.3060453-1-pgonda@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH V2 3/4] crypto: ccp - Refactor out sev_fw_alloc()
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

