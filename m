Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176603E1284
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbhHEKWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbhHEKWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:22:11 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B0DC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 03:21:57 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q9-20020a05620a0c89b02903ba3e0f08d7so3902341qki.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 03:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=E+bvdWx1drc2FEFV8hKAnzU+DC5vzXuWPKzeSXz10zw=;
        b=RhZ4LcB7yyr8tTPU+hboS6wJm7zS8dAqGoUlU6cR/r25zaCg1rCHseLiF4+Z/VSADo
         L5yerIOB0Tt4wtJwTbnYrT+DdIw7MAAlGs4QmVT+j1z+lFGuKcwXzQEnoOuBrO8Dm8f5
         R+l+k6hIMMbee9RlFQgs1U1B6OLRlDVZyU04qU4SFXtSMeCimaP22KAdcJtsZ5gfEgXX
         cJYhUL/tsAxn67TAU7UlkuV7uKLH2SBQuONjfVh/KJO98lhhULxc1KIdFUtvTUSxJWfg
         r1EmplzAXhRjZ7i8jl9pBfunKSvldohjXvH/Z8N+GJ3XrS0TboZnwzZwfdtzByjFnHU9
         1aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=E+bvdWx1drc2FEFV8hKAnzU+DC5vzXuWPKzeSXz10zw=;
        b=VKYg4SOzJxD3eCleo5t0eMGdNiNeHE/C1EXPoQjToJIWML68HNcJPGoc+h5xuuwxyD
         cud+lND4ckt35/9rFPiMQGuJQRHxj+Tia+BL5wB64zGIpqCeSlWeeMA3nrLCLXblbN9o
         0xrkz5J5CN2SEZJhOPokli5WRzwIn4IyhBtAjgcC2jtYhLwBbPmRT8mDS0gYw5tNW1Ly
         E0eiFeOxMFi1He+FHzLIMUVFnqjSLsBd/AJJeYtbwz5JajL0OjC1RHj1pQH8Hth+LybV
         uaSEKUuWb08ZIfiKIxnTv+yGHb473vLXtPud2mL6AraFccD1w2ANkj+71Z0EjK2xO8nx
         ZDmg==
X-Gm-Message-State: AOAM532nyLxrvmspc+pQ70mq0m9fghOaDc7O+V0FoGAfDZO6f3cdBwQc
        yB8o2BBRBjYyj8ZBEEVEvRTkZroxO4uu
X-Google-Smtp-Source: ABdhPJzzt9ip0a2x5WisLHYFXak7p+2iOOpfqJtbGoInHi5puXss+vkBDtezTnAiusErgOdn611+1bim6dUz
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fd92:a1bb:45f5:2fef])
 (user=qperret job=sendgmr) by 2002:a0c:e44f:: with SMTP id
 d15mr4402792qvm.18.1628158916746; Thu, 05 Aug 2021 03:21:56 -0700 (PDT)
Date:   Thu,  5 Aug 2021 11:21:52 +0100
Message-Id: <20210805102154.590709-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v5 0/2] A couple of uclamp fixes
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is another round of uclamp fixes, previously posted here:

https://lore.kernel.org/lkml/20210719161656.3833943-1-qperret@google.com/

Changes since v4:
 - rebased on tip/sched/core
 - improved commit message in patch 01 (Dietmar)

Thanks!

Quentin Perret (2):
  sched: Fix UCLAMP_FLAG_IDLE setting
  sched: Skip priority checks with SCHED_FLAG_KEEP_PARAMS

 kernel/sched/core.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

-- 
2.32.0.554.ge1b32706d8-goog

