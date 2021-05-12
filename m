Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BBB37C93C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 18:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbhELQQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 12:16:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33218 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhELPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:32:16 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <dimitri.ledkov@canonical.com>)
        id 1lgqpG-0000rf-M0
        for linux-kernel@vger.kernel.org; Wed, 12 May 2021 15:31:06 +0000
Received: by mail-wr1-f69.google.com with SMTP id a5-20020a5d6ca50000b029011035a261adso220912wra.17
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZI9VWslQbAkaL9+aHE2bKwdaoPdjTN0bkodyxaVHrI=;
        b=O3dAfYt5h+dmNOlSqo6xqICpy9Kx1sBWI9K3FDNnk1fPbadYfwGa8epzqYdZk2LRlZ
         h0/atqe5P5vR0JonnIINQOsdc3r2EvypjwUlmNojI20Qoc0pFUrm/Hcv6VrY87/Ojr1e
         yzs5+AHbkxQ/T+DwKwCdsPkVTV97TP542KzbzK6ENVXalTS5hXAmR8qmHriaLX/Cw2q4
         rO7ioPc8FPO5nk2SHaZz6VkzTZt6t8d0Hp77c78VQ/wJ8rKHtHz6SC+zxkJymuT29HlH
         Q512YsDk9H4LCZIhGhtv3Kglk5pzuchSHhfZeo7qAlZO+/zeqXpDQq0J4RjeFWE19qdm
         +OzQ==
X-Gm-Message-State: AOAM532m4QmdS2CuQ9flaajNwxHJDL00n3QPIh66m9Hn9grIT5ALYW3A
        XYXRDiCyi540CjVR2rTZc+qU9LbvSOtDptF9tLj6j/yBEGKtEBF6qj2wHQBagFflg20IxqT2BrJ
        eE+0lVaCt95bOE58AhzYMQO23NA+99/prJnkfJfnGnw==
X-Received: by 2002:adf:e947:: with SMTP id m7mr47459869wrn.70.1620833465047;
        Wed, 12 May 2021 08:31:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwo53elL32JG7xaTmhg1ws1K3bI1DUcpZXe8E1r6krk8pxvSGElDVeDAzJWgiXjHolsOTLYAw==
X-Received: by 2002:adf:e947:: with SMTP id m7mr47459838wrn.70.1620833464799;
        Wed, 12 May 2021 08:31:04 -0700 (PDT)
Received: from localhost ([2a01:4b00:85fd:d700:8f2c:460b:dbba:6128])
        by smtp.gmail.com with ESMTPSA id c16sm4576031wrn.92.2021.05.12.08.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:31:03 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        keyrings@vger.kernel.org, Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH] integrity: Load mokx certs from the EFI MOK config table
Date:   Wed, 12 May 2021 16:31:00 +0100
Message-Id: <20210512153100.285169-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor load_moklist_certs() to load either MokListRT into db, or
MokListXRT into dbx. Call load_moklist_certs() twice - first to load
mokx certs into dbx, then mok certs into db.

This thus now attempts to load mokx certs via the EFI MOKvar config
table first, and if that fails, via the EFI variable. Previously mokx
certs were only loaded via the EFI variable. Which fails when
MokListXRT is large. Instead of large MokListXRT variable, only
MokListXRT{1,2,3} are available which are not loaded. This is the case
with Ubuntu's 15.4 based shim. This patch is required to address
CVE-2020-26541 when certificates are revoked via MokListXRT.

Fixes: ebd9c2ae369a ("integrity: Load mokx variables into the blacklist keyring")

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
cc: keyrings@vger.kernel.org
cc: Eric Snowberg <eric.snowberg@oracle.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: David Woodhouse <dwmw2@infradead.org>
cc: David Howells <dhowells@redhat.com>
---
 security/integrity/platform_certs/load_uefi.c | 74 ++++++++++---------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index f290f78c3f30..f4b913ec76e4 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -66,17 +66,18 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 }
 
 /*
- * load_moklist_certs() - Load MokList certs
+ * load_moklist_certs() - Load Mok(X)List certs
+ * @load_db: Load MokListRT into db when true; MokListXRT into dbx when false
  *
- * Load the certs contained in the UEFI MokListRT database into the
- * platform trusted keyring.
+ * Load the certs contained in the UEFI MokList(X)RT database into the
+ * platform trusted/denied keyring.
  *
  * This routine checks the EFI MOK config table first. If and only if
- * that fails, this routine uses the MokListRT ordinary UEFI variable.
+ * that fails, this routine uses the MokList(X)RT ordinary UEFI variable.
  *
  * Return:	Status
  */
-static int __init load_moklist_certs(void)
+static int __init load_moklist_certs(const bool load_db)
 {
 	struct efi_mokvar_table_entry *mokvar_entry;
 	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
@@ -84,41 +85,55 @@ static int __init load_moklist_certs(void)
 	unsigned long moksize;
 	efi_status_t status;
 	int rc;
+	const char *mokvar_name = "MokListRT";
+	/* Should be const, but get_cert_list() doesn't have it as const yet */
+	efi_char16_t *efivar_name = L"MokListRT";
+	const char *parse_mokvar_name = "UEFI:MokListRT (MOKvar table)";
+	const char *parse_efivar_name = "UEFI:MokListRT";
+	efi_element_handler_t (*get_handler_for_guid)(const efi_guid_t *) = get_handler_for_db;
+
+	if (!load_db) {
+		mokvar_name = "MokListXRT";
+		efivar_name = L"MokListXRT";
+		parse_mokvar_name = "UEFI:MokListXRT (MOKvar table)";
+		parse_efivar_name = "UEFI:MokListXRT";
+		get_handler_for_guid = get_handler_for_dbx;
+	}
 
 	/* First try to load certs from the EFI MOKvar config table.
 	 * It's not an error if the MOKvar config table doesn't exist
 	 * or the MokListRT entry is not found in it.
 	 */
-	mokvar_entry = efi_mokvar_entry_find("MokListRT");
+	mokvar_entry = efi_mokvar_entry_find(mokvar_name);
 	if (mokvar_entry) {
-		rc = parse_efi_signature_list("UEFI:MokListRT (MOKvar table)",
+		rc = parse_efi_signature_list(parse_mokvar_name,
 					      mokvar_entry->data,
 					      mokvar_entry->data_size,
-					      get_handler_for_db);
+					      get_handler_for_guid);
 		/* All done if that worked. */
 		if (!rc)
 			return rc;
 
-		pr_err("Couldn't parse MokListRT signatures from EFI MOKvar config table: %d\n",
-		       rc);
+		pr_err("Couldn't parse %s signatures from EFI MOKvar config table: %d\n",
+		       mokvar_name, rc);
 	}
 
 	/* Get MokListRT. It might not exist, so it isn't an error
 	 * if we can't get it.
 	 */
-	mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
+	mok = get_cert_list(efivar_name, &mok_var, &moksize, &status);
 	if (mok) {
-		rc = parse_efi_signature_list("UEFI:MokListRT",
-					      mok, moksize, get_handler_for_db);
+		rc = parse_efi_signature_list(parse_efivar_name,
+					      mok, moksize, get_handler_for_guid);
 		kfree(mok);
 		if (rc)
-			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
+			pr_err("Couldn't parse %s signatures: %d\n", mokvar_name, rc);
 		return rc;
 	}
 	if (status == EFI_NOT_FOUND)
-		pr_debug("MokListRT variable wasn't found\n");
+		pr_debug("%s variable wasn't found\n", mokvar_name);
 	else
-		pr_info("Couldn't get UEFI MokListRT\n");
+		pr_info("Couldn't get UEFI %s\n", mokvar_name);
 	return 0;
 }
 
@@ -132,9 +147,8 @@ static int __init load_moklist_certs(void)
 static int __init load_uefi_certs(void)
 {
 	efi_guid_t secure_var = EFI_IMAGE_SECURITY_DATABASE_GUID;
-	efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
-	void *db = NULL, *dbx = NULL, *mokx = NULL;
-	unsigned long dbsize = 0, dbxsize = 0, mokxsize = 0;
+	void *db = NULL, *dbx = NULL;
+	unsigned long dbsize = 0, dbxsize = 0;
 	efi_status_t status;
 	int rc = 0;
 
@@ -176,23 +190,15 @@ static int __init load_uefi_certs(void)
 		kfree(dbx);
 	}
 
-	mokx = get_cert_list(L"MokListXRT", &mok_var, &mokxsize, &status);
-	if (!mokx) {
-		if (status == EFI_NOT_FOUND)
-			pr_debug("mokx variable wasn't found\n");
-		else
-			pr_info("Couldn't get mokx list\n");
-	} else {
-		rc = parse_efi_signature_list("UEFI:MokListXRT",
-					      mokx, mokxsize,
-					      get_handler_for_dbx);
-		if (rc)
-			pr_err("Couldn't parse mokx signatures %d\n", rc);
-		kfree(mokx);
-	}
+	/* Load the MokListXRT certs */
+	rc = load_moklist_certs(false);
+	if (rc)
+		pr_err("Couldn't parse mokx signatures: %d\n", rc);
 
 	/* Load the MokListRT certs */
-	rc = load_moklist_certs();
+	rc = load_moklist_certs(true);
+	if (rc)
+		pr_err("Couldn't parse mok signatures: %d\n", rc);
 
 	return rc;
 }
-- 
2.27.0

