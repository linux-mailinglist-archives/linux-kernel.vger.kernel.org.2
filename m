Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71852314DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhBILBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhBIK5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:57:16 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90FBC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 02:56:35 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id v193so13502808oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 02:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkhNliH3YgOPkCyynn/prx2ea2eFAhGQKtJVcxGFNyM=;
        b=CXVTXGhT1jpdGSdaOF6wbIPMBso7LA4dIX+i1WnR/+slTJmAcyQNwSJXPmixmMwMVY
         1X7eSuWcqhnYKhPkC5bNFpzaM/lR2ROVHs08glmlEknll7gQZo+1FduWUYOOOfGiODNG
         sF4k2TysZS27Bk6G2WzY5b9Hwd6k18wmuVxhO/bSwYQ7Y8uPe5AqcIhLvHbNhUCqo6zo
         Mv6wDlGQlMSosNWC6a0fyYdtpdphWAhMy/cl26CEuiBmaXhZ5pKtluamgCWr05NkrFLj
         nkOYbqVMN9b/ClEqUghgX37CDQ9AIYL2UDI5AS6xPafD/+32t2FmQHJt4c66Z+MdxiWS
         5gRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vkhNliH3YgOPkCyynn/prx2ea2eFAhGQKtJVcxGFNyM=;
        b=aR6OJtcak9y/HDA4GFmbLBc/eIRxRk6u5VAag8f0KscEHCGAK+lHKdTpoQrfY0Os2d
         RzvUsY+CtsF7StI+0Ee535RIk0ms6xpMHs1vxv2n4XM2a4QPiDikkiRMaqw0A+r97XYv
         guX3GI/oy+iEx7NgGwOGvzWOvd+sVWdm9ZjMq9oQvX7CXvpqtEtkt7wS2pqCxmXD84DN
         bRYyZl+QuowNj583JF0C2jwpsskTllszOrvOkQIrPfqMKJZIWEpLGWShuGCpfjtF3/ms
         QVP5Sy4o2ENuoM8gl8hjzwDyEzpDwmQa8fkq3C8RWTe0ON3DTyI+j+3d3GqlzwgWyFWK
         uMfg==
X-Gm-Message-State: AOAM533r/e2jOj097NDPJr57d7CPBmP3Tmsc6K5SCXVKkAVv9wKAHXD7
        5jvbSwXXFwQEYgBoJquD9do=
X-Google-Smtp-Source: ABdhPJw3taIy/2xTOrFM8JMh7wECFUC8D1pbcYxIM7LLaa5k9UaGnmR4I5D2PNQc5E7WNVAIR8TO7Q==
X-Received: by 2002:aca:da44:: with SMTP id r65mr2135902oig.154.1612868195347;
        Tue, 09 Feb 2021 02:56:35 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id g3sm4171377ooi.28.2021.02.09.02.56.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 02:56:34 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     willy@infradead.org, andriy.shevchenko@linux.intel.com,
        david@redhat.com, linmiaohe@huawei.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 0/3] mm, vsprintf: dump full information of page flags in pGp 
Date:   Tue,  9 Feb 2021 18:56:10 +0800
Message-Id: <20210209105613.42747-1-laoar.shao@gmail.com>
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
[  501.485081] test_printf: loaded.
[  501.485768] test_printf: all 388 tests passed
[  501.488762] test_printf: unloaded.

This patchset also includes some code cleanup in mm/slub.c.

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
 4 files changed, 121 insertions(+), 20 deletions(-)

-- 
2.17.1

