Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F8A446B06
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 23:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhKEWuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 18:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbhKEWt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 18:49:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F88C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:47:16 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id f8so11890518plo.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 15:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8G7C8nsDy15wA5lpwg2GfHwvnNpNmOJdVq919XoijNA=;
        b=WOrV80UnZe/T2btUKcyfUDXiCR9XVH8tO0vqc6IP6y/wWeaPpO7ZO4gfSPwalRsfrx
         P6ktcGM4iMsJ8kaIJy7EZaDjHcZhZsQkIqOiJf+wFef59tMaJhcxr1mmac4J5MhL7Jwl
         J0QEtVLyHbNWjXPF2Ac8MpFA/VO+fepoZoKAywCKqxyaN8/3tX/haq1CjTiBFIlvM1Qc
         Fc0eOfCt4J/RW8FXIE4by5pO7omTQRu4ABaze10Quo9tkfTsDwTcyrE2KpjuroPakNIE
         AeCfe8XE5BC06KkAG+lcyGUWXbL4zf/sEqQgdTMMo0tGIFZqQcntQQcdDXeRGrwSoFeG
         qN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8G7C8nsDy15wA5lpwg2GfHwvnNpNmOJdVq919XoijNA=;
        b=sK9TUOx25owqW8h4U5uymYjh83ksG/b0dCadXyF6Bjezweo7VDOxEyurMlmMF02E7b
         Bfw4yDa5f6SHJ+CgSIpD3VyqKeEcboNk1oKblO79YYIlos7TMPJ69VLzH0NNBDen8IWB
         9bVBK5p5pB13t7A/50NwGlmg+rRyJgQgTl2oZo3uqku0mvpbHOp/trSusA1HSENe7otB
         v/d7EghgSlwliuaDH/F5JcNku3XfRKz2pVAHI3BRyYXJ6cAKOjRrNMm2N6lvM2UZHWb2
         CY4xWm2Zgk6s9yfASOte/QQxFoRnQQrm/+AnZqdTZBQ69gNPAHLbqrqKCyPRPWDUGsOX
         6tcw==
X-Gm-Message-State: AOAM532YVTJ9O4hlwdRppmViEprkOlk5Go3q4t2f9IlpZdhR4N5YoDDS
        x+zHaaLGEtIYkEos7yZfx+OPlg==
X-Google-Smtp-Source: ABdhPJzr+WVGsImu+m6dRSH581SA9YE3OK4buYyLsih5WTm91nm5X7/qePPe0lOPciiIb/ftHaeduw==
X-Received: by 2002:a17:90a:bb0d:: with SMTP id u13mr32949966pjr.158.1636152436128;
        Fri, 05 Nov 2021 15:47:16 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j2sm8499027pfc.155.2021.11.05.15.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:47:15 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Coresight fix for v5.16
Date:   Fri,  5 Nov 2021 16:47:14 -0600
Message-Id: <20211105224714.1873452-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 561ced0bb90a4be298b7db5fb54f29731d74a3f6:

  arm64: errata: Enable TRBE workaround for write to out-of-range address (2021-10-27 11:46:06 -0600)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-fixes-v5.16

for you to fetch changes up to 20b02fe36530a1e48dde73c80b882ae276346ea3:

  arm64: cpufeature: Export this_cpu_has_cap helper (2021-11-04 10:46:21 -0600)

---------------------------------------------------------------
coresight: Fix for v5.16

This fix enables to compile the TRBE driver as a module by
exporting function this_cpu_has_cap().

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      arm64: cpufeature: Export this_cpu_has_cap helper

 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)
