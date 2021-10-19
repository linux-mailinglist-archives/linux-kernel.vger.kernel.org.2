Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E756432E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 08:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhJSGtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 02:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbhJSGtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:49:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2B2C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 23:47:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y4so13042189plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 23:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46hHnRr3YTPXmRk/mfEBr3Jwf0d6+QS6fhmqHfW8e6A=;
        b=BHp5YvdXcJepgmPn+D0oe6Lu+5rQwUdRi0VX3eDvmrFqcFmFWYfpH+cwVzyrMp2eoN
         ++HuHrI206EEBDMHvJvJ0KV3cRvX1w546b6zt2oFzRdWSXctsfrQKemZFnF8F8iVS2Fx
         PNPj4BTqBejwewbrnptSRveGXZfh0XAaRmTnLkOFutw7jkmfTc+S3FR98F4f/4nihxR9
         DCvpIBrNgpHnIXGzX8/vvNyaVttJPgyTPODcbk6Ehn4jIlh+EY9xiSEnczTObGA88IpD
         wdCHPpZNCgSWjrWwXDPoQLGUDsWqYQvCGn1qkMRJzBrLoJdlkVwxkMumVGE8B1vEpPDk
         ll8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46hHnRr3YTPXmRk/mfEBr3Jwf0d6+QS6fhmqHfW8e6A=;
        b=sQK3prUn7bMKuQq/i3hHhgHhzaTHiOXPJ3m07WyWH9qZHmg3Y5gxINFcCkvEoYaWJ/
         5jSH/iyeVxO5bEwSC4N/mUhIm17fsWKe8g12rERSUpbtzzWlSXcte1Saz25WYpzF7kSd
         5g5cKFZF02w2Lj/kbgTPypXUeypFheELfytQTdieSxZcvUXBL5wQyFU87AakSm4rFUY1
         dBEap38NO2WSicX+TX1wFqvGBPBB6yFbv5+15/VzJKQhSgL2GVYvem13IhHV1khmP7pR
         ZHpWVYvGd+RKOQif35h8El0MmP3xWBw/dZQ1y4lCQ0mQAdoVN2qjRgqeTQJexYOaFc8Y
         ldBg==
X-Gm-Message-State: AOAM532QtPySxGoTOewP7j3FO8w199nfOdoHNQiHj0HS6wcif0Knrf/h
        QeKkA3mDYEnQN6vgrcYDapk=
X-Google-Smtp-Source: ABdhPJz2FKdhfb+MwdRDo5LQrFoIasz8p1thrUImzSDOnJgmcLgYXSpLld26xLZg90uthycc2iZHzQ==
X-Received: by 2002:a17:902:bb94:b0:13c:9113:5652 with SMTP id m20-20020a170902bb9400b0013c91135652mr32365510pls.70.1634626040926;
        Mon, 18 Oct 2021 23:47:20 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f15sm2894205pfe.132.2021.10.18.23.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 23:46:50 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] sched: remove duplicate include in sched.h
Date:   Tue, 19 Oct 2021 06:46:21 +0000
Message-Id: <20211019064621.982233-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

'linux/psi.h' included in 'sched.h' is duplicated.
it's also included at line 59.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 kernel/sched/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5e82db2c2799..a5dadf63d92a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -354,7 +354,6 @@ extern bool dl_cpu_busy(unsigned int cpu);
 #ifdef CONFIG_CGROUP_SCHED
 
 #include <linux/cgroup.h>
-#include <linux/psi.h>
 
 struct cfs_rq;
 struct rt_rq;
-- 
2.25.1

