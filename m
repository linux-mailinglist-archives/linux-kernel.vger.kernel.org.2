Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAD53F12D6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 07:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhHSFmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 01:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHSFl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 01:41:57 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8FCC061756
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:41:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u15so3218146plg.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 22:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BwNoXd2rkxIRbmu9Dz8FHaUqpffdyUvc7YXbY/NWg74=;
        b=PdcEETJ4lvxCKbU5HNkMObo/tzIR10Sio6tX8G5djfW7suz8OI3ehQMKsU/oDnVWNC
         ahGmK8RoZurLovVnDfMYTVT8j3662vj/VyB3FynnJ7tKg2qN1t8FsaJGFQcSbGeLfJUp
         IlUZZbJMevUtW45efSzodMEpTnaMBzNeJt128zo46Zctz0l5WDnZMJEluO+Opb9j60FY
         vSWUIhdJmN+ngPlNoXfaTOR4Bx9EQevY8lEUDUbTaY7t/POY/+ch4V4pxSF4LggJnBgw
         sfwL/nhjUL8BFhmI6cKeh8rlfm8GtJ/nWUojo8dNB4rNUC6EtOoG9r9ceKozu6pC3uL3
         MU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BwNoXd2rkxIRbmu9Dz8FHaUqpffdyUvc7YXbY/NWg74=;
        b=bqr38eOD0MkH2586AUQ0TVik8Sw7nwZrF7Tkeizn3dPZTPHcRnamdy5OKGcUDO2ZAZ
         +fUKQXlCIaH7Il4VVFCOiHzVnnC3lmtrFohGG8RHgu40xaZdMXwo7ptHpE6P11lhRuf9
         L6I9q7R9TJjGo9HQeteyvF8i9hIiZ1IHiTi8bzXtREStuSmnTYFjQiO2sUV1eH8s95aB
         kN7tWe4OEhx2w/JsNSW+/nUbh/ifFDFZPqRXd9ppL0YuDIk0fsVFAosLYrwgktynF7kt
         7f7hcJrz34gY5wClccCB2D1IfLNRATmW6IwJX74yBsnN/cQchIXjbKFGavmfLCNClbFj
         jgFA==
X-Gm-Message-State: AOAM5317CqKRLvAU1EGPFejdh3JtbAMNN1V9/nWHUoaKDa9/ibBmYL97
        cMcdXAb2Czl68/u7+gPoP2o=
X-Google-Smtp-Source: ABdhPJwlRDHwmoY4LYbWF0eLUcH7gjgRBpwhAERepvRAbRzqX2F2N6qQYu+EGeLp2nxNRgb8Fe3ETw==
X-Received: by 2002:a17:90a:8d06:: with SMTP id c6mr13107839pjo.9.1629351681836;
        Wed, 18 Aug 2021 22:41:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id s188sm1708312pfb.4.2021.08.18.22.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 22:41:20 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naoya.horiguchi@nec.com, osalvador@suse.de, tdmackey@twitter.com,
        david@redhat.com, willy@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/3] doc: hwpoison: correct the support for hugepage
Date:   Wed, 18 Aug 2021 22:41:15 -0700
Message-Id: <20210819054116.266126-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819054116.266126-1-shy828301@gmail.com>
References: <20210819054116.266126-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwpoison support for huge page, both hugetlb and THP, has been in
kernel for a while, the statement in document is obsolete, correct it.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
v2: * Collected ack from Naoya Horiguchi

 Documentation/vm/hwpoison.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
index a5c884293dac..89b5f7a52077 100644
--- a/Documentation/vm/hwpoison.rst
+++ b/Documentation/vm/hwpoison.rst
@@ -180,7 +180,6 @@ Limitations
 ===========
 - Not all page types are supported and never will. Most kernel internal
   objects cannot be recovered, only LRU pages for now.
-- Right now hugepage support is missing.
 
 ---
 Andi Kleen, Oct 2009
-- 
2.26.2

