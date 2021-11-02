Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83621443048
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhKBO0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhKBO0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:26:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D0AC06120A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:23:37 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k9-20020a170902ba8900b00141f601d5c8so3347508pls.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qXnwABhA26FtcwRiOkwwItakkHsn0lTvM03+FEbDB6Y=;
        b=YYnVCEW2r4hHwMzOIxQTSzlv652l5c9dHtPufSOWZtNfEThh5O1mMSabauac5msWvh
         va1NieZjuSXPW0TY5zrbeh1jnhAZQaHvewJGt51pZLSKeQRrx7prSAR/CqTtYAx22Olb
         YKR8ixWvMg/aSK1YzchrZV9ZdnyPGIBP7Gfw1Cj3t2kw4DTbl0TDdBFklcaty9TG2Oz7
         ZdN31vJy3T1N0YH1DGWMl88ASVIWa9PXuz/J3HyyykbFpBvbzF03om/8g67ELQ+A9TIi
         LVQfZJLTdxlTNBM8uylEHE/mHGesX+MKkRFUt81qrvFPH1X/j9W3X4juEd8BEEAheFGs
         +PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qXnwABhA26FtcwRiOkwwItakkHsn0lTvM03+FEbDB6Y=;
        b=jdVWiiMVMV1dtJc5Y4To7+0b7bcR/1yTWqdo32s8M8izkDO67YpAzuLCCd8N/OtFlk
         z54BGHX26LLM8EZCcklLrLJ67kb8t8iQ+xUkaBbSjWXDVQiH5XKASAg+QCYASzPe9+wJ
         B5f3LBZVpPpHZt7LTiCtt0kyG1IIsR9qVLwdTSuovr199BQkI8GmibXoRDmfWNtAjHsh
         N1vXuihbmaRhmSKknU7+7ZgBpKAkHhHrBfE6itqjEnghYDPxrVUN0GQqMpw7xNfbFT49
         eW5ug+0YaA7wwL/eXxF2n8Y/vfJIxW7I/dy1W7WMoC37Pn8xOuDMJZVlcZKkJqzxVe9i
         Mfrw==
X-Gm-Message-State: AOAM531JGzRK8s7KCETPpUXbE6/hZKUOoKKK1C8CTsNRhkqwRg6vFJ5a
        3hvIRNf3Ho1q+UriSdMGUg63XScIRZs=
X-Google-Smtp-Source: ABdhPJxQxw3IpsO6tsK07Airg4jfVnZE0ymteCk3hDLFQZ1gjUTW3/LpPax5EyjpakE1n8BivFwrfUgy8tI=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:3109:8497:f59d:9150])
 (user=pgonda job=sendgmr) by 2002:a17:90a:5285:: with SMTP id
 w5mr37602pjh.1.1635863016596; Tue, 02 Nov 2021 07:23:36 -0700 (PDT)
Date:   Tue,  2 Nov 2021 07:23:29 -0700
In-Reply-To: <20211102142331.3753798-1-pgonda@google.com>
Message-Id: <20211102142331.3753798-3-pgonda@google.com>
Mime-Version: 1.0
References: <20211102142331.3753798-1-pgonda@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH V3 2/4] crypto: ccp - Move SEV_INIT retry for corrupted data
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

This change moves the data corrupted retry of SEV_INIT into the
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
 drivers/crypto/ccp/sev-dev.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index ec89a82ba267..e4bc833949a0 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -267,6 +267,18 @@ static int __sev_platform_init_locked(int *error)
 	}
 
 	rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
+	if (rc && *error == SEV_RET_SECURE_DATA_INVALID) {
+		/*
+		 * INIT command returned an integrity check failure
+		 * status code, meaning that firmware load and
+		 * validation of SEV related persistent data has
+		 * failed and persistent state has been erased.
+		 * Retrying INIT command here should succeed.
+		 */
+		dev_dbg(sev->dev, "SEV: retrying INIT command");
+		rc = __sev_do_cmd_locked(SEV_CMD_INIT, &data, error);
+	}
+
 	if (rc)
 		return rc;
 
@@ -1091,18 +1103,6 @@ void sev_pci_init(void)
 
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
2.33.1.1089.g2158813163f-goog

