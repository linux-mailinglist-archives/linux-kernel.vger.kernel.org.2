Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0B53F6920
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhHXSiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhHXSiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:38:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C40C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:37:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m28so1180557lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hUkG3xr/dMt/8zI98k75vhyv50SLMYA7N1BDb0m4ctg=;
        b=hcp5pLtAOovIB3GujgCAwVZ1xEnCaTwVJZn/SkMdDESmxQBFocjHffQae3ojrqGcPw
         SGXVOXws20bN0r3xbs7NfpSQsFM/KM0NqAXl8M7oKPUfhdRiS5RoZs3P6JS4UKArQunn
         YPdHNSr/1xEO2pGARWBZxQpU84KDhtIavmVhJXAh9qvRl9A95lLI5im52d4sX3bOI2l8
         72NZa9aAmv4LAKdQLuy2jc1xXaxuQ9F6JoQCbqVrejO7aTMjLPaAdh3XD5FCDgpPY/Zl
         NX9DgMNKAbbbQPRF2ij700FZxaVwxLgv+qtg8s+szXtiXjBIgYllT+SsbqaNLc8KNOBV
         zE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hUkG3xr/dMt/8zI98k75vhyv50SLMYA7N1BDb0m4ctg=;
        b=GNoL6fC3+rzG4AxVZ1xCInkewLVK3vGO+kSRa/gpHCe9Yq3EVFPmXIwGeNx2bytZK/
         NQ1wkfnJejzGBc45T8rVXUFmMaau3scyH+hbAzQUa1HluOgJf3t9GGHHhlo6kDyV2sf0
         4J7UiMu6Y1qdCBvejM2ZVY8po7jidp5TtQ9x6q9qgyni6SVFPrfKWY1CeMv/lgjrcHBs
         cKYp/dZGViBI5HXmWjWKwy1QTuRPBAuaFh8q/JpsnPPjB20y4Ffxd5FteTwUj5XvZoFj
         1ZmQpkkxoc+eif+T/Bwu4MHsx5wQlvebgcjxVEuSunnBdUNW+FyYMw3XEtdqTbQfJWFS
         EszQ==
X-Gm-Message-State: AOAM5309Ory2bofnb+WT7HhXm3Re+acslxLVKQo+zV02KZM3RHKHAKPp
        n55ka61HyCh+XQyNjvx6vaA=
X-Google-Smtp-Source: ABdhPJzXhOKJZPwAVsi9vxhpDDwEKS1xbHj1fQb3JS9IV+Dn+VVF3m9PaZRkLIM3OoCcJy+dToqRIg==
X-Received: by 2002:a05:6512:2603:: with SMTP id bt3mr29708927lfb.476.1629830238207;
        Tue, 24 Aug 2021 11:37:18 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id k13sm1826378lfm.168.2021.08.24.11.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 11:37:17 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH v4 1/3] fs/ntfs3: Restyle comment block in ni_parse_reparse()
Date:   Tue, 24 Aug 2021 21:37:06 +0300
Message-Id: <20210824183708.1008538-2-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824183708.1008538-1-kari.argillander@gmail.com>
References: <20210824183708.1008538-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of this fix one none utf8 char in this comment block. Maybe
this happened because error in filesystem ;)

Also this block was hard to read because long lines so make it max 80
long. And while we doing this stuff make little better grammer.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/frecord.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index c3121bf9c62f..e94d830b2f4a 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1782,14 +1782,18 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 		break;
 	case IO_REPARSE_TAG_COMPRESS:
 		/*
-		 * WOF - Windows Overlay Filter - used to compress files with lzx/xpress
-		 * Unlike native NTFS file compression, the Windows Overlay Filter supports
-		 * only read operations. This means that it doesn’t need to sector-align each
-		 * compressed chunk, so the compressed data can be packed more tightly together.
-		 * If you open the file for writing, the Windows Overlay Filter just decompresses
+		 * WOF - Windows Overlay Filter - Used to compress files with
+		 * LZX/Xpress.
+		 *
+		 * Unlike native NTFS file compression, the Windows
+		 * Overlay Filter supports only read operations. This means
+		 * that it doesn't need to sector-align each compressed chunk,
+		 * so the compressed data can be packed more tightly together.
+		 * If you open the file for writing, the WOF just decompresses
 		 * the entire file, turning it back into a plain file.
 		 *
-		 * ntfs3 driver decompresses the entire file only on write or change size requests
+		 * Ntfs3 driver decompresses the entire file only on write or
+		 * change size requests.
 		 */
 
 		cmpr = &rp->CompressReparseBuffer;
-- 
2.25.1

