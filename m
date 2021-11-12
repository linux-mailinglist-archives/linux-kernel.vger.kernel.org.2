Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA5044E44C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhKLKCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbhKLKCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:02:11 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBFEC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:59:20 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so6321613wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AhKlfHzphx2/8bZHl8GbakU61baQlBIjh9PmLAH061s=;
        b=e1XGM/JbjI2sPC6MQRSLEyZx8WrhUmSYovlwYkOoHrjDt0u2Ou//l5ye/EDyZJDxUx
         D4M5WP78NfAAeA43QG9LVAJPwLgrAm3lpwmhExeZvuspVwuooLWs9hZr5UTa92dH+wYC
         WnndZCLQ06FijRZ2wTnup2SY8uk3ekDewaiOtmX1Tr7auYlHlrEg/+YToA6qJvMsFo8a
         ZDUzBnwC3Xusyj+XEOtc88QN0cNpIflwPGtNYezZ++UdqmUR654hmZ3po4JdrgJAGleD
         YerPPbKoRvXa9EvC71aBhq+uSGGWKTSi1JOYYB9XSmblgiCwRzRrcWHfveobX+EDkkAM
         dntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AhKlfHzphx2/8bZHl8GbakU61baQlBIjh9PmLAH061s=;
        b=T9sU93mTZXfbRmEwUJZRNf5d/zy691351e3A7TdEm0XaFVPijbTqfZMMiUlDe3VImB
         7zYQ+QTiqTubaLjwKksnLbVNjtaae134eFInMYTe+uCUYlYVBkVAKBeMj2/NMgk6Id8s
         9lZuTMCtmKLctjZPDCvPASy1D/aKFjImIcFyBA73jVib609TrPGAaKLSsYGvfTxWWvpV
         IY0IUOf/+eDAIoIjw2nEHsXkMiewL0o7sdLa+Id238Rd8bzmIyfLTbTgS9P+88e4L5cT
         O3krPMq4AcAhROT6qsPtR7Flw8UuXMjFjkFWxEg79nGZmT9ZvaMJsruAAn/jxqDNYzKs
         m0Tg==
X-Gm-Message-State: AOAM533d3fHw7fPVjFR1Lekp4uL/OXbsavjtJtPWE/xx436aZFyGY9HW
        toywrIApaIt33kADeeXby/XgUQ==
X-Google-Smtp-Source: ABdhPJySEl1bSBviQgxSsW7kq14s2owaQhZlL9Mgi4od+aIbYEmlWRciQr7gWPwZlD+jPRtZX+bOuQ==
X-Received: by 2002:a7b:cb12:: with SMTP id u18mr15652457wmj.109.1636711159380;
        Fri, 12 Nov 2021 01:59:19 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:a45a:ef8:912:ffbb])
        by smtp.gmail.com with ESMTPSA id f7sm11589859wmg.6.2021.11.12.01.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 01:59:18 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/2] avoid spurious blocked load update
Date:   Fri, 12 Nov 2021 10:58:55 +0100
Message-Id: <20211112095857.7016-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a follow up of : 
https://lore.kernel.org/lkml/20211019123537.17146-1-vincent.guittot@linaro.org/

It ensures that newly idle load balance will not kick the update of
blocked load if it skips the load balance because avg_idle is too short.
It also makes sure that rq->next_balance doesn't go in the past when
updated.

Tim Chen (1):
  sched: sched: Fix rq->next_balance time updated to earlier than
    current time

Vincent Guittot (1):
  sched/fair: skip newidle update stats

 kernel/sched/fair.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

-- 
2.17.1

