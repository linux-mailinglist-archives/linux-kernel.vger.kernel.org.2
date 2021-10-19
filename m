Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D38433065
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbhJSIGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhJSIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:06:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A723C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:04:17 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r2so18608919pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 01:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cp+nPN+4XCz08RVhB682nBTlBEh6Qg2vTKAOwaCsPjc=;
        b=AmxA8hSIN0SgMQOw9eaNzAka2QeREILotcNaP9lMID5PaKA81W5nJJAjxwcVLFUaB5
         MHl/Ljdm4PvmgzV5w9wo4RXGEqirf4jWkuCMzA7MIvh+eqWVsDIFYHCg6Lx0aAr8KLxK
         qLSktlx8yNGleZjOmBQIhe1BD0o9ia7tCzz2VbdDlYbLYMBD6R56ef7/B5FTWSC/th61
         c1MnjT7IJ/0pL01KtTOl2IIHfE3z47+TpL0suaXTXd3LvNuiehnhwRRm59a02Pq+cUmP
         J+QXBf0bWSdP6S8g1n7KKwSBzXi8ETOgu0suGCJQzUtJ4n3NzZIqOsDFc55m+MFaO4A1
         ui3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cp+nPN+4XCz08RVhB682nBTlBEh6Qg2vTKAOwaCsPjc=;
        b=F270sF+T4G0X/7g/+J/ujeMB9ZvygObQjFnoqTT/Ba9Ym7Qx+P7o6RG1F4n3RvrKWs
         bxZvze3Dr91CTJiGKEdiLY+f5yCmya/oTa3PE2Q73WnEkP7NdAIvmK/kfRCND819p+UW
         SqUdSx6DPvdeX36xsA/HgzTgLQgmLB49e9+tuZdF6TEcfIfoeyew9uek4c7Mi5DgD6F/
         x84Z7btwiiDniJC/kEJT2RlweaP8zk02ML2rn3HKoUq50SVbn0VddH1hSyOFw4jMHaTk
         ZEta+rD1wcKoN041ICSyu0KguIuFHH0lNTcqa6gtftkwo02mvtj3nmazCmW7r/G447Qw
         jVFw==
X-Gm-Message-State: AOAM530mYf0zUxEVhyPR8bo0kSkqQdjdUiiS+TA3hzLIr/ICtQTiZKMp
        8iYjx1Ai/xtKTJIiShZELKI=
X-Google-Smtp-Source: ABdhPJx5q6GC+eZIq67EITVYpDncLZW+ekabCXR5HpHiXJoQ+Pjrc9SWlz48WyiZEp/IcCr4cBzrsQ==
X-Received: by 2002:a63:6116:: with SMTP id v22mr27493945pgb.225.1634630654127;
        Tue, 19 Oct 2021 01:04:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y22sm1700921pjj.33.2021.10.19.01.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 01:04:13 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Ran Jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH binder] binder: remove duplicate include in binder.c
Date:   Tue, 19 Oct 2021 08:04:02 +0000
Message-Id: <20211019080402.993974-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Jianping <ran.jianping@zte.com.cn>

'binder_trace.h' included in 'drivers/android/binder.c'
 is duplicated.It is also included on the 6026 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ran Jianping <ran.jianping@zte.com.cn>
---
 drivers/android/binder.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 26382e982c5e..19f6247d33f5 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6023,6 +6023,5 @@ static int __init binder_init(void)
 device_initcall(binder_init);
 
 #define CREATE_TRACE_POINTS
-#include "binder_trace.h"
 
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

