Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0EB32FFC1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 09:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhCGIxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 03:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhCGIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 03:52:30 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F79C06174A;
        Sun,  7 Mar 2021 00:52:30 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id l7so5237772pfd.3;
        Sun, 07 Mar 2021 00:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xYRfDyZoEfXhEjhI6xDP/cz7T5RB9Ng0myyQQDRDBto=;
        b=luGxvim7HU3mrB0ywo9ZVV5HO+UXuujus9gH+kFM6Exw/oRbZx/Zk7VrDSHoZv9Cwr
         igr9Iyd3oEMDXAb+I6KiHsRx2ZkVVeK7sJY4+E1VoHg9GeFzX9O5Gj/mHu/js/fW0b97
         AShiWlkeoTeM4FepE/QeCBvaSu4P+T6nBQR1Zz4Up6q2ZOEzxKNh+VlW72NFz0NWEDf0
         qpbyDyc9sl40fk9V692uXJHRO9cMQ1rzn9YIOIrOTXfCgcKdR5P3PvDfwP42prSwXk7M
         MmI220ulX3Jv5oG8jWQPg9t4oXOv2qXaANkf2blKyhxVVPvKjXnzh4ZQxc5R2sOk0zJ8
         PTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xYRfDyZoEfXhEjhI6xDP/cz7T5RB9Ng0myyQQDRDBto=;
        b=SWDPksjL+o9eDQG/nSdRv4Is1vMQkDJ/bV0YIdTjfJqpN/bajX6TD1Zbyrj2d0Knts
         DLEd7t+Vk/6YvnaYJkY/0EdD5R4bWJa+eulhgPXKHZgOq6cw19HQ3M/ptmvfb0Clkd3a
         jbv0YW8kFStKqsYABj+iDD/Ai7PLilpzdnHvjHj5muiYobIDanQ5b/2Arl3T+HmZQuhU
         EqFzRsdh78cLxeP/QIg6lGgKpWt1bSFUtgQXDEsZMGO5Xi2jxFz8SV+bhamX44BJvu2L
         AZ5tIf3UJ5/bdHrFvXN4RX5q8whvauRLYgBzc4UWcbGSMoP9ONJIjTd9imiRHbpzOhcP
         lYLw==
X-Gm-Message-State: AOAM533nLHKuwM2DxxsTTyfhVyuU8jzSBlGk2tbmPn5f9UVJf+97Ufd3
        By2LIP2KkdRazJWc4K/kGJTi4cE7vM81hg14
X-Google-Smtp-Source: ABdhPJzuZWru6E4Z5gWjX4b6I1YyrxfJEpfQJND2JaTEHzEHqotg4zh8Eo++rMLlBS+RJS8TaEZtPw==
X-Received: by 2002:a63:2009:: with SMTP id g9mr15931070pgg.219.1615107150198;
        Sun, 07 Mar 2021 00:52:30 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.66])
        by smtp.gmail.com with ESMTPSA id h3sm6517268pgm.67.2021.03.07.00.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 00:52:29 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        weiyongjun1@huawei.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH resend] usb: gadget: legacy: fix error return code of msg_bind()
Date:   Sun,  7 Mar 2021 00:52:19 -0800
Message-Id: <20210307085219.22147-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When usb_otg_descriptor_alloc() returns NULL to usb_desc, no error
return code of msg_bind() is assigned.
To fix this bug, status is assigned with -ENOMEM in this case.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/gadget/legacy/mass_storage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/mass_storage.c b/drivers/usb/gadget/legacy/mass_storage.c
index 9ed22c5fb7fe..ac1741126619 100644
--- a/drivers/usb/gadget/legacy/mass_storage.c
+++ b/drivers/usb/gadget/legacy/mass_storage.c
@@ -175,8 +175,10 @@ static int msg_bind(struct usb_composite_dev *cdev)
 		struct usb_descriptor_header *usb_desc;
 
 		usb_desc = usb_otg_descriptor_alloc(cdev->gadget);
-		if (!usb_desc)
+		if (!usb_desc) {
+			status = -ENOMEM;
 			goto fail_string_ids;
+		}
 		usb_otg_descriptor_init(cdev->gadget, usb_desc);
 		otg_desc[0] = usb_desc;
 		otg_desc[1] = NULL;
-- 
2.17.1

