Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD4437AED4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhEKSxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhEKSxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:53:03 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE68C061343
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:56 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id p15so18078913iln.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RetV73+gjmatQ10AYA8JVaODMFVKb7GL6Z0yeYfciDg=;
        b=fRIuCpEZT5toBeJSxRcZygcC8hRLmM9HlDEtdBqsGTt4k5QJA4Puu2+YFFwsLKN7/5
         mdNeZJmc0P8fhWS43um5qEISx4cqn/3thn0zsUihATIkz8KQ8EtSRchQw8Iy7l0JpeDV
         6mLurHEdKhFjq+GZN6mKsu2ypF8V9dYG+z3AFIO4AlmmoVfEwYVVbwHx8YrkLzeTPS14
         23X0nd4gEH/uyaYaZZfAqITHS4j9FkmOe23MWa/cvxlNZsjzSFg33Qn09/FEQ3iza0Fu
         lsj3CHOeAaS0rGbviepfMq0SxifOyC6rvKnV42TEyYGLYjWzRihoWlidLK0GS22CXTKP
         UjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RetV73+gjmatQ10AYA8JVaODMFVKb7GL6Z0yeYfciDg=;
        b=A89F+S1jSxJ4S7OK7tB7g7niFmVO9kQRdQ7IhsMqTplVs/tIUKT5n9IDJl31RN9MOe
         6hkWLeyPjYgIO3wKGQMK7mSP41F4Nw+XRM80Soh5G/B9gKB350R63/EGKkA0g7jkkI+m
         /5SH6uWLgJ/y4qh8edZc63qhiOaTu8XEzHJGOzw8ysGa70CU5aOcmL9qfqVewlxmd69l
         bFHdVhm6wIB+smbhEc2aocKrNrdru5joNvN1Ih89l5mD6LdmxbhmTLeu/4kBmsWLsNUz
         FmEfvzG3/Dj2tzVNnIYs8DbXAeBQOcGOB+HexsSmtfAtpHvE5omHMGIyCHOoctP+idgz
         i2/A==
X-Gm-Message-State: AOAM5316OUo+ZnF6dfd9rVqqLHHavfVikvGnPDrRyjl5ZIqAL4QK9UBF
        /MyQ30QdYw/kZwQlgE3b2Kc=
X-Google-Smtp-Source: ABdhPJxqhsB2v+ubkXoKuKBuZ58V3W7JR1ZIHk3WyB51m5HA5YvDAVqhizjZsfGdclze8KcHYlAwiA==
X-Received: by 2002:a92:1a12:: with SMTP id a18mr27991241ila.168.1620759115477;
        Tue, 11 May 2021 11:51:55 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:55 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 27/28] dyndbg: unionize _ddebug*_headers with struct _ddebug*
Date:   Tue, 11 May 2021 12:50:56 -0600
Message-Id: <20210511185057.3815777-28-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now, to create our header record (pair), we reused struct
_ddebug(|_sites), initializing the pair with "impossible" field values
(for a pr_debug() site), which makes it recognizable as a header not a
pr-debug callsite.

Now we want to specialize the header; differentiate it from its model,
then we can drop _ddebug.site, and use header.site indirectly.

This commit has several elements combining:

Update DEFINE_DYNAMIC_DEBUG_TABLE by replacing "struct _ddebug*" with
"union _ddebug*_header".  This change places the new object types into
our 2 elf sections.

our 2 new union types have 2 jobs:

a.fit properly in the section/array.  We do this by putting the struct
  inside the union, making the unions the same size as their contained
  structs.  This was sufficient to fix a data-misalignment crash on
  2nd loop (ie 1st record after header) in _init.

b.unions need the same field defns as their models, as refd in:
  DEFINE_DYNAMIC_DEBUG_TABLE() - inits
  is_dyndbg_header_pair(i,s)   - validates that init
  use anonymous struct.

RFC: My "anonymous union/struct fu" feels incomplete.  The struct in b
must contain all the fields of its outer union's own contained struct,
maybe even in the same order (tho not obvious yet).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 46901b5348ee..9ca413985fb2 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -36,6 +36,16 @@ struct _ddebug_site {
 	const char *function;
 } __aligned(8);
 
+/* verbatim copy of struct _ddebug_site. nothing to save here. */
+union _ddebug_site_header {
+	struct _ddebug_site __;		/* inherit footprint */
+	struct {			/* header validation */
+		const char *modname;
+		const char *filename;
+		const char *function;
+	};
+};
+
 struct _ddebug {
 	SITE_CHK_(struct _ddebug_site *site;)
 	/* format is always needed, lineno shares word with flags */
@@ -74,6 +84,21 @@ struct _ddebug {
 #endif
 } __aligned(8);
 
+/*
+ * specialized version of struct _ddebug.  The only field we NEED is
+ * .site, since keeping it here allows dropping from struct _ddebug
+ * itself.  format, lineno are used to validate header records.
+ */
+union _ddebug_header {
+	struct _ddebug __;		/* inherit footprint */
+	struct {			/* header validation */
+		union _ddebug_site_header *site;
+		const char *format;
+		const unsigned lineno:18;
+		unsigned _index:14;
+		unsigned int flags:8;
+	};
+};
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
 
@@ -136,10 +161,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  */
 #define DEFINE_DYNAMIC_DEBUG_TABLE()				\
 	/* forward decl, allowing loopback pointer */		\
-	__weak struct _ddebug __used __aligned(8)		\
+	__weak union _ddebug_header __used __aligned(8)		\
 		__section(".gnu.linkonce.dyndbg")		\
 		_LINKONCE_dyndbg_header;			\
-	__weak struct _ddebug_site __used __aligned(8)		\
+	__weak union _ddebug_site_header __used __aligned(8)	\
 		__section(".gnu.linkonce.dyndbg_site")		\
 	_LINKONCE_dyndbg_site_header = {			\
 		.modname = KBUILD_MODNAME,			\
@@ -147,7 +172,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		/* forced pointer loopback, for distinction */	\
 		.filename = (void *) &_LINKONCE_dyndbg_header	\
 	};							\
-	__weak struct _ddebug __used __aligned(8)		\
+	__weak union _ddebug_header __used __aligned(8)		\
 		__section(".gnu.linkonce.dyndbg")		\
 	_LINKONCE_dyndbg_header = {				\
 		SITE_INIT_(_LINKONCE_dyndbg_site_header)	\
-- 
2.31.1

