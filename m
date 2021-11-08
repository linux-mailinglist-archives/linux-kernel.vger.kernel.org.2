Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B56A4480DA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbhKHOKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:10:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240227AbhKHOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636380432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHhiP8dWU/yCrRHfZ4flhCwBp7rRmlRP7VQTJMKR8q4=;
        b=XxaBCgXdjRwPiqRyXG7E0v80fGR4U2sl/Cdg6EZZQxDFol3EBYMbRw4Xl0MsbUVnFa4kbl
        nAEPKQQQv1A5bw/cVKYNAMB8eNs0ADFOLbbtvOpjMz+oTUpsV5+WVAQjvgyH0Q34eECdX/
        0F5M2QdkYqzKWw8580j9KxKzZ8aiDoQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-vM7vHXRDOJGlbLlfyAYYrw-1; Mon, 08 Nov 2021 09:07:11 -0500
X-MC-Unique: vM7vHXRDOJGlbLlfyAYYrw-1
Received: by mail-wm1-f72.google.com with SMTP id r6-20020a1c4406000000b0033119c22fdbso6259824wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 06:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHhiP8dWU/yCrRHfZ4flhCwBp7rRmlRP7VQTJMKR8q4=;
        b=UsEP1Qj0VYobKovJWH/eN8Xw4ZarYxJwwvF/CJldg6QTeb6gyJLDgE4vbSZTYDEbTO
         pd1eSCNR+IrHhma1/dhcKFNjUDbq1Xu6SrZalMtaPXguMgduF7KYMb8AaM6djA5C1vFb
         Rl+Wncaj/hlH1lnzz6T5OmWSlclwP1SFW6wm/eW/m0YurMkxX9VJ9JxTv4Vd5Fj/Sq1T
         w5dPjjlllUBvpNW1M/zIGMkSu/yGPQs0Zq28bKVofaCIauFcTzXPHhR0GSMsWsSTCURQ
         a6bho2UmlFvzyKGpN3SdHfTs4XzQht0KIHRFlU9gvFzmyZwPYlOvibCV6mh1PteCnDLJ
         E5Wg==
X-Gm-Message-State: AOAM531x+kQ7PjC88fHy/YqS+Yy+FQ3EpQb4O9VXGcgI329kKsbt11a6
        0wNXig4SD1XW+Vuzj1PReVSdBjsctZgvNxmeR36TAgySoGz2Oz+0Xg8/k4W6wo+VFI3GQC7xI0M
        CRSDjijIWDf+zDPxC1hvKMvF1En4qwHVpSnzZHQLVf79AYeLy1rx/N/MeJPvU08kR00RJEXvD/5
        0=
X-Received: by 2002:a05:6000:1869:: with SMTP id d9mr23381wri.416.1636380429826;
        Mon, 08 Nov 2021 06:07:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBR8kNUJGMU0WDyzFvHqppXC/rJqD8zpASqe2AAp4OC/OcZbz6W8aHlANT8ClrikiGMpRVMg==
X-Received: by 2002:a05:6000:1869:: with SMTP id d9mr23323wri.416.1636380429544;
        Mon, 08 Nov 2021 06:07:09 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id m14sm10081696wrp.28.2021.11.08.06.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 06:07:09 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 6/6] drm: Make the nomodeset message less sensational
Date:   Mon,  8 Nov 2021 15:06:48 +0100
Message-Id: <20211108140648.795268-7-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108140648.795268-1-javierm@redhat.com>
References: <20211108140648.795268-1-javierm@redhat.com>
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
---

Changes in v4:
- Don't mention DRM drivers in the kernel message and instead explain
  that only the system framebuffer will be available.

 drivers/gpu/drm/drm_nomodeset.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git drivers/gpu/drm/drm_nomodeset.c drivers/gpu/drm/drm_nomodeset.c
index fc3acf3ab2e2..148b01f7183b 100644
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

