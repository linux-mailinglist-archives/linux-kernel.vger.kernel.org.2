Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2A32CB6A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhCDEfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbhCDEfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:35:01 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F03C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 20:34:20 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q204so16960607pfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 20:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A2hLtjNljNetAkSmo/iHqzzoKnA6pftypZoUWx6FurU=;
        b=rHqw52UXPF+xdckDBtcyZS3CUYmrMbR3cobcppf35CgyssREqhhCCwzCsoQZc4NiZk
         thNRdQ4UpMHDphFBeVbcomsCvqOTzmIkp5EV5AmHo23rKGxgVtKNpQQrh7cEzlKrOw6I
         DEANoc+W9nbATxuLvHTLq54zAAz2jQkvmUJ76Nw/RtPA/5GSq8350zOWNp4fiWBte4/u
         uuvPjOWfas7a1qQt7pIrIdaaMM+H2o+TChOUmpOhj49HGc9KBDQkciKtQu1on9O23+8f
         NXSz0J9ZOM3Tf5Er0EkGVlbCpOuTA3XRxI8b3KTG/oxlIRbaPvdlTqYGAkZDHIcs64nt
         fVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A2hLtjNljNetAkSmo/iHqzzoKnA6pftypZoUWx6FurU=;
        b=cEOrKqH/CW1Yqm5Z8tBaVWj5LVkUoY5NC8c0M1p74R3PvE9MVn4ksx5TGQ3gcqS3NL
         +hXmXtOiIWPou4IwYlzaL4mM11GTxXIxxEWwXuSpc0EVRONOW0EWLYuxBWN+AyyoTBcu
         I1gfbB4OuqzBBmvCXZTXTBqqP72Abt8AeJ2Z/pBGRixP+2I8FvT8gb6y7aGR/5W/tsxE
         Xn7FjHDL7T3fgZAoTR7VLgNePjpIbCL4xoQFiy/DjD3o/7mFQEw+33Vy2nKUz7+jCRbv
         acbho3cdhl7hI3Z/sdroWpo3b1GsiTxcKQ+kHXJmiVZ3XY+icn2sqZOwWMrFaZqspVYg
         6shw==
X-Gm-Message-State: AOAM5307eQ1fjDcl11JwUMLYU/vX2Yv9+c2yN/q04GlyZZLHyAz3+bTx
        f+T8DCYAkA3kStiWmAGd00o=
X-Google-Smtp-Source: ABdhPJxq/ac63Tv3Iihf95Hb63XawyRjE/7qX7mVuyui7LWCpQaK9Sh8ZV3ZihWeAmnZyTRACyOg4Q==
X-Received: by 2002:aa7:900e:0:b029:1ee:14ea:f719 with SMTP id m14-20020aa7900e0000b02901ee14eaf719mr2115641pfo.46.1614832460444;
        Wed, 03 Mar 2021 20:34:20 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id ha8sm7709078pjb.6.2021.03.03.20.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 20:34:19 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     svaidy@linux.ibm.com
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, rppt@kernel.org,
        akpm@linux-foundation.org, jniethe5@gmail.com,
        elfring@users.sourceforge.net, gregkh@linuxfoundation.org,
        aneesh.kumar@linux.ibm.com, ganeshgr@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] arch:powerpc:kernel: remove duplicate include in setup-common
Date:   Wed,  3 Mar 2021 20:34:12 -0800
Message-Id: <20210304043412.190085-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'asm/udbg.h' included in 'setup-common.c' is duplicated.
It is also included in the 61th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/powerpc/kernel/setup-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index bee984b1887b..7221f11acf04 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -69,7 +69,6 @@
 #include "setup.h"
 
 #ifdef DEBUG
-#include <asm/udbg.h>
 #define DBG(fmt...) udbg_printf(fmt)
 #else
 #define DBG(fmt...)
-- 
2.25.1

