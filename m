Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6AC38AFA8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbhETNIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbhETNIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:08:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C089C068DAA
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:56:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so5356707wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=if0ycK4+NNWTbWHGaYK5Da18NP5caqSXni6fMq7q9yI=;
        b=amZH54kSKRB0+hHIeIIM+BkjBYAf7u3p66FFqGGNKMpW11NL5KOEWMxs99h1hVpteZ
         AYmWghNu407l5ol37KkhmjtgbvI3yqAPSrVFJN3dG6JAuLIE0eMuu4JmKZ1mFLETSxYW
         vB3A2Cnzx52Xy/CQtUgHXxbIxi06vjHW8EfjUhbN7KAA4lhnKjWsQzN13g4hmdBe2Lhr
         vNVQ8PayG9Cr4wKyQoNahGSJpwm+ghlbVZ50Q68JwX5NDOG7jgzsm+G8jM4N+U6roEKY
         0WKcwkSS0+7Fh5qp3Ffggl+gJ0/JlcHr2wYL+NVqiuu2mtExFYfpIKKjjz9+hbVn0Fvm
         e9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=if0ycK4+NNWTbWHGaYK5Da18NP5caqSXni6fMq7q9yI=;
        b=nZ2pvRdyhS0IuXm3Ga+rZQPAOkSHzc9/KaUYX/kA3UxSn5DMZ1fPHlUGABO/PLnV8C
         0hRBnh50qdM5iaGOWMgUtxR/tfnQgWYrdQMhBxTGSNqlMP5EoqlIJXT3rqWbHwwJawAN
         joRGkup08NndN8JeEaHlJ2b8E6OL/fChfX0n8DFzZzYAFf2PVfVot+Oya37GGBQf3mNQ
         Whlcyzhy2YJjESfb9F+RrArZTAMdpHVByZKsT0fperO6bvVE7BWz23UCizosszzq53UV
         0qWnYeJ3IWTOF6xpfHkE5RCRRIeHPq4R0fexOe+RA4x7DXQMXUak/u8Jddo96TcXg6Uo
         N8bw==
X-Gm-Message-State: AOAM531xU/JR7BdxfdbU7AiYtRfhIIuZ3UHU5yw5APMDq2tUN9J20v1p
        hQ6HOn3hFC4ypc8w9EVbKSfyaA==
X-Google-Smtp-Source: ABdhPJwp+Q5nP0uN2sUE9lL1K9KxsQLF0iSwGoeUL+Yc6xFGJd1EMWCymFlzFqIhwvX/Nr4eJTPKUA==
X-Received: by 2002:a7b:cf13:: with SMTP id l19mr3915112wmg.140.1621515367215;
        Thu, 20 May 2021 05:56:07 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id q3sm3015977wrr.43.2021.05.20.05.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:56:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Remy Card <card@masi.ibp.fr>,
        "David S. Miller" <davem@caip.rutgers.edu>,
        linux-ext4@vger.kernel.org
Subject: [PATCH 1/1] fs: ext4: namei: trivial: Fix a couple of small whitespace issues
Date:   Thu, 20 May 2021 13:55:58 +0100
Message-Id: <20210520125558.3476318-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Remy Card <card@masi.ibp.fr>
Cc: "David S. Miller" <davem@caip.rutgers.edu>
Cc: linux-ext4@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ext4/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index afb9d05a99bae..7e780cf311c5a 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1899,7 +1899,7 @@ static struct ext4_dir_entry_2 *dx_pack_dirents(struct inode *dir, char *base,
  * Returns pointer to de in block into which the new entry will be inserted.
  */
 static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
-			struct buffer_head **bh,struct dx_frame *frame,
+			struct buffer_head **bh, struct dx_frame *frame,
 			struct dx_hash_info *hinfo)
 {
 	unsigned blocksize = dir->i_sb->s_blocksize;
@@ -2246,7 +2246,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	if (retval)
 		goto out_frames;
 
-	de = do_split(handle,dir, &bh2, frame, &fname->hinfo);
+	de = do_split(handle, dir, &bh2, frame, &fname->hinfo);
 	if (IS_ERR(de)) {
 		retval = PTR_ERR(de);
 		goto out_frames;
-- 
2.31.1

