Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4213C30A6F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBAL53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBAL52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:57:28 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA264C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 03:56:46 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id r38so11895089pgk.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 03:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xbp12Mg2UJJoPH+sHwsE5VabTWCxUoYEw4JlttfR6VM=;
        b=paSpmXTLvwIdL59W0CknNKBf9I7StZTGlSkGPzyP34sj+mUNTCtmU69LCH2V6l8EYJ
         ut9GSRjB1nCXBnyYHND7J89IziZ5YpLwf0UEfzCMc6ui4SLFd1cxRzCXAlLpI3L3dYTV
         BpTSzaovILVkW8e9mn0TBDGlveg1ZUn8oLB+DSGOETiXebTbvAsnJgVTq5IHyxLQJ+TR
         sysplukWRXWLzt1qo4Ju4t/TLgudo5h9XEiXpDTzxVZJn2U3pPkumL3G+iDTqYwcpMNc
         DxuQ/3wq4DlbfdQyqH9+uGgmo4AqWUnCn+ZvYl937qO1M43q93SKHNhj19FQw9fFeOYX
         gWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xbp12Mg2UJJoPH+sHwsE5VabTWCxUoYEw4JlttfR6VM=;
        b=DnkbiHbn0t/neYkzuzNpcVMWlgpTMaUAuayEyRODRjAPAo0dXoWFCDz9TpJi18tRhQ
         vfHJPEBItmTtpAVXxXmSlS1WEt8f0akSqV5oTyMO6hTPS8Y+84e2CGE6gswS9KfxjPOz
         1emWNRVvyiTBC4qA4sVbHEMlXTuKCi8k7h8tNblRoPGL5sv5uAixn/unWHbm8zbwdJ9K
         OhQxKb7QkMDNj8kBsu7K4pWDfIaYvI3kIK4qglV9+IErm7NeSW5wAfT5eItHmjnKUeTN
         EJvdiKvsl/OJWT5AFPdP0sJ+xEZrtQnSLlQJ5V7nfIHFRgIeaAup15rVCzqw0i/WVcOn
         f4IA==
X-Gm-Message-State: AOAM532srLpOZwADu7zDlZxbLVDhAfS3OJBZ+gF+KJX5dEnGO0Iyt8Ul
        cnQCnqJNh0PqwmZPVdA2NlHuhpDRORUUug==
X-Google-Smtp-Source: ABdhPJw59ZzWEZzVifiW9Hq2MY1cV9kjKcnaVUATEpfGh2eFT1Wtq4jLrNiCdwKUPyj6qyypFN3kZw==
X-Received: by 2002:a63:c64a:: with SMTP id x10mr16739225pgg.14.1612180606410;
        Mon, 01 Feb 2021 03:56:46 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id dw23sm7195152pjb.3.2021.02.01.03.56.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 03:56:45 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, linmiaohe@huawei.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 0/3] mm, vsprintf: dump full information of page flags in pGp
Date:   Mon,  1 Feb 2021 19:56:07 +0800
Message-Id: <20210201115610.87808-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the pGp only shows the names of page flags, rather than
the full information including section, node, zone, last cpupid and
kasan tag. While it is not easy to parse these information manually
because there're so many flavors. Let's interpret them in pGp as well.

This patchset also includes some code cleanup in mm/slub.c.

Below is the example of the output in mm/slub.c.
- Before the patchset
[ 6155.716018] INFO: Slab 0x000000004027dd4f objects=33 used=3 fp=0x000000008cd1579c flags=0x17ffffc0010200

- After the patchset
[ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)

The documentation and test cases of pGp are also updated. 

Below is the result of the test_printf,
[ 5091.307308] test_printf: loaded.
[ 5091.308285] test_printf: all 388 tests passed
[ 5091.309105] test_printf: unloaded.

v2:
- various coding improvement, per Joe, Miaohe, Vlastimil and Andy
- remove the prefix completely in patch #2, per Vlastimil
- Update the test cases, per Andy

Yafang Shao (3):
  mm, slub: use pGp to print page flags
  mm, slub: don't combine pr_err with INFO
  vsprintf: dump full information of page flags in pGp

 Documentation/core-api/printk-formats.rst |  2 +-
 lib/test_printf.c                         | 65 ++++++++++++++++++-----
 lib/vsprintf.c                            | 58 +++++++++++++++++++-
 mm/slub.c                                 | 13 ++---
 4 files changed, 116 insertions(+), 22 deletions(-)

-- 
2.17.1

