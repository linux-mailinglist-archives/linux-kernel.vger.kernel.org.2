Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABFB3D90D1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbhG1Oml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:42:41 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42790
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235345AbhG1Omk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:42:40 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id E39073FE73
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627483357;
        bh=I1PKEMwXuF82cGlAevCPYveDll1B9ZxnvL7Av9RVEa0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=fDOoCA/wwBv4aFg4tVD6a3qPMsSS6HzGJtyzw+AB9TKVvIa9o6U4vpUBokH7gFC88
         N3hSgIbDCxZ5mi+CgK7xoZ2YJ6e03LUaPe11fyvg6yZ3FoDvb/ajKAFMEVxARVWZCs
         1IYv3faYMlKs8eSYvdKf4GtiJY3zp+6JQgc4lrUpAr972fcS4nkzxAV+2XQ4/yJEi2
         sUqFf9L0kpNCw8o4aU6lweActDtHG96N0fH4MQuzOFvIPOJ6hy7YhO41qbbuadHRf+
         0s7Lf96lvu5XgnCPxNL+nex0uuZ5IrP04y+mAOSp+uKmtWUOB/E4h3sFv9vKdE80pH
         AVCibPpJLJJsg==
Received: by mail-ed1-f71.google.com with SMTP id u25-20020aa7d8990000b02903bb6a903d90so1350439edq.17
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 07:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I1PKEMwXuF82cGlAevCPYveDll1B9ZxnvL7Av9RVEa0=;
        b=uV+Z9ffcsLqoYNreyZDuZjzIJk1f6yyTqOXyZw5XUT5VTaSEguABA1f61ecOrDeljS
         rwqOvbny/l75QG1AzAf1v9h9Srym5KPWg4+foIB5011v+W/4J5LK8NK/VQJGGguq7+Do
         tSuDpNcF4tkpGAdQc5wXNxDiUEqlmyWJbP5zIN1hiMmd3GZfCJxSTebZD4585qTdyeel
         Sw5YpI0keb1BIyAuBGcIPrpG/QjHVbvFg4QHn3vly7qJpal+WAfuYzlIVbD8+CrisqBx
         /navNGGfVCaCdoTOawkR3TjNmlYALaaFHURKAFGXk3XH3Tfh0wLsFi0sH+2yfI0FGtxk
         mwEg==
X-Gm-Message-State: AOAM531iu+VzFRSkLfRooCsZl0K4FJdZDvdkYGNbzAwxnRhN93GomiXy
        wNXXD0dNCLzlui5opygiuQ8yDEGI5fMJowIWjuw8hCEpdmYKDA6rCrQh1FxrvWEAJDLL/0+xXEn
        Fxe98qEPlRxOKUfvsTwJD27LPt4rZJgSlbKX1d2Ds6A==
X-Received: by 2002:aa7:c597:: with SMTP id g23mr186031edq.340.1627483357634;
        Wed, 28 Jul 2021 07:42:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlzVaR6Q3zwsFWtnXgHfb0bnEN67CBw95glR9J9AzgAsrKT/4ZsPZqnlvood7OLi4vWzsLSg==
X-Received: by 2002:aa7:c597:: with SMTP id g23mr186015edq.340.1627483357490;
        Wed, 28 Jul 2021 07:42:37 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id d19sm2683676eds.54.2021.07.28.07.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 07:42:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 0/3] of/gpiolib: minor constifying
Date:   Wed, 28 Jul 2021 16:42:26 +0200
Message-Id: <20210728144229.323611-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Minor constifying of pointer to device_node.  Patches depend on each
other (in order of submission).

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  of: unify of_count_phandle_with_args() arguments with !CONFIG_OF
  gpiolib: constify passed device_node pointer
  gpiolib: of: constify few local device_node variables

 drivers/gpio/gpiolib-devres.c |  2 +-
 drivers/gpio/gpiolib-of.c     | 16 ++++++++--------
 include/linux/gpio/consumer.h |  8 ++++----
 include/linux/of.h            |  2 +-
 include/linux/of_gpio.h       | 15 ++++++++-------
 5 files changed, 22 insertions(+), 21 deletions(-)

-- 
2.27.0

