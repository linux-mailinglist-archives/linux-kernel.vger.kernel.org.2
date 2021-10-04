Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653064214FD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbhJDRQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhJDRQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:16:49 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48237C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:15:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j10-20020a1c230a000000b0030d523b6693so9766099wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0lwQTmpHIj3bHhzvrvqOdN9uxdOqA9WytC341Pcda8U=;
        b=LlheC/KmVIXzDKHaU6QeljcixiV6jXam5aO1yd7U8/0yUwAulT4jhm7/BQsbI96c11
         QFlR4CLNOP0SsZyRFz7Vy14u5vy7bE5qD8E8w7HY9d9lCyYXQqd8jjW+IE/Clab5Rx8m
         iR6HC8pKjEobDRiTgOnG6x/M5rdPCFQFZRQZZkoq04UcsunMuirBP0gJFUSRcQRPKqA3
         1UG7ArdZ5vlBotVMpf0jjx1GL9ITvG5MX66pMxQe+Vj/cWsdlgadOgPS6bzLQ3b9UVmc
         72pEo9xzjTcbkRKs5KrKbvQCopm5Cnb8oUu75JNJmGbzpUtKbQ0w6wQfsm6y52/aNr86
         lD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0lwQTmpHIj3bHhzvrvqOdN9uxdOqA9WytC341Pcda8U=;
        b=pvkXl2ze9BO6JI5Pao2rIkGcWPJDQsDOUJx07DM6RSWioeIx2ld3hpF+eODkjdC+K/
         5G78KRJXJpCBQrR+39slxVnc6hOvR+5nljl7L3plyVrohqVuk1KTYGx7BrkgAh/N6RMc
         DX8QJ7Ici3lBq9TZJQmARBLQ1J/DhoLZaYGCO3exwzsOoa6FtqEZCXN441NoCpKmyiaU
         0j5ri3aPgwJOD/hvKL2OqtNKgTNrk3vAQjy/KPTBpD5QbFaNZ/nyq4zGxyU0J0W5K1p3
         6D3NN72yUTJqAYN2EZC9d5sxokDfGozSWW8xUP8/ooK5rZWHbCHcGNkOBdP6kZBjv9eL
         lF7w==
X-Gm-Message-State: AOAM532KCv3uhwhVOIIdf7fEAS5FGkTK4s8hMbFMHoAPtwMFLDldhUrN
        Cc807ZUM4nbeQ2hpsOKPLofCDQ==
X-Google-Smtp-Source: ABdhPJx7mE1vdTSXxtoa81m6rLu1g70MH7+WLqOFUC4jZwsypVRkrug7fKxTtCbPIZSprU4Yv6qhuQ==
X-Received: by 2002:a7b:cd13:: with SMTP id f19mr13743716wmj.109.1633367698808;
        Mon, 04 Oct 2021 10:14:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9c40:6a4a:bd46:e324])
        by smtp.gmail.com with ESMTPSA id g25sm14833116wrc.88.2021.10.04.10.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:14:58 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/2] sched/fair: Improve cost accounting of newidle_balance
Date:   Mon,  4 Oct 2021 19:14:49 +0200
Message-Id: <20211004171451.24090-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the precision of the cost of newidle_balance by taking into account
the time spent in updating blocked load and skipping load balance loop 
entirely if there is no chance to run at least one.

Vincent Guittot (2):
  sched/fair: account update_blocked_averages in newidle_balance cost
  sched/fair: Skip update_blocked_averages if we are defering load
    balance

 kernel/sched/fair.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.17.1

