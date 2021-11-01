Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8105844146B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 08:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhKAHyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 03:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhKAHyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 03:54:44 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BD1C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 00:52:11 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id o12so4333623qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 00:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z8gd5eXoOO0YCcqvOnuBWJhDMDcVyBGcLd9YfvoYxb4=;
        b=qp6WVVobRiQ4EQb3DNpEpcfgEVFbQ4SZplGxv7MFEAD5AGFLgBecE2efxdIFaLLihN
         /WVAQZKUS6RpTA9UA5b0RzDamR9Yfy61TvbNlhXsP98SHXYCIC9pt/X5WM/6hhWvg38R
         FgAt2aAYl8F2eg4+jko+7JUUPGdfZbVwJyPp9nVLB5UINDhuTc7a2lTGEM0P4mBBiH3L
         hlguPtAFp/8io0sXCTczcccwF2uQFgVzEpTOYrzsARQ6bJ6bUxz8iRbT0VcXZ8nz0zPn
         rIyAdkSpSF9yiCnbe2G3LxTu9NTsyCb1PZbWdMGIoZ26T8wmisI8e2qymVQPMy5tXeGR
         MexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z8gd5eXoOO0YCcqvOnuBWJhDMDcVyBGcLd9YfvoYxb4=;
        b=Nk2FjL0N+IbfEtZX6JgvzZDbvxNl4k9iEg7DMpRhNDSjYBgxnrym1SJ1rfh+zvhAyS
         dT2NzNYTVQdgUEatFvU9DlHmFAjmHpU9tIKDH/aAHjShGW02uBsfj6ytoj14a5zM5195
         lRnIjgRqW8fIXPpV1+ZuT/43GHbMJjUpYNHWQFHoTsIQWWx/JKLgKnWVeKTVFELsocdJ
         oI2lZrhteKylm/zYxatC2hyhdlK71JosTly2uDVlrt+lQR8xdgWMXMdQfaV8xqsD7OWR
         60xdj1Coj71H/j9j5uvRWfTxLV4UxMiTx88dUxGwocsYLCqtty9Zql7Jx0DT0qApRqLx
         vm8w==
X-Gm-Message-State: AOAM531+qjxXVm2ba2gCa5eS56c7EkWt86onL9g34zV6tgTPOv/H/dQJ
        95t14vtOScWTwOCpqc3hgP8=
X-Google-Smtp-Source: ABdhPJxOx14zvRj0wc5ekFxCXobemjnhLgiQIgWQDCiFLXVU+DUcQf5HgtcXi2a+DRDhRBGbgs7rjw==
X-Received: by 2002:ac8:7f8f:: with SMTP id z15mr1276467qtj.32.1635753130884;
        Mon, 01 Nov 2021 00:52:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g1sm4495636qtb.7.2021.11.01.00.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 00:52:10 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     jack@suse.cz
Cc:     zhang.mingyu@zte.com.cn, krisman@collabora.com, amir73il@gmail.com,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] samples: remove duplicate include in fs-monitor.c
Date:   Mon,  1 Nov 2021 07:51:52 +0000
Message-Id: <20211101075152.35780-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

'sys/types.h' included in 'samples/fanotify/fs-monitor.c'
is duplicated.It is also included on 15 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 samples/fanotify/fs-monitor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/fanotify/fs-monitor.c b/samples/fanotify/fs-monitor.c
index a0e44cd31e6f..0a5f742a77a8 100644
--- a/samples/fanotify/fs-monitor.c
+++ b/samples/fanotify/fs-monitor.c
@@ -12,7 +12,6 @@
 #include <sys/fanotify.h>
 #include <sys/types.h>
 #include <unistd.h>
-#include <sys/types.h>
 
 #ifndef FAN_FS_ERROR
 #define FAN_FS_ERROR		0x00008000
-- 
2.25.1

