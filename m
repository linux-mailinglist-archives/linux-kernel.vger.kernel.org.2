Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5288A3F0E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhHRXGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbhHRXGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:06:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99DC061764;
        Wed, 18 Aug 2021 16:06:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b7so5748615edu.3;
        Wed, 18 Aug 2021 16:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuULxqsBES1oBE55HfZGFl348h78G9+Ze8axMVfhIx0=;
        b=Ix+Qj7OQCtiY61HTgu+km0QkG/qzuJlLQYs8ElY6/vaO2HdvNNrNkuJHadsx7OvRzH
         lwxD0g8520WOnhhdPCKAQyX/ewdtuQUVpaBSVZSMInfTwa6Ri2iMYeNApmx9p/pub0yJ
         w+08BRJW46tpccp62thVGjEgeoMDrZ7IgD15bX9F4Qq8Hv3G4pQx6gV6mrzLh8Dk2mbA
         IilMW2RJMV2MPkN7zYiyvnpfdWZQ654vQ6VhmJoNjhIrQitIYecPvnTseXmEcBajV2Ms
         o70kFiKppcREWluifH9fHTxpSQDkFGL8jg1tn7u3kaiOTphftOtv0Gv3XMpdB3MVZPxP
         wXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cuULxqsBES1oBE55HfZGFl348h78G9+Ze8axMVfhIx0=;
        b=nZOQvrdS9oAD1H7XA8rDIEAjyWSgs/um9NshCc2I/EV1m3GcnJqfh4lmrvg6n4zdCZ
         WhuXW8vHjJv/8213pE/Zaeym7naDSPFRoOmICo2h3fdqK59AkQAkcwin7y1q3NAt3c0b
         3qTuACos6YU9HL2M+wo6337gRjugMBdqUSVIniBotcYCN3AQqau9+rDpqbNnJcx7Pd5u
         Zh52sP2SSFnRVAUWPC5RA3hbWyrrxI8avr4FvwPVslMwo+NbwEXRj9770Ti8jfcgEmN3
         w7jWXxJFSZnN4tGlBFdpaFmg7j8M3+cH2sd+w2fKpAJ2x3XL+MExE+fSTgYBz/OJt20G
         wrOg==
X-Gm-Message-State: AOAM531ZXTY82HzUS3WbrZEOpaMHrsEKziHXAkD5nNyl7nNRrYnVquf+
        WkBCeWBfxjc68nMYUxumBuc=
X-Google-Smtp-Source: ABdhPJwhqaeQ5K6j3BSpyPMBmyAV/blmvsI2jsFlUzqZgr0jN9SLYiwldqQNHsmZOHkwaJevJjv3lA==
X-Received: by 2002:aa7:dd0d:: with SMTP id i13mr13028821edv.371.1629327968888;
        Wed, 18 Aug 2021 16:06:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:21b0:9002:7dca:dea6:32ff:fe9d:5ad6])
        by smtp.gmail.com with ESMTPSA id p3sm480011ejy.20.2021.08.18.16.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:06:08 -0700 (PDT)
From:   Chun-Hung Tseng <henrybear327@gmail.com>
To:     jmseyas@dit.upm.es
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, henrybear327@gmail.com,
        rdunlap@infradead.org, andrew.a.klychkov@gmail.com
Subject: [PATCH] Documentation: kernel-docs: Update the title, the author, the URL, the date, and the description of the book "The Linux Kernel Module Programming Guide"
Date:   Wed, 18 Aug 2021 23:05:26 +0000
Message-Id: <20210818230526.695084-1-henrybear327@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, the content and examples of the book "The Linux Kernel Module
Programming Guide" are being actively maintained and added on Github[1].
Currently, the book is being regularly built into webpage and pdf
file using Github static page[2].

[1]: https://github.com/sysprog21/lkmpg
[2]: https://sysprog21.github.io/lkmpg/

Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
---
 Documentation/process/kernel-docs.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 22d9ace5df2a..631a3dc04e3e 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -126,15 +126,17 @@ On-line docs
         describes how to write user-mode utilities for communicating with
         Card Services.
 
-    * Title: **Linux Kernel Module Programming Guide**
+    * Title: **The Linux Kernel Module Programming Guide**
 
-      :Author: Ori Pomerantz.
-      :URL: https://tldp.org/LDP/lkmpg/2.6/html/index.html
-      :Date: 2001
+      :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob Mottram,
+      Jim Huang.
+      :URL: https://sysprog21.github.io/lkmpg/
+      :Date: 2021
       :Keywords: modules, GPL book, /proc, ioctls, system calls,
         interrupt handlers .
-      :Description: Very nice 92 pages GPL book on the topic of modules
-        programming. Lots of examples.
+      :Description: A very nice 93 pages GPL book on the topic of modules
+        programming. Lots of examples. Currently the new version is being
+        actively maintained at https://github.com/sysprog21/lkmpg.
 
     * Title: **Global spinlock list and usage**
 
-- 
2.25.1

