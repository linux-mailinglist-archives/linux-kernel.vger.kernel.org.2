Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B0841CBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346289AbhI2Sjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbhI2Sjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:39:31 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D3AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:50 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 134so4326482iou.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NzVREY3+gytLq7oEsY0e3jcU0ECpeVaZTWkMcC3UOjw=;
        b=DD2a0k2ZCXNPq8oQBfNZNRlFHyKJDnFZp+imutgMs5ecVQhnAncopz4RZAu9hEIWl0
         +/zgrPeIca2RQYnbxxaK0/W2fj6iqAFbyh4YocFFHpz/8WiUpbTfQXAmq71B63EiL4CH
         bAMw43dYvGoxZn/LVrFITPn2/znc1R4iSFjv4vOb65trunmjjTDpk5zbpL12mw5rqodT
         FowGaSBlYgR975jSwylLDpv+Li2blZ3IXUCbk3mnmN3KU1e8dkL7Ztgm1xgaLtnQ4+lQ
         drR6w9w+JAWGXdxmXPuKHI5wAuxq57sbF2be4E3n0zBTrR9c/4gMhTGE3xvK3WN6FlS5
         PR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NzVREY3+gytLq7oEsY0e3jcU0ECpeVaZTWkMcC3UOjw=;
        b=WWFXzItZ0pJskJR0BKBgRarPScS8iv1OuJBZy4DfWQMevlfE7QJ++ifBUgSBkLHh8w
         gGVnqqc86HNHVozUtwCvQWpjFB8GfYFFfMtiDI+Sl5/FDdDa7BaXsaQJ7vfv6l7BOkQH
         2jAagM0x8DQS021rp44BodzpIk4loPO30/wn1xDMqiwWqlCQLlv+s+ObTWZrdzCafyTN
         m1Lz/PGeyVXC8aOOf+EV8serhuNZ0wlbUWKwl89oJ72JUgZ8QFAE6kB45kACcgTXhU9P
         9oIfOIR+sR9yf2GYkqWtrrJ5wB+k5BNHOknYFwkgZGrBTeSNUZ70C7a2HJkl2zJwt/RF
         kp/Q==
X-Gm-Message-State: AOAM531bfFnOxvnhp6vV+546JMdKR+HxWyE0BnkHi0a06d+Rk2+kv3Uz
        xxyDNbsCz4whyyagW4SwD4c=
X-Google-Smtp-Source: ABdhPJz+XqUO2GDZPAU9sLTGgjJ+Nh4M8m8Rq9leEUBQbc4/4CNAeFhVEvU3VkF6/AlsDryIjAyPlg==
X-Received: by 2002:a05:6638:204c:: with SMTP id t12mr1133705jaj.9.1632940669836;
        Wed, 29 Sep 2021 11:37:49 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y2sm317041ioj.12.2021.09.29.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:37:49 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/6] dyndbg: recode for stronger precondition
Date:   Wed, 29 Sep 2021 12:37:30 -0600
Message-Id: <20210929183735.6630-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929183735.6630-1-jim.cromie@gmail.com>
References: <20210929183735.6630-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The table of struct _ddebugs, due to its construction by the linker,
has an important property; namely that its "equal" fields have actual
ptr-equality, not just strcmp-equality.  Lets recognize that truth in
dynamic_debug_init(), while slicing the builtin table into a
per-module list.
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index cb5abb42c16a..817a87e9c37f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1101,7 +1101,7 @@ static int __init dynamic_debug_init(void)
 	iter_start = iter;
 	for (; iter < __stop___dyndbg; iter++) {
 		entries++;
-		if (strcmp(modname, iter->modname)) {
+		if (modname != iter->modname) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
 			if (ret)
-- 
2.31.1

