Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466403221B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhBVVpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhBVVpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:45:35 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749ECC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:44:55 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id h8so14246513qkk.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 13:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1dNKSWdiyZdcySCS8Mo5qwTMLCVeoueOOG2rvs262jo=;
        b=D/+0Js26+HlfFQqMWd4QnMQ98GQQuoxrWwxYY4jKjloItBDrEbKRDIRnoTvrj2jsLZ
         +VoTol7Zos8swZE8ooW4d1tt0+p1lR5qQIoUcSHDclxVP74QbKjUCb5LhB1psGs5W7jm
         CMDz31J8BQZDT7LiXnP7QISkZdobC/4AgRZojU1mUaGhYCmUrUuUZPdWB7o28JPxfR7c
         qCdWM7U0A+eu5D62AdYAoOvpAHKn/AtdToFOTQuVexockM6ZbpwWZhx5tz7KHlpP9l6G
         tPFToFt0L1pEZKyMqOCcTugeGGxw1TAomprjAeH/dPHmFXZpbV3qW+kCNEah/QMt8RXn
         u4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1dNKSWdiyZdcySCS8Mo5qwTMLCVeoueOOG2rvs262jo=;
        b=fyY+wsQfye2mOXyHEcvFQYm5CQOyKxZ2uGQ6IU7n3KhzyCPehnjwSJ6KujDL5nE7Ra
         Eieh/r3przlfEnxD2isu0C9nwVIFsM0/N5viupjqiMqgw16mJoPSLYC1yUw1ukK5N0eo
         YhVnlhmHbWuxZdNtyWiBtYKZxc+k9FEKnYA19KsNSzsbZDwql469H5C5yeasbb46/K0X
         38jXzVwvshZaQ8RB0qWWQS4MGnR3XsijwhoXl0jaxXDYT/zUdKEQAcXj8Y8eaknO9QdW
         FTHHhn835SE8xBUey1xiK3g0rMnDxDfsYvzMrQwmW9QUQ65ZeAXyxq87p95PGXDyBakf
         xJag==
X-Gm-Message-State: AOAM533wlrYTkQxaiQr+6uNTLHg6vQCYQB+9jHPDdBu53o9alpQYV6Vv
        dZG+/z9CeMp7KaH962dlEexxXzsF+I7v5oP6
X-Google-Smtp-Source: ABdhPJwFSCSJLOSqsPqKt3URkuoEibnPZ79qNnVRlvLNBOgSLG7t2y7e0ZwQSSypqQB5QOdocrILKA==
X-Received: by 2002:a05:620a:22a3:: with SMTP id p3mr22841037qkh.13.1614030294650;
        Mon, 22 Feb 2021 13:44:54 -0800 (PST)
Received: from localhost.localdomain ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id j5sm11595009qth.80.2021.02.22.13.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 13:44:54 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: soc: codecs: fix kconfig dependency on GPIOLIB
Date:   Mon, 22 Feb 2021 16:44:44 -0500
Message-Id: <20210222214444.23340-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SND_SOC_DMIC is enabled and GPIOLIB is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for SND_SOC_DMIC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_AMD_RENOIR_MACH [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AMD_RENOIR [=y]

This is because SND_SOC_AMD_RENOIR_MACH selects SND_SOC_DMIC,
without depending on or selecting GPIOLIB, despite that config option
depending on GPIOLIB.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 sound/soc/amd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index a6ce000fac3f..5480dff7a1ad 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -46,6 +46,7 @@ config SND_SOC_AMD_RENOIR
 
 config SND_SOC_AMD_RENOIR_MACH
 	tristate "AMD Renoir support for DMIC"
+	select GPIOLIB
 	select SND_SOC_DMIC
 	depends on SND_SOC_AMD_RENOIR
 	help
-- 
2.27.0

