Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A9E370AA2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 09:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhEBHGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 03:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhEBHGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 03:06:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F252EC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 00:05:09 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a11so1185166plh.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 00:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C1OozhOqYWow9vKRtrmdalc38MZaDvLbwI8Yo4ED4R4=;
        b=DODPMNtzJegqfsXEj/XzuQOyFkd+mq/L8dbNAV5VsVF3mZmJJjpUGr8rJkqfPpIDRj
         OyIdAaAgQbzwhP4/pvIf0G6qbyPGeGT0IhC8y+jHgwQZnXfn+iWjZ79QyGzoI6k/76DX
         nQ3LjkttiETbF+7oIiGcFl+2+XcwZm37MIfp+zi+dPBvBr1Pe72teiT5arSaKnwDIEM/
         3Aukxkx1TvwYjDZ4gqvEZQD5YsXb1bnHEFdGNH0iJE/0x0BCgByYt/D4iG5Bl6+e1p8i
         2SESQH6bLARXFc9HZrE6XjrRfjItry3Wf3YNhC5eK2zkyjRY2A/7bZmA9BZ6zFi69TwK
         7NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C1OozhOqYWow9vKRtrmdalc38MZaDvLbwI8Yo4ED4R4=;
        b=TfcacDcXRaLwpgrvUeVV6yjxfxDUrfi9rctzInoXjbAQ2GR8WTgBN8a9RIoGn0VQX/
         jPQUCMuK12TKgXcSaadVz0uzsKXIWJoUnjliGNtiy6wg90q9iMfo/tZxYmSoYcC6zrTd
         l54yksrl7f3j/rdhWhflX8xqxlEzKwsdxbOqphhAzGUPqZrGXkJX8IrsRawTj+7gix6M
         8m/zoaR0aaulzPCp/2ddjTW0jlcdIDIob4Ha0IjAUfR6SAGsxZZ9QChlFP4fyeSXGJRL
         eWGajRyFHP8KikobA4pqJgqeMtqxCtWBqwSjgsxfiiO4sxmrcAJXJpxXDUj4rXlCScWC
         Uz1Q==
X-Gm-Message-State: AOAM531IGA702F3PzIgsnxPO4fFivYL1/ygHblytFeQA4sYMIQPOao0C
        saZ/tpL5BD7t8rcl3t0AIh8=
X-Google-Smtp-Source: ABdhPJyEwekwxTiGp0YA4R3nvr3BTzQv6hPa2xdCn/3aQn/bXV9t88yIBi6XlXayLypqeC0lnZOshA==
X-Received: by 2002:a17:902:c106:b029:ee:a12b:c097 with SMTP id 6-20020a170902c106b02900eea12bc097mr11054337pli.27.1619939109326;
        Sun, 02 May 2021 00:05:09 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id r18sm14345713pjo.30.2021.05.02.00.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 00:05:08 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] iommu/amd: Enable page-selective flushes
Date:   Sat,  1 May 2021 23:59:55 -0700
Message-Id: <20210502070001.1559127-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

The previous patch, commit 268aa4548277 ("iommu/amd: Page-specific
invalidations for more than one page") was supposed to enable
page-selective IOTLB flushes on AMD.

The patch had an embaressing bug, and I apologize for it.

Analysis as for why this bug did not result in failures raised
additional issues that caused at least most of the IOTLB flushes not to
be page-selective ones.

The first patch corrects the bug from the previous patch. The next
patches enable page-selective invalidations, which were not enabled
despite the previous patch.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org

Nadav Amit (4):
  iommu/amd: Fix wrong parentheses on page-specific invalidations
  iommu/amd: Selective flush on unmap
  iommu/amd: Do not sync on page size changes
  iommu/amd: Do not use flush-queue when NpCache is on

 drivers/iommu/amd/init.c  |  7 ++++++-
 drivers/iommu/amd/iommu.c | 18 +++++++++++++++---
 include/linux/iommu.h     |  3 ++-
 3 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.25.1

