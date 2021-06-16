Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7243AA300
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhFPSSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhFPSSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:18:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55054C061574;
        Wed, 16 Jun 2021 11:16:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t7so369330edd.5;
        Wed, 16 Jun 2021 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P+8h2g83qtLoWNEKi+lvDz0GDalziHy5ge6TIRqp0fw=;
        b=ZYZ0/jf0tb6htGtlneyPf1sYtBxmgRZL/ek1xpfaHDuH9Oh+QrzqptaYCFqMhNn/ve
         v4ylenGVJx8B4zBtFwsrbdRwx1MmUheAjZGttyCXyZR4K4t2I9UxAC7x7WhT7D3zqw7y
         ACVw9AygwwOy8c/iwDjjjnTpDbMrb6GtL/7bH3h2TkH5cCsTqqIF01BQkSALPH6P9X0C
         y4ryY0WdV1ZL7GJHunUH3br8UjrUhKXPixwTYcLig6imX/YwERnXtL0eBWH1ls8Irirn
         nW6jFka4P+aTiVxZaqOnwlCSR8gtfeh+KPSeJfR0mjEWWlMSkdPsR9k2q7d6hSkrty5v
         rqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=P+8h2g83qtLoWNEKi+lvDz0GDalziHy5ge6TIRqp0fw=;
        b=f0xpL/JTpIUqbTO07Ykclzy7ndBoJEe5D/gLA4xggvcMIJN3zefJp3e6yx+B+aFwiE
         3u6Ik5MPq6bnsBIwGnBqf8ofc2kP5Vw5KorpCWmkAiaG0shwl5I9W1SYGCbd81F/X1l2
         25N/63TFC+OholWZMrs2XVzlU57Y741yWnYdK+o21MD28dclmy6GkqQkEqGqLmcPhHTs
         g8b05fY9cGdojCoHPcwyyjlI/pe6Okc/iKuDco7kEw9GZRqhChINbMJvcyaOqZkcoJj6
         DIqhwVP3p/QHW5lBnDUEOg/GRIC5HUGjWk4tkuR4fUYdWuBHxoSBPD293f609RMRAh9A
         kkzg==
X-Gm-Message-State: AOAM531Ruu+vggX5sa41a5oaKhkznV/+VhsCIFOyfygQXnXNNv+9iP8/
        DSohpBsEzCawv5UFsrh+N+k=
X-Google-Smtp-Source: ABdhPJw4q4goMYkai3VPWPGh8Y4YrUbpwyxSUApO9ILk3AzTZO+Sp3v7fkKPbu/FbALnRpX+gzYIiw==
X-Received: by 2002:a05:6402:1103:: with SMTP id u3mr327127edv.342.1623867363912;
        Wed, 16 Jun 2021 11:16:03 -0700 (PDT)
Received: from stitch.. ([82.192.166.82])
        by smtp.gmail.com with ESMTPSA id p10sm2439599edy.86.2021.06.16.11.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 11:16:03 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Samin Guo <samin.guo@starfivetech.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] hwmon: Add StarFive JH7100 temperature sensor
Date:   Wed, 16 Jun 2021 20:15:43 +0200
Message-Id: <20210616181545.496149-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a driver for the temperature sensor on the JH7100, a RISC-V
SoC by StarFive Technology Co. Ltd., and most likely also the upcoming
JH7110 version of the chip.

The SoC is used on the BeagleV Starlight board:
https://github.com/beagleboard/beaglev-starlight

Support for this SoC is not yet upstreamed so feel free to not merge yet
but I'd love some early feedback.

/Emil

Emil Renner Berthing (2):
  dt-bindings: hwmon: add starfive,jh7100-temp bindings
  hwmon: (sfctemp) Add StarFive JH7100 temperature sensor

 .../bindings/hwmon/starfive,jh7100-temp.yaml  |  43 +++
 drivers/hwmon/Kconfig                         |   9 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sfctemp.c                       | 309 ++++++++++++++++++
 4 files changed, 362 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml
 create mode 100644 drivers/hwmon/sfctemp.c

-- 
2.32.0

