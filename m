Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA5F3EF729
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 03:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbhHRBH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 21:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbhHRBHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 21:07:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E72C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 18:07:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w20so927401lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 18:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GuxDKW/GAM+p5sLoLukWpyUcq/5PoDFOcuNKUo2nvms=;
        b=fzpDCJYElVK4OCtf3p8qUuPuFLOqX+84YQ5nFHwK2zAGgG6Xyxq4+IaHGVhhDerX4y
         kggUYcjKlA5Gi0dskcnG+1cds6PHzBEFgautI//svnSnQP1WvNcDY6WIY/PmabmVBkCP
         FEqJ+LEcUJwtZBev8efe0BtzlWtWdsIDovzDn7IJ9WQvWNRy/ilGXZP2eO//w+PwCfCQ
         M9949/xSVbqYm8LTYTLbboNjXfYZ/cfxzi7vgOawoArBbHoqQb2RRY+6NxUqwZxSybDm
         AS86XpTnoCBfTXz59eOsangzUwDdJ8EfZuFNUj8QoZY/z4n8zbLmWHL7y2T0K7JKRhq0
         nyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GuxDKW/GAM+p5sLoLukWpyUcq/5PoDFOcuNKUo2nvms=;
        b=LGEtVtNroZvkBlm1QuGA/6fd/yVzJfRIl2WSfImxV4SLblkwZ3IW9+nbgxJs/St5jv
         GSh2jOmWrkhGD4/AOXjQ9xC73GFj2F8ENNWFg9Vr9mebzuApq8KPz+cG3APVebeobXKG
         r0sTGpIzOPSRONPoqSXrKbjaxi9h82QOW79sLkqrJtYOV0xHiTrLiDa6kaOmTbxB5rTr
         SnP3+tKLTrkCaFmrCjryl7RPGSMS0lOV6tQ64UDTFiudy9O8rYsccfv6gysCxW1awaKc
         Nday+kkRYc9ynVAWctGpqCIYCIrgYF2s9Ur2t28XY+H0pHkhpEqLAnXD0Tay/h+pJjoc
         3VXg==
X-Gm-Message-State: AOAM533guie3hDuCoa8csHWM7YGX7CLndgHvnI+nCNdDc1jln7qN7cjz
        9+iwDs/CMgVEb8PhHHvHsNGg8VOm+4U4UuBJ
X-Google-Smtp-Source: ABdhPJw3Rqg1Zln5Q7IeqzZmRYjCDOncWGAbtZd2vJTnBW6CtT6adJnc8A/YSo8fz7odAAD6LgHjTQ==
X-Received: by 2002:a05:6512:3f28:: with SMTP id y40mr4616727lfa.345.1629248831288;
        Tue, 17 Aug 2021 18:07:11 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id j4sm400245ljh.120.2021.08.17.18.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:07:10 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v3 1/3] fs/ntfs3: Fix one none utf8 char in source file
Date:   Wed, 18 Aug 2021 04:06:47 +0300
Message-Id: <20210818010649.412912-2-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818010649.412912-1-kari.argillander@gmail.com>
References: <20210818010649.412912-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In one source file there is for some reason non utf8 char. But hey this
is fs development so this kind of thing might happen.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index c3121bf9c62f..e377d72477df 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1784,7 +1784,7 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 		/*
 		 * WOF - Windows Overlay Filter - used to compress files with lzx/xpress
 		 * Unlike native NTFS file compression, the Windows Overlay Filter supports
-		 * only read operations. This means that it doesn’t need to sector-align each
+		 * only read operations. This means that it doesn't need to sector-align each
 		 * compressed chunk, so the compressed data can be packed more tightly together.
 		 * If you open the file for writing, the Windows Overlay Filter just decompresses
 		 * the entire file, turning it back into a plain file.
-- 
2.25.1

