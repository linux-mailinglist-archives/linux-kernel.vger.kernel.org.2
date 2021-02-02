Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE0830CA6A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbhBBSsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbhBBSpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:45:17 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE746C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:44:36 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n10so15450505pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqYAJ+nDIkVEKnS+v7ZhHGM7/OU8LF5OYhbV8HTOckE=;
        b=EbqJ0Eurb13i9Kw7vv82CpFT7VlQSyoOtUH5W4u37wAbfax4UUXya1SmKJ0iwKaSfl
         VxqsOSzQDWUmkiJI4xt6F6HBcRKZy5gKku7bXr0dp7tUWLHFYIvMJDmUXHVs0bRIGASq
         qFzeb8ioYMyL4PqV4ZhFRHd8THUyK4izEz8XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pqYAJ+nDIkVEKnS+v7ZhHGM7/OU8LF5OYhbV8HTOckE=;
        b=RJDeTPvvChbUf7Hp9C5Mb6jh1VpyMNjstKbCo1QuxIV7UbC/cp+NYL+GKTNlCacOes
         aZoeOwJ77HnB7sJdkd8nTMXeANhPFj29HmRW+HMA/MzBOR42GqdQS5b9urfjERp2Kh/l
         wI8kQFdDVnGas30qQQBeyfh20SsMbWxJGakBRne1b+saG/MPCnJdAI6SwA5m/oYwZgtB
         rNhj0vV/vTyeo+tNxpreSy/gQj6hks3GoV487GDsrnb40nkNg3w+uoVxPPNVrPLtMsiD
         lCL1Umfer0IQD2xMKhTWD550O3W668W2eaLpwXLN5cZkAPF9g3MxUnUweQBrU3oiUs7F
         4xpA==
X-Gm-Message-State: AOAM533FkiyA0sAQCyhK1l78dZs46D3+I4wVb5XfRtg+NIaSryaMS3Iq
        XWwMyl8MLRMjFu8XaEF5sOds5+jR6nJKQQ==
X-Google-Smtp-Source: ABdhPJx1CNpkVUy6oY3ybTfZeELGCkt9kxOASEb/AynyM8HGSLE0OxMZky3E0lP+gxQBbqJcpAo5xA==
X-Received: by 2002:a63:2009:: with SMTP id g9mr23088703pgg.219.1612291476245;
        Tue, 02 Feb 2021 10:44:36 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3571:bd6e:ee19:b59f])
        by smtp.gmail.com with ESMTPSA id b21sm23159859pfb.45.2021.02.02.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:44:35 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCHv4 0/3] iio: Add a ChromeOS EC MKBP proximity driver
Date:   Tue,  2 Feb 2021 10:44:31 -0800
Message-Id: <20210202184434.42644-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a different approach to [1] where I tried to add this proximity
sensor logic to the input subsystem. Instead, we'll take the approach of
making a small IIO proximity driver that parses the EC switch bitmap to
find out if the front proximity sensor is detecting something or not.
This allows us to treat proximity sensors as IIO devices all the time in
userspace instead of handling this switch on the EC via the input
subsystem and then other proximity sensors via IIO.

I propose this is all merged through IIO subsystem. Please ack
the first patch so it can be merged that way.

Changes from v3:
 * Added SPI and cros-ec wrapper nodes to yaml example
 * Ignore notifier registration return code that is always zero

Changes from v2:
 * Check iio clock and use IIO time if not boottime

Changes from v1:
 * Driver moved location
 * Put mkbp everywhere
 * Fixed up DT binding to not fail and make sure is a child of cros-ec
 * Simplified logic for sending a message
 * Dropped CONFIG_OF usage
 * Sorted includes

[1] https://lore.kernel.org/r/20201205004709.3126266-1-swboyd@chromium.org

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: <devicetree@vger.kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Stephen Boyd (3):
  platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY MKBP define
  dt-bindings: iio: Add cros ec proximity yaml doc
  iio: proximity: Add a ChromeOS EC MKBP proximity driver

 .../google,cros-ec-mkbp-proximity.yaml        |  46 ++++
 .../bindings/mfd/google,cros-ec.yaml          |   3 +
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   1 +
 .../iio/proximity/cros_ec_mkbp_proximity.c    | 242 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |   1 +
 6 files changed, 304 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/google,cros-ec-mkbp-proximity.yaml
 create mode 100644 drivers/iio/proximity/cros_ec_mkbp_proximity.c


base-commit: 19c329f6808995b142b3966301f217c831e7cf31
-- 
https://chromeos.dev

