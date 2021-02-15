Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A74C31C01D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhBORIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhBOPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:53:40 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85724C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:53:00 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d2so4151969pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S5NBz3621tCfDoAHB0YD9Xyr4a9YK2FafwMqwj93OAQ=;
        b=gXr622vVwD2Fq5pslnGfzGab8yOA/vH6xE2pYWeyP9+1wuj4Nurwhb1E9zx1aZ1119
         HEqstLywmdwzE7SiOoERvmxdrqxr7x3LOIDa5RQGzitrbSqaG8e/Zjo/BAF1zbXvhrdx
         FpqYH0Zlg93tIhIMKVGHCvUciikM6AW0NgmLbFo6Sqzn3XKpmaK4mPlyOj4atInrUl9o
         PnJ+biAFbrZkEXZbm1pXfS9+b1y2lSTGmomkkr1nrXyrhI9cLQbDbv7kFyh7tMTV8jIO
         sQ6/aV4aTWO1Rm8guRhEpkpyLUACNreW6vuC4bMgl8RiUqTJX26t3O+dW6kGSZwcMecj
         uWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S5NBz3621tCfDoAHB0YD9Xyr4a9YK2FafwMqwj93OAQ=;
        b=mNEqDYE7+WjSD0VI1jJIo00WKqQCj+sFDDgcHji3F5HKE/iPfZio2yaeAE7+ur9LTA
         M/RcD4LrM31ywQgzgZ3aznb34V81YbsNoww5DwpXFa5CbZMZYdK5SKcuWeIu53XxG6Us
         5jiQnbgyKSbmgpkQVRXQucpN043bhn7qrZQdUMUT19NcaR8ZAY7Fr9p8+lQB69JwLElK
         AArSLZyeOYS3UK6d8NYjgarNx0JnUTLrxnureA6UWB7rv+Y+PcWI88dk/mAFWiWVUBLu
         A5NXpyDQuU0qJH/+0Sw2jgl88Y1Kc5lJww5o4UbWWmNzIBV/L5hXiJ4C+eyHfx9/u3GG
         nmZA==
X-Gm-Message-State: AOAM533njl7svjgOa4S70IGBTJyfbxBkDWoFJHIu35EbZMijxRme7A2U
        aRTGJ8XVc8aN5cpxxHBuCjY=
X-Google-Smtp-Source: ABdhPJwHgToC2mZ6+WAa6zGR65EXNpJXug+4KzeQ0rZCr/9brvpPitO99GthcwAoRKJX5b3s+MGE0g==
X-Received: by 2002:a17:90a:1f4c:: with SMTP id y12mr16855015pjy.52.1613404380181;
        Mon, 15 Feb 2021 07:53:00 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id i1sm19771215pfq.158.2021.02.15.07.52.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2021 07:52:59 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 0/3] mm, vsprintf: dump full information of page flags in pGp 
Date:   Mon, 15 Feb 2021 23:51:38 +0800
Message-Id: <20210215155141.47432-1-laoar.shao@gmail.com>
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
[11585.830272] test_printf: loaded.
[11585.830454] test_printf: all 388 tests passed
[11585.831401] test_printf: unloaded.

This patchset also includes some code cleanup in mm/slub.c.

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
 lib/test_printf.c                         | 60 +++++++++++++++++----
 lib/vsprintf.c                            | 66 +++++++++++++++++++++--
 mm/slub.c                                 | 13 ++---
 4 files changed, 119 insertions(+), 22 deletions(-)

-- 
2.18.2

