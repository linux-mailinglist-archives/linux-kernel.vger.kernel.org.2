Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D173419A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhCSKNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhCSKNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:13:15 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A89C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:13:15 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id t18so7505244iln.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=swgTZcyDxG5UXaW4eHWPXDYwsdLtPHRopFJD8lRPN3g=;
        b=BHZgQsWpnBiS9SCjS+RnsgqjhdNZMxFkXvHJDRTzTP2VLZHicmCOzIB+GL+gXJf1QR
         dEp02FmhbrFuIyefgYxhBOeBog+kqks67UEW9csOT+AxC891/ncEKektHoYVgOMotWLy
         cwAolNe5nWLHCegNhL5av07pfwakXqvHGWaUCtrLd2l57+aJVgb0CEe33H/5xd8MejKA
         BT3OSQvhpatu2V8iDJHYcCyMcCsOvWwSfkd3yxBlG3XmCow9TJ089aH2HzoKTnPtufPC
         o+wdPOWzhwYcuQZSPhyER0SGSu1EST8zCr5oL8W2l4t1hganJh1/Qy0yZKaHPJLPwiwp
         1RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=swgTZcyDxG5UXaW4eHWPXDYwsdLtPHRopFJD8lRPN3g=;
        b=r0q7ccki2G1HmT/FxnIyNtJRFAPFk+8bip6XnYFwTDgWTxR+ZgCJnjQuVn2eMH15V7
         OwTY+bXMdABdTXBNdP35W8Xa/GmWG37C4er2QUZd2OAEIDLelV5fqSYGcy+TeMBqqAic
         UgBJMRwK0prHF3z4AHswnai+pXwedgYGCUlaqQ1hWlMvAPh2n9zjSoJAg6Vu4i7q/wgK
         0/JbzoP1fV0HtLP1I7a4d2rbyrBtMsBjcHTVZQXcp/2/H8HrNic2cLrzDCIOdhEmPv11
         iitcQN6RcWqRq6eXhb2YGR6BGtJutZ8OkvSksthOLRjco5uTUGZEHlHD1cWOdLxFZHbj
         qtNQ==
X-Gm-Message-State: AOAM533Y7l9JxjiAWjGIiM98uJiBo2Jax1JQ1RARAa+dU9TYAXgnOvYD
        Ges8Xt4mP1wvADwwnVfOj8A=
X-Google-Smtp-Source: ABdhPJz98OKxqCE3R/n5bwWuYlzTJScdl9KQUiNSCb+FTLjL0Ka8VXGgLZqW85jUI10CuMTRcwvi/w==
X-Received: by 2002:a92:4b0b:: with SMTP id m11mr2135500ilg.156.1616148794629;
        Fri, 19 Mar 2021 03:13:14 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id v19sm2372827ilj.60.2021.03.19.03.13.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 03:13:13 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@intel.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 resend 0/3] mm, vsprintf: dump full information of page flags in pGp 
Date:   Fri, 19 Mar 2021 18:12:43 +0800
Message-Id: <20210319101246.73513-1-laoar.shao@gmail.com>
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

