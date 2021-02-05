Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFE6310AC3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhBEL6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhBELtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:49:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4A0C06178C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 03:48:36 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id t142so3616642wmt.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ip5GCw06Gzl+nEE/t/9+El0uhHaoc0zXCg14zT0geNg=;
        b=gmRDbVrETOXralM1PXBQmb1CfHhNq3tI8C6syZDZgEgAOB2ncStdtyNDaHBwm+67fe
         j6blbFOAaFefsDj1TwS2JmF6gIVICEzo3IJ1SequavsRAExzrbHhQtRenON762R3tfnU
         ekKoNiZe6TccjcpFSZpaFu7AGZLoASPTHkBmPY1HRbnhtmqV6BdplF4KdqrbMk70BmJb
         DfD6HYgvlflKvqMVRzvy0H1GTfDuVrMpwyJyPzZ7SMKxGM8aVoLCPxkQRbbzl+DymkMN
         R/Ogs8NhPspXgF2hHzxOq1HWSRiUHS2//eG7cZlEnWmWGkWDa4OlP+gXcU+bDt6rUtj6
         QBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ip5GCw06Gzl+nEE/t/9+El0uhHaoc0zXCg14zT0geNg=;
        b=djpNIPHcNz1eCEd7Uq9G74c98MgIgGx013I+4FXOOCxG1HRyhBjL2HwaX1P2VbsvLe
         GhmuobIgSP+OLOw8Lt2YJYEtu/SrfP1QYP4IddslqnPyN31ODq0+zaHgGlQ3ElweY/Cr
         HNiLLgt+0nLAEyjSXBm0k0b3JYDJa9Gacwt7SOKx+hBoaZUhGY0Zw02xAqiekHVIjmvm
         6WKup5rhr6QeYM/wFY1PA0gKYI1+6EzVEh7/GE1XgIf+mjMCOTpwNiInUVXM45Vv0kdT
         Ru8tMeImH9HpJ70wrl0AE38PI05fiFVfSd0mN+jVnHp8L7O/qVPRP4OrV7wqxGf3IxuI
         Ja8A==
X-Gm-Message-State: AOAM532Op/0cHHXBYGMTCrU/N6QBRCaUI7znnYSZanNvZi8C0erVeUul
        iTN+YbMZr/Rtscg2x/T2qA7GRw==
X-Google-Smtp-Source: ABdhPJzXupm0BfLGnk0YynSoMaBKjxlMf88RICl/lwAjkoOcnVE3Zzv75QwEVw3HTpBxZb7aaYlaPw==
X-Received: by 2002:a1c:c242:: with SMTP id s63mr3324220wmf.9.1612525715142;
        Fri, 05 Feb 2021 03:48:35 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:442a:8956:28be:e500])
        by smtp.gmail.com with ESMTPSA id z4sm11647586wrw.38.2021.02.05.03.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:48:34 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, fweisbec@gmail.com, tglx@linutronix.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     qais.yousef@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/6] move update blocked load outside newidle_balance
Date:   Fri,  5 Feb 2021 12:48:24 +0100
Message-Id: <20210205114830.781-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel reported long preempt and irq off sequence in newidle_balance because
of a large number of cgroups in used and having to be updated. This
patchset moves the update outside newidle_imblance in order to enable
early abort during the updates in case of pending irq as an example.

Instead of kicking a normal ILB that will wakes up CPU which is already
idle, patch 5 triggers the update of statistics in the idle thread of
the CPU before selecting and entering an idle state.

Vincent Guittot (6):
  sched/fair: remove update of blocked load from newidle_balance
  sched/fair: remove unused parameter of update_nohz_stats
  sched/fair: merge for each idle cpu loop of ILB
  sched/fair: reorder newidle_balance pulled_task test
  sched/fair: trigger the update of blocked load on newly idle cpu
  sched/fair: reduce the window for duplicated update

 include/linux/sched/nohz.h |   2 +
 kernel/sched/fair.c        | 100 +++++++++++--------------------------
 kernel/sched/idle.c        |   6 +++
 3 files changed, 38 insertions(+), 70 deletions(-)

-- 
2.17.1

