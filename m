Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618563673B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245534AbhDUTsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245493AbhDUTrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:47:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FC2C06138D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:47:13 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id w186so18306895wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yfid5mt4o5SnHIBGrtPwH6oVDyBU8btfMOQ75Gb0/cY=;
        b=LKfsuxEC1pQx5HGYVdIakZHU1YNE76qyidClLc1Ingi52X2R8O0ujbEUwocr50BqHq
         FEQ11v/VpDyhweTsTFm8+L8ZAb5V2OgQKNxlZ1uNAUK6keMrv9fIvIRcatZenE93XCqY
         ECmBewYF8nWmY6k1y/EFhLnV1hp/ro93FHJcq1+oZBh7MIo+wQZnAOvri1u0GJEfcGo8
         pEGYgKaOIWJ7O/r0C9r7DQenrBkIQq8X2ZQ/C9neqiZ8Oy2dMR7aDZ3ZU3JZWKIvcU7r
         +VF3Fdk+Vt8aw4gM+rwHxsNw6kMhM9Fkgw186E9FHvut5+p3H5viZEkPWj0rhEWfwK2c
         t5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yfid5mt4o5SnHIBGrtPwH6oVDyBU8btfMOQ75Gb0/cY=;
        b=eA28Zfaef1Ueu/JvOrY3qepAaY/5NFjc8Cmxv5G0m3z5EnFOfXX5tVFQjG187RTU/i
         96omn/UosRu+3jt0AbY9EApCOWFNr13iLL21CKRzqw105ULCU2hvPN1wUhdJZrVNnJs0
         b07pFoJdiPiRrlN3R72U8o4U+oRa/X71Qi4kBD/F3GYSLFHGx20Sh8qgpNilMVo5CDQ6
         NTKTBvPOm7tnux70YCF8qJbe0MNPv0UMHpCpAUSr/5guQqPL8Ifk0tWAhDRoyJLdJXbX
         D7FKNqGdRoP27ZlGSeX0/qOKe1tQJZXSgkYY6+bpmtdMyXnAV8JEhDvMjbtnvPak3rEa
         Ku5w==
X-Gm-Message-State: AOAM5320hSUymVOXVwAhNLpFA8SEfbqxSr6nTHqRI/0nOK6QOMeoxvjV
        5Vcpfatty4+fhXvQkbP6/ZA=
X-Google-Smtp-Source: ABdhPJz2uLV4nWLi4eXhOCtXdleTEIXrzjTgH7mD6Oolld/dVCTPksywDFUu1wAm+e7Y+o4O5Vx7JQ==
X-Received: by 2002:a05:600c:cc:: with SMTP id u12mr11443875wmm.110.1619034432706;
        Wed, 21 Apr 2021 12:47:12 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:6d3d:2d8b:5417:831c])
        by smtp.gmail.com with ESMTPSA id c6sm13004217wmr.0.2021.04.21.12.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:47:11 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     melissa.srw@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 5/5] drm: drm_context.c: Adjust end of block comment
Date:   Wed, 21 Apr 2021 20:46:58 +0100
Message-Id: <341b1ae1475fad22035cf3ff11df73cd49063d4c.1618756333.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1618756333.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1618756333.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new line with */ on the last line of a block comment to follow the
Linux kernel coding conventions.
Problem found by checkpatch.

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/gpu/drm/drm_context.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
index c99be950bf17..54e3c513d6a5 100644
--- a/drivers/gpu/drm/drm_context.c
+++ b/drivers/gpu/drm/drm_context.c
@@ -312,7 +312,8 @@ static int drm_context_switch_complete(struct drm_device *dev,
 
 	/* If a context switch is ever initiated
 	   when the kernel holds the lock, release
-	   that lock here. */
+	   that lock here.
+	 */
 	clear_bit(0, &dev->context_flag);
 
 	return 0;
-- 
2.25.1

