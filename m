Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292943BE97C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhGGOQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhGGOQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:16:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E1C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 07:13:41 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id k8so2884467lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=phystech-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g5y2U6uok/0so0eFkpqI39QSbZF7lC9EfSeNA/R2eiU=;
        b=b69y5epbfVrMskok7SBd1fb6b+hS2UNHIjBQpCvisPd9gFak1ZIcM1t+CCpoHXjx48
         AYqnzcVvvaYeOw5tbYaLmdMEmNJ9epDabUQTTJxMY6CkFbF4Af3SXV3nQ3XQ3QuPuOLx
         wjW0pncMm8r57xkk0W14y2f/V4kfTptIqomWgvad66QefRyb5ZFIjfyCcgxnaP4tX4Jn
         5oLRPogaJswJY0tBQ8mLfaxN4Tw4R00hZibCFs5IAd/Z4NrRVsc8I5Z5lxpYWMP+duiJ
         qbDG0vkhPcmo8sl3NI2eEZx9L4H7bxYsVcCg6dLHzkGliujExF0U2bdlgRjhx/EKi+wc
         Nc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g5y2U6uok/0so0eFkpqI39QSbZF7lC9EfSeNA/R2eiU=;
        b=Dvt6b+NJhht0APbtpQMcsiioKzNGkdTxGFrB2SPsOiLTQ8mlfK7BiYqovxDSZHmF/C
         KaGMlf15Wiho+4XR8bPIU+jFT3M6lN3TTAPp/Z/ne7z8Dz2dSMD/70P1IgR1PBI8Xpro
         j+Mmnfk7nrtumOekU98Wo/z78cyJOy3SR0Gd/1+6uwcFSUXgSuUtiQe0VTUU3I7bW4N5
         HP5Zzwv4qo6ugtaiKydf/PQAi20jcwZO2OoE+mrkaTWyknPA3D+RC/vHT6yzTNjK/jN0
         2IvbcpucsjCDVdXoC9s2lUumGiAx0jFmRDPEr1j9RzcVE2/fa39Zb71JCHXHRzg2bmTB
         EO2Q==
X-Gm-Message-State: AOAM533ulW1kKkYy9aGpiwHi4k5Afy5g7fubF42ZwFO+zhEsOGSpPt55
        8VbO2lU0kUGITnkU9eyM/cr0GQ==
X-Google-Smtp-Source: ABdhPJwFZTZe2iloQ3VAroTCsguHeU1FjVUp8cYQVAbXI7WPISb1E0nxwT/5jQC8Z9Ebykwsatgwgw==
X-Received: by 2002:a2e:6c10:: with SMTP id h16mr19473010ljc.234.1625667218555;
        Wed, 07 Jul 2021 07:13:38 -0700 (PDT)
Received: from 192.168.1.3 ([2a00:1370:810e:abfe:9c62:44e3:b0ab:76fd])
        by smtp.gmail.com with ESMTPSA id a26sm205077ljq.120.2021.07.07.07.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 07:13:37 -0700 (PDT)
From:   Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To:     sean@mess.org, mchehab@kernel.org, robh+dt@kernel.org,
        khilman@baylibre.com, narmstrong@baylibre.com
Cc:     jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, rockosov@gmail.com,
        Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Subject: [PATCH v2 0/2] media: rc: add support for Amlogic Meson IR blaster
Date:   Wed,  7 Jul 2021 17:13:21 +0300
Message-Id: <20210707141323.20757-1-viktor.prutyanov@phystech.edu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a driver for the IR transmitter (also called IR blaster)
available in some Amlogic Meson SoCs.

Viktor Prutyanov (2):
  media: rc: meson-irblaster: document device tree bindings
  media: rc: introduce Meson IR blaster driver

 .../media/amlogic,meson-irblaster.yaml        |  62 +++
 drivers/media/rc/Kconfig                      |  10 +
 drivers/media/rc/Makefile                     |   1 +
 drivers/media/rc/meson-irblaster.c            | 433 ++++++++++++++++++
 4 files changed, 506 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,meson-irblaster.yaml
 create mode 100644 drivers/media/rc/meson-irblaster.c

-- 
2.21.0

