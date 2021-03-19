Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762DC341FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhCSOlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhCSOlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:41:25 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA94C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:41:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id n11so3815031pgm.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yq2AQYTBwcMSkk50BfF3YUyk3WvoM0RKP8OIdZyLogM=;
        b=Pp9i5eXC89dTj73yMTNviANChtWGzOSQPPxpjROOV89DC1cJKniL80efegMN8c7zDo
         9JJVgrSAKabRDXm4ek/m0QR+cyxgSxOWNBnNYM+IqArsCERQHHAffp743QYuXRubCqJF
         KKJLKzUVNz29+1H/1okUU2NrfLm97jZ1fhxQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yq2AQYTBwcMSkk50BfF3YUyk3WvoM0RKP8OIdZyLogM=;
        b=K1+BU4gUCM7YVqqrUCOHvX4vLwabnFKKAAyHlzqbAnk0e4I9CcvG1r2L2GGAwMtm1D
         WlRMdtUfqDHXc81IBZNIaWoGwqyx8oCtGK5w+SelarWD296qDvBp5jr4amGUW/hnNV8E
         1Vg6SttMNiCAY/p6CPZ56QJFcQoYBpFZh0K6p0xiYyh/54n/HCaDBe6gzd0EuoBRg24J
         qsW9edty7e9wTLGY8bmEJkj/FCAxwOCO/4A81qGu682Ooc9UtutxNdpl6MB2X5XmzxYW
         s975qRPGfCwtNhU1spiWhI3jkXZ9Cd4H0nFgwj/9doDS795Y5GRYbeaMPKvjafZJSnfg
         m/EA==
X-Gm-Message-State: AOAM531FWYxfH0g/FED/Qj5Exqbtx+MsXLUPb1LQPXtoMkwH0noWkJeJ
        QxAOL0BkIo9VVMS1fYkMa3CkrjvAlf6GYQ==
X-Google-Smtp-Source: ABdhPJzJzQ0B+ewWNBZMSXaoPb9f+KSB83OXkB72IsMoCXTL5bjXzymNNUc5j/qLGRplb0QmcZE4jQ==
X-Received: by 2002:aa7:92c7:0:b029:1ee:75b2:2dab with SMTP id k7-20020aa792c70000b02901ee75b22dabmr9622789pfa.61.1616164884381;
        Fri, 19 Mar 2021 07:41:24 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-674e-5c6f-efc9-136d.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:674e:5c6f:efc9:136d])
        by smtp.gmail.com with ESMTPSA id y29sm6058594pfp.206.2021.03.19.07.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 07:41:24 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v11 5/6] powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
Date:   Sat, 20 Mar 2021 01:40:57 +1100
Message-Id: <20210319144058.772525-6-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319144058.772525-1-dja@axtens.net>
References: <20210319144058.772525-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan is already implied by the directory name, we don't need to
repeat it.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/mm/kasan/Makefile                       | 2 +-
 arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)

diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index bb1a5408b86b..42fb628a44fd 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -2,6 +2,6 @@
 
 KASAN_SANITIZE := n
 
-obj-$(CONFIG_PPC32)           += kasan_init_32.o
+obj-$(CONFIG_PPC32)           += init_32.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx.o
 obj-$(CONFIG_PPC_BOOK3S_32)	+= book3s_32.o
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/init_32.c
similarity index 100%
rename from arch/powerpc/mm/kasan/kasan_init_32.c
rename to arch/powerpc/mm/kasan/init_32.c
-- 
2.27.0

