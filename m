Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D53EF2B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhHQTj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhHQTj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:39:56 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80F0C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 12:39:22 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h17so553556ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 12:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZJxlGJHEO77T883an67egr7W9MXKSGEA9+xvPHrhu4=;
        b=uTunJJx6zTBGFQKxa37z5HQc6OIyHoZRrt04h6ooImO/2WgBSSzRzZenLeqTm/nsM9
         z/RQPwTeoWPrFxG7CnXaY21pLs61r+HH0FuSBNMgjKUFdjqiZQZhXlneW3K/Sax8xsXN
         BmJPXx+fIZZjqfYDJZ40AuzD6tTHtV7Si0yRX9S2PHIt7wVdqSHLv1kXm+6n6A1KcPtd
         GQ8+KitsOZu/JkazjNzxKsW9brtdqRZP2YNoMdK7X+KKFkQId7TLNfN9vx+AVpbTqCkq
         Nmf7qiGebWSFcfYYnSD+NAihKeplGO6OesKWBUPC/vblTB6eYPtyBd6aUOJovygG2r4j
         9W9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZJxlGJHEO77T883an67egr7W9MXKSGEA9+xvPHrhu4=;
        b=f4b42T0oeusLAqi1rAKlHIg2L+heLObeLyR2bA79bUv+egSFMwxc11Lk1wflnxxMpt
         Bdm/cNr6bfKgPULNCr+Y40xyrUa/9FSVkqT60bb3IdtcrvL2a+RQAXEI0VwzsSwZzjt7
         AweyfuBPDQ483BWxy5IYT0Jratf2Mmfsl85OQYmo2TK5XD3JbWKIXchu7v6r241oOWa9
         pPC3xue9ZaPkl87VO6ReWXdNomIdSmG0OGX5vX5UPppQF2QXKOHr0Kp25ZK7ZwudX3Gq
         dhel4xdeNxGFPYNzx8zdvTWOxgXby09TU+HNwj0RZ7JcFP4bMBfY2frflxywZdIeDULO
         V9/w==
X-Gm-Message-State: AOAM533bQsvsLeQn8Jgz712s9lZx3hko1OFCkG1RTiz1T3seAXzp6qcj
        guT1b50apEBGVhwEATghG2s=
X-Google-Smtp-Source: ABdhPJzioeRODhoJArqwaQogIAvoGPz61J7Qxg2TaOpbJ57iWPXREK5EmWkVijG/o9821UNJHKELCA==
X-Received: by 2002:a2e:a602:: with SMTP id v2mr4734864ljp.50.1629229161229;
        Tue, 17 Aug 2021 12:39:21 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id o28sm99697lfg.238.2021.08.17.12.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 12:39:20 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs/ntfs3: Fix one none utf8 char in source file
Date:   Tue, 17 Aug 2021 22:38:13 +0300
Message-Id: <20210817193815.307182-2-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817193815.307182-1-kari.argillander@gmail.com>
References: <20210817193815.307182-1-kari.argillander@gmail.com>
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
I tested this for my self and at least it apply. Hopefully will apply also
there.
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

