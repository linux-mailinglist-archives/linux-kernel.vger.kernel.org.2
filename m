Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4B832AE10
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360466AbhCBWUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383537AbhCBVOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:14:53 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96792C0611C3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 13:05:38 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id q25so13300637lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 13:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4xeOgOV+dmgQ3Vrlz+EBeXvEG98wn5ETgFd9xy5bmxM=;
        b=RhYXGFpZRG/9GjiZ3erfaRWqQPZ6DQ3tUVAWkAWXWxDP4CrO2pT7AyzCSOD9r2rq/X
         DOO1JNYjACf7HcrGzpEFhQRjCmhuc49XSXgYVdkY3Cy24uoz1RYhrOvh+rW5jKkaCh4p
         DIHPbzfbokm+bsQcoIxXcSgTnnYslqWfLdnxOpmxk34jpw85G7+T1pOq+ga+7JN1dysG
         ZO7hsf/09qAutB9GbpgBdZLNJXNa7WYgMI1F3DjiL5q00nXD/amE4/JRl0RG8B69Sbs9
         8eOH6mS0KGiBc1qnld2Apc+qAVpz/v6CVRfdO3S/NPfyJJ9Tim0fQYMJsjL4qC6hBRRL
         sa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xeOgOV+dmgQ3Vrlz+EBeXvEG98wn5ETgFd9xy5bmxM=;
        b=gsUb0Jumm5UEsBzGZuwlwhO+OZhAK+8VsGdJV5yivpG3l8gg7+ZMPRbkVLAXJuhzR5
         APJ2r6/MiGAZ7Bl9TofqoXaVBA6KwEivk89TVvvSTdt1Kt63iZNHD9dKXSveEyJKPtXy
         dDQoVAXcqJPIDwaIQTAXUMRS3ISssJiptmh6xOgsESY2qfIWy8WyKwqu+39pHoV6aVe5
         EfocZrVDD0TlnobzdaPKsK+/+cZmmet2P8Tf2/wkxM74wOG72fyajlwPXNP1NDM4+8pB
         i2cFgyv2dsLh7bo6q6MErtm/fQUkbWOnUx8Wl3rE1l6OlYdMrdm3mYzS7bNzxsgh+gCB
         TOPQ==
X-Gm-Message-State: AOAM5329luIx09+P6x1NE+GKXht7UQmTuqtRNPT0AzH+GlrzShWqjexj
        UYlN/djd9VOSqMXVItJ/Kec=
X-Google-Smtp-Source: ABdhPJyYq6/T86xRPJkRNfjSdYIUnV+TLBiJKYGouZ1JfTfZXVERo+CqaygmWg/EnBTUKA1/gPX92A==
X-Received: by 2002:a05:6512:21a5:: with SMTP id c5mr12936115lft.125.1614719137171;
        Tue, 02 Mar 2021 13:05:37 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id k6sm1619796ljb.110.2021.03.02.13.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 13:05:36 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [RESEND PATCH 3/3] mfd: pcf50633: Constify static struct attribute_group
Date:   Tue,  2 Mar 2021 22:05:28 +0100
Message-Id: <20210302210528.70945-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302210528.70945-1-rikard.falkeborn@gmail.com>
References: <20210302210528.70945-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of pcf_attr_group is to pass its address to
sysfs_create_group() and sysfs_remove_group(), both which takes pointers
to const attribute_group structs. Make it const to allow the compiler to
put it in read-only memory.

Done with the help of coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/mfd/pcf50633-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/pcf50633-core.c b/drivers/mfd/pcf50633-core.c
index 148bcd6120f4..0768d684113a 100644
--- a/drivers/mfd/pcf50633-core.c
+++ b/drivers/mfd/pcf50633-core.c
@@ -131,7 +131,7 @@ static struct attribute *pcf_sysfs_entries[] = {
 	NULL,
 };
 
-static struct attribute_group pcf_attr_group = {
+static const struct attribute_group pcf_attr_group = {
 	.name	= NULL,			/* put in device directory */
 	.attrs	= pcf_sysfs_entries,
 };
-- 
2.30.1

