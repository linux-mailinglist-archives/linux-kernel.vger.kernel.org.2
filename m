Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0757A412797
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 22:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbhITU7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 16:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231784AbhITU5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 16:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632171348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4VKFLtrv5F+Sqia58aIUV8mMMq0gd6yS5dG8Lafx1o=;
        b=CGCyXxSpI5BUR0dMsspifQ7dBMja61d3L3mugVMxPnu1BeqcZ5HHf7WCmgEYBwmCJ0rvVk
        DjSSfdQv9dUDxXsoB2Oh0bX+Af2rYyFZkY5/ZqwzU4+XWp3pi5TZCv1i5OstFI/w+GzvAv
        9eJA+bggDho84w3OPxCLLzoa+5qjW3w=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207--lCGBGwTMNWsjDsZg1eFjg-1; Mon, 20 Sep 2021 16:55:46 -0400
X-MC-Unique: -lCGBGwTMNWsjDsZg1eFjg-1
Received: by mail-il1-f197.google.com with SMTP id f10-20020a92b50a000000b002412aa49d44so40449401ile.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4VKFLtrv5F+Sqia58aIUV8mMMq0gd6yS5dG8Lafx1o=;
        b=Wa8PU5jOFlwbVv60VU+AP7OUIX4CAgmlwq3yxNC+f03UvrfiMSSA0N2gGiBJQfu/cV
         rEpd4Zm9lvNN8YR9U0seO8nS4NTZfpn/QnPXZxS/o2My6Ng6xaj+xh/vjJhrNZkfAYzZ
         VDwgQpdXfs7A5RArsTpeW615LaqxoLRg1mv1Fr+M4CfqGU7XHOlVnKmmnVlF2JZco/zQ
         Es9XFCYeQY4dJjZV5Ip1oqNEFZSAO/ydx8njZGQFT/6NYKiuxNO6IjUoAPEQ367ORAfU
         T4fFxvn3/XDatf1oiDObN271R1MKvQEjZ52um+d5TMN1pGKc3mfcZq/UeuxT4PIdv7DI
         RVPQ==
X-Gm-Message-State: AOAM530paHBiUWM2I7t6+kr3XBiYpHuHnGKQPZtXsIHt3hIhk5iK1ZbY
        tQiBoz1VSmrv2R1nqIqjs81eYI58NM4nKIrQOZrEOuv+vqNBUxXqzN1xlgU8tw2o32qSCNyIwtc
        OxwiHaOYkx0HgoAPvuL0M0sDK
X-Received: by 2002:a6b:cd01:: with SMTP id d1mr17336334iog.88.1632171346330;
        Mon, 20 Sep 2021 13:55:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwe95i2375dC+5VC3FwfOiZ49FuXMNgnAsnCt+5yXxUVqT8mSI59DRcKPEVF0316d9KBE3J2w==
X-Received: by 2002:a6b:cd01:: with SMTP id d1mr17336329iog.88.1632171346122;
        Mon, 20 Sep 2021 13:55:46 -0700 (PDT)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id v9sm9268905ilc.16.2021.09.20.13.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 13:55:45 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Jason Baron <jbaron@akamai.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] Documentation: dyndbg: Improve cli param examples
Date:   Mon, 20 Sep 2021 15:54:44 -0500
Message-Id: <20210920205444.20068-4-ahalaney@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920205444.20068-1-ahalaney@redhat.com>
References: <20210920205444.20068-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim pointed out that using $module.dyndbg= is always a more flexible
choice for using dynamic debug on the command line. The $module.dyndbg
style is checked at boot and handles if $module is a builtin. If it is
actually a loadable module, it is handled again later when the module is
loaded.

If you just use dyndbg="module $module +p" dynamic debug is only enabled
when $module is a builtin.

It was recommended to illustrate wildcard usage as well.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Suggested-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index d0911e7cc271..ae264aab42b6 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -357,7 +357,10 @@ Examples
   Kernel command line: ...
     // see whats going on in dyndbg=value processing
     dynamic_debug.verbose=1
-    // enable pr_debugs in 2 builtins, #cmt is stripped
-    dyndbg="module params +p #cmt ; module sys +p"
+    // enable pr_debugs in the btrfs module (can be builtin or loadable)
+    btrfs.dyndbg="+p"
+    // enable pr_debugs in all files under init/
+    // and the function parse_one, #cmt is stripped
+    dyndbg="file init/* +p #cmt ; func parse_one +p"
     // enable pr_debugs in 2 functions in a module loaded later
     pc87360.dyndbg="func pc87360_init_device +p; func pc87360_find +p"
-- 
2.31.1

