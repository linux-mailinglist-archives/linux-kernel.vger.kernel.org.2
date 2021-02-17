Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67231D789
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 11:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhBQK1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 05:27:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229707AbhBQK0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 05:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613557509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=231EQhXBKGVJJmNeKMVuk7An4UCv3i4lBfCr9M2GnZg=;
        b=MeQXUV2Ezc48J7oar2nj5wLtyr0xaVOsiM/O3QNlSGIToXbt+0zOwTHYhPNYJND8ylAPHJ
        58TjiaNEwzh30OcovaxN7sr/EDMrwMOpFNPmW1EK2CglGDS2QnRp4hCzU345Eg8sv1kEUt
        4R6ZRj7txRhboh9HAb9S+AvnEg8fFX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-8GvPOYgNPD6rutriqz90Ew-1; Wed, 17 Feb 2021 05:25:07 -0500
X-MC-Unique: 8GvPOYgNPD6rutriqz90Ew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C162B85B66A;
        Wed, 17 Feb 2021 10:25:05 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-224.ams2.redhat.com [10.36.115.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 982557086D;
        Wed, 17 Feb 2021 10:25:04 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] misc: lis3lv02d: Change lis3lv02d_init_device() return value for unknown sensors to -ENODEV
Date:   Wed, 17 Feb 2021 11:25:00 +0100
Message-Id: <20210217102501.31758-2-hdegoede@redhat.com>
In-Reply-To: <20210217102501.31758-1-hdegoede@redhat.com>
References: <20210217102501.31758-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern HP laptops do not necessarily actually contain a lis3lv02d
sensor, yet they still define a HPQ6007 device in there ACPI tables.

This leads to the following messages being logged in dmesg:

[   17.376342] hp_accel: laptop model unknown, using default axes configuration
[   17.399766] lis3lv02d: unknown sensor type 0x0
[   17.399804] hp_accel: probe of HPQ6007:00 failed with error -22

The third message is unnecessary and does not provide any useful info,
change the return value for unknown sensors to -ENODEV. This is the
proper return value to indicate that the driver will not be handling the
device and it silences the pr_warn printing the third message.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199715
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note this does not resolve the bko 199715 bug, it merely silences the
message which was used in the Summary when the bug was first filed.
That bug really is about the actual accelerometer, which uses the AMD
sensor fusion hub, not working.
---
 drivers/misc/lis3lv02d/lis3lv02d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 9d14bf444481..22dacfaad02f 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -1173,7 +1173,7 @@ int lis3lv02d_init_device(struct lis3lv02d *lis3)
 		break;
 	default:
 		pr_err("unknown sensor type 0x%X\n", lis3->whoami);
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	lis3->reg_cache = kzalloc(max(sizeof(lis3_wai8_regs),
-- 
2.30.1

