Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9338AE9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbhETMml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhETMl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0175FC04FF1D
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r12so17394284wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vSYwp3QUO2YAhp1nmIDTgLX8YA5Z78Ipy39KrYbLSpw=;
        b=AVcVXUsLdTRkxi3Ow2TCUfpN9x8yEfzbiWzuXm0RhB1htxhozoNaqHiWOLYKHLgJiZ
         SxTVCC99KwjMuMAr4w6OH/54XXkX9XZDIExHnxNA0ski3rkjzXa/zcXwj5Ufn1ONOEZl
         GrrjpS99U2SmhsPbt7QAkm9UWsXq02cuwHr1JZWtAMy6MDtFyQHWgsGd96zW0rENQAHx
         /RBQWz20Rdb4ra7ZySXi4mXi+nuSzfG1HQlR+RQS7CXlN1Nun40NOMCMXdFPhg7IjOF0
         vPrC8mz8uavm5RIirEvcm73cZ5fB0IO9qOsNqC/3H8USlzJoDRW3kSobQTaoXAYwDBkw
         wjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vSYwp3QUO2YAhp1nmIDTgLX8YA5Z78Ipy39KrYbLSpw=;
        b=gBqlbHP1vFcRY1uhwELI3bRwi+7dCPik26t7XD2K5B+D5HqWx0XdLmYI+F3eAvLBGZ
         xIBrL+KEGpqV+zFlv/1Zym9GAYLTDBsOQ7x4HkRobKWHDUkBhS9Fep1JXNLNjsrepxzj
         eE7r+0yGPCnzzbR/5d68y63bzK/IoOGPbMHeNqS2uSXfqkFuZsI46AEQzlgd9UZkrJ3/
         sn6Ilt+pKtJ/tXz/O/ifONpTKvBEgLPSAn/zkpPNel+KjKDDbb9FXUvwg4QzMWPrZP5b
         /lnkJqPnmicRG0Xzx3vrjQX4VH1iIFBZRNWzPlPfbfYmNclgwYRgXmv4+c1Li003hL6A
         eMFA==
X-Gm-Message-State: AOAM531fnydACo+Csnz6HpsJn0927OCWfaC55m+jRUgxyi2FhWqkt35f
        7nWxN1ckJK6zpC4qJIzZkWyuDXKwyEW9PQ==
X-Google-Smtp-Source: ABdhPJxhm/PGu7aWMLpLOXhb7NIFn1A5wj3ebAXlbn9pX23PRDc6WgsS6XXmzmI/aQuFVVs2CmPtEA==
X-Received: by 2002:adf:fdce:: with SMTP id i14mr3789207wrs.303.1621512053613;
        Thu, 20 May 2021 05:00:53 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id s199sm8848269wme.43.2021.05.20.05.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:00:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 09/15] fs: ntfs: attrib: File headers are not good candidates for kernel-doc
Date:   Thu, 20 May 2021 13:00:37 +0100
Message-Id: <20210520120043.3462759-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120043.3462759-1-lee.jones@linaro.org>
References: <20210520120043.3462759-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ntfs/attrib.c:25: warning: Incorrect use of kernel-doc format:  * ntfs_map_runlist_nolock - map (a part of) a runlist of an ntfs inode
 fs/ntfs/attrib.c:71: warning: Function parameter or member 'ni' not described in 'ntfs_map_runlist_nolock'
 fs/ntfs/attrib.c:71: warning: Function parameter or member 'vcn' not described in 'ntfs_map_runlist_nolock'
 fs/ntfs/attrib.c:71: warning: Function parameter or member 'ctx' not described in 'ntfs_map_runlist_nolock'
 fs/ntfs/attrib.c:71: warning: expecting prototype for c(). Prototype was for ntfs_map_runlist_nolock() instead

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ntfs/attrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index d563abc3e1364..2911c04a33e01 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * attrib.c - NTFS attribute operations.  Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.
-- 
2.31.1

