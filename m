Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845B0374E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 06:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhEFECy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 00:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhEFECC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 00:02:02 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D247C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 21:00:34 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z24so3680178ioi.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 21:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qBFb4Gxm9pm1HlMbQIx5Qf3rpxd+eVcwr0x66B3N+eI=;
        b=He23F1JAJf5cvLKZZwm4J2i6PwqFXZtEi/VDYSo3Q7PHwltzKOST72+2rA5FFe9A5k
         30vSJ2a/a8ABEpK7AF0ObJpQPl9koORi1ZGAuY5ni7CwF0g5E6/KNdrLjij60mkpYUWT
         3DyVrq5Z2gKd6L1vHp5io8JWp2U+SgsWB7jxHJUhgLjYlChuFBSeSMq4m+X4EPsa7Q7i
         gkgsj+J3uRGpORFRm7B5jDfMhDuz64HG6Anko1J1xst0hAlAoc8W4S+oKTXzU97YqHWJ
         NFkckVcklHS3zMf8NBgLUybnZcA3gtPFt7yfndMOW80U5DATvYF6EVyMhr/4JB4wpNNJ
         0YkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBFb4Gxm9pm1HlMbQIx5Qf3rpxd+eVcwr0x66B3N+eI=;
        b=sjfTcbc8LgoZ48QpBt8li0LHPgl2dOoL1caNojGwQSBAkFvowohSApVLPZ131XIpwV
         xEyS69NCUEm2GfzkILBWdUUxxwlJ8aWoWViGL3amQ9KEJ4xmYhUgQvlLlZM5Y6dtPDHr
         wpyMfqUsO1N1zg6SSHUwSE2YkKCTBYg0a44PEAmNukMmCLQTx0tQ4X0oS2LqQxXHy/+f
         lhTaGX9UyoqbOIah1QOiB5KmOjEGHXQANlYjBhnCjFDqUZPHMuKlav2zt+R9/0E650KJ
         VOr3lTFVSa7hci4WZ2qXzU56nIGQcNKbT7SCCEIaHvgrgJeVD2Ds1SvZi+p7wmAo7uo1
         ARaw==
X-Gm-Message-State: AOAM531EnLLcGM1WIIIrmcGHUO4Fr1E83NWSBinkX2gmUS6cBKkUEMiz
        r/KD1YG//JoPfXx5ibq92RQ=
X-Google-Smtp-Source: ABdhPJxdNvoKjOLnKBdp/ugnOxMDbSmjoBEUFzbvqKZHPw8roSiwLF91eMkAEyAm2TawlVnomS4npw==
X-Received: by 2002:a02:c912:: with SMTP id t18mr1888270jao.100.1620273633912;
        Wed, 05 May 2021 21:00:33 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id v2sm536918ioe.22.2021.05.05.21.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:00:33 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 4/4] module: reduce already_uses pr_debug verbosity
Date:   Wed,  5 May 2021 22:00:19 -0600
Message-Id: <20210506040019.1322778-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210506040019.1322778-1-jim.cromie@gmail.com>
References: <20210506040019.1322778-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

already_uses() is unnecessarily chatty.  For example,
`modprobe i915` yields 491 messages like:

  [   64.108744] i915 uses drm!

This is a normal situation, and isn't worth all the log entries.  The
!found pr_debug is kept, its more of an exceptional condition, and
seems worth a pr_debug.  I haven't seen it happen.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 kernel/module.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index c3333b45d812..dc1eda39ba96 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -772,10 +772,8 @@ static int already_uses(struct module *a, struct module *b)
 	struct module_use *use;
 
 	list_for_each_entry(use, &b->source_list, source_list) {
-		if (use->source == a) {
-			pr_debug("%s uses %s!\n", a->name, b->name);
+		if (use->source == a)
 			return 1;
-		}
 	}
 	pr_debug("%s does not use %s!\n", a->name, b->name);
 	return 0;
-- 
2.30.2

