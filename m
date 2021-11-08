Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461E9447F65
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbhKHMTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239462AbhKHMSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636373770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnGe14GlJaau0OMIVugUisnX721y7g1CODOMkymf8RU=;
        b=h54CM3tZ1W9dOnd9oBkqGiBygn+mQmq/D2TgnK+UyK8HbzEof4le2kAvon5tI+wUx8QXHQ
        hN1Q8627iUR/GjVSeCrSBK7zsoR05ZxDrlZyLENIotbxdWLFtwQCRB6eieQ8l7sLPJHzCd
        YpEVQDDgwLXCFBM3GABaSc5+vJqVmqg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-SG-p3liyNKCBoHEYgasQWA-1; Mon, 08 Nov 2021 07:16:09 -0500
X-MC-Unique: SG-p3liyNKCBoHEYgasQWA-1
Received: by mail-wr1-f70.google.com with SMTP id p3-20020a056000018300b00186b195d4ddso3966430wrx.15
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 04:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WnGe14GlJaau0OMIVugUisnX721y7g1CODOMkymf8RU=;
        b=N8gT1+QslepxKzpuiiu/h+fHMYb1FNp0mI9J48YRzUtXN1J5jJ7UyZA6O1fIvTs9u+
         2h1MLYmYkBeSUdJoE3pCq3L5U5b0IcvICv7nFBVUWZQc1gMkBI5OCW3p0trzybcrAI2E
         5MXXhlJ0IKV15E3ZgmeLbZ9L/5cWPTEkMnxmELRAPEylIkNj4MTlSISScdFR9YckHscJ
         EW9ANJEIEQHXyHXjGhBN0cpjJ+vwZ7mla/0CA6cxXhLkntX+lGCYoGwMoab7vX+vpHCv
         5xlwPrGLDDZz7tuwh9iLpn6FhHAvovCItsWOBGtyGIVhdK4Vg/Vlpb+f9Nirf3fkOFPe
         N3QA==
X-Gm-Message-State: AOAM532IigdLINZHLx0LvmxeSbTa0xdI5FW3A/vEsX0vJRRt8uWrCTdR
        pzPwrCaY2mFP7mJmjgjWzf5kr6m5QhumKERUNiPy4bEKYdwGCEbajcu+6vXPR9/w6g9hAMpIPaz
        V5CweMkbCPTd3C+SlyKKBLLipHbsU9oO42+k3c6lKgN/8sfJz79OYraK5uTSwTOkQqF9br7JXiA
        U=
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr82534233wrx.173.1636373768349;
        Mon, 08 Nov 2021 04:16:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBgQKrPYRz0pBv/sk0n4DbT9LpRxV0KvN018VU3gUyPHYzjFByA3zdZkPSUre4xqa4mBeFug==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr82534189wrx.173.1636373768094;
        Mon, 08 Nov 2021 04:16:08 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id q4sm16866866wrs.56.2021.11.08.04.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 04:16:07 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 6/6] drm: Make the nomodeset message less sensational
Date:   Mon,  8 Nov 2021 13:15:44 +0100
Message-Id: <20211108121544.776590-7-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108121544.776590-1-javierm@redhat.com>
References: <20211108121544.776590-1-javierm@redhat.com>
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

(no changes since v1)

 drivers/gpu/drm/drm_nomodeset.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git drivers/gpu/drm/drm_nomodeset.c drivers/gpu/drm/drm_nomodeset.c
index fc3acf3ab2e2..45e50b3497b8 100644
--- drivers/gpu/drm/drm_nomodeset.c
+++ drivers/gpu/drm/drm_nomodeset.c
@@ -15,9 +15,7 @@ static int __init disable_modeset(char *str)
 {
 	drm_nomodeset = true;
 
-	pr_warn("You have booted with nomodeset. This means your GPU drivers are DISABLED\n");
-	pr_warn("Any video related functionality will be severely degraded, and you may not even be able to suspend the system properly\n");
-	pr_warn("Unless you actually understand what nomodeset does, you should reboot without enabling it\n");
+	pr_warn("Booted with the nomodeset parameter. Graphics drivers will not be loaded\n");
 
 	return 1;
 }
-- 
2.33.1

