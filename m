Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A53331162
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhCHOzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhCHOzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:55:31 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46511C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 06:55:27 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id mj10so20944357ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 06:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bnsuh0vq+62rnjm7MYYTgLga5GlY2kr+7IxJtOibpCI=;
        b=N1FVc8Z2tRKpwYH9fL4HKr6THyo8PevHEbp5v/qmeSlrVfPEeD2O4/S67ivryQUiAm
         aHbIGxNRQCHxify3UOabLTHBV+N4iuRCqJGz1dioXQpq6yiOrHxiTpU1B2/04j7FeGYD
         naZAz5C88GdXr02+gdOeKgpp+/vPN5i9r6DE6Jevg/trUbSIPqGOA12rwUmXfk/3xlPE
         gI2iKvVsLM8N4x4iI6yZvqFllB/T5QTPrEFU/UBhAK6dMYmeo9NL18w9OAUhg5WrdFh7
         CZRO1vh1Gqqw4UoKII36MvrLn7gDqM6bTGT1nTcvH49iRiMerZw5pVKwtsOJqOAfeb6n
         C3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bnsuh0vq+62rnjm7MYYTgLga5GlY2kr+7IxJtOibpCI=;
        b=WFHbtWF2lWduts2Y6OihYjNfgYoejdqUayAjQUPjpWPInW4LxXxnZ14LWsCZSKs7T2
         uyyFuLGSvS7YkCtpDoIevS0PK6zYU9do757jnhYQMXzN8uYjdS6GmKZTM129niIF7Oul
         zIlp9l0LpXT9gqzpvToRfacTXv2flpbTgtb9gQ4wqzM323CU3msuC40Fkz7717g5Xt6i
         TAfjcI5CaQNT8h1pmfVL/23C4EtyiN4rkG2q2KoLzXCzzbpcjfx+o+aih+7kG77sUOFi
         h/agx4JfsTTfUHuvdqSyeL8FwJ4CRHT+/JRxo5vC0Atpl0rP3tivrGr0MDertlq/V/Ok
         TtUA==
X-Gm-Message-State: AOAM531CNKCCwI8+NiylTA0pz8sCyrrVaDTNj8Fg7Y7NDg6xGfRAmkw9
        W0azMOiXwNtv7mxYYPI6U1B7SQ==
X-Google-Smtp-Source: ABdhPJycjUzbWfr6Q1XYlchcZzEFGdtIgBWKvfrweQMg1xKHbjHGHXbtsc0WmUKOX45WAIgHuFYsOA==
X-Received: by 2002:a17:906:3c50:: with SMTP id i16mr15683196ejg.175.1615215325807;
        Mon, 08 Mar 2021 06:55:25 -0800 (PST)
Received: from localhost.localdomain ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id bt14sm7411234edb.92.2021.03.08.06.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:55:25 -0800 (PST)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org, elder@kernel.org,
        johan@kernel.org, vireshk@kernel.org, rmfrfs@gmail.com,
        f.fainelli@gmail.com, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, linux@deviqon.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 00/10] spi: finalize 'delay_usecs' removal/transition
Date:   Mon,  8 Mar 2021 16:54:52 +0200
Message-Id: <20210308145502.1075689-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A while back I started the introduction of the 'spi_delay' data type:
  https://lore.kernel.org/linux-spi/20190926105147.7839-1-alexandru.ardelean@analog.com/

Users of the 'delay_usecs' were removed from drivers.

Now it's time to remove the 'delay_usecs' from the SPI subsystem and use
only the 'delay' field.

This changeset adapts all SPI drivers to do without 'delay_usecs'.
Additionally, for greybus we need to adapt it to use the 'delay' in
nano-seconds and convert it to micro-seconds.

Alexandru Ardelean (10):
  spi: spi-axi-spi-engine: remove usage of delay_usecs
  spi: bcm63xx-spi: don't check 'delay_usecs' field
  spi: spi-bcm-qspi: replace 'delay_usecs' with 'delay.value' check
  spi: spi-sh: replace 'delay_usecs' with 'delay.value' in pr_debug
  spi: spi-tegra20-flash: don't check 'delay_usecs' field for spi
    transfer
  staging: greybus: spilib: use 'spi_delay_to_ns' for getting xfer delay
  spi: spi-falcon: remove check for 'delay_usecs'
  spi: fsl-espi: remove usage of 'delay_usecs' field
  spi: core: remove 'delay_usecs' field from spi_transfer
  spi: docs: update info about 'delay_usecs'

 Documentation/spi/spi-summary.rst |  7 +++++--
 drivers/spi/spi-axi-spi-engine.c  | 12 ++++--------
 drivers/spi/spi-bcm-qspi.c        |  2 +-
 drivers/spi/spi-bcm63xx.c         |  2 +-
 drivers/spi/spi-falcon.c          |  2 +-
 drivers/spi/spi-fsl-espi.c        | 17 +++++------------
 drivers/spi/spi-sh.c              |  4 ++--
 drivers/spi/spi-tegra20-sflash.c  |  3 +--
 drivers/spi/spi.c                 |  1 -
 drivers/staging/greybus/spilib.c  |  5 ++++-
 include/linux/spi/spi.h           | 12 ------------
 11 files changed, 24 insertions(+), 43 deletions(-)

-- 
2.29.2

