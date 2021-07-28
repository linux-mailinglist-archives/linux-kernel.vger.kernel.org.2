Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642503D920D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbhG1Pco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhG1Pcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:32:43 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1317C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 08:32:41 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id j204-20020a1c23d50000b029024e75a15714so1088543wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=woxBdtlGB6zB1Cvm58/DELTClL+Pi4ueOkLDe2VMF2M=;
        b=epz07g1EaavCivdoVuxcYOGCNXaoqnHhC/UGhLJRF+Pky/IvXdl3JWJ/nFWpj1Ynvf
         KjegyFAa2rqJf5VkvBzIf5tCpmdFnEuEi+3GKS+sfYVz+flelYUipvnrD5flmnVoNSdp
         HYObj4QGfiMOQmAIe3/I4itJkSqJwj8bKMkVQhbx8UQejc84bFjgnN//b2YSK0Shovvv
         3TSYIRoZRvbXhh+oXXVNHCOqLH/Neby0qKwUGuDd+xPKZOK21+GKxBiI4nRE4D8Ba8dS
         O7SJsrFOZwe9huviD1vNwjgYFKYApbdca566DIHnHOgoMQmwf7QVMBBFhB6CARGzEuDw
         sotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=woxBdtlGB6zB1Cvm58/DELTClL+Pi4ueOkLDe2VMF2M=;
        b=kEXl0v8u7qqqzkuRL2y0v6LB40jQ5zv88EpKH0G6hX2Vxh0Dj5VwOk6CASzUOrSZWB
         HvUprURyTyQyyv1MOeZJqC8Dvz4paSq+wyPqq6pEbxS4vZutYw6EsAbWKF/D2E4apm7x
         hnEKYM3H8yb1MZHrcqdQx8O5swg0HH70Y84jmkKNKV3avoXj7M2vGs9OIXezmQxS6vXI
         ubkkp/VJcfqyvIvJyHLGbQjfFTByFlFVhMf8MLF+x252cfV+4DeguC6tJeNeM4CCQ874
         kOn9nM5GhDYg5l8jBeYdq/KKtixDy1sm6lJlszrSwIfRs8LMIo1cUB47fGLuW+Y+e1VI
         HRRg==
X-Gm-Message-State: AOAM53168FptbpIskvRAazRUR0MT56UEQTgZT+eFeql5bB1cWyX04Tid
        ItkETK6f3f4weE7BgHIvt8VFR2BDxPt+EQ==
X-Google-Smtp-Source: ABdhPJxcC9G+bs+7QxWK7qVmeijPTYfUQ0BkmUenPrMR4B9UrgEdp6IuwoWBJPGRXAZh21n0pgqNMUrPMGxJ/g==
X-Received: from dbrazdil.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:7f9b])
 (user=dbrazdil job=sendgmr) by 2002:a1c:7c04:: with SMTP id
 x4mr331814wmc.48.1627486360245; Wed, 28 Jul 2021 08:32:40 -0700 (PDT)
Date:   Wed, 28 Jul 2021 15:32:30 +0000
Message-Id: <20210728153232.1018911-1-dbrazdil@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 0/2] Fix off-by-one in range_is_memory
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, here is an off-by-one bug fix and a very minor improvement for
the range_is_memory function in hyp.

David Brazdil (2):
  KVM: arm64: Fix off-by-one in range_is_memory
  KVM: arm64: Minor optimization of range_is_memory

 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.32.0.432.gabb21c7263-goog

