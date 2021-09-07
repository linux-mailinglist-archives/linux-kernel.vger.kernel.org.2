Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0822A402534
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbhIGIg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242835AbhIGIgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:36:11 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004A8C061796
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 01:34:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h16so18015630lfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 01:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CtxYUHHPIcThwVP0UB7Lx6CHuiQRrXcZpwKxsh057eE=;
        b=apfvhDIqPlNvssNiHUw0pFzamwVhtrnZ3nJs1bqYOMKQA/Jr78142NiUlS52qnSYjs
         OrT9PaBOxBlovDH+usrbkPBISIdcjfqEUFS2yYsT5ayLxF6f60O7bVrAqjowCeUR3OCL
         FoEiYE5y4EFTQIjBQiHjv3lyes7cEei6TooxkMRxTU4aBorpTvN99owc0x6eLHZVdjW9
         reNVWuhjD0hIlozDYHLXSNQWW3qNdMoYjNWgp3gP2Opib32lcVHmGN5hVlX0LRfew5G9
         QzgwUATRUMXdazN854a57ZEa2jvlrZzsCQqX3QoHrRTMzUvS1BTB5cpro29qGOuHzPY4
         ndTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CtxYUHHPIcThwVP0UB7Lx6CHuiQRrXcZpwKxsh057eE=;
        b=t7w/24Rek1F0ZhlpnMuYStqwJ7RPv9yoJF8Fxf671T2BCGGfmnxRzn1SrP8i6r0VEM
         mziNOhSFvy2HqA5L0C/n0K8cjCNvvLmLJA4Xn12oHSjbEMety5SzCjk5jHpOKPRJAn0G
         sRaFRiqQFLU1K4MS/V8gi2BixtwkQGXgc1731umqU/kV0o3ySgJfC0FbUa/4QXStth3B
         hnD7fcHfnK1PG/uSDh/95+5h8gzwOQi7M6oP7oOVjfqcDea5dVkW3Nf4vqCjlQXamlBy
         g6UKS6PikfKRnSCOwhZay8k5Sdqhoolgn5cP0CZrgbbidQbl4NFX3KDk2E3xRxbV7VEu
         Iwrw==
X-Gm-Message-State: AOAM532Php00GXsvboPI30HRjRFxqt1qzz9bov3/BFcc+rGQIMIPqXuO
        14bAxfgjv37q994mCq/7KM4=
X-Google-Smtp-Source: ABdhPJzqGUIQX2CxiYHmC8tth8p2KwumY2EB/qBr640tCazomTuKlKAsJi8Eh8AB9rvHJpZdMeYvfA==
X-Received: by 2002:ac2:4106:: with SMTP id b6mr12534866lfi.89.1631003698230;
        Tue, 07 Sep 2021 01:34:58 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id q30sm944771lfb.155.2021.09.07.01.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 01:34:57 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v2 4/4] fs/ntfs3: Remove tabs before spaces from comment
Date:   Tue,  7 Sep 2021 11:34:41 +0300
Message-Id: <20210907083441.3212-5-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907083441.3212-1-kari.argillander@gmail.com>
References: <20210907083441.3212-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove tabs before spaces from comment as recommended by kernel coding
style. Checkpatch also warn about these.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/lznt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index f1f691a67cc4..734a251deae9 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -292,7 +292,7 @@ static inline ssize_t decompress_chunk(u8 *unc, u8 *unc_end, const u8 *cmpr,
 /*
  * get_lznt_ctx
  * @level: 0 - Standard compression.
- * 	   !0 - Best compression, requires a lot of cpu.
+ *	   !0 - Best compression, requires a lot of cpu.
  */
 struct lznt *get_lznt_ctx(int level)
 {
-- 
2.25.1

