Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD283E11AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbhHEJzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhHEJzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:55:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913D3C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 02:54:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so13443837pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0IcL/D/ZU1hAOTd1XphGXL3D3G0tDnrkBfwu1W2heo=;
        b=pquM2t+nywW7CAYSTqvDat9wbULumcUu+EjyjLXwNvV9VqS1mnWBMlilyWjkgMd0vc
         asueXzY15tk6ff0rlMBm0oolufJK/0xr1QTFm92adt9+H30FUXiCQkUlRdZCEq4YUKeY
         qhtVge3LDzz+T7jlfaLTmlXLPRUevDC/LBuDRrFUXndyzrpTJW0jbSuDRZrwXWpyHajv
         PpEqrvKTehgCZlgBB4cKra2ykJhna+nF5/Jh6asqIkiw4qZRJDRT0vXfou6YjHTZxT1V
         mdZxA+4gxPoXzEe5TDVq/acSFPFWZy92AUJN/a1OrioVW9XhGULC1OLZh6TXiA68e788
         Dcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0IcL/D/ZU1hAOTd1XphGXL3D3G0tDnrkBfwu1W2heo=;
        b=S2sVn+Ol29M2fBsCUbnrRNBKDySKWyJPetcWU1HxqoEVAlK3hbqguJZpnsYjeXUF3Z
         nNAkbDxtiO6VNHZ7fCNe0MASGp8prWNhdDarI1z008CRHU2dassYCz3sIxgGICTuHKjo
         bitQvd5BekZZd+Tam9pbc45J8Bh1F+pjKZ20kTO/sqQ2IflI7h8+lo4X8KAWvcPFEnGk
         J1U83hTR7dX+YT2WmbJvwZpwiplj9VqehsrbjNO51Wh3a3vQWIgysm97YxNBJVaX8ujn
         DLMrdqqSxSLz6c1uVC+Uk8h1zRw7LkQY4DobI1WoqsMCwNbprZAD6VYH3aD3O+3DjFYM
         Ct8Q==
X-Gm-Message-State: AOAM533r0nxTwPp1QK3K3JmzwjTM2mInLJor6QNjlARPBNd0hvP6N7XA
        QxWolCp+GLud9fdzyKvzczk=
X-Google-Smtp-Source: ABdhPJwmvX72jpwYfTxC6HxagcN/4rVzwN7gDJRN6VvdCSbL+2OaF3CcwEPxIv6G7xIhx5qQ/NiD8g==
X-Received: by 2002:a17:90b:1c01:: with SMTP id oc1mr4128579pjb.72.1628157288203;
        Thu, 05 Aug 2021 02:54:48 -0700 (PDT)
Received: from ownia.. ([173.248.225.217])
        by smtp.gmail.com with ESMTPSA id v7sm5178914pjk.37.2021.08.05.02.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 02:54:47 -0700 (PDT)
From:   Weizhao Ouyang <o451686892@gmail.com>
To:     Julia.Lawall@inria.fr, illes.Muller@inria.fr,
        nicolas.palix@imag.fr, michal.lkml@markovi.net,
        o451686892@gmail.com, efremov@linux.com
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: api: rename kzfree to kfree_sensitive
Date:   Thu,  5 Aug 2021 17:54:40 +0800
Message-Id: <20210805095440.1731633-1-o451686892@gmail.com>
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

