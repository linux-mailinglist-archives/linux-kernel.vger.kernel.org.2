Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371B741D154
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347618AbhI3CQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhI3CQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:16:27 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFF0C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:14:45 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id b34so3046834uad.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PpCU8izzOsX7jh4ESnlskYhNOAn/mAiGICctelPlKUY=;
        b=QngmCQiWOxuHi2o/yq99khW2xyx30dtpLsIo3MyI1O6hIH1ouq+8eJfO/JQRiHf6qp
         9foZRZVqzjfHVh2VcKLc0ooCiRbrWeo88I+Ab94SEpU5gn2calyGAfK5o6SAacg4CnM6
         sxapphHKAD1iflRfNoJOPK1BdjySpqA0YMGJP/ZiTq53QmLI8sPKRTL8mP5aRgwHqqSe
         7Qozq5PB8Pf/vufX0HDyT9nkxwTszyi3mqZQFp9bRtHW9yR3YGLFbJU/Wl4j+Jf54Kfj
         cuPt3jj4wMgaOwr24jdtbzFHPBvKbvtpkrtogy8W4xCG4uaa/HLPCdU24D5a22pP8cXJ
         uz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PpCU8izzOsX7jh4ESnlskYhNOAn/mAiGICctelPlKUY=;
        b=yPFGSxc6M2qzIVtvEGYRKBAzGdP2yVpYwKzfJbrGssAbdKjH+6hZpNlbgIQHHzkI+G
         zXk0toUD7W2VhbWSc0v+hIyVomFDzf0IUpzZBGSwZi553+ldswi9mHDTu3fvxrPQrQih
         uXK4Iqq9BJVeEHmcidiBAo1cW8HszTfsqHvQuno/cdQuMpJsUzIFtsFLwnEQ1dDeSOe/
         WuQgvQaIkWsYcSIZmp16rf27Q2mzL20ghEq1D/tNZt1eSFzW3xg9Sr3RjCZkh65k2Uzw
         YvSe07tDBNp4BjfluLqU2a24nhEOWRqx5DFmm24oEEZRLu1mgI/kUF1dPbwqW5hAvJbp
         0ffA==
X-Gm-Message-State: AOAM531qaBowc+a4WvmVNK2ofZGCurRXgtNP+v3B6HRqypEl/1qdDrue
        23cq9DzmUkY3dwOnjY4uyAEIqhAX+OYqay3YYCQ=
X-Google-Smtp-Source: ABdhPJzddT7HF6KtkIoWqk3VJ0VJAJ1VdGdgGVZ88SLG+HOS5f7g7QsJA/SpfsAj2GbTgJDJ8Oa0QRbmPJ6f1F80he8=
X-Received: by 2002:ab0:5bdb:: with SMTP id z27mr3571640uae.67.1632968085165;
 Wed, 29 Sep 2021 19:14:45 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Thu, 30 Sep 2021 10:14:15 +0800
Message-ID: <CAPm50aLBfe7N_udxCkS3-PKbTmUvSpqu0sL7U6qHXZ=OWGQnTQ@mail.gmail.com>
Subject: [PATCH] mm/huge_memory: disable thp if thp page size is too large
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <flyingpeng@tencent.com>

After seting the page size to 64k on ARM64, the supported huge page
size is 512M and 1TB. Therefore, if the thp is enabled, the size
of the thp is 512M. In this case, min_free_kbytes will be too large.

On an arm64 server with 64G memory, the page size is 64k, with thp
enabled.
cat /proc/sys/vm/min_free_kbytes
3335104

Therefore, when judging whether to enable thp by default, consider
the size of thp.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5e9ef0fc261e..03c7f571b3ae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -437,7 +437,7 @@ static int __init hugepage_init(void)
         * where the extra memory used could hurt more than TLB overhead
         * is likely to save.  The admin can still enable it through /sys.
         */
-       if (totalram_pages() < (512 << (20 - PAGE_SHIFT))) {
+       if (totalram_pages() < (512 << (HPAGE_PMD_SHIFT - PAGE_SHIFT))) {
                transparent_hugepage_flags = 0;
                return 0;
        }
--
2.27.0
