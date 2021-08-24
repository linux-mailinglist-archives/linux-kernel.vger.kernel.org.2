Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC013F57B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 07:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhHXFro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 01:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhHXFrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 01:47:43 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751CBC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 22:46:59 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b64so8076303qkg.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 22:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtQ5/lbpPPgFCH2RrD2R5KC5Y7nLBYADb8jHbft7f6E=;
        b=CiEkU4n1+jNFrQsipSMoTslNSZv2qRACbhyAvxgDbw2Qkj033c7J7ct38raJk5OYkj
         nQmFlpDvG6YuLPqGEowZXcKAR0lc05vcHIKZ7TOkSpsR7APNTOgVNMN2xN4rcOFXFzKW
         LYS5BXJwlIby3NRSZBJZvdNwNzcMGwfI5sQt+BkO9Er1U9E95WGeQofSVY6dG5OxLJP5
         +oB0RVPuIEdG7UHkTlQ9HHpoEL+m94sUZcjQqG7ULS3HG/ogoW3ZZqquemBRaLbiax8y
         wumdb6CAa/1lyAS2IJidFWMbrBfbB72bm+Oh1foMUZghgqjwKA9b4JBUyM7xIqNBF4pV
         pbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VtQ5/lbpPPgFCH2RrD2R5KC5Y7nLBYADb8jHbft7f6E=;
        b=Albl/i3o8H09Njns/9rfsLUvJX3MwUx8SeZ56ZiEc3k+cS8RLhF2DRMaUBd+a0qsg3
         ExIVn7/PG860+kfm7kYDxQ77EXzS3teTGmcmoz7/S480a1R+EowplJtitLLUzY5eGYCw
         wPLqzABLSC2+4Pnlgf1jqsZviC1H/4NvKWS7UmCXKUqdPshIylh17oxYUsCWtk26gIVe
         BIN/fY27eBKnslLyaPZ76eoqABysojEqnSH7NV6RWMtvxRhw7JMbnvrjt9PBITeWUlUu
         rS4fqQpEXeVeZko/h/984eM9A0E9VfYa4nkY9joowRQ6f1HYPsZYz+0Q0pYSjuUxpMjv
         9YCA==
X-Gm-Message-State: AOAM531Y9R14rGmgDZ29IY5f6Lcr/D2F1SVjYbaqJfkvoKiaTFB/8QBB
        Ehwx+1sYssLXeAWmi5wQrsg=
X-Google-Smtp-Source: ABdhPJy9nNOsoIvUAS61vZESbI/dCioMxAZInsEhgsjfT3Hhmr6i+8e4EX4xdzUjDMB8Pfb8QL/JFg==
X-Received: by 2002:a05:620a:1222:: with SMTP id v2mr25383172qkj.1.1629784018752;
        Mon, 23 Aug 2021 22:46:58 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h4sm9774021qkp.86.2021.08.23.22.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 22:46:58 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] coda:psdev: Use vmemdup_user to replace the open code
Date:   Mon, 23 Aug 2021 22:46:51 -0700
Message-Id: <20210824054651.58520-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Yangyang <jing.yangyang@zte.com.cn>

vmemdup_user is better than duplicating its implementation,
So just replace the open code.

./fs/coda/psdev.c:125:10-18:WARNING:opportunity for vmemdup_user

The issue is detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
---
 fs/coda/psdev.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 240669f..7e23cb2 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -122,14 +122,10 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 				hdr.opcode, hdr.unique);
 		        nbytes = size;
 		}
-		dcbuf = kvmalloc(nbytes, GFP_KERNEL);
-		if (!dcbuf) {
-			retval = -ENOMEM;
-			goto out;
-		}
-		if (copy_from_user(dcbuf, buf, nbytes)) {
-			kvfree(dcbuf);
-			retval = -EFAULT;
+
+		dcbuf = vmemdup_user(buf, nbytes);
+		if (IS_ERR(dcbuf)) {
+			retval = PTR_ERR(dcbuf);
 			goto out;
 		}
 
-- 
1.8.3.1


