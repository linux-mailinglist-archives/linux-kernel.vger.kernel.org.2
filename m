Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CC6393F31
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhE1JGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbhE1JGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:06:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452B2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g17so2478554wrs.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x4wIuz1s2gqzP/x9A7F4zXqS69dsm+xjTMP8Z10m2eY=;
        b=VgAkxOnEHVE33AmTNHtRtlTa7zzJjxyTD1gpG+b2Mavafk8F0338x5+4UXlrN4Zyz9
         sGfeBIMiVQHNK1yousB7Ud7ByBjfgQgI1lnm3yoowYR/YjAMGbk2rTJu23fDc9mY1bR5
         F77CD44p+DVYaMT4TkVmeCqsoKoBmwGtSE1hY+7Sil59GNuLEY3LForZOIu2I5esDYXR
         hwNx+SI2bY15RHVuZ9CR5ev+qlMIsbsVV2IYWy+2Mr5ASr+tNuXmix6oesXecGOjq6hz
         01mIQDVzPo+/joQ+obEucPWJq+dZlfhiLtyK0UJWTq3kWoo+oO4pYWyY5G/DP7MjRr2c
         JlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x4wIuz1s2gqzP/x9A7F4zXqS69dsm+xjTMP8Z10m2eY=;
        b=jUsAeyQBxT7SgnBUOSFS0VHGt8/TcVOh2hUSW3i4eWQtwXXYSG847UpQz9yr1ijJUx
         NVKFpEpst/lG7wscSZb050B6YogSJMkkoW0d7q0gbjKZcbaotYW2bu/aYiF052zerPM5
         Y3yzcSZj+XOb1d2TGW8e9SNzyJp5eMQNNv6NFc/HqZ0GnjGcI9QFspIrbz8KRu5X54cl
         iiw7ADvzYq0jzj3jBTvpYQ4J6yUSA6OYv04UOqq4gq6z51+dahFWhBFJsCfG1+ccd2PE
         wXRLCSjXtNWqAt4yOGOQu8bgot6dgF0utarRt2R4oTO6go1euq0GQM/6pTmS+/K6b7k9
         o8tA==
X-Gm-Message-State: AOAM531kr4Y35RkJHQnmjRvSpwx0Uv71jTsPkIxLNdQXoAfbzWVG9Di7
        GS6FNSKdMalNMAqBP+rjT5fxvw==
X-Google-Smtp-Source: ABdhPJy6NC8fxoezbUSmaO5XCtCmwNj7bvGHW5AKd99pOPgdnngB+i8JCHjpvpXdFLGhZ1bdwlTt/Q==
X-Received: by 2002:a5d:5052:: with SMTP id h18mr7482638wrt.365.1622192704884;
        Fri, 28 May 2021 02:05:04 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id q11sm7193937wrx.80.2021.05.28.02.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:05:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        ALWAYS copy <linux-ide@vger.kernel.org>,
        Andre Hedrick <andre@linux-ide.org>, ATI Inc <hyu@ati.com>,
        benh@kernel.crashing.org, Jens Axboe <axboe@kernel.dk>,
        Mark Lord <mlord@pobox.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 00/11] Rid W=1 warnings from ATA
Date:   Fri, 28 May 2021 10:04:51 +0100
Message-Id: <20210528090502.1799866-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (11):
  ata: include: libata: Move fields commonly over-written to separate
    MACRO
  ata: ahci: Ensure initialised fields are not overwritten in AHCI_SHT()
  ata: sata_sil24: Do not over-write initialise fields in 'sil24_sht'
  ata: sata_mv: Do not over-write initialise fields in 'mv6_sht'
  ata: sata_nv: Do not over-write initialise fields in 'nv_adma_sht' and
    'nv_swncq_sht'
  ata: pata_atiixp: Avoid overwriting initialised field in 'atiixp_sht'
  ata: pata_cs5520: Avoid overwriting initialised field in 'cs5520_sht'
  ata: pata_cs5530: Avoid overwriting initialised field in 'cs5530_sht'
  ata: pata_sc1200: sc1200_sht'Avoid overwriting initialised field in '
  ata: pata_serverworks: Avoid overwriting initialised field in
    'serverworks_osb4_sht
  ata: pata_macio: Avoid overwriting initialised field in
    'pata_macio_sht'

 drivers/ata/ahci.h             |  7 +++++--
 drivers/ata/pata_atiixp.c      |  3 ++-
 drivers/ata/pata_cs5520.c      |  3 ++-
 drivers/ata/pata_cs5530.c      |  3 ++-
 drivers/ata/pata_macio.c       |  5 ++++-
 drivers/ata/pata_sc1200.c      |  3 ++-
 drivers/ata/pata_serverworks.c |  3 ++-
 drivers/ata/sata_mv.c          |  6 +++++-
 drivers/ata/sata_nv.c          | 10 ++++++++--
 drivers/ata/sata_sil24.c       |  5 ++++-
 include/linux/libata.h         | 13 ++++++++-----
 11 files changed, 44 insertions(+), 17 deletions(-)

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ALWAYS copy <linux-ide@vger.kernel.org>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: ATI Inc <hyu@ati.com>
Cc: benh@kernel.crashing.org
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Cc: Mark Lord <mlord@pobox.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Tejun Heo <tj@kernel.org>
-- 
2.31.1

