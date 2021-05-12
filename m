Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B151A37BB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhELLEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:04:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54098 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELLEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:04:38 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <dimitri.ledkov@canonical.com>)
        id 1lgmeI-0004Ki-EG
        for linux-kernel@vger.kernel.org; Wed, 12 May 2021 11:03:30 +0000
Received: by mail-wr1-f71.google.com with SMTP id 4-20020adf80040000b029010cab735fdeso9971366wrk.14
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ksFYSUB08pq8Nu0f8+tRAEFzoQcNFQPa/IzSDmTOQ2c=;
        b=OemHNaPzj0/lUiCJLdMBn7tgYfjBIjMG8t4eGW894uOpYE3xrgAawdZwR0ZSpUu2m9
         oHSKAe8a6tPEGFbLvg+gha7GewYXRrmjjZD+Shh9yGHsfL8VLZllCD+PEIx+EKiPbGTR
         l3Mz9tfZp92ei80oyg+C3q6k1qwdQsy86DgtGuQxDHCSShyGsxPrTitNNyOojfJgMIGk
         yy8dpam8QB4oyVWS+bSmLjAXqjWFNBgChnjR4/htL6Ioc+OB0gy90zAEBTN82JZJFi3u
         rrTnL82nCrU3Use4y9dLXhC+CyS70oM+Dx5vX/HgIRfOyk89ifofWgDiz2dpvXlPziG2
         5wUw==
X-Gm-Message-State: AOAM532QlfGJOvS4CfnK3J1WIoeafVNBKU8rxet1KmGAKylKmjoWWpa9
        +M5phTRspKFcpJ24HiIhWbVBt/lQqRX2o88lb5DKFTUSffZUK98DtHp7G1GzIgQaC3kWL3+4dRX
        15PoANS75ZAlJ0saXxLVsGYCQR4teX+fBS3ASJJAkMQ==
X-Received: by 2002:a1c:7e93:: with SMTP id z141mr6712336wmc.59.1620817409500;
        Wed, 12 May 2021 04:03:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfqspLfy84tsWQocApOU+jdiYwOBR2Z17yCy+8oUs5Mi7KriX9TLIg5nPjBxIxsKbcu1gFPw==
X-Received: by 2002:a1c:7e93:: with SMTP id z141mr6712308wmc.59.1620817409191;
        Wed, 12 May 2021 04:03:29 -0700 (PDT)
Received: from localhost ([2a01:4b00:85fd:d700:8f2c:460b:dbba:6128])
        by smtp.gmail.com with ESMTPSA id j10sm30399481wrt.32.2021.05.12.04.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 04:03:28 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        keyrings@vger.kernel.org, Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH] integrity: add informational messages when revoking certs
Date:   Wed, 12 May 2021 12:03:02 +0100
Message-Id: <20210512110302.262104-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

integrity_load_cert() prints messages of the source and cert details
when adding certs as trusted. Mirror those messages in
uefi_revocation_list_x509() when adding certs as revoked.

Sample dmesg with this change:

    integrity: Platform Keyring initialized
    integrity: Loading X.509 certificate: UEFI:db
    integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
    integrity: Revoking X.509 certificate: UEFI:MokListXRT (MOKvar table)
    blacklist: Revoked X.509 cert 'Canonical Ltd. Secure Boot Signing: 61482aa2830d0ab2ad5af10b7250da9033ddcef0'
    integrity: Loading X.509 certificate: UEFI:MokListRT (MOKvar table)
    integrity: Loaded X.509 cert 'Canonical Ltd. Master Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
cc: keyrings@vger.kernel.org
cc: Eric Snowberg <eric.snowberg@oracle.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: David Woodhouse <dwmw2@infradead.org>
cc: David Howells <dhowells@redhat.com>
---
 certs/blacklist.c                                   | 4 +++-
 security/integrity/platform_certs/keyring_handler.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index c9a435b15af40..6a2afa84a5db9 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -172,7 +172,9 @@ int add_key_to_revocation_list(const char *data, size_t size)
 	if (IS_ERR(key)) {
 		pr_err("Problem with revocation key (%ld)\n", PTR_ERR(key));
 		return PTR_ERR(key);
-	}
+	} else
+		pr_notice("Revoked X.509 cert '%s'\n",
+			  key_ref_to_ptr(key)->description);
 
 	return 0;
 }
diff --git a/security/integrity/platform_certs/keyring_handler.c b/security/integrity/platform_certs/keyring_handler.c
index 5604bd57c9907..9f85626702b2c 100644
--- a/security/integrity/platform_certs/keyring_handler.c
+++ b/security/integrity/platform_certs/keyring_handler.c
@@ -61,6 +61,7 @@ static __init void uefi_blacklist_binary(const char *source,
 static __init void uefi_revocation_list_x509(const char *source,
 					     const void *data, size_t len)
 {
+	pr_info("Revoking X.509 certificate: %s\n", source);
 	add_key_to_revocation_list(data, len);
 }
 
-- 
2.27.0

