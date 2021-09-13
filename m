Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429ED409FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 00:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244384AbhIMW2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 18:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237393AbhIMW2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 18:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631572038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGG4Fa5Smycs29b77eteLeOLTMiK3YmJo+qPCM0YDLQ=;
        b=RyNMp1lw7yHOXkjYQ+kEvn/FgsFtTV/9+BcdPgS/LPZRtxpFu40gnm/48Ha5EYlKeeSP30
        TGwLxtF/fjAmnXXkRd/NLXZwD6oSSSP8D+pMjWCo7UlW51IZ5Q+yj1jWhyi6KvjrKlhhFp
        JbFqCNwZ+RFqQYy+Ttd3rp3T8/e6F+I=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-fOgzmAxqM6Wxu9gIWb97Pg-1; Mon, 13 Sep 2021 18:27:17 -0400
X-MC-Unique: fOgzmAxqM6Wxu9gIWb97Pg-1
Received: by mail-io1-f72.google.com with SMTP id i11-20020a056602134b00b005be82e3028bso14996234iov.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGG4Fa5Smycs29b77eteLeOLTMiK3YmJo+qPCM0YDLQ=;
        b=NTibtBePQ4TEkSppte4EcbE82ZnzJe+bE8ZY7YpnFXPPB57KqRdJ0fcw5UD5YkVTc3
         buNzeSebWVNXwzRaBvKeTQh7TFB/jrwPafDatJKP3rlDry27tcSuV8i0URfVwSSgcyR+
         9YNOLx+3VzjQyCkHNLLFHAhIO4DAbbu6jb1t80zpI14RiFPPUMoRrU4YamlabR4YiBrA
         XUV9VSNSv8j/3koYJqvpzmMbjKJzkNQ1BBfjIhGlGiomKvoxiYtXvJgFtU+uiPIEbF5a
         mCEMb3Y/opLJAXRXoP7BhilKY2VloEuPL8+97uCI+SZN35NaPXBcHpdFaXBASalvAURA
         5iYg==
X-Gm-Message-State: AOAM5327zBUuhdBpvEIjFEqi7cSqyqEstGIQZxoaklNOgtwUUBpfNl18
        BF03rB3dmUcxaVueV1db1o7GAxDpzuyVYVOD/2xSCBcIsR5tsmV5jhGbul7HcNI0btfBJ2zQyWy
        nVz3oCnTbNuX4K2uu2QLvLc4J
X-Received: by 2002:a6b:8d08:: with SMTP id p8mr11162101iod.150.1631572036251;
        Mon, 13 Sep 2021 15:27:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0bPc4L5DoLISKmwwxoaeru9bINbkoHdUXmHrr09ECgQlXzcJxdMMRfNjcHMInIucOCgv3MQ==
X-Received: by 2002:a6b:8d08:: with SMTP id p8mr11162092iod.150.1631572036074;
        Mon, 13 Sep 2021 15:27:16 -0700 (PDT)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id d10sm5809457ilu.54.2021.09.13.15.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 15:27:15 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Jason Baron <jbaron@akamai.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dyndbg: Remove support for ddebug_query param
Date:   Mon, 13 Sep 2021 17:24:39 -0500
Message-Id: <20210913222440.731329-3-ahalaney@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913222440.731329-1-ahalaney@redhat.com>
References: <20210913222440.731329-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This param has been deprecated for a very long time now, let's rip it
out.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |  6 ++---
 .../admin-guide/kernel-parameters.txt         |  5 ----
 lib/dynamic_debug.c                           | 25 -------------------
 3 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index b119b8277b3e..d0911e7cc271 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -249,8 +249,7 @@ Debug messages during Boot Process
 
 To activate debug messages for core code and built-in modules during
 the boot process, even before userspace and debugfs exists, use
-``dyndbg="QUERY"``, ``module.dyndbg="QUERY"``, or ``ddebug_query="QUERY"``
-(``ddebug_query`` is obsoleted by ``dyndbg``, and deprecated).  QUERY follows
+``dyndbg="QUERY"`` or ``module.dyndbg="QUERY"``.  QUERY follows
 the syntax described above, but must not exceed 1023 characters.  Your
 bootloader may impose lower limits.
 
@@ -270,8 +269,7 @@ this boot parameter for debugging purposes.
 
 If ``foo`` module is not built-in, ``foo.dyndbg`` will still be processed at
 boot time, without effect, but will be reprocessed when module is
-loaded later. ``ddebug_query=`` and bare ``dyndbg=`` are only processed at
-boot.
+loaded later. Bare ``dyndbg=`` is only processed at boot.
 
 
 Debug Messages at Module Initialization Time
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..9c0c57d1ca78 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -841,11 +841,6 @@
 			Format: <port#>,<type>
 			See also Documentation/input/devices/joystick-parport.rst
 
-	ddebug_query=	[KNL,DYNAMIC_DEBUG] Enable debug messages at early boot
-			time. See
-			Documentation/admin-guide/dynamic-debug-howto.rst for
-			details.  Deprecated, see dyndbg.
-
 	debug		[KNL] Enable kernel debugging (events log level).
 
 	debug_boot_weak_hash
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 84c16309cc63..130ce0eb550d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -746,21 +746,6 @@ EXPORT_SYMBOL(__dynamic_ibdev_dbg);
 
 #endif
 
-#define DDEBUG_STRING_SIZE 1024
-static __initdata char ddebug_setup_string[DDEBUG_STRING_SIZE];
-
-static __init int ddebug_setup_query(char *str)
-{
-	if (strlen(str) >= DDEBUG_STRING_SIZE) {
-		pr_warn("ddebug boot param string too large\n");
-		return 0;
-	}
-	strlcpy(ddebug_setup_string, str, DDEBUG_STRING_SIZE);
-	return 1;
-}
-
-__setup("ddebug_query=", ddebug_setup_query);
-
 /*
  * Install a noop handler to make dyndbg look like a normal kernel cli param.
  * This avoids warnings about dyndbg being an unknown cli param when supplied
@@ -1133,16 +1118,6 @@ static int __init dynamic_debug_init(void)
 		 entries, modct, (int)((modct * sizeof(struct ddebug_table)) >> 10),
 		 (int)((entries * sizeof(struct _ddebug)) >> 10));
 
-	/* apply ddebug_query boot param, dont unload tables on err */
-	if (ddebug_setup_string[0] != '\0') {
-		pr_warn("ddebug_query param name is deprecated, change it to dyndbg\n");
-		ret = ddebug_exec_queries(ddebug_setup_string, NULL);
-		if (ret < 0)
-			pr_warn("Invalid ddebug boot param %s\n",
-				ddebug_setup_string);
-		else
-			pr_info("%d changes by ddebug_query\n", ret);
-	}
 	/* now that ddebug tables are loaded, process all boot args
 	 * again to find and activate queries given in dyndbg params.
 	 * While this has already been done for known boot params, it
-- 
2.31.1

