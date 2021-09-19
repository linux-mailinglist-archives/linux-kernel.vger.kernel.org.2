Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B767410D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 00:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhISWHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 18:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhISWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 18:07:49 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:23 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a10so36197394qka.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qnvBHVofCI078vE8ENwQVrZQWxUC8kXdsfVEs8ZqGPc=;
        b=EmPmJimiwzUaOxywPMLvTOyZc0SUnhOlErQoTUmX7st9GVg8SjD/ELsfCeSTEb4zVa
         cu4wJFO6HzK/vKl5K+V2or5TTslnUu/SkhR3sMtLId4M/Lm5VoKRnsuBCzdk5cfoyf01
         bF5eFG3T4UBoLA0rIRcgqbnNK42SKc7pcgXEWYkfwntxMqPRHaKHAtR7BMAcTbaZPF7N
         UyWvHhdjvUhm2P8D93k3BlMlEqIAqeWLPaK79nDaCTRFZPAZYEuFiHLg6EuA13OZm2xL
         09pyZCIMwxovOyVi3cxltpkJJqBliaDxpWrQJXBTPrNd6YvwnVLmU+t/U2y4e3mqKOJM
         KyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qnvBHVofCI078vE8ENwQVrZQWxUC8kXdsfVEs8ZqGPc=;
        b=oKy1aOP8tIT1jXCf0y+uUP3uU4YzNgItSNAqHTXm19joFSmiHjIb7wTcImt87BvQjZ
         nN0TDalF2eEblOC422pkfK0k/m80RkuWb6dvspAa59SKXuAEqUxgB32EA3JqwfeuPiKT
         Qpy8XtoL2IQ8WqogbbRjR94jY+W6qWoqNmkwghq0g8CYp305tuIklkkaTugDwQWk7ddR
         98phWNv3w98Rv/BMjJZrGtMADYQXo+Y3hBjzJy7IMClSn7ANMDGYG4BvioTVSHFn7qki
         6+2vikIRz090zuX71Sp4+GcNioVivp7Xw2J/qN/XIYxYig7pky/3Jmk6SC4yqPKLxew1
         kjcg==
X-Gm-Message-State: AOAM530Nyvx3OOf+ELcBwoAXuxBZFhn9UfF2RyTHDUGp4fFTuYd5K7p8
        hnG8rlIFkbQt3JocVLVbwMc=
X-Google-Smtp-Source: ABdhPJzgctTUWico0bxsBx08tGbafnOdLRfiTf++cbU5TqsqExBO43BBC5f5IDmma2KnhiRAYkFaZA==
X-Received: by 2002:a37:a793:: with SMTP id q141mr21055987qke.10.1632089182434;
        Sun, 19 Sep 2021 15:06:22 -0700 (PDT)
Received: from localhost.localdomain ([191.84.236.195])
        by smtp.gmail.com with ESMTPSA id t23sm246313qkj.31.2021.09.19.15.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 15:06:21 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 0/7] staging: vchiq_arm: Various cleanups
Date:   Sun, 19 Sep 2021 18:59:07 -0300
Message-Id: <20210919215914.539805-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches consists in some code style fixes.

v1 -> v2:
    - Remove patch vchiq_arm: replace sleep() with usleep_range() from the series
    - Add cover letter to the series

Gaston Gonzalez (7):
  staging: vchiq_arm: cleanup code alignment issues
  staging: vchiq_arm: remove unnecessary space in cast
  staging: vchiq_arm: clarify multiplication expressions
  staging: vchiq_arm: cleanup blank lines
  staging: vchiq_arm: fix quoted strings split across lines
  staging: vchiq_arm: remove extra blank line
  staging: vchiq_arm: use __func__ to get function name in debug message

 .../interface/vchiq_arm/vchiq_arm.c           | 221 +++++++-----------
 .../interface/vchiq_arm/vchiq_arm.h           |   1 -
 2 files changed, 84 insertions(+), 138 deletions(-)

-- 
2.33.0

