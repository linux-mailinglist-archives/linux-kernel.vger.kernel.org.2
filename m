Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946A83FC4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbhHaJWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbhHaJW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:22:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2890C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:21:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m26so14492809pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44UO0xEw3VXiQ6bhQ7qA+cut2xomVvEwS3t/fwSgC0U=;
        b=WiDP0b0Llj8nohphfpXVhc3wKciurzf6XdAE19S0vSaoGQZcNw/hbC1LXB4Ob8OHZv
         TvTDwn0MavW+bWKoWN0a8yn7FNHSmmRvRJVKJY3UdZyjWYGpXcJh8UnSEqKBtGvwwJ4X
         Oa0yOiKZ9gX/AHvT1Ps11Ks8wSYkfaEfvwsnyVXLHyabYz/zS2QLQYjn6Am5QwhqH+7F
         7agW+kWDg6XLsmlpG80Tij4r3KR81MCAvYR6GAQTDneSRfOMkEc+aakzYExQ4knwXgXr
         DzqL3CcwMAVFnS7Uk3e0LDYGmIZNN8tvw8/IyLoAu75u0FNVzAnbXi5mdRK5PNSnt0RX
         8mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44UO0xEw3VXiQ6bhQ7qA+cut2xomVvEwS3t/fwSgC0U=;
        b=TMlHOZ68Ni4cfAxB7AfUYM3NWt9HUtqz5e0LmZ5OHr3tfzGM89RE3qNoJWANifiL+F
         h4sdnIcCBQDGTTH5WHKtliWKV+0VQ/YVMAZignXRGFvfctpl1yqTjLlHCf515jL/191G
         sZ7yRTAcybnoWC1P4TIyAF3eI2VvmHmKPm9bzr6uJ7ErsgA4I53sWLe9gZKFi1HMPRlv
         CD3C6RuJlS9H47++PR/RGQbeNcn9rwxc4XMyjN9IO5WNNmmb2BKoG1Nv3HfNDs815U43
         Ijs7kmdcYteuy41vP73Z9FzLTYWqI0S7vexbMG20PvkiicsB250pYCqKWY6+5fALXKa/
         UDdA==
X-Gm-Message-State: AOAM533LFn4xXWKYRD633z2kznUOv0yyIs9XqdrRnKJhvZ3WzkPaEMO8
        Xq9HGYcROOs17exnoSamiF6U5s/OuUM=
X-Google-Smtp-Source: ABdhPJw7/Y5YisCYs7PlqhDldGkq5ZZ1RxcYJJDCS+6iyEAxIEn//L963mMfRpbxUTgRMouAm8TgJg==
X-Received: by 2002:a05:6a00:787:b0:405:700b:69ce with SMTP id g7-20020a056a00078700b00405700b69cemr1863016pfu.50.1630401694372;
        Tue, 31 Aug 2021 02:21:34 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c23sm19959506pgb.74.2021.08.31.02.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:21:34 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     ccaulfie@redhat.com
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Chi Minghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fs: dlm: remove unneeded semicolon 
Date:   Tue, 31 Aug 2021 02:21:28 -0700
Message-Id: <20210831092128.15981-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chi Minghao <chi.minghao@zte.com.cn>

Fix the following coccicheck REVIEW:
./fs/dlm/midcomms.c:972:2-3 REVIEW Unneeded semicolon

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Chi Minghao <chi.minghao@zte.com.cn>
---
 fs/dlm/midcomms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 7ae39ec8d9b0..aa4215388b62 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -969,7 +969,7 @@ void dlm_midcomms_receive_done(int nodeid)
 		spin_unlock(&node->state_lock);
 		/* do nothing FIN has it's own ack send */
 		break;
-	};
+	}
 	srcu_read_unlock(&nodes_srcu, idx);
 }
 
-- 
2.25.1

