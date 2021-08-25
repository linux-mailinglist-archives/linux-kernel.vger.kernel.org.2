Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AD73F7C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhHYS01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 14:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhHYS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:26:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED1C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:25:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r9so897014lfn.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d34tpgIDKyjoD+L4mvGfC7Pr2FZGyCS0REfCnZnALE4=;
        b=NTCkk85hdTszQdVSWZsBa4U7PdPHVCrr2DIrlPps1N4JjOBRLqpcyq2U3OVukRhuLm
         y4TX+gXab+wpApfXgCq5RpKUJk7IaS3oj5c2glU4aIToCBwH//1INcQXOApePS6UTVEC
         WmdMlUg5LeF2wJX2qL2DhBNqZLcPOB7T613aUGCLlw8AXMeg5FvQNrchcjYglT0S8ZoS
         EOxZSvyE+jFJexinDkVZAG5oteyQBJ0DtcjZU57k5Xww7rE6jvHFNUjT9OrKDKjpQ5SD
         RIrGdQ0w4EhnNQzI7HdaVoqc6WZQV5D6Vf9D2MlTR6AN93fphs4ci8fKJjstT4b7fOsJ
         1pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d34tpgIDKyjoD+L4mvGfC7Pr2FZGyCS0REfCnZnALE4=;
        b=FEoqGuI01EPwOyMhYPd/roBsByfdwBdoFCH9trGiZGmgqv/T6Ouo4I0xzWuhVGkUKB
         pv5obnNGBuuaON+CINV36IDGjU7Q/6An9tqea39ac7ukcbipR0YfUKbcYN7CIaHgpnuU
         9n4i/II9IRkhq9YB7BF2pwfkRYhTo0yZY2rEa7Q6sPMG5ABpkbMRYoa3quhiGxWWQ9mG
         OqFdJaHczokKDFJy2JNCQOahxK5oL5yxsIcjTgKmN6RGMiuYhPzFSnr27LiWLoJ3LE5v
         GcqtauXQktzoIj8m6SpWo5/si+dPWt/a+GvUGX16z5tEnggNLfko76KonFV8FM4FXzzz
         L5Xw==
X-Gm-Message-State: AOAM533yx3CrLcMZMAbEKkkYPdXay6SDR6/tv0kPcQb6NByZWCIkojyd
        fXDHSK1Zw9t59yNC7LkduIE=
X-Google-Smtp-Source: ABdhPJzfDXlT0XpCjZC5y7PHJPLcPv3wN4+gJJ3W+UcSgUhmxDrfau0/ftDl1nstIBQVYqXpn1RWdA==
X-Received: by 2002:a05:6512:21b1:: with SMTP id c17mr34446215lft.34.1629915928045;
        Wed, 25 Aug 2021 11:25:28 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id t12sm73396lfg.151.2021.08.25.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 11:25:27 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] fs/ntfs3: Remove unnecessary condition checking from ntfs_file_read_iter
Date:   Wed, 25 Aug 2021 21:25:22 +0300
Message-Id: <20210825182522.1367594-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check will be also performed in generic_file_read_iter() so we do
not want to check this two times in a row.

This was founded with Smatch
	fs/ntfs3/file.c:803 ntfs_file_read_iter()
	warn: unused return: count = iov_iter_count()

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
I cc Dan also because I am happy that I finally managed to install
Smack and straight away I found something with it. Thank you for
this great tool.

Next step is to integrate Smack to CI system. But will probanly take
a moment.
---
 fs/ntfs3/file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index cb736701f2cc..5d41b84067ee 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -799,8 +799,6 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
-	ssize_t err;
-	size_t count = iov_iter_count(iter);
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
 	struct ntfs_inode *ni = ntfs_i(inode);
@@ -829,9 +827,7 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		return -EOPNOTSUPP;
 	}
 
-	err = count ? generic_file_read_iter(iocb, iter) : 0;
-
-	return err;
+	return generic_file_read_iter(iocb, iter);
 }
 
 /* returns array of locked pages */
-- 
2.30.2

