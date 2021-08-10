Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A93E55D7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbhHJIsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233034AbhHJIsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628585309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PKUTk+76laugq4Cr2nwyksE4Heb04pD9E5SNbJNctsA=;
        b=UG6URQNx34V2H1IjPgI6xFkUJAf0uPlvfjWMOw8b1WXga4iVJ2j3pjbElit1Y3Ac4eRzdz
        zRqvz6WSM9zx7iDX/s3rlMmRadPU5/XUX+ka/fZ4D4yPFxJ65HAhbBEP1uYSIQg2ufZY2Y
        qghJV75Gyj+8NSdixBkcVOOcvKTUqRQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-Y7UHykcnMg2-9_PL6_KC-Q-1; Tue, 10 Aug 2021 04:48:28 -0400
X-MC-Unique: Y7UHykcnMg2-9_PL6_KC-Q-1
Received: by mail-ed1-f69.google.com with SMTP id d6-20020a50f6860000b02903bc068b7717so10463138edn.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 01:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PKUTk+76laugq4Cr2nwyksE4Heb04pD9E5SNbJNctsA=;
        b=dKARklbn1TJeezlIOMiJkMVOd5UvUOasktsCFVE8Rk3TpjvLqXQk6YXm2+OZ3/5kt/
         hJvqxyiyAkttaC4jVcvKiK3Q3RhkFNkz5lcmKbKswO0/qC8RMpYuEakuAGlMWnQHyR0P
         /VrNBZN5Bdz125Z/rzTq4hDLkndtjiMFeV3CUqYF2h++onai9Rs9BRyZvQNTG+s4KtmO
         cyPaarF3lRH2R3EA6qD9CZ5irTphFR6OuWOu8rMgt0h7KyyrjTzBG8ExGmhQkdlqRgaM
         ATInnCBZYBeVeU7joGLv4k0DfWtyOum8QlVjlRVmRJZWnGzW87iq7fRF5zovl2hVWFX9
         uG/Q==
X-Gm-Message-State: AOAM530qmTPbu5Jpuz/ddLI+uWnGcSDXB4eb/Ke2cxRiWW4Ewdu0/vN0
        eNnd/sPKoxMiPMzlXyW/jsdKl7UQN+TOxIXoeVdDhgBcPcDshQJsYb46K4vDZSDfwALMsJE4CVz
        wqSyv9GT6kD4Fr0L3NpS0b25O
X-Received: by 2002:a17:906:cd02:: with SMTP id oz2mr1164212ejb.227.1628585307150;
        Tue, 10 Aug 2021 01:48:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyheDIpLjXKFM5u8jw6L0eI1kwX1Dc7r3iPjoVrOT6gQ4QtZ8X7tCUI7yirfMTRZQ9clwv1nQ==
X-Received: by 2002:a17:906:cd02:: with SMTP id oz2mr1164195ejb.227.1628585306983;
        Tue, 10 Aug 2021 01:48:26 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.52.108])
        by smtp.gmail.com with ESMTPSA id la23sm6557667ejc.63.2021.08.10.01.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 01:48:26 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     paulmck@kernel.org, josh@joshtriplett.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, bigeasy@linutronix.de, tglx@linutronix.de,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 0/2] rcu: Make rcu_normal_after_boot writable again
Date:   Tue, 10 Aug 2021 10:48:14 +0200
Message-Id: <20210810084816.155203-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v2 of a proposed RCU change to make rcu_normal_after_boot feature usable
on PREEMPT_RT as well, as it turns out it's useful on RT as well on
NO_HZ_FULL configurations.

v2 gained an additional patch to revise rcu update module parameters
permissions (as suggested during v1 review [1]).

Changes wrt v1:

 - Restrict the option to !PREEMPT_RT || NO_HZ_FULL (Paul, Sebastian)
 - Change module params permissions (Paul) (02/02)

Thanks,
Juri

v1 - https://lore.kernel.org/lkml/20210805080123.16320-1-juri.lelli@redhat.com/

Juri Lelli (2):
  rcu: Make rcu_normal_after_boot writable again
  rcu: Make rcu update module parameters world-readable

 kernel/rcu/tree_exp.h | 1 -
 kernel/rcu/update.c   | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.31.1

