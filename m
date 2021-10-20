Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EF243472E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhJTIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJTIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:46:36 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BE2C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 01:44:22 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id j190so15142666pgd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 01:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ldBwu3bHZGlvOZN+/H28E5tSq74U63ERarNGJKJY7E=;
        b=Htg09zdPIQ3sGdFiVh/XEUMhJbHFofFtOYBKyhipsStuWCa4VClo30OGrzlC0nzniz
         K9xoexX1ebXwXELyMZSnpv3u6FEIxzbYL78MPXYB+OwLaBr372a82CECxCgwD0C3sQ7T
         FieRfUU2snqeI/UTs8croSWKkrh1OYpOFXxu/A9ZZTXP3I2EBb6ZcUKK4vFfhhNC5P11
         eY9yuCea5D0pz4JCaiD6B65G2AwDGq6Wg85Tk6O7Sy9/7ZzgAMtBiMzln9Vc5kr5E/eG
         a06I8fsr2tG+B+ew8i4a0vsgAyITSx082UhLnnV2YA8jgpNNC1gyHHvwz78yb9PQfdXD
         wOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ldBwu3bHZGlvOZN+/H28E5tSq74U63ERarNGJKJY7E=;
        b=dyT3lJM3kB0/IKVHuUX5q6zFVHdDVKeh9d8J2rC+m4oFc41Njdpnp2AdALaclulxQa
         90T/ytMzz8zauvt+YVTURONn8+vfZXw4aH7d+xfCgQhfXsoyUI2BkCraHmnOVaYUUukF
         VMSe4/uw0lcxWT8gLnnMn1CgA4tXUjJ+UIL1B3k4y44447YGuEtQMxU9i0WprD0TOib2
         26TUa02VO7Sm4+bUErC/Tq7fRCP43Zdd0PlFVHmFDriK8lWx03MUi3Lwf3Nl6l4PzdUO
         5/uXVI0wnohqPpNhVi4KSN/nEEps6MxVmu2q35k9FXnNv+H7X2yF9sn/RsmmPj2Vx+wL
         JwBw==
X-Gm-Message-State: AOAM5338Dus/KDgcGjbSha72jMJvNslUOrGy9jsl1zF96/5sIdQDdPOc
        oceKGRya0sopCoMBFYNRQaQ=
X-Google-Smtp-Source: ABdhPJyPzNor8QOprCSY6YIJc61rgoKYUjPy00aGT8mi/nIORq8vjSkFKHZkm+vFwoc6twOywVdToQ==
X-Received: by 2002:a63:1266:: with SMTP id 38mr32452957pgs.219.1634719461880;
        Wed, 20 Oct 2021 01:44:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x27sm1610632pfr.181.2021.10.20.01.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 01:44:21 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     mingo@redhat.com
Cc:     will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] locking/rwbase: fix boolreturn.cocci warning
Date:   Wed, 20 Oct 2021 08:44:07 +0000
Message-Id: <20211020084407.1038176-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

./kernel/locking/rwbase_rt.c: 226: 9-10: WARNING: return of 0/1 in
function '__rwbase_write_trylock' with return type bool

Return statements in functions returning bool should use true/false
instead of 1/0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 kernel/locking/rwbase_rt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 6fd3162e4098..e3dd458ee0c9 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -223,10 +223,10 @@ static inline bool __rwbase_write_trylock(struct rwbase_rt *rwb)
 	 */
 	if (!atomic_read_acquire(&rwb->readers)) {
 		atomic_set(&rwb->readers, WRITER_BIAS);
-		return 1;
+		return true;
 	}
 
-	return 0;
+	return false;
 }
 
 static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
-- 
2.25.1

