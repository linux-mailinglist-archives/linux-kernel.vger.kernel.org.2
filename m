Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B693F24BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 04:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbhHTCZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 22:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhHTCZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 22:25:40 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B42C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 19:25:03 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a10so558948qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 19:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e12Fdj0H/GzNvYiPmXkZR9coJxYkGDOj8wc4ZBlhff8=;
        b=Vk5qUmT6JpyL0tQl7SYZTk25N5BoXeC9/+yEfiI+yRMOmQmU0UOfwi5d76NOrjoKWE
         4DvR9WCNUPYFWxfF2VXDZOMqo79zWdvt1APShnn2yg5OfgTVH+fDGiWa7UxGIpb/1yte
         wU1DKoiqDF54JqjTay3sM2DsT9zRO7DKFAFEmektQAx5eq0SpPedf2pns2wWP50Wy2J3
         lpw7hc5bsk5AcF3VNcCnG69og8ORqph4dzlpS8FzFEp1ZbHmGu5w/PU5DifqT3Nl/QXz
         +jcaTmx97QoqyiGd4APkSKd0fj+ynBoLXq65mHFvu3yT/rxR4tzrFUrOwwuBD19/tsW+
         xEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e12Fdj0H/GzNvYiPmXkZR9coJxYkGDOj8wc4ZBlhff8=;
        b=JdBFFw5yS792z2K7sEtn2vlwrAvPJZUzJtRixdptQUPPkBlc5lkv/MtaXPtzB3AJ4k
         xz/8/NXYkwtFYPuP4jnQFZkv6Xi8koBLdNWvZ6QH+PBrhjp897/KLar0UwoH93CTWzqd
         ukBbymqbAgVNW46briSAVq2zTPo64B8etWFUMQZSPniqw6l0pd7GjGKoK4aytQRivlYK
         t/l2WHc0+8Ivp1LpxSaxNGOJO7Ss+lsR/ldmz0fML+dUzuWx7ZxpGMjFEFcEUzkzhbQe
         iSH1BLwz1PDd/ioCe3eNMNecogvzuKNwYpqkYow9SS9uRTLvnnTs83pP9eW5/p9aolvc
         8fxw==
X-Gm-Message-State: AOAM531Qj9+nMcd2vZLOt8d2k2AlTIpV2lGoYJTTN7sNkHOglEnq+6VU
        iUON7NRpwaskRTGYL/k/x64=
X-Google-Smtp-Source: ABdhPJzMvF5SJh0bN8VWKI3dxiY8iD94/z4UdRgqg5m1jG4vlfCimhoAUS317AsU7+zc0xyp3H0QjA==
X-Received: by 2002:a05:620a:1525:: with SMTP id n5mr6726722qkk.386.1629426302750;
        Thu, 19 Aug 2021 19:25:02 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d26sm2586626qkl.6.2021.08.19.19.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 19:25:02 -0700 (PDT)
From:   jing yangyang <cgel.zte@gmail.com>
X-Google-Original-From: jing yangyang <jing.yangyang@zte.com.cn>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        Stephen Zhang <stephenzhangzsd@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] debug:kdb: fix unsigned int win compared to less than zero
Date:   Thu, 19 Aug 2021 19:24:42 -0700
Message-Id: <20210820022442.11107-1-jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warning:
./kernel/debug/kdb/kdb_support.c:575:3-10:
WARNING:Unsigned expression compared with zero  p_state < 0

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 kernel/debug/kdb/kdb_support.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index c605b17..fb30801 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -560,7 +560,7 @@ unsigned long kdb_task_state_string(const char *s)
  */
 char kdb_task_state_char (const struct task_struct *p)
 {
-	unsigned int p_state;
+	int p_state;
 	unsigned long tmp;
 	char state;
 	int cpu;
-- 
1.8.3.1


