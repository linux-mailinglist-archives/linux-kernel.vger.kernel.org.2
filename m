Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215084480D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbhKHOKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:10:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240218AbhKHOJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636380431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOreeT9xy7J8ItI94NHKifuwS46AUpOFOueH2yffi6I=;
        b=NVRzvmCxNJoTylj/GD5Ai2CpFOGke5wHtnUhhnY4oJKbwfN2CyllentI/TFjBEPGJ2sIdM
        GHQsA7xZ3sjggRZgLV/6aLbwyvSRd8NBYZQyZyA+6Mddl73ZNUqhth5ziTG5jML3CDplve
        1MM8mOdu1xa3lKaRYd1tZJiYTeNJbJg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-_LWUHpq5Psak9MutoXVRAg-1; Mon, 08 Nov 2021 09:07:10 -0500
X-MC-Unique: _LWUHpq5Psak9MutoXVRAg-1
Received: by mail-wm1-f69.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so6249908wmg.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 06:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VOreeT9xy7J8ItI94NHKifuwS46AUpOFOueH2yffi6I=;
        b=NLwnRZOrQ7sVl4ebAQ67YR01Ak7deR4eidWZ1upPtvIKjUqbzGB0F0k3sfmB9VuTzE
         UTctfVO+fcDoZZiIjIHlPoPS7PAGz5yyzjTQNR2CU/3BR15iERts8HC0vUQYeFxy8Nl3
         weqv1dGnoHAlkALiAyPY31AM827jPOVfLyxG4hy507ifHe3FeIisOvSue2zGep3CZxXo
         3MEpmH0IqOtqOgZO+4Fgz5VFE1SOdReVDmYmQrHNMBmQZECAIt6ISyPvA6WWt5dJX/v9
         HKWDL7KmYMAbtFafzHoxXy4Deb0ow8jpZPuwhGGcm14+DcYhcUd4On6TCnl/tuXgzt+e
         n/pA==
X-Gm-Message-State: AOAM533/k+KPdExPAqiLhT6bhMthyf9l9JkURapWG1R+vvv5e0GvIHyC
        ya5FSQFGtPD5WhNgWm6k+3K0rwtwQZN3o3kLQqkqm84J3wG3bocXaU6EdqzkmON/eZ9uqd//BKc
        JUUj5vAT6RDQo5zxOCU63vHryy731rrwGb4mWIcI2Ly22I8VZ8s7/NpVVDRlVN6AtfJoqsXL7H4
        w=
X-Received: by 2002:a5d:51cf:: with SMTP id n15mr80160wrv.106.1636380428697;
        Mon, 08 Nov 2021 06:07:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsYYuejGw7CybgaCxd/E1fUntxtMWk95iWPCbVv910JhxO1p9TBwfd54lnbUNLk9ILcI1Iiw==
X-Received: by 2002:a5d:51cf:: with SMTP id n15mr80114wrv.106.1636380428489;
        Mon, 08 Nov 2021 06:07:08 -0800 (PST)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id m14sm10081696wrp.28.2021.11.08.06.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 06:07:08 -0800 (PST)
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
Subject: [PATCH v4 5/6] Documentation/admin-guide: Document nomodeset kernel parameter
Date:   Mon,  8 Nov 2021 15:06:47 +0100
Message-Id: <20211108140648.795268-6-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108140648.795268-1-javierm@redhat.com>
References: <20211108140648.795268-1-javierm@redhat.com>
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
---

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

