Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB333A3A0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 09:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhCNIhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 04:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbhCNIhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 04:37:40 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5636CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 00:37:40 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id q12so3379268plr.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 00:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=swgTZcyDxG5UXaW4eHWPXDYwsdLtPHRopFJD8lRPN3g=;
        b=ehStkWu2iBocAGjMZvirspZr25tGyAgTfO3RIo4e9bEDjvzze1klz5qeQIAyQydHMu
         VcX2j+SNwCZbtiY73rz23XfZA23Af3iFoDLKaPEbAe6PpSqBvGvGcFvNT1ZkeAOI7yZY
         vWlXnyr6v5yhxS2k24Chbp+gvZykLcqEpN/NJ6kLxrome+Juj1aTcc1P9yr7Ob/harHD
         hLrhRoIQJpQFGGlkJuaLiiTbOJN+PriIM5LBLbb/L7em4IppYrywr9ySXoaeOEwdKLNW
         Hl8AZEZqcr+75ENDMlV4yTXC2AlO9Am6poc2G2mlm+blB0aEzyNflEkC7Lx4rSivFRBN
         82eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=swgTZcyDxG5UXaW4eHWPXDYwsdLtPHRopFJD8lRPN3g=;
        b=W13WBqe/uYHlne6H/8ldn5fTEWuexoBoE7ojP/XhOBcJXPu3+YUsOXdl3Yqc0xflvM
         Ms7FqijBpq8u0ijYTL8fqvVgFb4tkNcCbTiA81r80ESL0Yi68UgVXE83yHsfJgZv0U6o
         XwWH6bfmw5owHMn6OF6iLSNN51QbpemOpC3KM62Gdhh76q8/6ofqekjGctxdwf9jjVHL
         6HlePmP9vK+u/K9olstDhBhRQgQNNEvBVAOaXX32E0qc4T/7wMcTNgzGa/WY+4djoZ+H
         W4Q0iMNchy510biJlghdjPd6PH71syUwB7u/+tqs6IkEPl8uK0ZYFMbo4gnsbHDIRhmv
         SvGw==
X-Gm-Message-State: AOAM530Vr9mjo8dHacECRsAenPjKOKfDHR2jGFHYDMwJexodFwKV/Run
        YPSxlSEs7e3sv/QxUaif/z0=
X-Google-Smtp-Source: ABdhPJyrBRbmV5tblyah3oI71emRbVXLnQT6TJFHMwmHmR0/amEE0enBbutmHTEXSNrXcVaB7BWR9g==
X-Received: by 2002:a17:90a:e00c:: with SMTP id u12mr6953165pjy.133.1615711059647;
        Sun, 14 Mar 2021 00:37:39 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id s28sm10462585pfd.155.2021.03.14.00.37.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Mar 2021 00:37:39 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@intel.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 0/3] mm, vsprintf: dump full information of page flags in pGp 
Date:   Sun, 14 Mar 2021 16:37:14 +0800
Message-Id: <20210314083717.96380-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existed pGp shows the names of page flags only, rather than the full
information including section, node, zone, last cpuipid and kasan tag.
While it is not easy to parse these information manually because there
are so many flavors. We'd better interpret them in printf.

To be compitable with the existed format of pGp, the new introduced ones
also use '|' as the separator, then the user tools parsing pGp won't
need to make change, suggested by Matthew. The new added information is
tracked onto the end of the existed one, e.g.
[ 8838.835456] Slab 0x000000002828b78a objects=33 used=3 fp=0x00000000d04efc88 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)

The documentation and test cases are also updated. The result of the
test cases as follows,
[68599.816764] test_printf: loaded.
[68599.819068] test_printf: all 388 tests passed
[68599.830367] test_printf: unloaded.

This patchset also includes some code cleanup in mm/slub.c.

v6:
- fixes the build failure and test failure reported by kernel test robot

v5:
- remove the bitmap and better name the struct, per Petr

v4:
- extend %pGp instead of introducing new format, per Matthew

v3:
- coding improvement, per Joe and Andy
- the possible impact on debugfs and the fix of it, per Joe and Matthew
- introduce new format instead of changing pGp, per Andy

v2:
- various coding improvement, per Joe, Miaohe, Vlastimil and Andy
- remove the prefix completely in patch #2, per Vlastimil
- Update the test cases, per Andy

Yafang Shao (3):
  mm, slub: use pGp to print page flags
  mm, slub: don't combine pr_err with INFO
  vsprintf: dump full information of page flags in pGp

 Documentation/core-api/printk-formats.rst |  2 +-
 lib/test_printf.c                         | 90 ++++++++++++++++++++---
 lib/vsprintf.c                            | 66 +++++++++++++++--
 mm/slub.c                                 | 13 ++--
 4 files changed, 149 insertions(+), 22 deletions(-)

-- 
2.18.2

