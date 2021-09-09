Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA84405CA1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbhIISLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbhIISLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:11:04 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA513C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:09:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r3so4358746ljc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F2YE/IpBouufnw/SY3U1h27yOblAPYlbcr4zue0STtU=;
        b=c7BByKEpi8GRVP+ar5aD5pvYdgHdL/PPzvTYDy9o7YqlFXEsd+VWfQ9juyPtUsZG1l
         X16dcK0WjK5pQzFbI+WJWjZZqHdiFSF4FKtpL5BTo7niOaqbj7Z7+hWTKoA+LDilfw1G
         44eH8g7FfpTp90qmopZPseFc+wZ7UtsVfLEeobUm1JR5FISJ+ty7UPaQcyZooU8y7OOH
         Wwn9Ff4s/9a9irVxVBgCxCAd1MeprQPEeX+j/v42olML9G2Dz6yyzSolAUf/FSkBCxTX
         Ha83b1+5d8wZEuzEkVkmiHsegkSVEYzG4lrw/OVBtIPGkaOy1zP4O9+QYHJLxc3HOfYC
         LCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F2YE/IpBouufnw/SY3U1h27yOblAPYlbcr4zue0STtU=;
        b=eciRZIaiwc2flJato3KCziV4310TlKR7gAPlPZDMLwr1nRsmtvb4/XHxfHM9J4gbb9
         7hyGnJlxsHdjAhpQlvVxc647Ul9bFjl68Mn154/HyKeRSbjgLkhMN5smi+p+5YFBzyIQ
         IVXNoqAAc87LO9ExNdJXpAWB6VyXaryFAkFuR8ad1i6EiAT7POIlTFr3DdwuVxC9lFeP
         54/AxQ7BHEN7BmO9pfNmAniXLZPZgcV/fttERP9O/YqNScfDbmNkHgwkeJy5Y+oz5+gJ
         WvihErgNcAdQEpGceVIa/2XvRsh3rPmIPA32/Hs0qizlD+badrbKpRfnbHoQBFpzUDjY
         EhrA==
X-Gm-Message-State: AOAM532zdAah9SyOiToE+lv6Yki/tUql/GpTIKyQZNh6Vfe1X+EL5L5C
        +tFDBxk7YSEOM3qYQ1tTeQg=
X-Google-Smtp-Source: ABdhPJx5dZEUFZVbNE8p4jn8CGjWeBL33pyiyl6VF6utW4RJdPC8Ru11Nppi4ci8dos8Cq5H2QRKYw==
X-Received: by 2002:a2e:984e:: with SMTP id e14mr972467ljj.134.1631210993354;
        Thu, 09 Sep 2021 11:09:53 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id u2sm270276lff.238.2021.09.09.11.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:09:52 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 01/11] fs/ntfs3: Fix wrong error message $Logfile -> $UpCase
Date:   Thu,  9 Sep 2021 21:09:32 +0300
Message-Id: <20210909180942.8634-2-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210909180942.8634-1-kari.argillander@gmail.com>
References: <20210909180942.8634-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix wrong error message $Logfile -> $UpCase. Probably copy paste.

Fixes: 203c2b3a406a ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 3cba0b5e7ac7..c3df29bb21eb 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1203,7 +1203,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	inode = ntfs_iget5(sb, &ref, &NAME_UPCASE);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ntfs_err(sb, "Failed to load \x24LogFile.");
+		ntfs_err(sb, "Failed to load $UpCase.");
 		inode = NULL;
 		goto out;
 	}
-- 
2.25.1

