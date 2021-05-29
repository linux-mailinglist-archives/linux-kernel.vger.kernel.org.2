Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD74F394E17
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhE2UFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhE2UEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:20 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1E5C061345
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:43 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so7003576otl.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWq0OzDlE4td6FzxKFBbl0488rrLOlVoyWpeKwVrArs=;
        b=FLSfp9RCohi/rGx0AFMZasrTD4taZ7pqju16I7cKELW7c/v9FoThLxvDTAgiGYLnM7
         Wm4ZM0D6wbv7Of9miUXkNaMymmxaw/PyFU1jvqdU7ICpC80lf9a9TXx1fw3TVSuNIpb1
         JnxFfnTIqv3L5y9byvLsNzLhIhjQRPXP8RLyZQCZCDf5b4SEAGW4rnNw178Nc8t1AS0N
         Rhovl082tboPLlUzmuDUIQJJLT3SlCdq2Qtsl8LrQzBO84Z8AioklBqXDeIOrLaL2k2r
         m7iHmbnfBvD9kDUPtqpkKsQ+wrh1LOVZ1LnUvh55g3ESkSugnhYEvPn3Ni3UkGgwqTB/
         q/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWq0OzDlE4td6FzxKFBbl0488rrLOlVoyWpeKwVrArs=;
        b=U8v2MiZO+Yzv2Xbbwy1YGThEY18pKPUKtenh0do2YRPGf30AYK99ncR/rDJjX1C1XM
         Mg3wES9D6W/r78pbes79/lTPPoblVktOM9XR/RePiQdpWRUaEn23bsM2WBUINr499DMc
         5cO0ULnl5hbeFT01g4Nz/L70SnAO/G9dw9xfivytIiz6NDOspFS+mdqKF1s6JQguF1ZX
         yoVrUllrjtRA1ZXpB+9arWIVriEQWPwZFYT9M1EA586ZUXqiaeTo+BC/Ecfiv6wXLqdi
         JGD1Kp7MxATuj9LJEMGhlE//G2WxNnPVeHBA5s716KMQTOpf8i/3kvHedlUdagyWX4fe
         5DWw==
X-Gm-Message-State: AOAM531LIG0XpwAU2mTqc+ON5b7qKw0EldIfLN0P4mT624GgxZMLHb5t
        +EIddd4dHUQKC/Y/rU2YHEg=
X-Google-Smtp-Source: ABdhPJx/7BaDJG15cZ920YWxXqsCjhkn5IdUFy6AZLeKrPqOOnwPXsNCrpb33bJzTcvs+9DVJcraeg==
X-Received: by 2002:a9d:6655:: with SMTP id q21mr11772591otm.185.1622318562428;
        Sat, 29 May 2021 13:02:42 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:41 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 28/34] dyndbg: unionize _ddebug*_headers with struct _ddebug*
Date:   Sat, 29 May 2021 14:00:23 -0600
Message-Id: <20210529200029.205306-29-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
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
then we can drop _ddebug.site, and use header.site indirectly.  This
is really just setup, next patch finishes conversion.

This commit has several elements combining:

Update DEFINE_DYNAMIC_DEBUG_TABLE by replacing "struct _ddebug*" with
"union _ddebug*_header".  This change places the new object types into
our 2 elf sections.

our 2 new union types have 2 jobs:

a.fit properly in the section/array.  We do this by putting the struct
  inside the union, making the unions the same size as their contained
  structs.  This was sufficient to fix a data-misalignment crash on
  2nd loop (ie 1st record after header) in _init.

TBD: u8[sizeof(struct _ddebug)] would also fit properly.

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
index 7acd4c88411d..c9c568a698a8 100644
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
 		.site = &_LINKONCE_dyndbg_site_header,		\
-- 
2.31.1

