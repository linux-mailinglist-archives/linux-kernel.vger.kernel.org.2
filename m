Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA7844E76B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbhKLNfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:35:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235028AbhKLNfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636723977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AaO3QXEQbXfVqe2t/6/9SpNrbCP6PsY29GvZKutU2UA=;
        b=Ok8IpjMytbWZTuWPsJvRSIwqZbl6xTtPL1KaeGV34N8abavY+nLH1TY/c/OC8oCZLrnCe8
        tsyPW6BqoJVrscCVNMz41F+tYeL62fajwnAnRQVYk4kRSth7L/c+Yes6FiyzUjQeDd2W4l
        Wg/45Le+lYxyg/JiNgd9W2V0aiH+jtM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-icsZol8BNb6CwSdlCt8H7A-1; Fri, 12 Nov 2021 08:32:55 -0500
X-MC-Unique: icsZol8BNb6CwSdlCt8H7A-1
Received: by mail-wm1-f70.google.com with SMTP id m18-20020a05600c3b1200b0033283ea5facso2231738wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaO3QXEQbXfVqe2t/6/9SpNrbCP6PsY29GvZKutU2UA=;
        b=cG46zdco8djRBnl9OzIzQoc9owKFDY4/4IuV0HkRQfjoNcAZGcgPxHWN+wmTtDDjFp
         VC/juaqPwcPxUBAOLOJcCNMYw0faVcyT4avD2bpHA+fWjRcAc+Hn7OOmmB9g5eDKLHkl
         4oOxMc/5TFzp6BPMaHquhFsuTn94RQ2cet/VtGxIepTViycKVs/9ayZOz3EGv8ZVbFWP
         U0G8wEEsZV1PQBcoWZMUJmD7f4XIPNI8PjbIHqLl8BYOLSmHy0rsh9yL3PuJXlR1HroB
         Ta5etB/flLTT0cX0vh3NP0gC/xPC7tU7YEsfbf20pGlYIlnvfJ69bF/CuOOTzTZrRI6u
         A0iw==
X-Gm-Message-State: AOAM533YRUc2yU8RUfeITOFTCCbiSIGLjzEzFqqv1l2+fOWJ7p0KiWXu
        Azc0W8p1pjLRqeTbqOdTbhAecDONAsmwYcUxwa9vGwGFUUR0zwp7Dx7JWQUCfReh5Nc6n9mwPnu
        gaxt58WdqwjqG18X44fcH1QcGd9peqaQAALsDcOl4dwAT3ARaL9ag0okbmmkMoGO68PPO/OU4ce
        c=
X-Received: by 2002:adf:ce8b:: with SMTP id r11mr18856993wrn.294.1636723974631;
        Fri, 12 Nov 2021 05:32:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFhz4WOPQz4XIIQurMGjApmL4pEhOMydaNTrPkUDoEb55215QS7i1Xxt0f2vAEHuNr9oDRQA==
X-Received: by 2002:adf:ce8b:: with SMTP id r11mr18856946wrn.294.1636723974379;
        Fri, 12 Nov 2021 05:32:54 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z12sm5733470wrv.78.2021.11.12.05.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 05:32:54 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v5 6/6] drm: Make the nomodeset message less sensational
Date:   Fri, 12 Nov 2021 14:32:30 +0100
Message-Id: <20211112133230.1595307-7-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112133230.1595307-1-javierm@redhat.com>
References: <20211112133230.1595307-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The message printed when nomodeset is present in the kernel command line
makes it look as if the parameter must never be used and it's a bad idea.

But there are valid reasons to use this parameter and the message should
not imply otherwise. Change the text to be more accurate and restrained.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---

(no changes since v4)

Changes in v4:
- Don't mention DRM drivers in the kernel message and instead explain
  that only the system framebuffer will be available.

 drivers/gpu/drm/drm_nomodeset.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git drivers/gpu/drm/drm_nomodeset.c drivers/gpu/drm/drm_nomodeset.c
index 287edfb18b5d..f3978d5bd3a1 100644
--- drivers/gpu/drm/drm_nomodeset.c
+++ drivers/gpu/drm/drm_nomodeset.c
@@ -15,9 +15,7 @@ static int __init disable_modeset(char *str)
 {
 	drm_nomodeset = true;
 
-	pr_warn("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
-	pr_warn("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
-	pr_warn("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
+	pr_warn("Booted with the nomodeset parameter. Only the system framebuffer will be available\n");
 
 	return 1;
 }
-- 
2.33.1

