Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBA43F97C0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 12:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbhH0KBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 06:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244758AbhH0KBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630058447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=foW7usJ3woghuCkc/3vNgB/OwFOj3a3CXY41KP8I0wQ=;
        b=XkWr/0ro5u1TPccFTsI/15wi/vb6BsVaCYbYSBXcm0BT388xkKcReuFd+wOFeNpqqw3sfC
        thFbOMExmfx9orXVPq2FtDBm2Nlwmo2XU3j0i6oKv/ViGeRkMkZPgCYafcqUq3iqP3+gTw
        /eXZblDiWl5TVtAaR8Yi4pTAUkvR+Dc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-x4MhHcaeMSSeiCe5cXCRxA-1; Fri, 27 Aug 2021 06:00:46 -0400
X-MC-Unique: x4MhHcaeMSSeiCe5cXCRxA-1
Received: by mail-wr1-f70.google.com with SMTP id r17-20020adfda510000b02901526f76d738so1717524wrl.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 03:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=foW7usJ3woghuCkc/3vNgB/OwFOj3a3CXY41KP8I0wQ=;
        b=GAZYOToKN7/enk6IbQS1w/gtyVzR6Ub9aweUUxcmWzTmIXEf3B1NTF3pSRPH/iB68g
         oMc2WL14xqOxBkw2b3JLnShQ3NHH0xC4wdIIp+YPmXq8wgkUQYfDbYSCPckzsGXwANLO
         Yt3pTZCIEZUwTc64SRCZcUxttONjgBHr8SJ0Sfh4B9haE4Kc+1bf0A47jtMpdWlO4F5T
         Q3t9NJueqMgTB3sTxaawEvop6GXZpkSxFRr5CiQGwwqSG7iPAXZyXWCJWFpXZfclNnW9
         k/Hx3VMA5a/tcnahuxMjYtu86fSJ3BvJ0D5PwROnwwCQ4uzOyt17np/z2M7sbRrjZ37N
         7H6Q==
X-Gm-Message-State: AOAM532fhCtYGXcZNjUUfxvWHlm6IgcjAJ2H3LdjP3xnhDa08wPjBRJA
        s7jwD3KLc1H1Kfel9Pw78sP1zn37lPbUTo6tlh7kwLPGJsUqxMs3B6tb0PQraG46c8zi7znemHT
        A/1TMtChsCUkke3Q7nzkqo2d5sI4d5AQ7MrsJ8Va2sI/ikpXUglxBWGB+V2WzdOzvfhZIcWqO3o
        w=
X-Received: by 2002:a1c:f314:: with SMTP id q20mr18904202wmq.154.1630058443537;
        Fri, 27 Aug 2021 03:00:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFlYp1BMQ77FCjlALBardwbtrf8PR3eyfLYaynSRZe3DMWKOKmTwk3yQe4c5MOPI7tPuHpLw==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr18904160wmq.154.1630058443199;
        Fri, 27 Aug 2021 03:00:43 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z17sm1121267wrh.66.2021.08.27.03.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 03:00:42 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [RFC PATCH 1/4] fbdev: Rename fb_*_device() functions names to match what they do
Date:   Fri, 27 Aug 2021 12:00:24 +0200
Message-Id: <20210827100027.1577561-2-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827100027.1577561-1-javierm@redhat.com>
References: <20210827100027.1577561-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fb_init_device() and fb_cleanup_device() functions only register and
unregister sysfs attributes as their initialization and cleanup logic.
Let's rename these functions to better match what they actually do.

There's only a call to dev_set_drvdata() that's not related to the sysfs
registration, so move it to the do_register_framebuffer() function which
is where the device is created.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fbmem.c   | 8 +++++---
 drivers/video/fbdev/core/fbsysfs.c | 6 ++----
 include/linux/fb.h                 | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 71fb710f1ce..d886582c0a4 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1602,8 +1602,10 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 		/* Not fatal */
 		printk(KERN_WARNING "Unable to create device for framebuffer %d; errno = %ld\n", i, PTR_ERR(fb_info->dev));
 		fb_info->dev = NULL;
-	} else
-		fb_init_device(fb_info);
+	} else {
+		dev_set_drvdata(fb_info->dev, fb_info);
+		fb_register_sysfs(fb_info);
+	}
 
 	if (fb_info->pixmap.addr == NULL) {
 		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
@@ -1701,7 +1703,7 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
 	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[fb_info->node] = NULL;
 	num_registered_fb--;
-	fb_cleanup_device(fb_info);
+	fb_unregister_sysfs(fb_info);
 #ifdef CONFIG_GUMSTIX_AM200EPD
 	{
 		struct fb_event event;
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 65dae05fff8..a040d6bd6c3 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -507,12 +507,10 @@ static struct device_attribute device_attrs[] = {
 #endif
 };
 
-int fb_init_device(struct fb_info *fb_info)
+int fb_register_sysfs(struct fb_info *fb_info)
 {
 	int i, error = 0;
 
-	dev_set_drvdata(fb_info->dev, fb_info);
-
 	fb_info->class_flag |= FB_SYSFS_FLAG_ATTR;
 
 	for (i = 0; i < ARRAY_SIZE(device_attrs); i++) {
@@ -531,7 +529,7 @@ int fb_init_device(struct fb_info *fb_info)
 	return 0;
 }
 
-void fb_cleanup_device(struct fb_info *fb_info)
+void fb_unregister_sysfs(struct fb_info *fb_info)
 {
 	unsigned int i;
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 5950f8f5dc7..96111248a25 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -689,8 +689,8 @@ static inline bool fb_be_math(struct fb_info *info)
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
-extern int fb_init_device(struct fb_info *fb_info);
-extern void fb_cleanup_device(struct fb_info *head);
+extern int fb_register_sysfs(struct fb_info *fb_info);
+extern void fb_unregister_sysfs(struct fb_info *head);
 extern void fb_bl_default_curve(struct fb_info *fb_info, u8 off, u8 min, u8 max);
 
 /* drivers/video/fbmon.c */
-- 
2.31.1

