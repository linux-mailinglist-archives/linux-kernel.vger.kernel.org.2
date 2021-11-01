Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0170C441D7A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhKAPlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229658AbhKAPlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635781151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bwG/uS1SpbhgepQxyK4RlDMrb4xITIn578cEQdcwCYI=;
        b=M/E/7iLjloP3t4CiUIvKfjWILFi0/0gSTuxB8n9hKB4VBT31oEFletkE4p3YpVvKJKTtqj
        CNM3ORxGQLwh72TG3mR44S4+HNkIPuKvgeeM+WrNVczYBUFF1Vgkg+qcajxVBLyhYIjiD5
        Bu0JlY45r6nrH2qtFOv4TDRvNqteA7g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-VWsyNIxNNV2Z9-BhrHBiLQ-1; Mon, 01 Nov 2021 11:39:09 -0400
X-MC-Unique: VWsyNIxNNV2Z9-BhrHBiLQ-1
Received: by mail-ed1-f69.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso16000618edj.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bwG/uS1SpbhgepQxyK4RlDMrb4xITIn578cEQdcwCYI=;
        b=10O6k7peUECrvFuqwdVZpujQ8cGzQXwttCw+AUhBVJ5bzfuP7+K6wruX3hqz1gPhbT
         TJ7m3LTXu18Kj1pCOCzX/Kbebfb7UHbU4s0KLtVC6/9BlL1hKmg6tCfoWZ20/S22ey9H
         qZhmpGuqMJa592gTCo9UcFbYO8H3DgPSCod2WejyNOcG4qLx0x8ZtV/v9KLSW/R6yecP
         3H0kCW3pBM5zf9tD1/g8v03WngOrjYIDM35+cH9z59TBJ54kbZYmJ5J0Kt2J/XglHqI0
         OErIhDtOr+AgHDmMEVh6hXSzaocZ5j0cKYE0f7kvkDE2fjuMbCuFgCTygubNzx6aMTpP
         Z64g==
X-Gm-Message-State: AOAM531TiC7/ik0b+SwVEaRKxczKAO84A7/F6/MzMeVsj6L5P3AFZleb
        Jj7Gmscxik4JCCQhQwWY4b7pn2FAMdEbgJptAwKt727hNMhqdENsukI9sP0fSw9v4cvQNrF7kvb
        K5IehExVPNaMj04oa5cbKsPju
X-Received: by 2002:a17:906:4fcc:: with SMTP id i12mr5074113ejw.309.1635781148722;
        Mon, 01 Nov 2021 08:39:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz587Ms+6nqdF7SRpcM1L5tSWtWQOQEN+94ABdcjIiy79Lh89JKZ+kiOXwcIk5nEWBOXpm0lw==
X-Received: by 2002:a17:906:4fcc:: with SMTP id i12mr5074092ejw.309.1635781148538;
        Mon, 01 Nov 2021 08:39:08 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id r3sm7266696ejr.79.2021.11.01.08.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 08:39:08 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel test robot <lkp@intel.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCHv2] ftrace/samples: Add missing prototype for my_direct_func
Date:   Mon,  1 Nov 2021 16:39:07 +0100
Message-Id: <20211101153907.377668-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's compilation fail reported kernel test robot for W=1 build:

  >> samples/ftrace/ftrace-direct-multi.c:8:6: warning: no previous
  prototype for function 'my_direct_func' [-Wmissing-prototypes]
     void my_direct_func(unsigned long ip)

The inlined assembly is used outside function, so we can't make
my_direct_func static and pass it as asm input argument.

However my_tramp is already extern so I think there's no problem
keeping my_direct_func extern as well and just add its prototype.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 5fae941b9a6f ("ftrace/samples: Add multi direct interface test module")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 samples/ftrace/ftrace-direct-multi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 2a5b1fb7ac14..b6d7806b400e 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -5,6 +5,8 @@
 #include <linux/ftrace.h>
 #include <linux/sched/stat.h>
 
+extern void my_direct_func(unsigned long ip);
+
 void my_direct_func(unsigned long ip)
 {
 	trace_printk("ip %lx\n", ip);
-- 
2.32.0

