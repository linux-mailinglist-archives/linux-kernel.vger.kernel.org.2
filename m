Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1D145169A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 22:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347307AbhKOVeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 16:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241302AbhKOSTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:19:24 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6184BC03D786
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:41:10 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id f7-20020a63f107000000b002db96febb74so9509778pgi.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CRmKneQGh7LhiLdsP4utN0YpBtikanpDsGxgmhK+gRw=;
        b=LYSjdUnemxBriMO2FT+0ID89mEzWjWqzCA62WeA6CCg+xyqfTJXaCk/xi9OyqAhK1q
         /TGUgltQlUeMv/7pevijlbvs2EyiYylZ0vVJs4+8/VjlcpiG1jcCdDabvV1SrSmPGTca
         H6KUo32SlI8Rwtlyic6Z202jNMei+5LMLQjfPgaOuwIVvYQFJvBmlhKBcDjalYcW50qx
         +8SckzVtfkppqtxV+B83ewHioCvzkT41gXXzWh9J2r9+YVDF6Wpr2dyKSC5PfR6Aq73n
         45dPt6rxOPFP9wVzzTO16NvHhi5myn9rI6iD8xdNjcqJV2xw1uP1BKLpaONjG05ClZ5q
         jE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CRmKneQGh7LhiLdsP4utN0YpBtikanpDsGxgmhK+gRw=;
        b=42TXb+26xdx8yLPj8OS7XfGO26q9xZwtRl6Q/a6+PYhA0X6I946/6oqXkU9s1z2Pjc
         DT9l3MgnOO6iuqb9wxnGxYF9WKW73v+z2Z8ei3d5CYYfgOCga4DMVah3EHg7PiY+BO1X
         +EZz/2lsIJgmlBIKiJILmWMfOBJeXqCdJvgTK6yB3pFNIFuXs0q/uLkdDvqnq1apiNZw
         tjLtGYEsD3s00J4lZqBwOOHGz2B8W7pnrNO7Wgu27wjPN19otPQmIWO1RAq4hJUhJEpp
         q+Ya6vjoXoAAtfFrXl6dxE4niCKJxZAGXLkRu7sO85wJ5jZD7ihko0nipKV/LvjdtSQQ
         d3rA==
X-Gm-Message-State: AOAM531raq6tgBuJs0us4TDr7Nf3hl12zZb0TPUc+GlexL6bi+S2yWZo
        Iegmp3v9haSr+gTXiBGJZuvZM/xLVjg=
X-Google-Smtp-Source: ABdhPJxHkaUMfZ9fmgoZn/BN8KOFHML+IfcxE47qqNEj6JhN26EzmqEFRVZXSf4mA0ReZ73crkjM/IYLmKQ=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:9fb:192e:3671:218c])
 (user=pgonda job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr6222pjf.1.1636998069377; Mon, 15 Nov 2021 09:41:09 -0800 (PST)
Date:   Mon, 15 Nov 2021 09:40:59 -0800
In-Reply-To: <20211115174102.2211126-1-pgonda@google.com>
Message-Id: <20211115174102.2211126-3-pgonda@google.com>
Mime-Version: 1.0
References: <20211115174102.2211126-1-pgonda@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH V4 2/5] crypto: ccp - Move SEV_INIT retry for corrupted data
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

Move the data corrupted retry of SEV_INIT into the
__sev_platform_init_locked() function. This is for upcoming INIT_EX
support as well as helping direct callers of
__sev_platform_init_locked() which currently do not support the
retry.

Signed-off-by: Peter Gonda <pgonda@google.com>
Reviewed-by: Marc Orr <marcorr@google.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
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
 drivers/crypto/ccp/sev-dev.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 62031e861e69..c9e7f2d92992 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -241,7 +241,7 @@ static int __sev_platform_init_locked(int *error)
 	struct psp_device *psp = psp_master;
 	struct sev_data_init data;
 	struct sev_device *sev;
-	int rc = 0;
+	int psp_ret, rc = 0;
 
 	if (!psp || !psp->sev_data)
 		return -ENODEV;
@@ -266,7 +266,21 @@ static int __sev_platform_init_locked(int *error)
 		data.tmr_len = SEV_ES_TMR_SIZE;
 	}
 
-	rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
+	rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, &psp_ret);
+	if (rc && psp_ret == SEV_RET_SECURE_DATA_INVALID) {
+		/*
+		 * Initialization command returned an integrity check failure
+		 * status code, meaning that firmware load and validation of SEV
+		 * related persistent data has failed. Retrying the
+		 * initialization function should succeed by replacing the state
+		 * with a reset state.
+		 */
+		dev_dbg(sev->dev, "SEV: retrying INIT command");
+		rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, &psp_ret);
+	}
+	if (error)
+		*error = psp_ret;
+
 	if (rc)
 		return rc;
 
@@ -1091,18 +1105,6 @@ void sev_pci_init(void)
 
 	/* Initialize the platform */
 	rc = sev_platform_init(&error);
-	if (rc && (error == SEV_RET_SECURE_DATA_INVALID)) {
-		/*
-		 * INIT command returned an integrity check failure
-		 * status code, meaning that firmware load and
-		 * validation of SEV related persistent data has
-		 * failed and persistent state has been erased.
-		 * Retrying INIT command here should succeed.
-		 */
-		dev_dbg(sev->dev, "SEV: retrying INIT command");
-		rc = sev_platform_init(&error);
-	}
-
 	if (rc) {
 		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
 			error, rc);
-- 
2.34.0.rc1.387.gb447b232ab-goog

