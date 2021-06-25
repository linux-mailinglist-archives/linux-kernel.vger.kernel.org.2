Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43273B4335
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhFYMcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhFYMce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:32:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE5EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:30:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id s6so13110252edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkmPicKD/hvE1nW5aGFrwYzV3suaN7+QqIgid14W1RM=;
        b=aWvdXe5XxuJLs+y354C+rsFcCJrwk505J9mYe2YmMAclBBs2MP0Coj5KIDV+XKEA74
         tNOpNcSkfYwDCNq42gfGUHqhblf9oQCoBb1nf+tMD1JgmWHuwn7n3GSPVh/tlTT67rbf
         IxA4e85MG5sBV+WK66wRf4Nvq1zI8YyaO8OkJFg4cGzqnNdGMfnRIPQEV7WmwoCKaw4d
         IqVOdr2bj4h2OwJw1VYCkxk32f18+USZj1Iyt7aGV/4wIE5r7M3WwK0+eeH93WyFFQsf
         5DVhDsKOW09q09E7C4Q+yMR1TUaEJ7fHuDEbAsClMOhBAMGDGvh3SiUO4b5U5snbESCo
         EUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkmPicKD/hvE1nW5aGFrwYzV3suaN7+QqIgid14W1RM=;
        b=As8HAL1LiBTzbGKDdsb+7v8B+eNIo+dgkI6Hju19xKICSbJhjRfxEFvicTbw8TtCZw
         ZqZUDC6KV0tdgUec2s7IcincWo5QzqH9a/uR0WlLsycGBjzTe6HH3IJt/aKMr42b1MVK
         G/qCl9t8BBxM/Gz+dUW3zzOybbHeLpZtP3gHg9AWjqI1KpjMji8wWB2rT15qcVH+1axe
         s/z6axH/H2h9zjDxs1kgsd3YMmC4953+jUFEFXb51hET0vqL1Z3mM70J6ny5BJKIemIJ
         a6Rjb2Xb2PSlChAFWrtbpZhr/nIIxxZ3biGt4d5EYqhnHiQpGoUMm61pvP2I/e+yy/Aa
         5pMQ==
X-Gm-Message-State: AOAM531gAY29vPHF0J/Q5fjUhRzY7fKLfd4t4bK2UQJxmktn+09+yxHF
        21U168Y1ouSI++metiwoq0MHJ3F7AJcLuzPe1qU=
X-Google-Smtp-Source: ABdhPJwPT/qy7C/aB1WutrPy1ijeD+Bpz4Z5XsDs/7bMLIKfKtRBDE+jdCe5aVttOF3YSTuO53b2pw==
X-Received: by 2002:aa7:c70d:: with SMTP id i13mr14284574edq.249.1624624210315;
        Fri, 25 Jun 2021 05:30:10 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id c15sm3884351edu.19.2021.06.25.05.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 05:30:09 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 0/4] regulator: devres: remove unused device-managed unregister APIs
Date:   Fri, 25 Jun 2021 15:23:20 +0300
Message-Id: <20210625122324.327585-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These APIs aren't used anywhere and most-likely exist because of the
general principle of C APIs, where if an API function does an
allocation/registration, it must also have an equivalent
deallocation/deregistration counterpart.
    
For devm_ functions this isn't all that true (for all cases), as the idea
of these function is to provide an auto-cleanup logic on drivers/system
de-init.
    
Removing these discourages any weird logic that could be created with
such an API functions.

Alexandru Ardelean (4):
  regulator: devres: remove devm_regulator_unregister_notifier()
    function
  regulator: devres: remove devm_regulator_unregister() function
  regulator: devres: remove
    devm_regulator_bulk_unregister_supply_alias()
  regulator: devres: unexport devm_regulator_unregister_supply_alias()

 drivers/regulator/devres.c         | 105 +----------------------------
 include/linux/regulator/consumer.h |  23 -------
 include/linux/regulator/driver.h   |   1 -
 3 files changed, 2 insertions(+), 127 deletions(-)

-- 
2.31.1

