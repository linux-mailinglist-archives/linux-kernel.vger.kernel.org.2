Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62CF309942
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhAaANh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhAaANb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:13:31 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66573C061574
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:12:51 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id v15so12015939ljk.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNULYoCFMxkvIYfnPGwrWYt25AhtkOvu532DvQKjYIE=;
        b=VG60oQQVAtnPDp8YE7K73mpWCbyNFQFLV6fLCs9quGtY+kJB+yHj/ArUzYJT7T2ouB
         JDvO3SjJbgmBZ8gnubAECrtIvksq34OB69sgM3Ha/NL89/BKba0LPfApnzt7IOBUXN1G
         2UYYP4zYoX7CaRziUWviEwen3/sy45iCTDE2qlF6ZM+g/hZgdEhRYOMBZr9U7uCtCQih
         3K4R406nh9cFiT/9/1nIIUdy8SSqF8OHRmBuwdQ7A+ehgL39coJ1DLgwPKKgAIdPeeGy
         +g+RPt0s9Ay4dmdAKkLyWpkDVC1lJ4z8fAFIB1aRDSgoTbGDc7fgEv3IWzmZOBqS24qf
         zaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNULYoCFMxkvIYfnPGwrWYt25AhtkOvu532DvQKjYIE=;
        b=cNtmfcURbQO0sLIq3p79woFJ1kkDhzdkX/bB6YqWaBaVW8wt0k7Z5lT4vH11kKSKWk
         YapOuDRFLNdI0af2JFtHovCP8Tt0rwkTD3Hp2nFRlgMLsHGeCOUXMCbKKz/Y7TUEl6JD
         ZLBDL48F2BMC76pJssAvjiyAlY+TPrlLODWnRkb2CdHAYeSYrtmGQn/oHUbeuUIwCoWm
         Hib+LjR1jvTc5iF1JI3tCqbi9rmTKXVWXZYmpk0iB40BfdZUVxWx+sfXaI7CwDlkV9Ng
         Bqeg5IHIsm74u5ek9SgSon28bVFvUEgWJ2KwXFhyncUgqG5zWvIEdE1Uh18EE7bhUWdd
         pLWA==
X-Gm-Message-State: AOAM530+K2Y5p+UudxatzLREKMnskvJrM4zd/pOY1GUMO6n/PkiZuJcK
        IhidhXww+5Dc0rKmbx41PKORcXyevZU=
X-Google-Smtp-Source: ABdhPJwIwCCAqBgXPZ9A9uAUMWI5/ecyMgpwRPG/qFkbheuq32Wzct8Jlte+Q4yIT7dMt69pOf3tJw==
X-Received: by 2002:a2e:99d3:: with SMTP id l19mr6144824ljj.132.1612051969926;
        Sat, 30 Jan 2021 16:12:49 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id t2sm2503716lfl.141.2021.01.30.16.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:12:49 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/2] ALSA: ac97: Constify static struct attribute_group
Date:   Sun, 31 Jan 2021 01:12:40 +0100
Message-Id: <20210131001241.2278-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210131001241.2278-1-rikard.falkeborn@gmail.com>
References: <20210131001241.2278-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of ac97_adapter_attr_group is to put its address in an
array of pointers to const attribute_group structs. Make it const to
allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/ac97/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 7985dd8198b6..d9077e91382b 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -273,7 +273,7 @@ static struct attribute *ac97_controller_device_attrs[] = {
 	NULL
 };
 
-static struct attribute_group ac97_adapter_attr_group = {
+static const struct attribute_group ac97_adapter_attr_group = {
 	.name	= "ac97_operations",
 	.attrs	= ac97_controller_device_attrs,
 };
-- 
2.30.0

