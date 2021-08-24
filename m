Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8A73F594D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhHXHp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhHXHpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:45:55 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D132C061575
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:45:11 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id c14so11169791qvs.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78uVVTr8tEiUnO/3HZr+EL+WWj5QHkzJjhwnJw13NSU=;
        b=CRXwUrGRZ1PS0Vl63+a86Kz96buIvryF4C6/8RwdhTlFtzk4P/Fkm6CN2Q85F0yoW+
         1azwEaJELFyQVYc7pPsB5A43RyuzbUeHEQK+yIuHYff1N9gNABFByQzsHtPMutiOro30
         1TvyHPiev4ya+VJI2+WzqGiFQZmmEgham0nSIc0fHgbeUQnCFl1gTq8Skj4KuJLYMBvt
         GWITo9Hl2KrCYQJr3atfmSR+0Lon3tPiNW70sN11k2tq6X+LqViCpbICSZ7ah5YnhH8/
         l0RdqCqH/Y3w/oGAOnvuCrlVokZ/6AZD03xQyOfpBBKbQJKbgWC23qewfTaLaVpq/dfI
         282w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78uVVTr8tEiUnO/3HZr+EL+WWj5QHkzJjhwnJw13NSU=;
        b=NVg0nWx5epNUZy/Qeq6I3zIUpuiSQLd53hLo+HnCD5DSTmp8yQoMfl/k/dm6HDmEi4
         hZHJJG/F3IgUMMi7KvWkiWKHITWjHz1Z8N4JaitFZBFUmQckGG98hs2mWRx/oGy/ERJ0
         sVRQVGsmo6nbYmg12jgQFJsoyIJGT9hgUTNGSvz7rdFOGNbCvvDEiGIZfIOwucYNBJGC
         v9aCUECQjQ4X2QmO/HHW/IEnnisNFSoEVb74pDZNoafMiShtRr6V05t8XXqnEqOdcSqB
         NxsdMC0lhaUfVNjh+hqATBMXcfBqWK46337Wo/Q4CQVIlKtkip6b8/x2tXIx4HCcDrAE
         M6Ug==
X-Gm-Message-State: AOAM532L88/YfQgxYycaOxV40j/TlMaS9X76ManRpnn6eHOXAlsXQvbe
        fM/v54t34aBQnwyJCtpYzco=
X-Google-Smtp-Source: ABdhPJyJj+Yi44RMH7FAKVd85v0VpCawQmCUGuy20Z6/fgqDfB4bXK0/Uh5XjxIRL97JFoKHCSbuEA==
X-Received: by 2002:a0c:d60c:: with SMTP id c12mr19361284qvj.18.1629791110617;
        Tue, 24 Aug 2021 00:45:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 19sm9558380qkf.127.2021.08.24.00.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:45:10 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.xiaokai@zte.com.cn
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        ran.xiaokai@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fs: 9q: remove unnecessary label "out_err"
Date:   Tue, 24 Aug 2021 00:45:03 -0700
Message-Id: <20210824074503.62333-1-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: CGEL <ran.xiaokai@zte.com.cn>

due to commit 798b2ae3cd58 ("Merge remote-tracking branch
'file-locks/locks-next'"), label "out_err" should be removed to
avoid build warning.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: CGEL <ran.xiaokai@zte.com.cn>
---
 fs/9p/vfs_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 978666530d8e..d2d83163d6b0 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -319,7 +319,7 @@ static int v9fs_file_lock_dotl(struct file *filp, int cmd, struct file_lock *fl)
 		ret = v9fs_file_getlock(filp, fl);
 	else
 		ret = -EINVAL;
-out_err:
+
 	return ret;
 }
 
-- 
2.25.1

