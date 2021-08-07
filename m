Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4CC3E357C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 15:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhHGNQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 09:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhHGNQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 09:16:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D3C0613D3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 06:16:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k2so10983594plk.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 06:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5VslW/KJhGR1hgoioQTC7YzdiNBJwKXBb66br4BQVcE=;
        b=MzokAjOR57IptmHLvXeO9f0ki1MKD0b6K4EOXfjOXFcCgl/E0YdeQAiPwFYlwCZeTj
         bB5rCRJgPNGaT5ncdr7lUugULVJT+CvwoM1vhKnP7jo+E3pht9vNrpJ+uNG2lQlPYSOS
         ocdOB04SxGAMjUEKRwf0uRc1kvFRXmCE72FRJalVE6BlN8nFGWJH7XQaapcJCiXrGqso
         MLOj/uMrQeblSvgb31J2g3OzwmbwYE/i+MzAjKNVgeIVaCMxNj4MUTTm9rvJLjE0VThJ
         gye9a/wk52z2fGKkS1cqBMeZIG4/SLRP48/Hr6owm1POPnkNqU5oReUvWUE0VaewzVdC
         t4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5VslW/KJhGR1hgoioQTC7YzdiNBJwKXBb66br4BQVcE=;
        b=VECCGmS4Ml6t0eKVO/EKACFFns2RnAlFiB4+8fXt1/QvpvGlc5Qp4cJiDeoJGnYssB
         VYarLtWtLaYhNah96Q3ixzX6igVzHqxO2ec1D9lM313jTFZikVNCwgi3zZlNxrLaBukJ
         69EXWIpDzbnbkUr8CfeoHPGEae0Zudb+gobnjOUDES95ZI1wTRPxePzPecPWy2LQBmB1
         fHhM5L9vzlI1bZDUayZOHGXLPTL11WfUh3NUHd2bG3Bjgp61NxJcsuWVC2BA+kcaDe+X
         3q0tCyyaRe6pdRdR7RfzORWPxQ0FbPARySBMho/hgGxiEpLKz7RfVhXk7WTL4xeHf3ct
         iRiQ==
X-Gm-Message-State: AOAM530MRVGWfVotCwyhWZwScgmcUxRngMQzCfBInKOKdCWhao9pyDI6
        x+VFOi+lcLNWLfC6PC9gjCRJFZerrys=
X-Google-Smtp-Source: ABdhPJxq53LmYTSpPB1Ae5YmggOUcCuwgNcW5vvzr8vXrBsPXoOEF/Zqh4o0Y+Fq8xzitSTyV7pfyA==
X-Received: by 2002:a17:90b:3905:: with SMTP id ob5mr15754299pjb.211.1628342169562;
        Sat, 07 Aug 2021 06:16:09 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id t9sm17720014pgc.81.2021.08.07.06.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 06:16:08 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     akpm@linux-foundation.org
Cc:     chenguanyou9338@gmail.com, chenguanyou@xiaomi.com,
        gpiccoli@canonical.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        mhocko@suse.com, vbabka@suse.cz
Subject: Re:[PATCH v2] hungtask: add filter kthread
Date:   Sat,  7 Aug 2021 21:16:00 +0800
Message-Id: <20210807131600.27742-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805164328.58213d35e45d81c363b2135e@linux-foundation.org>
References: <20210805164328.58213d35e45d81c363b2135e@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please explain this point in more detail?

In my work,the rootcause of more deadlocks often occurs in user threads.

exp:
PID: 711 TASK: ffffffc13eb71d00 CPU: 0 COMMAND: "sensors@2.0-ser"
#0 [ffffff80251cbcb0] __switch_to at ffffff80080866c4
#1 [ffffff80251cbd20] __schedule at ffffff80090c0940
#2 [ffffff80251cbd80] schedule_preempt_disabled at ffffff80090c0e4c
#3 [ffffff80251cbde0] __mutex_lock at ffffff80090c2e58
#4 [ffffff80251cbe40] __mutex_lock_slowpath at ffffff80090c1f78
#5 [ffffff80251cbe50] mutex_lock at ffffff80090c1f60
#6 [ffffff80251cbe60] __fdget_pos at ffffff800829ac84
#7 [ffffff80251cbe90] sys_write at ffffff8008270550
#8 [ffffff80251cbff0] el0_svc_naked at ffffff8008083fbc

PID: 843 TASK: ffffffc135832b80 CPU: 2 COMMAND: "sensors@2.0-ser"
#0 [ffffff802554bb30] __switch_to at ffffff80080866c4
#1 [ffffff802554bba0] __schedule at ffffff80090c0940
#2 [ffffff802554bc00] schedule at ffffff80090c0d54
#3 [ffffff802554bc50] xxx_sensor_show at ffffff8008bc043c
#4 [ffffff802554bc80] dev_attr_show at ffffff8008668ce0
#5 [ffffff802554bca0] sysfs_kf_seq_show at ffffff8008314e04
#6 [ffffff802554bce0] kernfs_seq_show at ffffff8008314314
#7 [ffffff802554bd10] seq_read at ffffff80082a250c
#8 [ffffff802554bd70] kernfs_fop_read at ffffff80083135b8
#9 [ffffff802554be20] __vfs_read at ffffff800826fcc0
#10 [ffffff802554be40] vfs_read at ffffff800826ff08
#11 [ffffff802554be90] sys_read at ffffff80082704c4
#12 [ffffff802554bff0] el0_svc_naked at ffffff8008083fbc

The rootcause is deadlock caused by using same fd, and 843's file ops is block type;
If we want to trigger panic in the first time through hungtask,
must be avoid detect kernel threads on some platforms("mediatek"),
because they("kernel threads") cause misjudgments.

Guanyou.Chen
