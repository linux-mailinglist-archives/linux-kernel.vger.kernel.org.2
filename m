Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28A0402533
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242965AbhIGIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242750AbhIGIgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:36:03 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0007CC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 01:34:56 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id g14so15263922ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 01:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1y8fx3XyyuMLOh73EHMZ9CZAfZ05dGHF3wHDWaTIu0=;
        b=XMFPIknVlp3KFEhnevBgXqF9hxFQQ13ql7cNvAHCnggyYN5E7vsGa8M+dsrPKn0WyL
         dQAQOnIH7yTrcHk/WPxzPmp2cgFVd+z5WrBw8BfkorqefGnN69xHf2IYA6Xz71ryD093
         HaGYFtCYXGmyzlnjptLNvk05utiq2rzM2Wd7Dm7MzgvI8xNNpCVZpZ48tWeeCOfVVc+e
         OW/itM+qgLTm+Eq8S9Ni5+DE5XJfA+SntFu5YLv50Qb26H0ubzpX8qQpNmNOaQPwrrPE
         vaQrhSS4U8hiqn/X9ttdGm/uW6BeoG8oC5bk2NJJfGdhtz5QIQAk8qLwu1kRrxSrURtO
         usmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1y8fx3XyyuMLOh73EHMZ9CZAfZ05dGHF3wHDWaTIu0=;
        b=caI/iPCJEcnGdNWCQeXg5h8k5yuiT/e4sMhUSomAEmbCLj4Qt8A6H4df6N6fhmwaI1
         zie3tehrSuSL8yMtXoneTla36hZwj3VrvuhEb5Ub392IpD0wLtwXP9VwhTGIW0aTyIat
         32aZSq+e7ztqKELrSEkP3FAkeIda//ONvg7DQHzOkQhfUqfyzo/JbwgwOcZtFFdi+aOy
         xUgioE/IRwEXF1hfCs5sdfm/YuYLPIPeV2LCQLNtfO8z1SvUcT4L62S2xb/sPkH4mUKF
         0jrkN8Mc93MAruoWZD65MW3nSUHw21hmC7eyY3lmda3JozfXLq4sbwTZFaJF0SOgaisM
         akkQ==
X-Gm-Message-State: AOAM531wkHX/0zd+kqDoKaZnlPBf6ND+WWsvdAS/aZ1nJ2Rhu5NlShs6
        isseT5ndmFrcpetY7WCEZajVllUS6Is=
X-Google-Smtp-Source: ABdhPJxaUQUluOpHE8UwCQyv++XP9XWaaHIX6F7YZ/VX3VuRwL9R4zr2h0zfBfAW9zWvYT4Y4K7CmQ==
X-Received: by 2002:a2e:bd09:: with SMTP id n9mr13681082ljq.76.1631003695346;
        Tue, 07 Sep 2021 01:34:55 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id q30sm944771lfb.155.2021.09.07.01.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 01:34:55 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v2 3/4] fs/ntfs3: Remove braces from single statment block
Date:   Tue,  7 Sep 2021 11:34:40 +0300
Message-Id: <20210907083441.3212-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907083441.3212-1-kari.argillander@gmail.com>
References: <20210907083441.3212-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove braces from single statment block as they are not needed. Also
Linux kernel coding style guide recommend this and checkpatch warn about
this.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/frecord.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index d3c1c46cfb0a..549ad245269a 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2906,9 +2906,8 @@ bool ni_remove_name_undo(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
 		memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), de + 1, de_key_size);
 		mi_get_ref(&ni->mi, &de->ref);
 
-		if (indx_insert_entry(&dir_ni->dir, dir_ni, de, sbi, NULL, 1)) {
+		if (indx_insert_entry(&dir_ni->dir, dir_ni, de, sbi, NULL, 1))
 			return false;
-		}
 	}
 
 	return true;
-- 
2.25.1

