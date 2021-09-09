Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5955D405CA2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbhIISLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243393AbhIISLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:11:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7350BC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 11:09:56 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t19so5350664lfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Vx5VXlsDYM0By8qtcMLzzMkqkjvP8sT0BAMFB6qnBA=;
        b=VWN+KI3gXPykfmiXluHPCsUNjGkdviEwS6QafNig9FwHtEL/vpMD30GCVs7Dt4me1Y
         quTkSJqfz8deriMR6OYWruV6INa0p0UOwV2l1fxKx4TU1EgQGEN3qT7fbrAQkTMafdCc
         KfXDfN7Fep3zcjXmTIDcsqoWPzgDtXTxI2f0p7tc1mYcoUerI8s0TD3YGVfPNLh/HbOK
         e9AB+OO9l5/s0ARwWEG4B+FuWG6yarJLpM5vSTPEFwk/92dLSwGWZJAc1AgY0ufxeY4s
         GPtntDbRt4cPx7ox2bmb4kiB2K1r2j0MV9N2SneIs1YcVR52VItFM8axNi6nurL0F+Tg
         cvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Vx5VXlsDYM0By8qtcMLzzMkqkjvP8sT0BAMFB6qnBA=;
        b=2wN7NOLhr5SoCge3nd3Q/TqbdaBByxNhauGoS11km7DjvfM7b+jEjCJ74eogSyiyA6
         05Uw0IFaM7um0jm/hT3bpUd0Md4KgzNEzl08+n5SU9P4N56NKVvocgCaCpAqYz2sMjyz
         I030iXVrvdCMyPyH0UeJycH5+RUTA67eH+7AF7tzNGeaoxqdAJ6yj9N4Q0tZFCFQ3RPf
         /l/l1OD6ndfnJ2vfMAHtCqtnr62vcw0nyzv5KboZwpF/WyzfURsZzgCNMXQXqaePOLYq
         LebPGYvJq5Hi6oLu0rYV8NrHuqHpF+jP5pCIjQbSN/oSwuqLt3T0x6VR0OUHpqvbQRNE
         YhMA==
X-Gm-Message-State: AOAM533Qi3656uyXtkOiQ38jQKXX8KvvTa+G7MsNid5BnwkKG+Zx8tpA
        CjLNtumzFh5UbmgI4XWzWpc=
X-Google-Smtp-Source: ABdhPJwDszHiRj++9s+ncjc3eIQhblfVQl2ia20V7Ut3Y7cGzqPsuRjEfiaSl3V1MKYDEXkzQiR7AA==
X-Received: by 2002:a05:6512:3311:: with SMTP id k17mr856519lfe.520.1631210994802;
        Thu, 09 Sep 2021 11:09:54 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id u2sm270276lff.238.2021.09.09.11.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:09:54 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 02/11] fs/ntfs3: Change EINVAL to ENOMEM when d_make_root fails
Date:   Thu,  9 Sep 2021 21:09:33 +0300
Message-Id: <20210909180942.8634-3-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210909180942.8634-1-kari.argillander@gmail.com>
References: <20210909180942.8634-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change EINVAL to ENOMEM when d_make_root fails because that is right
errno.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index c3df29bb21eb..6ddc0051fe73 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1286,7 +1286,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_root = d_make_root(inode);
 
 	if (!sb->s_root) {
-		err = -EINVAL;
+		err = -ENOMEM;
 		goto out;
 	}
 
-- 
2.25.1

