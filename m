Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A77B30B8DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhBBHoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhBBHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:43:50 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C11AC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 23:43:10 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 8so6653475plc.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 23:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8TJ/V0kcQ+z/4bMWVnXKWVlm9XfrPmR0Im/BODOFC7A=;
        b=S2Y3br0AWNzYbz/+rkbKrtWVi6fj+jDiLDHdT8vR+ll+ayySVnrcR3FgtdfuhF4MP9
         k9HSPDrAsW8G97X6MAsY0GnHcpPKPorILtoUblhJ+fC1oyVKR+uOPNenpC7Z5FG27L5M
         RBbCM0AYPT2G0H2rZ/itq6/BWJM//esWZfD0yXMq4aZ4SmA7x8mbY6uza0rgetHMW89x
         r0FGoKpC+Ob+ZAEBi/SCKyD9Ai0IkVy7+lpHdi3jtxQQ5ALvVqPunD06II8ffr1d802u
         EpaJFpGo2wYgpO4UJO0yDLxEAiUbtMdIdscvN1CS1ZfeH74Tn25OGUA75uiB4vgY7TRf
         iXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8TJ/V0kcQ+z/4bMWVnXKWVlm9XfrPmR0Im/BODOFC7A=;
        b=IhSZr15Y48DmhBHjR3CHNgaQF+DyDGuSzG2lyp+/Q+LXRf7n2ar6FoqqAbpEFm6ZLq
         uXDRs+WVJ9o0DeGNP5O6T3a6d1dIqvkKOWiwxHUhluK+gYaUIEP9FsjBBxFvGs1AJNnS
         gDqaZjzp56CWG0Ic5vTHoDRMp92YZXR6QBUsSm+jRsb5r9NOFUPiLS1dyS2jQ5QqjJKI
         7GqEU79EHJMIgD82GBwsXokyRv1O+ByQ8u6gWVrK+5DvxJYTJSKAx/qHCXqn/0QmJU0H
         kMFMkgPmRgCbnafuBa/KAUCx2zzuWw4PokpbQ+EhElsTwMEz+rw3+iWL8RnYkJhODNAc
         iEmg==
X-Gm-Message-State: AOAM532wYHFORIkr+zDW0IaBuxBnW1wpaJKfZyy2wzsieZJvRcKSd+QA
        3d/qzdCnum1bWKWyCe09ezNeZR0wn6EeFxTo
X-Google-Smtp-Source: ABdhPJwZl59BOzNM10urTFGDtO97YcsTFY98hKxF6bSpD0KrfYHRrvWBGzUsInTo1Y24r7tWgCVKGg==
X-Received: by 2002:a17:902:8ec7:b029:e0:a02:3d26 with SMTP id x7-20020a1709028ec7b02900e00a023d26mr21404019plo.24.1612251789971;
        Mon, 01 Feb 2021 23:43:09 -0800 (PST)
Received: from localhost.localdomain ([2405:201:5c0b:3035:c597:b9c3:41be:d23e])
        by smtp.gmail.com with ESMTPSA id z13sm20507118pgf.89.2021.02.01.23.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 23:43:09 -0800 (PST)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
X-Google-Original-From: Prathu Baronia <prathu.baronia@oneplus.com>
To:     linux-kernel@vger.kernel.org
Cc:     chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 0/1] mm: Optimizing hugepage zeroing in arm64
Date:   Tue,  2 Feb 2021 13:12:23 +0530
Message-Id: <20210202074225.7244-1-prathu.baronia@oneplus.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed on the v1 thread I have used the recently introduced kmap_local_*
APIs to avoid unnecessary preemption and pagefault disabling.
I did not get further response on the previous thread so sending this
again.

Prathu Baronia (1):
  mm: Optimizing hugepage zeroing in arm64

 include/linux/highmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

