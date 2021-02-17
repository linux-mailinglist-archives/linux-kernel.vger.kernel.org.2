Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06A631D788
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 11:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhBQK04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 05:26:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231231AbhBQK0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 05:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613557510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WbTipJ1d5YkIMqJeCvt+KskMov1IfSHGgHIay7oT12Y=;
        b=i7nX4zgDCkQp1WHsZVslBp3usyEuMQTjWS9oNOK9vPN5Pd+pFANtowJCatg3DgNR2Fsv/X
        f/d5ZE6ohKSadetI35qNm2fzxCM+NYd59VwhouCiQcU2sXwKgBKBjKT0zq4zp3mN/obvlB
        PUAU55WUFpI1Q4IYN5WpZf8kj+ws9hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-2KukT3tjOxGzzReyASQFXA-1; Wed, 17 Feb 2021 05:25:08 -0500
X-MC-Unique: 2KukT3tjOxGzzReyASQFXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3756785B660;
        Wed, 17 Feb 2021 10:25:07 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-224.ams2.redhat.com [10.36.115.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15F087086D;
        Wed, 17 Feb 2021 10:25:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] misc: lis3lv02d: Do not log an error when kmalloc fails
Date:   Wed, 17 Feb 2021 11:25:01 +0100
Message-Id: <20210217102501.31758-3-hdegoede@redhat.com>
In-Reply-To: <20210217102501.31758-1-hdegoede@redhat.com>
References: <20210217102501.31758-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Logging an error when kmalloc fails is not necessary (and in general
should be avoided) because the malloc failure will already complain
loudly itself.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/misc/lis3lv02d/lis3lv02d.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 22dacfaad02f..70c5bb1e6f49 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -1179,10 +1179,8 @@ int lis3lv02d_init_device(struct lis3lv02d *lis3)
 	lis3->reg_cache = kzalloc(max(sizeof(lis3_wai8_regs),
 				     sizeof(lis3_wai12_regs)), GFP_KERNEL);
 
-	if (lis3->reg_cache == NULL) {
-		printk(KERN_ERR DRIVER_NAME "out of memory\n");
+	if (lis3->reg_cache == NULL)
 		return -ENOMEM;
-	}
 
 	mutex_init(&lis3->mutex);
 	atomic_set(&lis3->wake_thread, 0);
-- 
2.30.1

