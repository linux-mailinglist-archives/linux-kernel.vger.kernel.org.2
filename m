Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6FC441D44
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhKAPWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:22:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229826AbhKAPWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635780006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dAeRfr4dbthi/ovcb+Eba3V5YcBnIIBucSkoTXHdeuY=;
        b=PilItmKM9KOdPMyH/dbzENKir8YCLuurDzwiC7yuS+31yrVkp2ySwNRTjWqiiEdZ3HIFud
        MndSOSGft+2gACDzhf1b76k2e3zOkFPOVCa12KK/XeDchpZupiNNRaMxzZQnh6j6l38D2b
        /8W72bkNFuN7xSgobJxegxrHZavWdh8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-tECkm5QiNiu5z0t8vECAyQ-1; Mon, 01 Nov 2021 11:20:04 -0400
X-MC-Unique: tECkm5QiNiu5z0t8vECAyQ-1
Received: by mail-ed1-f71.google.com with SMTP id w11-20020a05640234cb00b003e0cd525777so11174428edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dAeRfr4dbthi/ovcb+Eba3V5YcBnIIBucSkoTXHdeuY=;
        b=IQEry7CFUvbqdJKICfkQm1ZODewzH1McfoG3Ll4qTUhTyM137zbRV3rWXHjb+8OAD/
         kUELSQlvoLe/bt9CSz6My107ppy2CpdUg1eCS3qMIE/n4Gjt5AY66gNvqAyDOXSGnxAA
         ruLtwFOLBwf/oBg/75aMesnxpLlZ9tbWEU9pBccKjgfh1ZqLSh8OjgiTI5A4A5Eq1d6g
         YTLj03TRJzBQHsIligTIKBLbFoo5+u1F2NqGJW7DPMVMYKoEhE1De6pHDulESHkYdbsX
         i4myjPeI1EBs+76tNTtXfy7hcBSxq3gsj4peirot8Lwn6Fpv0U3SnB4sSPvOp49SpEz6
         QEZg==
X-Gm-Message-State: AOAM533UsOsuvrB9YuN/DakkhHWIkPNYBCelIU141sxZSPs6p9J+yso1
        UK82qN427zTyb4/5m7XjM/tHsW0QbUSGuD2bk8zxEFTiEnhTXdhM0j9PLJIBpC6UEdshHdmThVu
        Y7bj3dqACYisvMp78nXJSn9Se
X-Received: by 2002:a17:906:11c5:: with SMTP id o5mr30891451eja.42.1635780003750;
        Mon, 01 Nov 2021 08:20:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEkfUSYKO7B+kM9IsLNrusJknNNOkQPPdxURtD13309uhjWycsHTyizdfh68asfG5BaBIpBA==
X-Received: by 2002:a17:906:11c5:: with SMTP id o5mr30891414eja.42.1635780003492;
        Mon, 01 Nov 2021 08:20:03 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id gb2sm6930903ejc.52.2021.11.01.08.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 08:20:03 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel test robot <lkp@intel.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] ftrace/samples: Add missing prototype for my_direct_func
Date:   Mon,  1 Nov 2021 16:20:02 +0100
Message-Id: <20211101152002.376369-1-jolsa@kernel.org>
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
 samples/ftrace/ftrace-direct-multi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 2a5b1fb7ac14..e0ccf43da0c9 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -10,6 +10,7 @@ void my_direct_func(unsigned long ip)
 	trace_printk("ip %lx\n", ip);
 }
 
+extern void my_direct_func(unsigned long ip);
 extern void my_tramp(void *);
 
 asm (
-- 
2.32.0

