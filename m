Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C572635E3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbhDMQVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:21:22 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:40812 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhDMQVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:21:13 -0400
Received: by mail-pf1-f177.google.com with SMTP id a12so11737956pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VAnLORvlHA0CqhWSiodUxhmbW4p+mlvry+H7OH+CbM8=;
        b=jkoKZqeVIYBjCxInSCYoqSg0XQ8Pbkd85pgdZVfgriZ3+PtrG6vMzyERgsyDYVR0Rz
         N+ygGl/63+WJjWzlJkMhAinycxSYkctyxOz60d2KAL8Ky0aVrdGE9EGExwLLR6+b8ER2
         ByaeDBLWwQMAzmm7dFaYBvMkGmHz1PBdF94wh4XM45OwdzuQIhRpIqZXxOsIcy+oUpl/
         SJbkATsW2YHWO5ctZdCbJDe8HAuCucGS6odzRhBvr3c+y4JOZf1wGcjzyVyI3g2cHVFH
         idFnV3Z67WlQcWMA8wPrdxF489fIFJBgcthrL8e6n0UadnUf7o1u011q9LriqTASXr8t
         JXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VAnLORvlHA0CqhWSiodUxhmbW4p+mlvry+H7OH+CbM8=;
        b=QPavDfPdcc/VZZoTd3JK17bbzsiwbt9kn1mA7eXRQTrtDOtCPYc72oez8e+uVhh/XI
         oVYUJBDI/lL1SzgeZdutDzHHBg4pdAkgVp+uI5aQ3XWP0PEshDyA+/WrTvHdBTPlrA8C
         H4rlglVLn2RAB+U/9/PciD1+4VaUtjW7IkfCSY4iekkPtypENlHIHn+Go37K4S84kSbp
         hDd2p0Bdhyak/UmhHigaXjDqKBK4zMHNa9VYXhO3uhidF6r3YrIMoryaSBySdzF8vwts
         jk29qsSmOqGY+ihR8XNHrehk3AVjHaZO9YAd3bAd6hWZDAUiqMEbsIjSAydUa4QGsX5/
         tuJA==
X-Gm-Message-State: AOAM532D4iJ0l3Ma+SrSV2Q4oocn9srQmLg4rvxpaGvPRNQee1BLWG7b
        c9W/0YD4p2GIT7YJ/liQNL1FS1Y3qglI5Q==
X-Google-Smtp-Source: ABdhPJz8SAQ/o/1a7/grAkz4uQOp6weGn0EjgYR/mhwyip2GjzJeZ2A2HlSdnlBLwWS/wRs+FLWmvQ==
X-Received: by 2002:aa7:86c9:0:b029:245:1c62:3499 with SMTP id h9-20020aa786c90000b02902451c623499mr24759311pfo.74.1618330793766;
        Tue, 13 Apr 2021 09:19:53 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s16sm9718172pfw.94.2021.04.13.09.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:19:53 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     maz@kernel.org
Cc:     suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        coresight@lists.linaro.org
Subject: [GIT PULL] coresight: Fixes for ETE and TRBE
Date:   Tue, 13 Apr 2021 10:19:52 -0600
Message-Id: <20210413161952.750262-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4fb13790417a7bf726f3867a5d2b9723efde488b:

  dts: bindings: Document device tree bindings for Arm TRBE (2021-04-06 16:05:38 -0600)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git next-ETE-TRBE

for you to fetch changes up to 68d400c079978f649e7f63aba966d219743edd64:

  coresight: trbe: Fix return value check in arm_trbe_register_coresight_cpu() (2021-04-13 09:46:27 -0600)

----------------------------------------------------------------
Hi Marc,

Please consider these two patches, they are ETE/TRBE fixes found by bots.

Let me know if you want me to rebase on your next branch and send the
pull request from that.

Thanks,
Mathieu

----------------------------------------------------------------

Wei Yongjun (2):
      coresight: core: Make symbol 'csdev_sink' static
      coresight: trbe: Fix return value check in arm_trbe_register_coresight_cpu()

 drivers/hwtracing/coresight/coresight-core.c | 2 +-
 drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
