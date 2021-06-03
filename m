Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4A539A146
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFCMoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:44:13 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:54011 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhFCMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:44:12 -0400
Received: by mail-pj1-f43.google.com with SMTP id ei4so3556075pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9TSM61PkI+pmXrHh1YnpxrAnljtSgKXMnI58hZGJB4s=;
        b=VWUOAj5BAXy3x5isUy4NPrcszN9QEx5oCLtz5wRFEN69cB6Oc7idOCIo6DmkSyjaKY
         PKzOukwl6KB4sO59sx5udmLld6Ksk3xRaxQTMYOSPhnWVt03OpI9nGHLN7Ib/zHWdSw5
         i2hjBiRgDmQq5tkish0lR7t8rCxeSaZzItcMi4iljBpCj2OI0ainK2lpoWtL/88u1sT2
         NxBuvoZSUhrmkugEAmFP2i0xzzwnZU14sPM0Jcf3+RvfwviAhaAvM+JmNTxxS/VC56LQ
         nZid4QUrcyN+fNbx+qDySq2yFhE4sGYXehzz+cgEYU9sAmxWcL+QCD+qiHfdIuRez9Pd
         Ys+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9TSM61PkI+pmXrHh1YnpxrAnljtSgKXMnI58hZGJB4s=;
        b=LC+GaG17Ll7Bm1JMmQTw9Ntg4vZ004zdHgrLGT6ogMlLdZ1IBmXLlEV+Vh6G25zGg0
         jkYsIeOIgpmM4sw5/taRYcUrTj8VISPj5ekXFQtJ2NufisocEc9CmSNZ5IT9ef9ywdGB
         lk71CSNBPpXCsqgAD5tbRzeDAdK+wZ9Pr/0p8h9A5iAcvvyMiYlbakwcb83VDqa/g1XY
         t31wKMAcMP9SU9cmg+dzpks4AI8HgV8e4EuvzbrpZPESFsbMu5z3trRZ2VYna42hxtgV
         jdvWcOAq6X2ba3xozbhpStqjZDs5Jy+AjEGvkHS7cLeOyT6Uocnjm46CSvj7F/OC1Jjk
         RZGA==
X-Gm-Message-State: AOAM5324S7e+l2xIM6yp8WClLR7SjhcOkQk++ga9+xck/fCiM53XA0D7
        EgeCDX/iVKENozRmTHq4clZQ5+EQQ2JN2+8o
X-Google-Smtp-Source: ABdhPJzH+ZsYlYQ49JSGHw8RthugjHx2VAQr5uXaP8kjjp1F8HUy1xvjWuDUW2URDSXZJGgbEXy9NA==
X-Received: by 2002:a17:90a:71c2:: with SMTP id m2mr7756709pjs.159.1622724075137;
        Thu, 03 Jun 2021 05:41:15 -0700 (PDT)
Received: from mi-HP-ProDesk-600-G5-PCI-MT.mioffice.cn ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id bo14sm2323515pjb.40.2021.06.03.05.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 05:41:14 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, mhocko@suse.com,
        lukas.bulwahn@gmail.com, vbabka@suse.cz, gpiccoli@canonical.com,
        chenguanyou <chenguanyou@xiaomi.com>
Subject: [PATCH] [fuse] alloc_page nofs avoid deadlock
Date:   Thu,  3 Jun 2021 20:41:05 +0800
Message-Id: <20210603124105.29052-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ABA deadlock

PID: 17172 TASK: ffffffc0c162c000 CPU: 6 COMMAND: "Thread-21"

PID: 9652 TASK: ffffffc0c9ce0000 CPU: 4 COMMAND: "kworker/u16:8"

Signed-off-by: chenguanyou <chenguanyou@xiaomi.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c0fee830a34e..d36125ff0405 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -721,7 +721,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			if (cs->nr_segs >= cs->pipe->max_usage)
 				return -EIO;
 
-			page = alloc_page(GFP_HIGHUSER);
+			page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
 			if (!page)
 				return -ENOMEM;
 
-- 
2.17.1

