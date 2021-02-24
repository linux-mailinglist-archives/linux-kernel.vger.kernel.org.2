Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0F632447E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 20:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbhBXTSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 14:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbhBXTR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 14:17:57 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BAFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:17:17 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id j1so3556305oiw.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=unIZiqjM81E4aLspX0eOoY8QoqZ7VwmVk3MtveJp+mg=;
        b=nL23m0TleeM/iM/xtqYq0/NWoaaa17YrmxKHOMGRs7rIR/C8gLsbXetmaw9ffktvIt
         lZ+4uxlhzQNGDWE4Z9q7GfYoxsil6VtFWya3+Xxb0zXzx63vBmfF64a40g7mvvvh0VKg
         F8Y/4Tn4NaZJbJQhuE7oBhdOTHbo74QEBLny7bWSxD1OQaK0Td3uCDwG/Nqe2AikdMLU
         2vDg5wX/i/DbhDANXUpX6Us5ZaddfeCl25gIIOqtNyIAisOT9c2eV6U79xRslmfJyA/l
         WKomgElkTOVk4tldrbRs54Hi2+Qxy2EqhkDWeNBv7sKgKXAoWxbaFb9WXsBnLJlPnnsU
         3y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=unIZiqjM81E4aLspX0eOoY8QoqZ7VwmVk3MtveJp+mg=;
        b=Vvsk3WUCkSXdzr01BC4C/x8qcigwnc6HmIdIkR+HZn7Oc4AwLX3UgrjRZxyn8NXFCC
         y7hd5BeudBEUl8rTVvff9C6KV/HLfwxG/2XpCVY0jtVx56uwL78E7ZBORueltkbLpAVW
         uipQAhxscGCYJ2pFyWYeS3h7fpzOpvum1omit+x+Vli9o0MzB3DjlFSFQSFTKaB+SO3a
         W50IX1F/08h0iGjJX6SaQkByiLqBa4mhJ3iPRnHmQ1fdx+88c0wa6AZJHh9ETf3Qcc8L
         +B4PM3sOv66HZNtSAcyMOneo3nJ29zhq+eVtiPb1YvRKUB/9WCk79qAkzEo2cX1lCm0g
         am6g==
X-Gm-Message-State: AOAM530OtU7qwftfX/vd5TDryPAodQFIHOA6cF4KGM7PTn9RruV+2jEb
        PRRpqkNM5yxedI+avyd10KE81Q==
X-Google-Smtp-Source: ABdhPJzs6hLGUPlk0Z1vQAiKOTASOCCNBdU7+ld0kU+Z2GKmp8poC2bIj0MnksBVaAFnxsaYwEXIdA==
X-Received: by 2002:a05:6808:140e:: with SMTP id w14mr3745185oiv.176.1614194236327;
        Wed, 24 Feb 2021 11:17:16 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b14sm551501ooj.26.2021.02.24.11.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:17:16 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
Subject: [GIT PULL] hwspinlock updated for v5.12
Date:   Wed, 24 Feb 2021 13:17:15 -0600
Message-Id: <20210224191715.192575-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.12

for you to fetch changes up to b9ddb2500e7e544410f38476ab928fc2fe01e381:

  hwspinlock: omap: Add support for K3 AM64x SoCs (2021-02-09 11:36:50 -0600)

----------------------------------------------------------------
hwspinlock updated for v5.12

This adds support for the hardware spinlock in the TI K3 AM64x SoC.

----------------------------------------------------------------
Suman Anna (2):
      dt-bindings: hwlock: Update OMAP HwSpinlock binding for AM64x SoCs
      hwspinlock: omap: Add support for K3 AM64x SoCs

 Documentation/devicetree/bindings/hwlock/ti,omap-hwspinlock.yaml | 1 +
 drivers/hwspinlock/omap_hwspinlock.c                             | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)
