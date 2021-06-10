Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22F03A2F19
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhFJPQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:16:34 -0400
Received: from mail-qv1-f74.google.com ([209.85.219.74]:57097 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhFJPQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:16:21 -0400
Received: by mail-qv1-f74.google.com with SMTP id n4-20020ad44a240000b029021cbf9668daso20494413qvz.23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=50MN4xWbgGEuj61j/i1zYF3JQQTtZRIXYmf3w+jlERk=;
        b=Ag3x0D7nRGpBBvEZR3it86HNKqQGY9JhtqCXASj/fZpv/iDJekhy/iFOYv77VsUmb1
         JHUX95Jn0HLz4RV4BjBtqxOUZm+9JqbQ6iH0KX51E6wNAzXIM4GLQ+m+tQBR6TqbzpCb
         u6Y9jLykW6wLrD+Oo2TW/UGxzStizs2KHOKxi87Kr5YwksIACAiXehDlP5Do6tR0Qjv4
         LzfFRnXzq1rR/+xCdKy3qo16HSXMxEJdiITuOOS3yvPxIFE+32vhvgEys70sF0bkOE3H
         fqf6nMeCVZqZkhN8o63p+xb/e2szVPAAG/UWRBiws7nKnHKAWgdJmxAyqpPGFgND9X1y
         hMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=50MN4xWbgGEuj61j/i1zYF3JQQTtZRIXYmf3w+jlERk=;
        b=kRHJA2zJ/v73o9j4dCTRkF4OED4F5w3AMaOVj5kR6Q1x+HAymmgC1/3ft4bK7IkxCI
         lWCGetCaU9jDCfEFhGWE3NwbPhj8yJ/09X/sAhFYeUPuKlXq6Wmc+ePSTD8DNlexpHHJ
         owypd/rfmnuqa39S0XINJoq7Uy+l/7hT9brcoGF4cnK0/0R2aRSb6gm9yUTzZvr1Ax2C
         95kSA3dLC2+W08Z8tjxpyoyC91igbr9nyX93G485WFVDLJCwU+9DokhEK5X/DWGrjyXa
         651/lhyfzby+Ohwd8fx3Lwu20upNGi5xOHfvRaDz7KtgIcXJPvBpBzs6D59cc8iSHZDy
         kZQg==
X-Gm-Message-State: AOAM532r9rIzm3A2AlPUHdDz3W/yF1eSC9F3mQjdnkRUUBz1zs7Hdzca
        xA/1lcroKWs9s0RcfVaSYq610xuy43y5
X-Google-Smtp-Source: ABdhPJz4x6IF2finvCtMhoLVzIOGP5R2Yo0epHG3EsPWgui3bhaX+iWKC6Jkxhc+Q6lev58h2OZa4gwStvbk
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:1909:: with SMTP id
 er9mr41932qvb.13.1623337991973; Thu, 10 Jun 2021 08:13:11 -0700 (PDT)
Date:   Thu, 10 Jun 2021 15:13:03 +0000
Message-Id: <20210610151306.1789549-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v2 0/3] A few uclamp fixes
From:   Quentin Perret <qperret@google.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series groups together the v2 of a few patches I orignally sent
independently from each others:

  https://lore.kernel.org/r/20210609143339.1194238-1-qperret@google.com
  https://lore.kernel.org/r/20210609170132.1386495-1-qperret@google.com
  https://lore.kernel.org/r/20210609175901.1423553-1-qperret@google.com

But since they're all touching uclamp-related things, I figured I might
as well group them in a series.

The first one is a pure fix, and the two others change a bit the
sched_setattr behaviour for uclamp to make it more convenient to use,
and allow to put restrictions on the per-task API.

Changes since v1:
 - fixed the CAP_SYS_NICE check to handle the uclamp_{min,max} = -1
   cases correctly;
 - fixed commit message of UCLAMP_FLAG_IDLE patch.

Thanks,
Quentin

Quentin Perret (3):
  sched: Fix UCLAMP_FLAG_IDLE setting
  sched: Skip priority checks with SCHED_FLAG_KEEP_PARAMS
  sched: Make uclamp changes depend on CAP_SYS_NICE

 kernel/sched/core.c | 64 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 11 deletions(-)

-- 
2.32.0.272.g935e593368-goog

