Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA42938F531
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 23:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhEXVxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 17:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhEXVxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 17:53:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 14:52:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kr9so7583923pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3S7o0k9P3DkYIRvOuPjEYqXAJlpvYFhJPCmQpjE5SM=;
        b=KRe88I2r9ADRF1vsDzw6VPvnWeRq3woM6tVYcl3HdVdl60uAVVPQ8gv1jG7Ij72XP2
         U/flCteOtV7omjCHMCRavXUMEzS1kMUo44CF7u1FvQhMqb6XFnKEP3hiOwwx9vqrud7b
         FnTp6AieAIl7XD/WFuMDgBigO/rowIL2CnqK/Moq4IVG/kZozKU9rPzS3uIcF6tY5SAv
         y+0QDK6kefpNSGhgLoXiCONuo50F5vwdio3zHK2/xgWjx6PsGr9aaGprmPlJZln85TTx
         3PxO+3dL8nPz+vLtS6A23bf/HUT9Ymy6Vdc0wrOkX8twI0eU9oenPmfwrmAtew0GaXNt
         X2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3S7o0k9P3DkYIRvOuPjEYqXAJlpvYFhJPCmQpjE5SM=;
        b=U6jx9xXdRLbxsOAEHUka1rqJUXYgvsJbWjv1wYiLFEgRIS4aJtnfOiWMlDOyBG/nm/
         eRs1+wTjS/DodIRJfGdm44kDTAcJGQRl73n5ST8qhbZ0K7q2deUTPw0lWRu+K5TQGiVV
         4926AwXA8FEc4PPHMpydI8fAxmF+8lzDLGbUopOaPtvEfZT9ns/rWO8KSWdXuBlF31rI
         9+29/Yk1if+ni9WTe+3E8d/XkBkrx1Bz7EpzLwvtBAW7BfILqgrmJjvmxkpXXxD+fOBu
         GvS0N1JVBbE2kkzLo10cMjxwtoJ14js7amfQ0kYUflAnEN3XoUcxoqGx8RfyVjgqemnn
         ZQ/Q==
X-Gm-Message-State: AOAM533LH22TMB44XI22hwnCkoG0dSdCz7IA1okns1QHA5jt0KSzrqKB
        6a+0n+QeG06Go5a5Rfz9shU=
X-Google-Smtp-Source: ABdhPJwe7DTLTm93yN3rzvyd+oAUTZ7Edcv0jIk781zFrhiaX4mSuMkTHfRSLWwu0h+o4yejac7X/A==
X-Received: by 2002:a17:90a:fc8b:: with SMTP id ci11mr24219238pjb.2.1621893136411;
        Mon, 24 May 2021 14:52:16 -0700 (PDT)
Received: from nhaiderx-mobl1.gar.corp.intel.com ([2409:4063:2309:9691:60bf:7a61:5dc3:9ca1])
        by smtp.gmail.com with ESMTPSA id n28sm5447800pfq.139.2021.05.24.14.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 14:52:16 -0700 (PDT)
From:   nizamhaider786@gmail.com
To:     lkundrak@v3.sk
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nijam Haider <nizamhaider786@gmail.com>
Subject: [PATCH v3 2/2] char: pcmcia: scr24x_cs: Fix redundant fops
Date:   Tue, 25 May 2021 03:22:02 +0530
Message-Id: <20210524215202.495-2-nizamhaider786@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20210524215202.495-1-nizamhaider786@gmail.com>
References: <20210524215202.495-1-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nijam Haider <nizamhaider786@gmail.com>

Removed redundant fops assignment, which was already done in cdev_init()

Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
---
V2 -> V3: Added changelog and squishing the subject and description
V1 -> V2: Spliting the patch into two
---
 drivers/char/pcmcia/scr24x_cs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
index b48e79356611..c41e9bf3a3f1 100644
--- a/drivers/char/pcmcia/scr24x_cs.c
+++ b/drivers/char/pcmcia/scr24x_cs.c
@@ -266,7 +266,6 @@ static int scr24x_probe(struct pcmcia_device *link)
 
 	cdev_init(&dev->c_dev, &scr24x_fops);
 	dev->c_dev.owner = THIS_MODULE;
-	dev->c_dev.ops = &scr24x_fops;
 	ret = cdev_add(&dev->c_dev, MKDEV(MAJOR(scr24x_devt), dev->devno), 1);
 	if (ret < 0)
 		goto err;
-- 
2.7.4

