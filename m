Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8059B3E11BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbhHEJ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbhHEJ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:58:50 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AF2C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 02:58:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l19so7493999pjz.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 02:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0IcL/D/ZU1hAOTd1XphGXL3D3G0tDnrkBfwu1W2heo=;
        b=Ulos4PtARRFLFCHQeZLRCmj3p88UF2vyD+RUuSiePKTG0K2VBkoVxO8skpEinQTM3q
         WaBxipBJSFjg/Z9n033egXetgR0VizykxMYKAHGt4ENOuvLdmLxpDQUpti23P8P0hvK1
         HrcpZbROr+Dm6SbJopW6hYKAJHTxRlb6MIF9FBgNQ7DH7e5YF/ZZQ598KAN3jAWmKPmc
         V71hXen00lc1z7//wL0nvKL+0+KLKYHi1Jwex4r82JJkg87T39o2ITMZq5z5RbIp3m15
         GbCkXQ/7YQ202V7v7ehea0hQOOU5zBOumt2z7F/Bm4xaG9IhenfOiJimSqKJODY9c9iV
         wO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0IcL/D/ZU1hAOTd1XphGXL3D3G0tDnrkBfwu1W2heo=;
        b=c8OLl0Rw5bDgmUvRyVjAhxGmSvBjrMCjWKe6zVAW2A8psE7Kc+KK4adLHnTVfZMY7G
         SoixB5dnaz6dBthnlqdUu1LXkC6CK0WvsQzuAjG3Rqv2osR1wwZdmO2l6iEblxRyN7Mx
         kH6UFSRTq+0V/oFMs7P5KLe3yDE8ZLJfZm6yzctWCzCgU9Radb3TdaJDiNZ8CUJX8ayd
         5RmFu6okHoei2Er0ZHsbl16Yp9JPgUCEvI6BuMIlxzrRNB1UIDAdKi60tMQeYZG+phhH
         rfCUA65RnYIDBYRf2K/cmT+FLufTO6yF7Ob0o94BFY9XSirRqui/93FggPrxr45PoDK3
         PK+A==
X-Gm-Message-State: AOAM532ZZD9cvpMMTg6Bu+ycBaEAGshj/8gPk6a+VPbYCkx29cF6qePG
        n2i4afcJQrhj+iXCF6Zzu+E=
X-Google-Smtp-Source: ABdhPJze8sjte1j57KB4oGCX6wwiziscvbsIR/9o/sSCBJze52HYZxBazUyzLi2/KxbgP6IS5ZQzdg==
X-Received: by 2002:aa7:838a:0:b029:3b7:31a5:649c with SMTP id u10-20020aa7838a0000b02903b731a5649cmr4160794pfm.44.1628157515514;
        Thu, 05 Aug 2021 02:58:35 -0700 (PDT)
Received: from ownia.. ([173.248.225.217])
        by smtp.gmail.com with ESMTPSA id n22sm5974444pff.57.2021.08.05.02.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 02:58:35 -0700 (PDT)
From:   Weizhao Ouyang <o451686892@gmail.com>
To:     Julia.Lawall@inria.fr, Gilles.Muller@inria.fr,
        nicolas.palix@imag.fr, michal.lkml@markovi.net,
        o451686892@gmail.com, efremov@linux.com
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [RESEND] coccinelle: api: rename kzfree to kfree_sensitive
Date:   Thu,  5 Aug 2021 17:58:23 +0800
Message-Id: <20210805095822.1732125-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 453431a54934 ("mm, treewide: rename kzfree() to
kfree_sensitive()") renamed kzfree() to kfree_sensitive(),
it should be applied to coccinelle.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 scripts/coccinelle/api/kvmalloc.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/kvmalloc.cocci b/scripts/coccinelle/api/kvmalloc.cocci
index c30dab718a49..5ddcb76b76b0 100644
--- a/scripts/coccinelle/api/kvmalloc.cocci
+++ b/scripts/coccinelle/api/kvmalloc.cocci
@@ -79,7 +79,7 @@ position p : script:python() { relevant(p) };
   } else {
     ... when != krealloc(E, ...)
         when any
-*   \(kfree\|kzfree\)(E)
+*   \(kfree\|kfree_sensitive\)(E)
     ...
   }
 
-- 
2.30.2

