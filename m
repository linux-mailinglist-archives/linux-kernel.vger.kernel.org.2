Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B79430ED6F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhBDHed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhBDHeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:34:11 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CC3C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 23:33:28 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id e9so1303640plh.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 23:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vqap69PTjSBgSOK5MfTGpnGIwz3jvScaWXjeQRxHfLs=;
        b=hv9diycxu8ma9/jDjzMxKS1hJlrG+GNv7lgiswjpc85PhoZxDGU2+lAzdUUPniVD3O
         lDbka4sD8OnG8WXce7pUlqm9tjShIckvHz1dFIDyKah+v5Wl4x/03xjn7t88bhIZGl6m
         om6LKAZpTZQDs1z5oErvB26r6TBkC2RPsnCmr7jCn2J3BdPhz8x80dk4zuGNopBJOBEr
         SlEu4xpS+2I4gYBmT8QotyzwlzkVbWzp1DdSr/IJJhqweHmucO5qn69rr3/9z6kPtAuF
         AP5a5C3bAdB2awBygzKhnEtVyMuMXhg01LM1dpjn4XayGYzJX4Eu8mEgfGgpEayPhxKG
         C24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vqap69PTjSBgSOK5MfTGpnGIwz3jvScaWXjeQRxHfLs=;
        b=pwVaxGNh3/yaEcqrOVtt0vaxFS2PTZxOuiMZET/JdbnroSOaann2ist11pExazAz+i
         0M+DgP37XnbYHyzu+RJrl07+7kD1RMRZ8zYEi3nYst1VEYydPRdpFLsRns6SiLOPxT32
         fQK5Pxj3Ya67g0NWJLyJjSsn4xAWzgLd9fjeKRDugI0sdxxRIp4e22bfCm/3HFfz3xs3
         uVkTZmbrFb45qSyi55Mf2FJo+tA5i53pZfcrSYPHWJ/bFBc9KwQvhkRCmztLYzRft0mz
         d8X3PzV8n4oVbKyFu55N/pGd4UVYfdyMTqiUWSLbDnGTQyzSylAzx4SizPoHo9FDXucd
         GftQ==
X-Gm-Message-State: AOAM530bLyIBJGY4Nm6+e6EfdpuN3pFMOX+v95ztpb9z3M8JAYtMI50R
        Yaw3ew2LiI3SpKQuRwA26BUrj+QaNi1U/s+WQrA=
X-Google-Smtp-Source: ABdhPJwNlYuOSj3PrIJNBZ+sRqeMjiYQta5Iqc+h+dJB3dDndMAnvENKRHDNcRVqdDYjyzKXL/fZKg==
X-Received: by 2002:a17:90a:fd01:: with SMTP id cv1mr7100917pjb.77.1612424007960;
        Wed, 03 Feb 2021 23:33:27 -0800 (PST)
Received: from localhost.localdomain ([2405:201:5c0b:3835:fc1d:bd99:95a3:b044])
        by smtp.gmail.com with ESMTPSA id y22sm4572020pfb.132.2021.02.03.23.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 23:33:27 -0800 (PST)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
X-Google-Original-From: Prathu Baronia <prathu.baronia@oneplus.com>
To:     linux-kernel@vger.kernel.org
Cc:     chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 0/1] mm/highmem: Remove deprecated kmap_atomic
Date:   Thu,  4 Feb 2021 13:02:52 +0530
Message-Id: <20210204073255.20769-1-prathu.baronia@oneplus.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated the commit text.

Changelog:
        Added my test data to Ira's v3 patch.

Ira Weiny (1):
  mm/highmem: Remove deprecated kmap_atomic

 include/linux/highmem.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
2.17.1

