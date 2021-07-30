Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C653DB22C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 06:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhG3EQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 00:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhG3EQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 00:16:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320D7C061798
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 21:16:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j1so13281454pjv.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 21:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RTjOUqNyS9qJHqvoohAwX/XHxdbP/hKwu8NmsnUvkUk=;
        b=ItslYacy27SJ4b7GiYhiajuZEYDADEadcPkuVsgi5WwJUhoyfK0Fl2xViA03tu0kop
         YdJ0lTZBf+On7uMIIM+OHbuG9nZnIlLenhsE/iUM8XkK53u9wqJdWCDVg46dSeIngd1X
         RstZYnskselzkrui5eZNfmEWGgWx4WBFYPxMsXP8D4Ur1kB9Y4G7Lc277PPWCzdflaoD
         Hxhm7XmzD7MMuvNdefGKbIBEWlvC/j5kvm2e+qnktZoFc61TY5xvkU+OGjC66YyUzlC6
         VvOqZyQM0KN4tEz9HvpWC9HqPOppbLQOinWaUFMzeIAlFkgfClRV1Xnr4vTzp6r09Sap
         EOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RTjOUqNyS9qJHqvoohAwX/XHxdbP/hKwu8NmsnUvkUk=;
        b=Nap6F7gPTR7Q8FVbhjm86xSkF1TN5WexDDIwCgCefRxJJHKRmBb2Etzj7IedJ8Navp
         ADBGxCR7xRyoDpSB4uh15p4lTu+lEUiEAALFZ2o8MtNQNpWbi+1y5Er1VcRT4NLvvB/X
         jpFEca6IyJcvm836KTG4eMits3L81wWxWFMKyEd5Ka2L74jL2QVvur3ihVlzTriN036+
         wEWa9bysC9KC/ADl8biPoDX2l/T2QqRQT4BqWD2WlkYSlI69z+uLXt9SHiE19XN9b8JO
         Q1CP5PTFz4+aqRkohFONLnz5KBImgG+wZmg1yMVveKX1QkUe/wsQWgpz89rCoWrQIsMz
         Ydkg==
X-Gm-Message-State: AOAM530LCqi4g5HD22lk6NLu/79hR8f4FNw6h8b1IKRhIBDqh6qj5KDu
        bPTnNA4p8quOplU+bIHxrkM=
X-Google-Smtp-Source: ABdhPJx1Cyvaf1G7x7xeUkAAew6ARMZZiaOrBSX3yqgurse9uuMelADmfCI/veBFqg5uqoygkaJFYg==
X-Received: by 2002:a17:90b:1645:: with SMTP id il5mr878098pjb.113.1627618574806;
        Thu, 29 Jul 2021 21:16:14 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id t19sm439322pfg.216.2021.07.29.21.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 21:16:14 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 2/2] drm: add lockdep assert to drm_is_current_master_locked
Date:   Fri, 30 Jul 2021 12:15:15 +0800
Message-Id: <20210730041515.1430237-3-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730041515.1430237-1-desmondcheongzx@gmail.com>
References: <20210730041515.1430237-1-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drm_is_current_master_locked, accessing drm_file.master should be
protected by either drm_file.master_lookup_lock or
drm_device.master_mutex. This was previously awkward to assert with
lockdep.

Following patch ("locking/lockdep: Provide lockdep_assert{,_once}()
helpers"), this assertion is now convenient so we add it in.

Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 drivers/gpu/drm/drm_auth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index 9c24b8cc8e36..6f4d7ff23c80 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -63,9 +63,9 @@
 
 static bool drm_is_current_master_locked(struct drm_file *fpriv)
 {
-	/* Either drm_device.master_mutex or drm_file.master_lookup_lock
-	 * should be held here.
-	 */
+	lockdep_assert_once(lockdep_is_held(&fpriv->master_lookup_lock) ||
+			    lockdep_is_held(&fpriv->minor->dev->master_mutex));
+
 	return fpriv->is_master && drm_lease_owner(fpriv->master) == fpriv->minor->dev->master;
 }
 
-- 
2.25.1

