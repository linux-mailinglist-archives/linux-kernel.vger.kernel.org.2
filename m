Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B13E36E201
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhD1XNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhD1XNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:13:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D64C06138B;
        Wed, 28 Apr 2021 16:12:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l189-20020a1cbbc60000b0290140319ad207so7754736wmf.2;
        Wed, 28 Apr 2021 16:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=73UMy4DJugiy03MSOWMHfDfMtGqM/h/aAW2Ff60I6w4=;
        b=gse3lND6vmPWXDuLOR5ehuwQ0XBR83ulX3rGOrORaeEULAeWZqgRCmfJQ4JjAL0hLf
         NCm81SgUNuyTxbQ88jymxZWHu4fQJordnglru2dnb5QcGWJH3YBReaAe3KoqpTsIqU+X
         zbX2g0uZBY7kquDVSM6kmijVff0Y2iO7AhI5V1ZyMJu8AaqqwvXDY+Tt84vychD/dcbx
         yN9R6CF90mEvHbQVwkOpzbOOFSLBx0IiNmiX3aeFn8DPSU/xO3NiWHJDwiy61BfD9HXC
         Ch3YFsfyJeLs1vrCtFlX6IecsGcd9aEbBahdT0ZetOyP5BVJIpJfQN10EmWyhETht8pI
         w8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=73UMy4DJugiy03MSOWMHfDfMtGqM/h/aAW2Ff60I6w4=;
        b=Iybu6/XiB00GDBj4uv9BEaySN0FqWPQUB0xKS+MTpWoaZGbS2QEttmy6/iOtu/WHfO
         w/e8q+MqaI19DZGuKfvawaXPn5dQomZXY9hCO1U8zRp1zxhPcDJ5UA+eJm9/1Uu6IPam
         FqF2bXw7ipIwFdWCi/dk3JiQ6MtWKh0ZGaclLP1lqvw49nfO3ZctLBboY/dpM8hkh6Yq
         2Zzy4uoRWeuQbXw311XnGrW5vMCPJJx87bQUMt6jzWxrcyEg1dpG6Ur1hcLZehYxgs7W
         iWiPAtrZhpybNu0azKBG1/G8DJFh7lxwwkQ+kYRr1lAH0HLfC/dc1vnPU2KYs0BFWZcc
         JS2Q==
X-Gm-Message-State: AOAM530Wh4sQCesXrPxZz8velupwI8vZ8kaF9Bp7K0A+dGuXEdRY8dKC
        6WR0WsDEohR4cm7ZwzVgT3te9cN5jbjaikI=
X-Google-Smtp-Source: ABdhPJw7cwYkLxKN62xnunPPs5vhtnfKLl4A+GLB3wsvQY0fPMOLggkWX4DldwT8Hqo2R9rEPq/9cg==
X-Received: by 2002:a05:600c:3796:: with SMTP id o22mr6988775wmr.139.1619651550930;
        Wed, 28 Apr 2021 16:12:30 -0700 (PDT)
Received: from fedora.. (cpc101300-bagu16-2-0-cust350.1-3.cable.virginm.net. [86.21.41.95])
        by smtp.gmail.com with ESMTPSA id m18sm1756238wrn.69.2021.04.28.16.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 16:12:30 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     rcu@vger.kernel.org
Cc:     joel@joelfernandes.org, jiangshanlai@gmail.com,
        mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] rcu: Add missing __releases() annotation
Date:   Thu, 29 Apr 2021 00:12:19 +0100
Message-Id: <20210428231219.48109-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse report a warning at rcu_print_task_stall()

"warning: context imbalance in rcu_print_task_stall - unexpected unlock"

The root cause is a missing annotation at  rcu_print_task_stall() function

Add the missing __releases(rnp->lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/rcu/tree_stall.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 59b95cc5cbdf..18b2d5274d65 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -314,6 +314,7 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
  * tasks blocked within RCU read-side critical sections.
  */
 static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
+	__releases(rnp->lock)
 {
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	return 0;
-- 
2.31.1

