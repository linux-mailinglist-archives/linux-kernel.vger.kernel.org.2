Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6963CECD6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381625AbhGSRih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352238AbhGSQB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:01:27 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51461C076740
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 08:52:20 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 1-20020a05600c0201b029022095f349f3so155856wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QM74ugMzacAlnVWbIE3quBjawO9J2H34/reK2D0vNhw=;
        b=U5waj5mmqCD7YQ2C3D/e3gb4XYKNIora1djeGQvXQSIzDO2FG0etVI9DT4vA6AEPZ8
         0URrBGJ+7NA3SF1uI4czJsdFq1+/GX9P2A/QWpQgUeooD7+hd6G8g5xu+Lq/wJl24vWD
         8Z1dGzWuAwaO7u7JUwJCNZ8YeXVkqwXd4tZy3kdpsFGc3ILxI3grCHMNqPEPBS6I0Soe
         Bxlj+CISzvaSJpYeczQWLSsGWQfJYABnobHnExiZXX7fgBb+hGLkO2edDDUbp9PvbNOd
         +U02iktkeUkG7lNQN6EeGm2ULNmbuUfuplBkpuDR1be6gfSq8iE+Kbc+9J9uH0S5TyY0
         qTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QM74ugMzacAlnVWbIE3quBjawO9J2H34/reK2D0vNhw=;
        b=PQL9tuwnJAvo3Tc1QqbCBln13v9h2s4QeZRpenDMhcbn8IrT/C5wGBNVOjxtosUdWX
         At3lFbipZc8dJng/yt0FOhWtOSQNWq6VZCo/8QId6WT0oKFm3l4y8zaHK0NLqUA1cwes
         MZc18EIXwEpGYMhMA9k+LnZzzVINcmfz15AyoRySH0dlIffN2SlsIjv7vy07rNnIRLQF
         dc8u+3NgsX0nz3GadAd1UOgkwMEhmB0jS2toUO5b7KumOYSJ4FZF18QRQKC8dQSxax9x
         +ZN+tWX48q6vpDUFqNOo7wwiM7Kzr1Z1sIRizdjLD3UP+MNyUSgfMLsHxmiIbYJdq06y
         G3KQ==
X-Gm-Message-State: AOAM532yHQx9Y8PuaquBapKMdzkEfjZlyEAZBBzigSfpvoshgxIp7gE+
        vH45wdJyonw2q0z+ATkVJBdK0rvY3U8I
X-Google-Smtp-Source: ABdhPJyR37oF+Boi3AfS0qPsKO9n6Donw3P7Gjr8wqOBsWhMlk1r2s3ZA2g5Vo0PTzZMOosVIRhmYymSk3NS
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:83e0:11ac:c870:2b97])
 (user=qperret job=sendgmr) by 2002:a05:600c:4ec9:: with SMTP id
 g9mr26365905wmq.54.1626711418048; Mon, 19 Jul 2021 09:16:58 -0700 (PDT)
Date:   Mon, 19 Jul 2021 17:16:54 +0100
Message-Id: <20210719161656.3833943-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v4 0/2] A couple of uclamp fixes
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v4 of small series previously posted here:

  https://lore.kernel.org/lkml/20210623123441.592348-1-qperret@google.com/

I dropped the last patch of the series which requires a bit more
discussion, and kept the first two here as they're standalone fixes.

Thanks,
Quentin

Quentin Perret (2):
  sched: Fix UCLAMP_FLAG_IDLE setting
  sched: Skip priority checks with SCHED_FLAG_KEEP_PARAMS

 kernel/sched/core.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

-- 
2.32.0.402.g57bb445576-goog

