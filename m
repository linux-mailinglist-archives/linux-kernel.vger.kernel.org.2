Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7414203D3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 22:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhJCUCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 16:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhJCUCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 16:02:05 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64753C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 13:00:17 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id i30so17139585vsj.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMigLaitifOukkJI53gEbD34hZV1NeNoJ7lOXzjShXQ=;
        b=OXHLliz3vpImECLH3fMcowjVcW8mgxeq4cZzmCHjriSOelou4M5R8h27jOqA2tJRC/
         FteXQxq8F90Un8aSxiZQWP9DMVvqD7eZlKtssOywBjwzC4tdifKGoMJmEFoordE3mWWz
         vW//s/xDTf6KwKLeoPN53bfSvYGXB8nYX7PdNGLj6+UQAfERJ3RlFxDMOFR7L3N0CIk8
         wzHniGE/W45cX0HTBtYwQjQOgwO+xveKGJalKd7myoqgTYKme35Zs91fYFXh4qTVh4pN
         BJPVG/+ldu54nq44vfGcbrgYFaczN6Cf55hprAqOeZofnHLtrqEV0hsGRB29FzySRYbo
         wgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMigLaitifOukkJI53gEbD34hZV1NeNoJ7lOXzjShXQ=;
        b=H7il5u80EW+artYi5vfGmAo171oFVwwQMKJ6MoznFYjlOPE1+Jv3p1sjAd2gAs+8Mp
         W5ECBb1eydQr4c3DDa6QT6HTfC2cyhK2jGyIoOjAY5RnkyPKdeom7lmASc65m12QCXpk
         2z3Svc3LofMy5ki+LdqxP8Q8ssMLN7b7tIjqVk3PrqvWQy11zUomGwpIBH8PL7akkYdJ
         0N/gubYGhyYpZRCnhX1XpPdquDHKkkRmRH6c1w5IlV1p+uKap7sDm+o30fFPMORfTOWm
         XbyTWPa0HxO4rdLSAFY9mz+5kYUJho4ucczNFhxNOTvNaapzq1Hs1fplD5dC+ui+PdZH
         Q34g==
X-Gm-Message-State: AOAM530ly2loGsPf/fIpvNVKBcxGjh2byAOQjXQlPzVMOc6nZ0sksLrc
        WZsnQh52LqdvsKrKxfO44aA=
X-Google-Smtp-Source: ABdhPJyh0fDRqtVxRvkW8y+i6KNPZZ7Pc6IqHlHwCInffwdxmEYGwWrktd51Bio/37YTPhjZjYHLxA==
X-Received: by 2002:a67:c896:: with SMTP id v22mr10782275vsk.39.1633291216576;
        Sun, 03 Oct 2021 13:00:16 -0700 (PDT)
Received: from localhost.localdomain ([181.23.73.135])
        by smtp.gmail.com with ESMTPSA id x21sm6691019uao.2.2021.10.03.13.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 13:00:16 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 0/9] staging: vchiq_core: various style cleanups
Date:   Sun,  3 Oct 2021 16:57:49 -0300
Message-Id: <20211003195758.36572-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches consists in some code style fixes.

Gaston Gonzalez (9):
  staging: vchiq_core: cleanup blank lines
  staging: vchiq_core: cleanup code alignment issues
  staging: vchiq_core.h: fix CamelCase in function declaration
  staging: vchiq_core.h: use preferred kernel types
  staging: vchiq: drop trailing semicolon in macro definition
  staging: vchiq_core: drop extern prefix in function declarations
  staging: vchiq_core: cleanup lines that end with '(' or '['
  staging: vchiq_core: cleanup unnecessary blank line
  staging: vchiq_core: fix quoted strings split across lines

 .../interface/vchiq_arm/vchiq_arm.c           |   4 +-
 .../interface/vchiq_arm/vchiq_core.c          | 764 +++++++-----------
 .../interface/vchiq_arm/vchiq_core.h          |  99 +--
 .../interface/vchiq_arm/vchiq_dev.c           |   4 +-
 4 files changed, 335 insertions(+), 536 deletions(-)

-- 
2.33.0

