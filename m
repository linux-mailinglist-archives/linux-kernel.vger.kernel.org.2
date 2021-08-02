Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76CD3DE2D0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 01:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhHBXDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 19:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhHBXD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 19:03:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A253C06175F;
        Mon,  2 Aug 2021 16:03:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j2so23162451wrx.9;
        Mon, 02 Aug 2021 16:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+/F6H1SVoDXbJfVxzoeNR/we1SvGGtstduI4cQWqmxg=;
        b=BTIvf1s1WiMh1a1qIv0GtWEpsvS+jiefT2b3Iw/5TC1Wt2eoXn9F4sy+hP32n2mVkx
         1wlf1H+Muh4pzTamgex3RgjWHf6hS4egDQER1ngarXUYMipckeE+Ys03J4sUKgM8EC+F
         +oXbXHfF2TjoSVa/fsMcUedgT+A4ve96+L7PoCHQ0t7JVpBCQPmKMANqlsTHVCudfBAv
         oVLN+pN1GGpCVxTd1cmUyiF8YnOMjxTj3xlLJeXqHY+s+Ey4el7hRuqcwf3qNwYBALy4
         7nHRZ8VZ/uYtV7JnHyXzCIcQgUk4KkrajJveTpySkMRy9+ZQN5/oe6eCQ57XvL1K1xPS
         eYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+/F6H1SVoDXbJfVxzoeNR/we1SvGGtstduI4cQWqmxg=;
        b=o4pvZCYASRQ3//uDU/MEMff7uB4PwtmWJ4Z0lBi37LBfU3xMQE0QN3JlIZrjSxVciM
         KYPDwaBROZ3W46NJ6HUjLCE96vg9/AqeM8DweIEqSk5r8WCFjz3zO5BIHlgvdFhS5r89
         NOsiiZyKzqgZSnyd80sfv9Urz3oQPlFWoDF/AORsLKy1evWEQ3M0zXa1s3OTO10DzPZt
         z4pK/01yWCJ+51ZWpLIVZOBDA0BBCoKj0yud3jhpHgZNXCBP5LkxeFpPDYfJvpt/ZkEn
         0+Dvrw7C5biwouH7bDbYNkBQvZ2zD0k/KuSD2ZLJ+7DtSbwSoHyG864YYGiEoQLpwUA2
         XCmg==
X-Gm-Message-State: AOAM5309pWOdyXj/uCskY9MfsVnhnx/jbkKo8ZGGfKqM1FUYNQ91IyJ5
        x/s3OGCtydVSVKK3irv/eA0=
X-Google-Smtp-Source: ABdhPJw2B+MDC5zwh8B5yzC3dbZtEooKEKPqmx0xOugR31BxdsP10/37JZYjUN6YrvbYoDQwuOPw5g==
X-Received: by 2002:adf:de06:: with SMTP id b6mr19688480wrm.316.1627945396369;
        Mon, 02 Aug 2021 16:03:16 -0700 (PDT)
Received: from pc ([196.235.140.151])
        by smtp.gmail.com with ESMTPSA id g138sm14146060wmg.32.2021.08.02.16.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 16:03:15 -0700 (PDT)
Date:   Tue, 3 Aug 2021 00:03:13 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: storage: realtek_cr: get lock before calling
 usb_enable_autosuspend()
Message-ID: <20210802230313.GA1480457@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the documentation of usb_enable_autosuspend(), the
caller must hold udev's device lock.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/usb/storage/realtek_cr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 3789698d9d3c..6948d6fdad39 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -918,9 +918,13 @@ static int realtek_cr_autosuspend_setup(struct us_data *us)
 	timer_setup(&chip->rts51x_suspend_timer, rts51x_suspend_timer_fn, 0);
 	fw5895_init(us);
 
+	usb_lock_device(us->pusb_dev);
+
 	/* enable autosuspend function of the usb device */
 	usb_enable_autosuspend(us->pusb_dev);
 
+	usb_unlock_device(us->pusb_dev);
+
 	return 0;
 }
 #endif
-- 
2.25.1

