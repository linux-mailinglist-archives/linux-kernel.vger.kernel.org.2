Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CACB44E76C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhKLNf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:35:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235014AbhKLNfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636723976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3FqzlM6+St6bQetl39I3gwMqH+GHqZeZ7fYAU6/+0T4=;
        b=UQd3D7ucaCKOOT3j3nUoLV7EugYXI1C721ZYulLCx+HQ/Sus3M1z5z/PTwZi64px4uhRSW
        V65SO0EHh784KUxk9CtyASbEX/vjsZQVfHxxL3Eu2gO4rFO0rl4UCmaxidjxnEup0/x2/5
        wh72LYjDV7jkNCsK15j6+K+k9aS5IgU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-g3_etzNbMVKhTzxU2FPUJA-1; Fri, 12 Nov 2021 08:32:54 -0500
X-MC-Unique: g3_etzNbMVKhTzxU2FPUJA-1
Received: by mail-wm1-f72.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso6326862wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3FqzlM6+St6bQetl39I3gwMqH+GHqZeZ7fYAU6/+0T4=;
        b=hQ9Tde6mHkA1uYqtfkxnDLn0ISIp1gL+Kg11oliFz6Mt6nwKgS9qWFU6ygJqPM+/Nm
         8NaYUd2OQqT5WA2YOeISnIHtq4jmoujhK5QWYB/cI2/wazKZfo0xFv1nkNTzelspsTFB
         Wqpvq1FJA4+yc7XafGSU+gq0QMe2aU1EiYUE2JpxXegzIrsZ+RvD1q3MHaCS8OKm1o00
         paY8hfDfV3e+RoG3QzDpaxC0xyIEFqEC3xkQ6bCdwcJunMAulpT1EofpDZNvy50dQ6pF
         1IPL1de6fmpQZMzs3wh9l4xjlH62eTZWxWF1quSHbcVkSV5LerDvB00XX8VDy2LbcQ5G
         zmgw==
X-Gm-Message-State: AOAM531VJCGPZU6SjKaNJB+jHBc1PSm9x0k3LAiA0XouP9auzLZYDpP2
        pVHQykeDEIFudKvKkHn6xLc7KCHb83ZBlfajuuDlCHkN7g9ggAE8/WT08YxnxR7kz4rN22OGvgn
        sFD75romtrkVeQU1tKJ/5KAU8WRFMFljGMz0+VTQv1btMQTteqG/Vt8zejnhCE6hrEK9lXtfj6M
        E=
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr34049727wmm.163.1636723973552;
        Fri, 12 Nov 2021 05:32:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXhf8o+Hmrcc8jR2g8wf726UvSKzVQSsR1IKzZrdqoEz7h67KIvU9EZPqzf/sK1e/whAJWug==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr34049692wmm.163.1636723973313;
        Fri, 12 Nov 2021 05:32:53 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z12sm5733470wrv.78.2021.11.12.05.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 05:32:53 -0800 (PST)
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
Subject: [PATCH v5 5/6] Documentation/admin-guide: Document nomodeset kernel parameter
Date:   Fri, 12 Nov 2021 14:32:29 +0100
Message-Id: <20211112133230.1595307-6-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112133230.1595307-1-javierm@redhat.com>
References: <20211112133230.1595307-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nomodeset kernel command line parameter is not documented. Its name
is quite vague and is not intuitive what's the behaviour when it is set.

Document in kernel-parameters.txt what actually happens when nomodeset
is used. That way, users could know if they want to enable this option.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
---

(no changes since v4)

Changes in v4:
- Don't mention the simpledrm driver and instead explain in high level
  terms what the nomodeset option is about.

 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git Documentation/admin-guide/kernel-parameters.txt Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..f6434aff943d 100644
--- Documentation/admin-guide/kernel-parameters.txt
+++ Documentation/admin-guide/kernel-parameters.txt
@@ -3521,6 +3521,13 @@
 			shutdown the other cpus.  Instead use the REBOOT_VECTOR
 			irq.
 
+	nomodeset	Disable kernel modesetting. DRM drivers will not perform
+			display-mode changes or accelerated rendering. Only the
+			system framebuffer will be available for use if this was
+			set-up by the firmware or boot loader.
+
+			Useful as fallback, or for testing and debugging.
+
 	nomodule	Disable module load
 
 	nopat		[X86] Disable PAT (page attribute table extension of
-- 
2.33.1

