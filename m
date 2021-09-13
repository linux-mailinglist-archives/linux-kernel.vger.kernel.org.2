Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDB3409FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 00:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbhIMW2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 18:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244986AbhIMW2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 18:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631572048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ed60XhekeWquIFLKIHPQ4y2Tgzq2QS36FAffaebUrj0=;
        b=Pm/Bcwbxgs2yC8586DcP0MSkF6JgDqxSXgKD8tud+7B7mAy8dUmck87TOGOjQ63rm6JQXX
        HzNB9b+hV+79ciwwqbZuTFaqz3KFAFT0jh8TqbB7P1AHNfTPQ0ZBHlQoXNnZvQiX53c6YY
        DJ0BKYFITJycmiuxzkX8XDAi39l2tgI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-EW8mQNKLO9yA6yLZblA0Mw-1; Mon, 13 Sep 2021 18:27:27 -0400
X-MC-Unique: EW8mQNKLO9yA6yLZblA0Mw-1
Received: by mail-io1-f70.google.com with SMTP id s6-20020a5ec646000000b005b7f88ffdd3so14979375ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ed60XhekeWquIFLKIHPQ4y2Tgzq2QS36FAffaebUrj0=;
        b=sCGzwGIdz6P4bdydyA8TSRL6NmNKtJvI2HDGpFUG7OvzYs93U8/a2I8uJMjp8IC6p5
         fevq03CGfVV7LPe616K+YGL07PA1r0U4BPDm+DDdK0RBHQHZOk1CAkH7ZtU09NUNKvEK
         S8PzAM46rV7Kj3QCiv0xhpnJfUNuTBjuu42j2QZiAd4y/KAIMFiURdLKbPxEOL7iSp5n
         LchHlk5cOghOxNODsHf3SOUngPDZBjkISlFk1CFmzCjCrdITAyLe9jExhVANmcHpZrNj
         ZGJEgcw5RFEr5eVB68/SRqg5CKUaUVCt2Ev46SrfeBoDLM16BdPzN7stB4+vcHc76de9
         icEw==
X-Gm-Message-State: AOAM531KHSGkhpfQURXodvRicivUgX6AHNpnqAdWB5bsg63CdE3Nb17u
        xdQjncbjFBnw73LVIpZskOBvWzmJdRF0Q5BZQM06HrAcQncjAMrPZd06Px3qDKZej9ti0Rg4t9e
        6zgmZL6EVYzuofph/hDPXJfwP
X-Received: by 2002:a05:6602:2e0c:: with SMTP id o12mr6655575iow.59.1631572046779;
        Mon, 13 Sep 2021 15:27:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2Be4X0ICHDQBimF+mHMVXCAyyI9/XcjxSzsnAR7FEgXBWZfVi9jiMU8MDsACdC3ZIM8EokA==
X-Received: by 2002:a05:6602:2e0c:: with SMTP id o12mr6655564iow.59.1631572046636;
        Mon, 13 Sep 2021 15:27:26 -0700 (PDT)
Received: from halaneylaptop.redhat.com (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id d10sm5809457ilu.54.2021.09.13.15.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 15:27:26 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Jason Baron <jbaron@akamai.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] Documentation: dyndbg: Improve cli param examples
Date:   Mon, 13 Sep 2021 17:24:40 -0500
Message-Id: <20210913222440.731329-4-ahalaney@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913222440.731329-1-ahalaney@redhat.com>
References: <20210913222440.731329-1-ahalaney@redhat.com>
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
index d0911e7cc271..4bfb23ed64ec 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -357,7 +357,10 @@ Examples
   Kernel command line: ...
     // see whats going on in dyndbg=value processing
     dynamic_debug.verbose=1
-    // enable pr_debugs in 2 builtins, #cmt is stripped
-    dyndbg="module params +p #cmt ; module sys +p"
+    // Enable pr_debugs in the params builtin
+    params.dyndbg="+p"
+    // enable pr_debugs in all files under init/
+    // and the function pc87360_init_device, #cmt is stripped
+    dyndbg="file init/* +p #cmt ; func pc87360_init_device +p"
     // enable pr_debugs in 2 functions in a module loaded later
     pc87360.dyndbg="func pc87360_init_device +p; func pc87360_find +p"
-- 
2.31.1

