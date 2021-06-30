Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7C13B817B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhF3LyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 07:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbhF3LyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 07:54:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5564C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 04:51:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso4198526wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 04:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akRbaXTEKIVDQqSRNSE5wCUGZIGSo9wuKChhoxpeqdw=;
        b=QOlhghSfGUkixEl2DIkQ4oMZqY2ev6Fl2ZH2xU7qFg6JYTZje9DsPYKecitHS1XrNr
         uJ/gtSKDvnIHH2CbBZVqau0jr+YDBhVau3LNfvciZH8NZNJx/nH5y/U0Z87/kSL8sawQ
         Kb91XZ8veVfpB4DH9/CmZf08ONmgbspP4ntaBViD2V1tmMrtSZQnQSO2PexMA2L0j51i
         8ZDke+b2pEr9WwJG5NFiES4wBE/5XqBx8QbZPsnz1RfsFRM1AAdB4aS+HD8/5iDDThet
         nvjU3/50pYz+AQT8R1klb3H/5HaBFEhQWPhMbOEfkQKNkKUshQ5npUUcKjHgKTwKdoIH
         DQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akRbaXTEKIVDQqSRNSE5wCUGZIGSo9wuKChhoxpeqdw=;
        b=kOCFg4gB8Thj2LzKDLIl8gpSDCIqJXXxzUdw0qnA8Q7TMhJs2TDREDH1GtTED4s6cQ
         0BaT5TH0JRkg/rY+izdmeteNGd7W7n/GBmiYnn0veYtU6Yj+E+xsQJ5Vv/M2nQ/hXtii
         NqkPYHH4UJHcL4aYyLvH2M1HjdiDnS3BjtqGIoge0LfZqrfaw3lvKbW8ghPPgQp1fFzM
         poUgZPx4db+ghVqt9qpNrGLg/bYRYEkgh9dH19p1G7/k25mMFsE6o+aI9886mz6kHa3+
         8e9sfQbzgdceOwsgmB1Oeum7U61ZwiawcpI3lQLaJqs5IR+HD3MyFtiDGwod5do2es48
         a8Hw==
X-Gm-Message-State: AOAM5331C02c/OxCKnCQ4WD9P/l2C3v+kRQUy6rylftJBJVw4q70A99f
        nX///IiQlsP2WYhOb632LctxUtXj4JKyOg==
X-Google-Smtp-Source: ABdhPJx3/cKoXYNMama0RHMiRBqHWZ6zLWgR8empYsxwhLifaxZQXEzVBWYTT8/UkGOwYeke4B831w==
X-Received: by 2002:a1c:1f8a:: with SMTP id f132mr3648369wmf.56.1625053909167;
        Wed, 30 Jun 2021 04:51:49 -0700 (PDT)
Received: from localhost.localdomain (91-167-148-192.subs.proxad.net. [91.167.148.192])
        by smtp.gmail.com with ESMTPSA id o2sm22107777wrp.53.2021.06.30.04.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 04:51:48 -0700 (PDT)
From:   Greg Depoire--Ferrer <greg.depoire@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Depoire--Ferrer <greg.depoire@gmail.com>
Subject: [PATCH] init: add rootopts=%d for rootfs mount flags
Date:   Wed, 30 Jun 2021 13:51:28 +0200
Message-Id: <20210630115128.3878-2-greg.depoire@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210630115128.3878-1-greg.depoire@gmail.com>
References: <20210630115128.3878-1-greg.depoire@gmail.com>
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

