Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C5F3B772B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhF2R2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhF2R2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:28:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044D6C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 10:25:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso1177021wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akRbaXTEKIVDQqSRNSE5wCUGZIGSo9wuKChhoxpeqdw=;
        b=JDlOfGpIOkCzSEfLEmzxCxfPs9PwkqkLYUhenXrAohZqh9rqh9jwwbGroeemsIW24P
         u56QAXyjaHyKGV/SvXYmLSos4ff4r2mSMmIyCvwMxV45MgBqvWAjflWks1+bYrA5s/1u
         ND8ubBc27CodznvbodXAcWjWW75nYexZseFI9I9q1xHw/zA6lncyikTILm3gDhlVpyV1
         VQd6yZySwjw4ovBMv3QJZJOcu6jvXghkNdGElmiuKoRzb1eL3w0M6fFTI/E2TZ7fZxmH
         kK/I7gCDw9FZ9CNfvjcHXHOITJep0p03sfS2sghUXCdjLmaHBgeSYPBy7bW5qG6k83/K
         Cg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akRbaXTEKIVDQqSRNSE5wCUGZIGSo9wuKChhoxpeqdw=;
        b=OiQ0u2TvySjHYZ5Rnw1jIOOgevDfxHndGwqo+qp8oYjDeBWFo6w3pi1EggKC921LZN
         xyCsZJqv8j7izD3HxiUK1CpZgSnWigkL/85HhjcjSqgNz/9pcaYgTJhmYOwS/DKj5fw6
         SBn4/5sapl/K92NULltTlWJLp4oKXjFG5+mNxT6Pc6HvvlufJ5h2lowelwnR4raeK7ov
         SarxQeBtnAaN4ylP+T0GEMOEg/U6ZraLFDQNmvt5/0swWBrzKTtyKNow3sw9iisxuGrM
         0MIoJt+bVeDFTFGtdtonhFLMJxB/A6TpVykzPqGD49tXKbPjeG3eHuCuloaIXJZ3bUb9
         XAyA==
X-Gm-Message-State: AOAM531i47GTC2G5se2gfvwbP3/7ldrOP1Ox6CC8+8WpRrGS6dgfhGa3
        I7qKpZqszJnNw58egZ4igj1jGpEYV2OAGQ==
X-Google-Smtp-Source: ABdhPJziTigm69m4P/E+jcnRaKqfMm5a/0XToISjjcPgFzlKlwbSNkUUJjYL7NMpf5/xLQyDEMnURA==
X-Received: by 2002:a05:600c:1d11:: with SMTP id l17mr7223639wms.180.1624987541593;
        Tue, 29 Jun 2021 10:25:41 -0700 (PDT)
Received: from localhost.localdomain (91-167-148-192.subs.proxad.net. [91.167.148.192])
        by smtp.gmail.com with ESMTPSA id g17sm14359173wrw.31.2021.06.29.10.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 10:25:41 -0700 (PDT)
From:   Greg Depoire--Ferrer <greg.depoire@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Depoire--Ferrer <greg.depoire@gmail.com>
Subject: [PATCH] init: add rootopts=%d for rootfs mount flags
Date:   Tue, 29 Jun 2021 19:20:54 +0200
Message-Id: <20210629172053.1709-2-greg.depoire@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <200308131944.h7DJiMpS001539@turing-police.cc.vt.edu>
References: <200308131944.h7DJiMpS001539@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the rootopts command line parameter to specify mount flags for the
root filesystem.

The kernel provides the rootflags parameter to specify filesystem
dependent options when mouting the root filesystem but did not provide
any way to set the filesystem independent flags.

This is not an issue on systems using an initrd because on these
systems, the rootflags parameter is passed to the /sbin/mount binary
which understands filesystem independent flags in the option string,
such as noatime (MS_NOATIME) or nodev (MS_NODEV).

Signed-off-by: Greg Depoire--Ferrer <greg.depoire@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 init/do_mounts.c                                | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 26453f250683..01e1217583f5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4851,6 +4851,8 @@
 
 	rootfstype=	[KNL] Set root filesystem type
 
+	rootopts=	[KNL] Set root filesystem mount flags bitmap
+
 	rootwait	[KNL] Wait (indefinitely) for root device to show up.
 			Useful for devices that are detected asynchronously
 			(e.g. USB and MMC devices).
diff --git a/init/do_mounts.c b/init/do_mounts.c
index a78e44ee6adb..ebe51fc7cf86 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -326,6 +326,16 @@ static int __init root_data_setup(char *str)
 	return 1;
 }
 
+static int __init root_flags_setup(char *str)
+{
+	int flags;
+
+	if (kstrtoint(str, 0, &flags))
+		return 0;
+	root_mountflags |= flags;
+	return 1;
+}
+
 static char * __initdata root_fs_names;
 static int __init fs_names_setup(char *str)
 {
@@ -341,6 +351,7 @@ static int __init root_delay_setup(char *str)
 }
 
 __setup("rootflags=", root_data_setup);
+__setup("rootopts=", root_flags_setup);
 __setup("rootfstype=", fs_names_setup);
 __setup("rootdelay=", root_delay_setup);
 
-- 
2.31.1

