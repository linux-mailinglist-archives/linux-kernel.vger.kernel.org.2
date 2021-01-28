Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8C7306B08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhA1CVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 21:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhA1CUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:20:52 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89768C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 18:20:12 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id h6so4477503oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 18:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2sVYOiIouwZ8nIqPPf2kTH2Pf4brpoO3LuG88lxkqFk=;
        b=gwhoHQCQWcLqF42KqWs9nhPHSYr3Lu4OAgV1cMBqgX9MqPSj5686Pjnjn7neCVnDTw
         seSH/LDOwpw2XmjMArbFQhjzdHbS16kIWFoemEebyw7hTfx8MjViwrKna0E5GBiMmyhM
         YAsLtgmkH5agz1YvWFbaLZOMzH3xnCS1PIbv7HzN+Ww9cJALzHuvz+xUZXycJl8re0hA
         PWzJ5fzyHl2zKxK2BOi0g8Y01GdMD4+Ec6bSrSUoYStwQGJ/oqb1DfIusuWNjF3j+6dR
         SpSY+HjK9Jc6WnHCcbpJm/0RZ+B4g9L3uRwr7XmCtnJ1RmIX9N+Sg4lEpXujGBvqAm31
         R2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2sVYOiIouwZ8nIqPPf2kTH2Pf4brpoO3LuG88lxkqFk=;
        b=UTtO7m3L7CTOrU+PpeQlN1o1ndIWLdCTsL0WqpSTYyXH2oL6J2+Eli25is7jwqzbQQ
         MGJ7bxD2MP8B8hHzIV4BEyZZmLxU8uDOxEI/zVvRUsf/wRItGLNdqTRXpLbhKRFa4H6k
         udXUWnGp0Xi+lwqTFyWWlp3oRv++F00KGm0bOxgU8g0HQdnl9Bl/aWrgZTg6iJJdsjqr
         BsGC17e+srmRpASZ9jlDZQAnXDNxB4c95NDNOX/d7BW7L02b2tnMkD2GnzfWcXfZXt87
         e8w78UwQEeGTMN3klqSL5cZ6c98MyNfz7tZRUGWABRYMozU2elT6t1uHuf2qBbN3M6jW
         8r6A==
X-Gm-Message-State: AOAM530LxtZ/qOBLOp9QXYbhMzAoXn+A6oUlKPW5xuqwB122RBdC384v
        DnKP7r/WqmMDxpVA1sbphtYyLTn1v7WxAw==
X-Google-Smtp-Source: ABdhPJxJOpOsYWPIhDKouSi5iGTnafCAQd4pXGm9w0Z2+vZKcht1OwZjIsrD/h8pJU45bdtAet6Rcw==
X-Received: by 2002:aca:d98a:: with SMTP id q132mr5191077oig.33.1611800412039;
        Wed, 27 Jan 2021 18:20:12 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id m10sm731246otp.19.2021.01.27.18.20.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 18:20:11 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@redhat.com, vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 0/3] mm, printk: dump full information of page flags in pGp 
Date:   Thu, 28 Jan 2021 10:19:44 +0800
Message-Id: <20210128021947.22877-1-laoar.shao@gmail.com>
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
[ 6315.235783] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(Node 0x0,Zone 0x2,Lastcpupid 0x1fffff,slab|head)

Yafang Shao (3):
  mm, slub: use pGp to print page flags
  mm, slub: don't combine pr_err with INFO
  printk: dump full information of page flags in pGp

 lib/vsprintf.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 mm/slub.c      | 13 +++++++------
 2 files changed, 48 insertions(+), 7 deletions(-)

-- 
2.17.1

