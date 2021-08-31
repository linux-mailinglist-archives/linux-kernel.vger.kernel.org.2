Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8553FCCCF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbhHaSQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbhHaSQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:16:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3AFC061764
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:15:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j12so198854ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5++aHHD3RXCwj0e7WuOBRTNcQJE0NmGKDk2bffqn2c=;
        b=jjMBSNSbOSwx8VfofOMpIrKkGR583oJRhEY+RGlLjBJbeUlNNj99kcsiWVUh/lVyUw
         qSAfoYL+o4kGY6TYeFVhL9iEL+G/FOOgqjOztW8PNeAA6gkzFsILH3IUUuS1rpqPuq6Q
         RfPoPLQKOCk7zCTqJU4//rNv0hZk18ScZq50fklDbpM109iJ8rr75A6ILfV/F/sixjeo
         58z25CY97kViw6QUW/RADai8UqxyuOTIO+XD6jeyMmuTWnSNNwUd8S3v+gCtRubsD5zx
         /yVXvoxc+5pSJj6HpI5hn9h8MtWOyZ0T3wSJTY6uk/2WN4IeapyFYTjTt78BP7mLmRsP
         Fu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5++aHHD3RXCwj0e7WuOBRTNcQJE0NmGKDk2bffqn2c=;
        b=iJepvgrBN81Db7DbGfprBGRG44iX4lhidZDQXiKYRsRjLVuSoI7ZTL2iPXEEsI81f/
         jn1QX9MMq/xc9lwLs41Gp4eR7Mpa6cOBOe3G6CtmFZe++0N79NRZXmcpw02Cq+93HrWF
         tDxIh8wne57fmf12onbXD9KLJJANtSHJs7IMhrl36VJbiLGZq2fV+9yFgt3ji64XayZx
         LSy3qz7pXNXJUCZf6M8geWOYD7Dhjjg7qdHZpSzhCpkvKAVb+ohOWiA55b0Ch1wYZMuF
         N/2X4X0VLqXnRJQdNkS+p1YdjgNyPHREK3KpAlPJo0+EcJu+IPNSWyF1PGLIVULyTcRJ
         t6BA==
X-Gm-Message-State: AOAM533s4uf5W/AdgjkRdNlFj1117tANr2ScnhHpd3mQfHNyUF8n73Uo
        6BK4NZhhJeBq2Ijmbh/3v1k=
X-Google-Smtp-Source: ABdhPJxGCPLcnb19VROY2euC3LDGiJXTEuV6bdaZ3QPfVoeMeDSguDv2Tbgc6XiZTgytkge1Hq9Uvw==
X-Received: by 2002:a2e:a7cf:: with SMTP id x15mr26185530ljp.227.1630433718347;
        Tue, 31 Aug 2021 11:15:18 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id z11sm2270757ljn.114.2021.08.31.11.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:15:18 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] fs/ntfs3: Use consistent spacing around '+'
Date:   Tue, 31 Aug 2021 21:15:02 +0300
Message-Id: <20210831181505.1074767-3-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831181505.1074767-1-kari.argillander@gmail.com>
References: <20210831181505.1074767-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use consistent spacing around '+' for better code reading. Checkpatch
will also be happy.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 938b12d56ca6..b207d260ac06 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1451,7 +1451,7 @@ int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
 		attr->res.flags = RESIDENT_FLAG_INDEXED;
 
 		/* is_attr_indexed(attr)) == true */
-		le16_add_cpu(&ni->mi.mrec->hard_links, +1);
+		le16_add_cpu(&ni->mi.mrec->hard_links, + 1);
 		ni->mi.dirty = true;
 	}
 	attr->res.res = 0;
-- 
2.25.1

