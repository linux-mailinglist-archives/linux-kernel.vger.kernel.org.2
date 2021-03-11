Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8199B337210
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhCKMHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhCKMG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:06:58 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F025C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:06:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q2-20020a17090a2e02b02900bee668844dso8969141pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wNDZFX51bsE7mLUj7OGeYIqHZHoyzFxKsl+4kSmptoc=;
        b=S04+Lyqp5any22LRph4iaTTz9xpXHKiLYYeZP2157OAUWffr/mJ/nvRWp4+CVvVXZ2
         /3RLgoyqC3Ok1BETg5scAhIqGADy8dspFMs4bsfUF9sULZgz9CH09p5eraTbVXv3hbsK
         8xhE0w2Bh2dABDuIvK7dxA2XGyIWxFswAnws7K7kBQVyz61X+gKkwggI4q/bCviGLOgx
         d99EgkTdgdh1hL+g/3eUh375dEWlv+inSAbyLqyX8wzTAo2aYDGjEV8lw0QofYXN66qF
         5amd+gBDS7YDIdqISbTKXKc0ve+wcSOScWQ0Wn08apuKDa11rpzt9pt/Bu4mun/B3pEG
         E5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wNDZFX51bsE7mLUj7OGeYIqHZHoyzFxKsl+4kSmptoc=;
        b=MBFEBAQiMrEAXKzxBf0FatKCnz0XbfFO+p0tBOTeb2C9s+sd725Eid4CTPs2m9X19d
         wqXaRZnggxfJ2oF618DrcJSrVNoZBvAQfsH9iuwxX0o8Rlowm60VbWJqmDmRQqz9RLgk
         NMPZBg3QMspFIygV/Fzoa7Mby4XeOd/K/OnW7k2EMfKCWR/aFN9wcTiLMJQ71rsQ7dgg
         h5WF/TmS/eSRecaqYtHk92cMY/OjG22UVj+hQvFF3kL4tg/Ht/oZirjLMHyKBMAimqLX
         nw5afv2ZKmy8e1QYFZBHFWtfU/U87zkgLAYux18Z4pqMZ5r02PJY+rj9x5bUWNNfNCES
         0EIA==
X-Gm-Message-State: AOAM5309vSVPOupJDhkEFlfRK8EwceBj0lXCpE6P0iG4TrtDmxmmMSTh
        H5aQqKMV2bVfByzGL9Vo+TQ=
X-Google-Smtp-Source: ABdhPJztmvPrMXgdrZqmMI8iUDlM0JsDN8/4I5AIY3+iQ16Nwz8ifZAs96LHo37/FCe6imJ0BDn+0Q==
X-Received: by 2002:a17:90a:a63:: with SMTP id o90mr8825647pjo.90.1615464417838;
        Thu, 11 Mar 2021 04:06:57 -0800 (PST)
Received: from localhost ([122.179.55.249])
        by smtp.gmail.com with ESMTPSA id co20sm2362958pjb.32.2021.03.11.04.06.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Mar 2021 04:06:57 -0800 (PST)
Date:   Thu, 11 Mar 2021 17:36:50 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     axboe@kernel.dk
Cc:     jack@suse.cz, hare@suse.de, gregkh@linuxfoundation.org,
        tj@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] init: do_mounts.c: Fix indentation errors.
Message-ID: <20210311120650.nzgv6l3addpouwep@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch and case have been aligned together, extra tab removed
Removed extra space before tab.

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 init/do_mounts.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index a78e44ee6adb..82fe66d2eb97 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -422,13 +422,13 @@ void __init mount_block_root(char *name, int flags)
 	for (p = fs_names; *p; p += strlen(p)+1) {
 		int err = do_mount_root(name, p, flags, root_mount_data);
 		switch (err) {
-			case 0:
-				goto out;
-			case -EACCES:
-			case -EINVAL:
-				continue;
+		case 0:
+			goto out;
+		case -EACCES:
+		case -EINVAL:
+			continue;
 		}
-	        /*
+		/*
 		 * Allow the user to distinguish between failed sys_open
 		 * and bad superblock on root device.
 		 * and give them a list of the available devices
@@ -459,7 +459,6 @@ void __init mount_block_root(char *name, int flags)
 out:
 	put_page(page);
 }
- 
 #ifdef CONFIG_ROOT_NFS
 
 #define NFSROOT_TIMEOUT_MIN	5
-- 
2.17.1

