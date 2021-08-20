Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67443F2697
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbhHTGBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbhHTGBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:01:42 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC6EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:01:05 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c10so7272784qko.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K5xyNIusVc4BrqPV2ok4Rq2VX+MqoQcEpsqZpDiose8=;
        b=ayDUzvNkqOaAmm4t1htQnEE8nyiv2it2eDt23GDeoUKsZJmWldIF7vyhmcMe5eh7Da
         Cm6e3bryMjxLwIFc9HV0JKRyp3LRfC7QnttkVz+/eX+9aVPf0rTxzQZj64JXF0r0x/6C
         fIL7qkchLQHKmSwRAuYsp8F7imDLBKOeKCIfDcJEwhRJTcMB8OPm4Ch4pV/5w53XP3QV
         1z6C7AWJCxsfJ+zTbSjlzSfY/U1DCsMADGFE/8yYxkaOU/AVH5Uh/RECKkBGxFRq2IoY
         llBTD5nXA9U/VN1KZ8wJw2hsBCERg+nvW7LhMe6R4T7n5On/LcD9TkzRNZFFYlvLYfzu
         RUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K5xyNIusVc4BrqPV2ok4Rq2VX+MqoQcEpsqZpDiose8=;
        b=dSkRgfgVLJXmDz3fLnvgcUyVksoU5ZZ/eJtg/m2yb6u6ZW3yIwkjGR9P9+HcRjm+bf
         RCli27GPnr2sNwCgxPm4JzNBWqgP5bZIg2FEtqB6NrTGHyxLfzR1pD2bt1f5gX+SWNH7
         93eSrih3GlJU/2X0FJuXWVM+XhpgcUjcjWa9ZlsbvHVoNa2sBGFvV668ijy7h2IV1Rv2
         +Nur8gl7B0YDcFcEAYLQssl/5SUumjuvaR66lHX42Wd4VTeDd9LsfUMPk6D7Oq6c2yBL
         pC2+9Gmq8+erO+Qzq83DBhHCQn39cd460iycYGPoKgyaSax89jWLyoJyKgJD3KZZG480
         HKoA==
X-Gm-Message-State: AOAM531kNVZnzKShQnne+nHxJK1rzk8FLB6a5REVC5o8E0ajIxjBYDnR
        xgolleNX0px0UKVeBFxVA10=
X-Google-Smtp-Source: ABdhPJy/34L7ZzIh7I2JU7O70aJwZoCtQUbtXJNSrOKZYZReoQ8au71xNgGatP6HHXUMNX3JdHh2Sw==
X-Received: by 2002:a37:a094:: with SMTP id j142mr7296283qke.465.1629439264618;
        Thu, 19 Aug 2021 23:01:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m19sm2160053qtx.84.2021.08.19.23.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 23:01:03 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Viktor Rosendahl <Viktor.Rosendahl@bmw.de>,
        Colin Ian King <colin.king@canonical.com>,
        Xu Wang <vulab@iscas.ac.cn>, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] tools/tracing: fix application of sizeof to pointer
Date:   Thu, 19 Aug 2021 23:00:43 -0700
Message-Id: <8fd4bb65ef3da67feac9ce3258cdbe9824752cf1.1629198502.git.jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jing yangyang <jing.yangyang@zte.com.cn>

sizeof when applied to a pointer typed expression gives the size of
the pointer.

./tools/tracing/latency/latency-collector.c:1541:10-16:ERROR application of sizeof to pointer

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 tools/tracing/latency/latency-collector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index 3a2e6bb..64d531d 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -1538,7 +1538,7 @@ static void tracing_loop(void)
 				mutex_lock(&print_mtx);
 				check_signals();
 				write_or_die(fd_stdout, queue_full_warning,
-					     sizeof(queue_full_warning));
+					     sizeof(*queue_full_warning));
 				mutex_unlock(&print_mtx);
 			}
 			modified--;
-- 
1.8.3.1


