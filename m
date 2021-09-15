Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C64640CAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhIOQmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhIOQl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:41:57 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0055C061766
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:37 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z1so4253230ioh.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FAAUD4UVAIgvdGAgUfVDeuWiveCb3NYwtKpCMpZVl+I=;
        b=Nj6tYJpK9houkWpzaczaQjb7+uMjNtEtRE8whUhsX4iXhn99YimKrVl8Df/+DZDfwH
         PPddZMCvXjaAKQrGRlRZ1dm8R1/3oGR5hQ+maecuXHvUZnUHAfkryqAnGd9uxILiPQUR
         FWKXCXiPVuTWx/AKPHyt63yAxq3RQy0d8ZlIpg6fv+5tdq3oyYPWJ40XuoUaQdDyZ8rN
         QvqlHsGz5Fm8TJ87izJo7SpUX3at/RkD+JT5PA75TBT1w+FLByGcpdEPfU2h8LKdhlrv
         S1JPwdnhVfw/7tOVfzuwQDj89zEUgrOCl5cS/VUy8EUx89q+5JP7VfsPmZ4hbv9DGfLQ
         uDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FAAUD4UVAIgvdGAgUfVDeuWiveCb3NYwtKpCMpZVl+I=;
        b=Y4kug1Fypff6h9UVJBu4ZoWwfbkGjL2TiseHOPdGfodNCdQYW3WkVErxbiAocXCxcY
         hm93i5W9Ugih2rzYSDfz3vxO1kfkTKhkbmwuZTqFJxQFc5m/Paw78F8EqSEJAk81jXCk
         UTZ5wWHqy9L8hESj9NwMeJ53Th9GxjE+o2cH6gGS3WQL/jgf5naeT3QpNHCc0jBz6ShK
         ufdK4xZeDpe1u0ltcR6OwW9lLxRU/l1iBDqtvfR3Y+uVgnPhPfHH5XHZORtXVrGTtIZ1
         ms0McQmVaxZ7hNIY21cS1t8uZAMxi9qekk1wDigK8pPI+8NyN3G0wGyVEj9FpqoevZBb
         ypog==
X-Gm-Message-State: AOAM531vBZMo5u6758MLHgsdVE4MkQqkL9B4prjzINSACt3jHBMHg3zH
        d1iO2vG0LK3pF87apszZ3uc=
X-Google-Smtp-Source: ABdhPJzFP26+aohIn5kHPCvXIsCTdV2lsKWwp1Fz6xIAnhxk/uwdB/4xjSujak3OGTs20tOa/e421Q==
X-Received: by 2002:a05:6602:200f:: with SMTP id y15mr793147iod.64.1631724037160;
        Wed, 15 Sep 2021 09:40:37 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a5sm299540ilf.27.2021.09.15.09.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:40:36 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel@ffwll.ch
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 07/16] dyndbg-doc: fix bootparam usage example
Date:   Wed, 15 Sep 2021 10:39:48 -0600
Message-Id: <20210915163957.2949166-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915163957.2949166-1-jim.cromie@gmail.com>
References: <20210915163957.2949166-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This example uses dyndbg as a core/kernel param; it is a (fake) module
param.  Using it as given gets an "Unknown command line parameters:"
warning.  Fix the broken example.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index ab28d200f016..b7329e72c630 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -359,7 +359,5 @@ Examples
   Kernel command line: ...
     // see whats going on in dyndbg=value processing
     dynamic_debug.verbose=3
-    // enable pr_debugs in 2 builtins, #cmt is stripped
-    dyndbg="module params +p #cmt ; module sys +p"
-    // enable pr_debugs in 2 functions in a module loaded later
-    pc87360.dyndbg="func pc87360_init_device +p; func pc87360_find +p"
+    // enable pr_debugs in 2 builtins, 1 loadable modules init* funcs
+    params.dyndbg=+p sys.dyndbg=+p pc87360.dyndbg="func init* +p"
-- 
2.31.1

