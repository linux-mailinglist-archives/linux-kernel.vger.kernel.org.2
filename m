Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF6E387FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344682AbhERSg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbhERSgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:36:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B13C061573;
        Tue, 18 May 2021 11:35:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 69so5599640plc.5;
        Tue, 18 May 2021 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0pCWCxkW1MMIQdUudHsoJuhPPHXRdzzJG0c8w1tSeR8=;
        b=DHCTvpnRHFzDo6XLOCLXRpjbdKxJDtobPp/gG1DSW+bd5JGzPqzrwnQLtwaCS0OYOX
         FMokn8fNxWWVGF3B/Ys1IST+fUl7tmOXv4j6Jq571gVQdpPkfc8KCdMn3FDgHt2aEOdi
         i4YO2+CKHv2gjodBspCage4Ne3xIk3BzXRM9dzj9MgILfJgibNDqwdqB+en3y41SXE6m
         phSgAu9lnvJ9mByvcRKh5HKxenhpOW5x8xGKFwMHN7CrxE3sH/w1fJe3tiLd2jVBNy9l
         rEtokD2XBH31JspFeZnJn52WanjrAMPyPq6BJyNS8PVihR/3NnW0mD/gYiMuTbAf9jM6
         Z3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0pCWCxkW1MMIQdUudHsoJuhPPHXRdzzJG0c8w1tSeR8=;
        b=TJB8ZI3aofTMwt7vska9rYYJTAo9pq/qUyBB7bAWToF5m+GkIMJPsQ6whLWQoCnzQD
         6/tridjrB88IC4pCxsOGriN781SabTOisdIzttmbyTUlhY793C+0C8GVDl5F3yE8RoaW
         n9JaEXBRcbc8s2KiG17IRBDKJcVx+kVmFyzx9aShEoKu3uK/P9GFUq2kjjHjrezhGOkf
         RrVhLC/g3Rf7atVGeYUwXtehIM0KhE+TUKV1gsS5eN0tf4TrOQ8sfkR2MarlKHh9QWP0
         0qyJ4gOlHnOtD44G6V8i8k6uQyBJ5CsA2PZd8p4/ySZeQJREbjFaYhBTkCoq9x74YMjV
         CkvA==
X-Gm-Message-State: AOAM532EkjHTWm9m22+Mjaaifpurlanc5+3GqyH3G3/mIn4pkGQWru8v
        gsJvmu+8SeFcJL435yAOIeCbXlxbO9vIsQ==
X-Google-Smtp-Source: ABdhPJxHN3lWgTNEvcx/VMEkuYOz7LIOeUXbyu5dHUFxytplk6xsY6N/J6jQsW8nL55plSd+ZpQawQ==
X-Received: by 2002:a17:90a:1641:: with SMTP id x1mr6383343pje.114.1621362904275;
        Tue, 18 May 2021 11:35:04 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a93f:e998:b72d:dcc8:8823])
        by smtp.googlemail.com with ESMTPSA id q24sm13371626pjp.6.2021.05.18.11.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:35:03 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        grandmaster@al2klimov.de, keescook@chromium.org
Subject: [PATCH] ASoC: omap-twl4030: fix kernel-doc syntax in file header
Date:   Wed, 19 May 2021 00:04:51 +0530
Message-Id: <20210518183451.15097-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
The header for include/linux/platform_data/omap-twl4030.h follows this
syntax, but the content inside does not comply with kernel-doc.

This line was probably not meant for kernel-doc parsing, but is parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warning from kernel-doc:
warning: expecting prototype for omap(). Prototype was for _OMAP_TWL4030_H_() instead

Provide a simple fix by replacing this occurrence with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 include/linux/platform_data/omap-twl4030.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/omap-twl4030.h b/include/linux/platform_data/omap-twl4030.h
index 0dd851ea1c72..68e903807dfe 100644
--- a/include/linux/platform_data/omap-twl4030.h
+++ b/include/linux/platform_data/omap-twl4030.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * omap-twl4030.h - ASoC machine driver for TI SoC based boards with twl4030
  *		    codec, header.
  *
-- 
2.17.1

