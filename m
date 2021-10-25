Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE44438CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 02:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhJYAki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 20:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJYAkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 20:40:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14116C061745;
        Sun, 24 Oct 2021 17:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9hAsGCm4JturhoyBVVdTBZyVQWWW3CL5Y+jli5Oa+Ts=; b=vguOr5ZgXw2jesoN4FsDEZ52+d
        nJhY6NsJzgP0BwP/hejawgr8spE4IuW2lUVosmebS1Ewqm+gk6h+eKdWjGx/n659zL5oScPSZj+DR
        tMkK2w/RbfWRHOSvGxRJD/+Un1W3PyqKwNDcQOpAGeg65UriSnJ5GA+P5EJaOIJZlfpXL8Gk+0vVB
        pKtvWkCHC3N7hfmW7331bkIomPw5S1DU7gIUlmt7hW/w0zJ4M2p98a0jMqfyfSBsVu8sW5yNrmPcF
        4N7kILrK6C9rs49sGYzJzR1da3mj9zWXNX98lbXn7O00HugFgbFYDme9O5n8Hhhc9odd2ipWAxTWl
        /pf5+Lsw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1meo0E-00EqBf-On; Mon, 25 Oct 2021 00:38:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH] certs: system_keyring.c: clean up kernel-doc
Date:   Sun, 24 Oct 2021 17:38:13 -0700
Message-Id: <20211025003813.5164-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some kernel-doc warnings in system_keyring.c:

system_keyring.c:43: warning: expecting prototype for restrict_link_to_builtin_trusted(). Prototype was for restrict_link_by_builtin_trusted() instead
system_keyring.c:77: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Allocate a struct key_restriction for the "builtin and secondary trust"
system_keyring.c:77: warning: missing initial short description on line:
 * Allocate a struct key_restriction for the "builtin and secondary trust"

Fix the warnings above and then see & fix these:

system_keyring.c:43: warning: No description found for return value of 'restrict_link_by_builtin_trusted'
system_keyring.c:62: warning: No description found for return value of 'restrict_link_by_builtin_and_secondary_trusted'
system_keyring.c:190: warning: No description found for return value of 'verify_pkcs7_message_sig'
system_keyring.c:275: warning: No description found for return value of 'verify_pkcs7_signature'

This still leaves non-exported two functions that do not have their
functions parameters documented: restrict_link_by_builtin_trusted() and
restrict_link_by_builtin_and_secondary_trusted().

Use '%' preceding constants in kernel-doc notation.

Use "builtin" consistently instead of "built in" or "built-in".

Don't use "/**" to begin a comment that is not in kernel-doc format.

Document the use of VERIFY_USE_SECONDARY_KEYRING and
VERIFY_USE_PLATFORM_KEYRING.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: keyrings@vger.kernel.org
---
 certs/system_keyring.c |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

--- linux-next-20211022.orig/certs/system_keyring.c
+++ linux-next-20211022/certs/system_keyring.c
@@ -31,10 +31,12 @@ extern __initconst const unsigned long s
 extern __initconst const unsigned long module_cert_size;
 
 /**
- * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
+ * restrict_link_by_builtin_trusted - Restrict keyring addition by builtin CA
  *
  * Restrict the addition of keys into a keyring based on the key-to-be-added
- * being vouched for by a key in the built in system keyring.
+ * being vouched for by a key in the builtin system keyring.
+ *
+ * Return: %0 on success or a negative value on error
  */
 int restrict_link_by_builtin_trusted(struct key *dest_keyring,
 				     const struct key_type *type,
@@ -51,8 +53,10 @@ int restrict_link_by_builtin_trusted(str
  *   addition by both builtin and secondary keyrings
  *
  * Restrict the addition of keys into a keyring based on the key-to-be-added
- * being vouched for by a key in either the built-in or the secondary system
+ * being vouched for by a key in either the builtin or the secondary system
  * keyrings.
+ *
+ * Return: %0 on success or a negative value on error
  */
 int restrict_link_by_builtin_and_secondary_trusted(
 	struct key *dest_keyring,
@@ -73,7 +77,7 @@ int restrict_link_by_builtin_and_seconda
 					  secondary_trusted_keys);
 }
 
-/**
+/*
  * Allocate a struct key_restriction for the "builtin and secondary trust"
  * keyring. Only for use in system_trusted_keyring_init().
  */
@@ -170,14 +174,17 @@ late_initcall(load_system_certificate_li
 
 /**
  * verify_pkcs7_message_sig - Verify a PKCS#7-based signature on system data.
- * @data: The data to be verified (NULL if expecting internal data).
+ * @data: The data to be verified (%NULL if expecting internal data).
  * @len: Size of @data.
  * @pkcs7: The PKCS#7 message that is the signature.
- * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
- *					(void *)1UL for all trusted keys).
+ * @trusted_keys: Trusted keys to use (%NULL for builtin trusted keys only,
+ *		  %VERIFY_USE_SECONDARY_KEYRING for secondary trusted keys,
+ *		  %VERIFY_USE_PLATFORM_KEYRING for platform trusted keys).
  * @usage: The use to which the key is being put.
  * @view_content: Callback to gain access to content.
  * @ctx: Context for callback.
+ *
+ * Return: %0 on success or a negative value on error
  */
 int verify_pkcs7_message_sig(const void *data, size_t len,
 			     struct pkcs7_message *pkcs7,
@@ -254,15 +261,18 @@ error:
 
 /**
  * verify_pkcs7_signature - Verify a PKCS#7-based signature on system data.
- * @data: The data to be verified (NULL if expecting internal data).
+ * @data: The data to be verified (%NULL if expecting internal data).
  * @len: Size of @data.
  * @raw_pkcs7: The PKCS#7 message that is the signature.
  * @pkcs7_len: The size of @raw_pkcs7.
- * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
- *					(void *)1UL for all trusted keys).
+ * @trusted_keys: Trusted keys to use (%NULL for builtin trusted keys only,
+ *		  %VERIFY_USE_SECONDARY_KEYRING for secondary trusted keys,
+ *		  %VERIFY_USE_PLATFORM_KEYRING for platform trusted keys).
  * @usage: The use to which the key is being put.
  * @view_content: Callback to gain access to content.
  * @ctx: Context for callback.
+ *
+ * Return: %0 on success or a negative value on error
  */
 int verify_pkcs7_signature(const void *data, size_t len,
 			   const void *raw_pkcs7, size_t pkcs7_len,
