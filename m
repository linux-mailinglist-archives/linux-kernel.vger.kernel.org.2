Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC3932FFBB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 09:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhCGIts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 03:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhCGItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 03:49:36 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1678CC06174A;
        Sun,  7 Mar 2021 00:49:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id jx13so1448998pjb.1;
        Sun, 07 Mar 2021 00:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=idHZ3++e9ffsG5dlWh/YD7jyhekwZNUkiwoKE6em0K4=;
        b=fUVhYqHipQ0d4kBOKMr4UsiiXnfvZkD/RFJ1aGyG51akNHWpngAGycdYdBYTK+FvvU
         pr2qE/pCrYk+gzOeB9E6+JUHmU6XIVIeB23oShY+FChsOSxW8n8VfATdUGvkueT/6N8w
         PKCjPuY6/w5P7YScAIKbnljzpQAOe8UI28qmT0yhW7MR8Cqugg4PSZXQFEHwKLMdADZe
         4rHbqYLh1gAzIgnhaoxW8KFtQ+dgesHDFAymLOaW3RCCX/uvtHLPbVahhbUcHJ9JuYk3
         isLRHJlp/ohXHnbZk/9bSyD9S+EMQFVk5H+dKqdEC0nin+81jMphDZGMfdTvQ14sIikk
         a0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=idHZ3++e9ffsG5dlWh/YD7jyhekwZNUkiwoKE6em0K4=;
        b=Vvv9a3HHtBIO6T7JNsFnClFnk4wURbiRiuYR2EkpytFM9M+Iom7eRRKsHYYeF7El1B
         f9Gra5fxq+QEdThXT0SlZfhL8GxPu+KbkCDHDg169F2SF2HJPrlwEaWukZJTRnX5j6gt
         A3KYjr/PLRy65YvVglJ/qPzCvWT4SBX8/dGl6/hp65BDQJST1Cc1XyvPBK7Lgo7+9Scs
         AMx452QebAWtyBwTBchjP1XNhNroMVKyZw3LE5W6bZMpK0PiW9nI2bnzJIMYWnPGXxTo
         ARqHPbgD+PzQTTT+avi0+Vx//KMKGpKldx/A2AWkTIJiCVBz4iaeZYvrAha4cow2KRgL
         fnjg==
X-Gm-Message-State: AOAM532i31HaznBX0e3D/I3banTxNAzJFuQT15fXkgR/NmuAz293Q1/s
        GXHdn40fSa8/ICKKmpmYGz3pXwLlJhwm56ui
X-Google-Smtp-Source: ABdhPJyeIK8rdeGI2qRyX4PsRZWOAWlA+jVdGUoN8advASVkoN3Bg9YNXOOz7AVpv3z6obw8siba5g==
X-Received: by 2002:a17:902:da8d:b029:e5:c7d9:81f2 with SMTP id j13-20020a170902da8db02900e5c7d981f2mr15789888plx.21.1615106974627;
        Sun, 07 Mar 2021 00:49:34 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.66])
        by smtp.gmail.com with ESMTPSA id mr5sm6173883pjb.53.2021.03.07.00.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 00:49:34 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        weiyongjun1@huawei.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: gadget: legacy: fix error return code of msg_bind()
Date:   Sun,  7 Mar 2021 00:49:15 -0800
Message-Id: <20210307084915.22022-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When usb_otg_descriptor_alloc() returns NULL to usb_desc, no error
return code of msg_bind() is assigned.
To fix this bug, status is assigned with -ENOMEM in this case.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn
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

