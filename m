Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E62405CA3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243678AbhIISLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243456AbhIISLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:11:08 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A154CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:09:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r3so4358929ljc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XyzdfVcXNWHz2AnLeeSYWunihPeiHYmqdtq+pDc6YuI=;
        b=S9rT8RXz5SICnplyyuiERWwzAiKoLRp5EKF50aEp3PGd47T0Rh7EtvsixVSJLQJ1qW
         lVqfKMCGh0L+IUTYg8VJujFywfRvzcVxfFaLd4q9J+aQGs6V+MLoI1npO/IZ9g3F0slc
         wvvnTSWXGRmbdSbl9khYlirdxZfLetqeIAqtTlDncRwR3HP1zcUE7+y/lFUo3ltL/M8i
         iK/tYM2Snq2TxqTFxU050YNu4mCzMHRkFtQqHiBrKBQ8w2VEjeMF8AD8YA/jMapA/fAL
         VCPspyRQ6IHFXhMmUiv7R57PQEye759px6PNOEfUjuZlGLdqSC2kRoVvUu1hwgaF4/EK
         KZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XyzdfVcXNWHz2AnLeeSYWunihPeiHYmqdtq+pDc6YuI=;
        b=K9fibrx0Vf38nWbC0yLBoUp8R/HgG7tQDo9bHGE7NtAL85bX6CCMwMD8qpghlEIxtZ
         K7+4iXmGhr7wiIojDg4HWIYOMDBggsyuVew7dYebWL/+i9VQXxt0kXdS1Am+70HfAsj+
         z59fZe2/5KIP/7PjqNx240crlqkdgmMhvf8PTQ3ABgLIMOhu8iIrYo+EgehZ76ldUuw1
         nhi1cprF3dTvc/hG7rriuoIMOZW0o+I2xKuaR7vC/sOhptliPXoYtG/U0eo7kROP+1X9
         +b39s5naSUIaX7tVFHGhVahRCPwHq555yv8sI3Zx/EoaNcY2/G2Zk5izsXU9YV5O7XZG
         CLlA==
X-Gm-Message-State: AOAM531/X/PyJ6nPm8XQl4maby2joVwBxy0y6xxNVdyoER0oo0PX89s5
        wlmCtKMQHWB/4HRTjcqcNunTTiXJ2q4=
X-Google-Smtp-Source: ABdhPJxBFXqNs2CoToW5Lu0/Za50cEVEJ90WoMnufalEHRX/LcOD4fKBkfZh6EqzQnZYSWaEgvSFYQ==
X-Received: by 2002:a05:651c:11c7:: with SMTP id z7mr938354ljo.288.1631210996000;
        Thu, 09 Sep 2021 11:09:56 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id u2sm270276lff.238.2021.09.09.11.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:09:55 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 03/11] fs/ntfs3: Remove impossible fault condition in fill_super
Date:   Thu,  9 Sep 2021 21:09:34 +0300
Message-Id: <20210909180942.8634-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210909180942.8634-1-kari.argillander@gmail.com>
References: <20210909180942.8634-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove root drop when we fault out. This can never happened because
when we allocate root we eather fault when no root or success.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 6ddc0051fe73..793c064833c2 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1297,12 +1297,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 out:
 	iput(inode);
-
-	if (sb->s_root) {
-		d_drop(sb->s_root);
-		sb->s_root = NULL;
-	}
-
 	return err;
 }
 
-- 
2.25.1

