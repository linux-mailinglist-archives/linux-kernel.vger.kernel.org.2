Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87C8390E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhEZC6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhEZC57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:57:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2D4C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:56:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k5so47031pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+qg4jIrttxlFVkdbLIETuAL+zofyp/t4lnCyo9LNjI=;
        b=LzSYhkjsHh23YhWgMnNmNO8cO/5y325J/84epdfzKWfq7U2VkjubGjDZCvpGVk+j2s
         AYdDadQ6kU0gNCS2IuKq/S/JfMQnx6oBQBxYGjmPe1V53N+9Ce/faQAWMBWqTA1wht0z
         GNvlJJ/owAra5Lg/43IcczDmqj5uneFN3HuDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+qg4jIrttxlFVkdbLIETuAL+zofyp/t4lnCyo9LNjI=;
        b=Uw1nesn1f5vA8yH1NRJv8aBX9j/5/PdrSbIqf+fTGUgiv8aX75EOFP80rk/2FdCyqP
         iYf0mWxjLPU0kDM4ys5h25T4pTiLr8ZFu19LKTpg+o4E/WBSecz9Q67fGTC0YUDUZI+R
         wtzMU2mxSvKpUE2uMlXjrQZhY0ccpvLkp9jP96C6zmOp1aQSTEttuvrnwxWUYBJCLPh7
         I0eNu+B3Fp2575vlSuUlRX4Um9+VoYjNgw8KC7f5xmtG4eHiEeM4Ay4jhDXUU27sGiTa
         6ICySXOY+o6lwFbHUjcNh7AMf3KPqlJDN0/oxFdW/VlLzu/6lnP178QUDK+HeAQ8QYm1
         quRg==
X-Gm-Message-State: AOAM531faa6IRri+CnH4Q5c33zx8AQRm3V6wZY2x5Dp0uOM2PcCRAV7X
        ooUB9fgO0JCEqbmpodynyBZ4eA==
X-Google-Smtp-Source: ABdhPJw90TzOK5s5zE3FuQZB4GRrdGZ6P7/To8y5OXqOVwu+pKobI6Iyyq8FViZVLm9oM1zSUbx5Gg==
X-Received: by 2002:a17:90b:100f:: with SMTP id gm15mr34218931pjb.197.1621997788800;
        Tue, 25 May 2021 19:56:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5a1b:e4e5:eb10:8870])
        by smtp.gmail.com with ESMTPSA id 5sm2966295pjo.17.2021.05.25.19.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 19:56:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Subject: [PATCH v2 1/4] slub: Restore slub_debug=- behavior
Date:   Tue, 25 May 2021 19:56:22 -0700
Message-Id: <20210526025625.601023-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210526025625.601023-1-swboyd@chromium.org>
References: <20210526025625.601023-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing slub_debug=- on the kernel commandline is supposed to disable
slub debugging. This is especially useful with CONFIG_SLUB_DEBUG_ON
where the default is to have slub debugging enabled in the build. Due to
some code reorganization this behavior was dropped, but the code to make
it work mostly stuck around. Restore the previous behavior by disabling
the static key when we parse the commandline and see that we're trying
to disable slub debugging.

Cc: Vlastimil Babka <vbabka@suse.cz>
Fixes: e17f1dfba37b ("mm, slub: extend slub_debug syntax for multiple blocks")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 438fa8d4c970..2f53e8a9c28e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1396,6 +1396,8 @@ static int __init setup_slub_debug(char *str)
 out:
 	if (slub_debug != 0 || slub_debug_string)
 		static_branch_enable(&slub_debug_enabled);
+	else
+		static_branch_disable(&slub_debug_enabled);
 	if ((static_branch_unlikely(&init_on_alloc) ||
 	     static_branch_unlikely(&init_on_free)) &&
 	    (slub_debug & SLAB_POISON))
-- 
https://chromeos.dev

