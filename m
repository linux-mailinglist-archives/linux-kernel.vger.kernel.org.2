Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDA8438C18
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhJXV2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhJXV2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:28:02 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87C2C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:41 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id p23so5449532uaa.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DqiOv1p3LOB7EKypi/0mOrwTqn1iriyu35ZKspNjngg=;
        b=DKvSVO+p/SFxE0r75HKW9OuNa3MhS2EvqtN+4jkFUbBPoib8QfYDoroxok9N3so9Hn
         exhiDYfvK2JpmUiZ3PfYfOGMAhDkvjZa+gZMlmPsZy+IucG2AQO8nhm5Vwvz0TTVCyAH
         /e8tl2ROV1EWMF1aVd5piqcoYTirX2dcwcX4hvabIBWQ7XoUnJD+mJntHWL/hYKCgBpw
         F+u7+KJaujnOFFeebEBtc58FDEY8TqARz9MRaPik32iYwtL4Y/icdw2c71jJ3ol/zpcM
         1Y1Fjl/u3r2/IydIaNAEyfSBll6J25biOQJwKRpwizoVoK6yv6PRZEiFqz+WcdD78tvG
         4s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DqiOv1p3LOB7EKypi/0mOrwTqn1iriyu35ZKspNjngg=;
        b=OZOeAgb0j/1xWu2PItIM5EGkl/vyrcLe2wVHFLq7UleDT/h+NuSTOAdIfKzvWf+V2g
         jYnVQWkY+IuCwSrr/CUvhHc6QTgL13zeaMcIpkAuqcLDUs9qW8hOSTPp4TAgZfWI20lY
         5hurcA2yUD/It7A+JASKjXRrCWkukqfwyFAS+rREFA9CCnV+56c8Qy0lGtIoPVgy7wVD
         wO8JWvrYpr0aVVKpIuxcO04uPvZt80tfp8THsga4EHqTI026vFVe+xdE5ZjvaoE4wpvZ
         nbjQQg2OIUX0I0vpLo+p4RDl+Q8LaicKsSmePNVCOjPOJjRnx2VUfmtZ5b/azzAwElme
         QiCA==
X-Gm-Message-State: AOAM5312rkfE4vYEsGkoqKdshEgM/QRpoXo3RiKnqR1NTRrgIw68WaR+
        tMKfnZRCgfPIyd8hfgaHmfI=
X-Google-Smtp-Source: ABdhPJx5a3/eziA4Af2q1yZwIzzKVvrciYGyHTKBotRo8MHzV2NoNC5PYHiWoxrmggMICmrqgmm2pQ==
X-Received: by 2002:a67:d81a:: with SMTP id e26mr11952472vsj.23.1635110740894;
        Sun, 24 Oct 2021 14:25:40 -0700 (PDT)
Received: from localhost.localdomain ([191.83.215.63])
        by smtp.gmail.com with ESMTPSA id 45sm8847869uaq.8.2021.10.24.14.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 14:25:40 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 0/8] vchiq_core: various style cleanups
Date:   Sun, 24 Oct 2021 18:25:16 -0300
Message-Id: <20211024212524.370078-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches consists in some code style fixes.

v1 -> v2:

- Drop change wrongly attributed as a checkpatch fix.
- Unify patches that fix unnecessary blank lines.

Gaston Gonzalez (8):
  staging: vchiq_core: cleanup blank lines
  staging: vchiq_core: cleanup code alignment issues
  staging: vchiq_core.h: fix CamelCase in function declaration
  staging: vchiq_core.h: use preferred kernel types
  staging: vchiq: drop trailing semicolon in macro definition
  staging: vchiq_core: drop extern prefix in function declarations
  staging: vchiq_core: cleanup lines that end with '(' or '['
  staging: vchiq_core: fix quoted strings split across lines

 .../interface/vchiq_arm/vchiq_arm.c           |   4 +-
 .../interface/vchiq_arm/vchiq_core.c          | 763 +++++++-----------
 .../interface/vchiq_arm/vchiq_core.h          |  99 +--
 .../interface/vchiq_arm/vchiq_dev.c           |   4 +-
 4 files changed, 335 insertions(+), 535 deletions(-)

-- 
2.33.1

