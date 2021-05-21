Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CEC38BCA6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhEUC4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhEUC4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:56:54 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AC6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:55:30 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 6so13175900pgk.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RFWaCbDB0cwTsksPKTZ0B5G+CGm/+tl9+83zopokMmo=;
        b=VsyjJrZdFmB0qAHXbC96AWUaIKx7xV3uoMFuPW8PNxY9vNoyz3+XzA2ciAkWYFyTtT
         YyhYyP+wB5WkVfopHF3RvndUeMIJHF0SAYxUuC+7TwOUbFzlWitaDCXm8r7lKUMoA5X5
         Rpwul5ByMrf8sISih/pp1SpGoXM77sQGqoN5Jj5nWad/8GOVBwqbXXilgTXjFxKTbKwR
         1HJUCsskbGyWhQ/LvnAkASBQJqsfbbdtZT83qX7KoWClZLRRB3Fc/SycjSweo+H6R6ns
         gbwzzHzSmerSK2e3xze+CETwImVL01oC/GkbKiPcSGVx+UqR1rjk46Cxc5Jp9xGZi8Go
         j7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RFWaCbDB0cwTsksPKTZ0B5G+CGm/+tl9+83zopokMmo=;
        b=efRGnmujptGDdmMOEgdJcxsGOA8Q+8r2eaYh8/S1vWWc61OFy5aY+jHDVg4dmgB1Ca
         LxVAKvyp5PcUzAH/+2iKpdcl5LlAYdT5UQXOP6iLI25AE3/zT42PX7BlZGeiCdON9Iri
         /SbYnCHOPyHOt48mGFuybtrycZVCYntF4v5eCgxtZe3FAviUEzurEGu+DdWISy7PzhMQ
         uWXEqDToxTpkHHUBRiv+qQX7hrjSboTbVjMAqRJH9T6tflmMRdBLA60uOHEuwAbqQcra
         DQR7nrFwaSIoPeIvCP1/GPZjzQL86Kgp8wHVeSYM542h1XTv0d78g6FnL3n2b6f+4b7A
         UpkA==
X-Gm-Message-State: AOAM533dTP/Phw1ZMVub40Cd3UhpetwkMJLlo0kPK0MWrI6kijCH1gx/
        rXUUeQ8KzTaju/hntC9ooak=
X-Google-Smtp-Source: ABdhPJwLxNdhSmGF62SLi6SArs51mkbjm1+z/PG0EP4yklU0VV9QMDLvUVRZ9YtL06c0bvmeAez4Gw==
X-Received: by 2002:a63:130f:: with SMTP id i15mr7435348pgl.151.1621565730427;
        Thu, 20 May 2021 19:55:30 -0700 (PDT)
Received: from raspberrypi ([125.141.84.155])
        by smtp.gmail.com with ESMTPSA id y64sm2964566pfy.204.2021.05.20.19.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 19:55:30 -0700 (PDT)
Date:   Fri, 21 May 2021 03:55:25 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org, neilb@suse.de
Cc:     linux-kernel@vger.kernel.org, austin.kim@lge.com,
        austindh.kim@gmail.com
Subject: [PATCH] kernfs: move return value check after kmalloc()
Message-ID: <20210521025525.GA1379@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 414985ae23c0 ("sysfs, kernfs: move file core code to fs/kernfs/file.c"),
'return -ENOMEM' is executed when kmalloc() returns NULL.

Since 'commit 4ef67a8c95f3 ("sysfs/kernfs: make read requests on pre-alloc
files use the buffer.")', 'return -ENOMEM' statement is not properly located.

Fix it by moving 'return -ENOMEM' after return from kmalloc().

Fixes: 4ef67a8c95f3 ("sysfs/kernfs: make read requests on pre-alloc files use the buffer.")
Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 fs/kernfs/file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index c75719312147..c5e2429af836 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -191,10 +191,11 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	buf = of->prealloc_buf;
 	if (buf)
 		mutex_lock(&of->prealloc_mutex);
-	else
+	else {
 		buf = kmalloc(len, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+		if (!buf)
+			return -ENOMEM;
+	}
 
 	/*
 	 * @of->mutex nests outside active ref and is used both to ensure that
-- 
2.20.1

