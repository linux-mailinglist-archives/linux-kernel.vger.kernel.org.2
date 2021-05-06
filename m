Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06C2374E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 06:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhEFECK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 00:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEFECC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 00:02:02 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A0C061763
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 21:00:34 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z14so3640108ioc.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 21:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dh58j6GU7M0CphLn4oKBpvl0eQmlpPoFOL756w6uKi0=;
        b=R+oKZBGYMV+jnmbb9Ew52fgqLytUD2T4kWzkjZ9sZuIR4dw46uhEaOp/WqYbUNOGKC
         BMxTFbGpQ8bV+xPMmyGQE+IGir9aDJRdLDAvAh2lJCAMym7aqoOrNvcq2aFaemTomegb
         i6ATSQM8j6k4g0qXFwoqfDUQOBoMTgdiVLRIGTQCCiglBgQVGUCF4/3wEYeqb3V4jctc
         RQDEwC4OXNWP2xmqtqrKyqpRZW3M9G0bobE0Gll8rBr6MVj/h5Ivi4IVMkXiNxNU8LDG
         bd3nn5NRuUWX2GNha9HFsxwHEKdagr+aCjS5YC7J7gMm8evIJathsfE103Vui30LSDDt
         Z3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dh58j6GU7M0CphLn4oKBpvl0eQmlpPoFOL756w6uKi0=;
        b=uehLslQ8lSV7LMLBOLRRL0eNQZ+AWvffT2BtNr7/+wKkn8IcT+lH7XHHBf0sHjrGyu
         tK/XLQYi6KZBu91drv7GK7CDIr9sTcQQ7TTc4sTbJr2GDjtiUK7Gca61O2fzQ3ZAIy/O
         /lrGCQlMybMovM2U0yLPtITMbV1rE6Y0jWGm0DfM/D1UWxZMRmxouPDvN5nkYD/9ZBkN
         KVEY5Xd8WWE/N1ILxFKtQu2cOxUP5sppJZQD/eyAGWEntVxZGfcEBPuMpaS7kbDWteJY
         lASpaw5d5xE6BW3qhsm1tlDB41PpMYt827SSRVnvkjFiLIfOpYmGAhIsNKO2rX+f5cUs
         OWCQ==
X-Gm-Message-State: AOAM5320CQgKjNvQJQAE3+H6HAaJPDwEbbcdLOSMDUqexGMOQFZbKPO/
        M/O9Tv2QMSzHnv9I77e7MUE=
X-Google-Smtp-Source: ABdhPJz4DbKwe73N8peeS6Yl6aODUCUbXpi++TapxHPrFroPtGyjEFxw/CRa2LcXrTnZzrsgcV3LIg==
X-Received: by 2002:a02:6957:: with SMTP id e84mr1911978jac.96.1620273632778;
        Wed, 05 May 2021 21:00:32 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id v2sm536918ioe.22.2021.05.05.21.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 21:00:32 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 3/4] module: add section-size to move_module pr_debug
Date:   Wed,  5 May 2021 22:00:18 -0600
Message-Id: <20210506040019.1322778-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210506040019.1322778-1-jim.cromie@gmail.com>
References: <20210506040019.1322778-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move_module() prints "Final section addresses for $modname".
So lets add those section addresses to the pr_debug(section name)s.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index ab16b8da2555..c3333b45d812 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3393,8 +3393,8 @@ static int move_module(struct module *mod, struct load_info *info)
 			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
 		/* Update sh_addr to point to copy in image. */
 		shdr->sh_addr = (unsigned long)dest;
-		pr_debug("\t0x%lx %s\n",
-			 (long)shdr->sh_addr, info->secstrings + shdr->sh_name);
+		pr_debug("\t0x%lx 0x%.8lx %s\n", (long)shdr->sh_addr,
+			 (long)shdr->sh_size, info->secstrings + shdr->sh_name);
 	}
 
 	return 0;
-- 
2.30.2

