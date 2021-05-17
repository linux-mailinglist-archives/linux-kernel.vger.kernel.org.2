Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0D5382D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 15:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhEQN2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbhEQN2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:28:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33690C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 06:27:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g24so3669122pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=T299hw2nrjetWllzvpwXf6H+9SfZqQxyFY9qbEw8OLc=;
        b=hv4ocnTuuIi59K2Wus0fnCTAWIitgTfuwTZXxeM0ySr5nfPSbcT6zbh5esq/SGRAcp
         gH/jqPYgyNZQlYzzoH60815biA/GWrYneI+vIKZEzb4lnYUP2Rej7ipdVb/Ks/WtMOon
         TjW8GdHgQUCJhtZBWU/OXjJqHcz6fUaHqTWYdnQ41hQq91NeMI+zTFt6/SRIo9tqKRz9
         JIOvtSc0tGNEimGGUprDxhtgowPiQsVMr6bdxDxr2AM6IIQZw8m68b1JhddpDdYK/t08
         8fiixau7juQxF6FOSfboTkahD1h2oPNaijU3N1NEN5cnMM3uJv3TGxGZaalvF3spKUeL
         SHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=T299hw2nrjetWllzvpwXf6H+9SfZqQxyFY9qbEw8OLc=;
        b=CWepDcAtCyH9YvAfL8TFuwjNy1964HKF0vvsf11ag8tojrmiC1KyenfXicE4TWaeJD
         LcCpr7azHpsT/bYmyA+uWRz+8C4ZdO0hsYnWu5wLvZ6Xqxlr7tS+q9gZFjazgtzfcMov
         TKgELTjT3vgrYBvGsimfPfoKFz9a1O/NOmnStQA/jj5VStpcDsN5KmwN9z2uIW7FXQZj
         7KhWyy72/74EhUY4e9WTEtbL0n5NQbfB0BcEJpYSb+aBs1iT+MnaV9dbFLqQQ54rbv29
         edeBe/JtcndprIJJkGSmoQyoivgNlZpyVTVyoHt27JHVsZf0dHcdGMhe9hXtz1p+5hd0
         ry8Q==
X-Gm-Message-State: AOAM533p2y80tLyCbYdxgFxear52teUtX+AxYgrDN4wulp3e3mnE4qW4
        JE/RbgYIiO+DYWfvunI5+ws=
X-Google-Smtp-Source: ABdhPJxg0Xe36+0X0/7cmHUnlus3XHOtNV8SkeU9fGLe57mMyTnYFjMTQlAO84whktZVHOo9LDU45g==
X-Received: by 2002:a17:90b:1e43:: with SMTP id pi3mr68345190pjb.51.1621258051832;
        Mon, 17 May 2021 06:27:31 -0700 (PDT)
Received: from hyeyoo ([121.135.181.35])
        by smtp.gmail.com with ESMTPSA id h19sm10504525pgm.40.2021.05.17.06.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:27:31 -0700 (PDT)
Date:   Mon, 17 May 2021 22:27:25 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] sound: line6: Fix race condition in line6_probe
Message-ID: <20210517132725.GA50495@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported general protection fault in midibuf_is_full.
the cause is linemidi pointer in struct usb_line6 isn't properly
initialized.

the pointer isn't initialized because there is race condition
in line6_probe. it calls line6_init_cap_control first, which submits urb.
and then it initializes it's data using private_init function.

so it's possible line6_data_received is called before it's
data isn't initialized.

Link: https://lkml.org/lkml/2021/5/17/543
Reported-by: syzbot+0d2b3feb0a2887862e06@syzkallerlkml..appspotmail.com
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 sound/usb/line6/driver.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index a030dd65eb28..2c183a2a30f0 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -788,17 +788,17 @@ int line6_probe(struct usb_interface *interface,
 
 	line6_get_usb_properties(line6);
 
+	/* initialize device data based on device: */
+	ret = private_init(line6, id);
+	if (ret < 0)
+		goto error;
+
 	if (properties->capabilities & LINE6_CAP_CONTROL) {
 		ret = line6_init_cap_control(line6);
 		if (ret < 0)
 			goto error;
 	}
 
-	/* initialize device data based on device: */
-	ret = private_init(line6, id);
-	if (ret < 0)
-		goto error;
-
 	/* creation of additional special files should go here */
 
 	dev_info(&interface->dev, "Line 6 %s now attached\n",
-- 
2.25.1

