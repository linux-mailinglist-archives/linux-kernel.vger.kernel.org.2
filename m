Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9173A405D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFKKqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:46:33 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:42916 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:46:25 -0400
Received: by mail-oi1-f177.google.com with SMTP id s23so5354444oiw.9;
        Fri, 11 Jun 2021 03:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KmtLQNVt01SxqlhzNXgyyhe3YPwY/DZFqbcsbWGOgN4=;
        b=bl/7VocYqK8QFrluU82hPfR0mye62qAuKm232TZMhuPlqk0xQnz/31XEhvBw9oJvPs
         UoeBo1Wp0kbIFx5zdCovlBH/XTqdcLGQCVyknTL7DXpUf52wWLbsmT9Zx+JzEac+MmdP
         fhaslW10AYsvlNOyxJ1KZ/GZW/5liIc+VMkoamIiftj2lUITavc8lBGlWhFHkdo8v+Q/
         xuBaUhtAfQf8vGC7pNAG9x0feka46JmTzNUN4IrO3SvvP62Opho1SN7awhpPyX4YgviA
         OI84iw9+zN/jAvh23tDayYswnNsy8FnkZENUrmol1U+6XqnB/d1mA04E6+A2l4jTBAyR
         FAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=KmtLQNVt01SxqlhzNXgyyhe3YPwY/DZFqbcsbWGOgN4=;
        b=JJM0Rq9X++In/+oIMWgRqFfMdOmMSSLaU8a4biVj8bRA/pmWUMWd/R0LAEUqJv4K6O
         +h2Z56jLjbaTC+h6laVUfb66Yj52RWhzCOBspTFsGU0Sv9XCUnSbEn/KKmF9e3aeAQzF
         f39WG/Li965cUVhDlGXbIrMZNKFEbf842cDdf12yu8+rAKju0r+j2s3W13pi3+DCOYEJ
         +rhvhwb3GhlXJshZhIuapg4CKUlzDsnUV2aww3dofkE99Mi0gV2zuB1HXdmVylFOsRKY
         xSstSLQ34/OEC4TNnZhi2bW9v2sF8rYBVbBqY/rLYALXkaBxvpJvNcHW9tw6eHucJyv/
         egTg==
X-Gm-Message-State: AOAM5301bEWFN58K0VXqLM6b4EzbfY30YcokVVVwUT5Nzq8s76IJEoIf
        X9qPXGqKUmnWJ3EjVGPsJvF0QVa67zw=
X-Google-Smtp-Source: ABdhPJyFMjYo2cTTrxo94xo12TTjXApgnNAHuyKCFvONalqBL1gX6X9Xptck3Q7sSDViCb6qqXmJEg==
X-Received: by 2002:aca:f2c4:: with SMTP id q187mr1974669oih.141.1623408192370;
        Fri, 11 Jun 2021 03:43:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w8sm1179304otk.16.2021.06.11.03.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 03:43:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.13-rc6
Date:   Fri, 11 Jun 2021 03:43:10 -0700
Message-Id: <20210611104310.35824-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.13-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.13-rc6

Thanks,
Guenter
------

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.13-rc6

for you to fetch changes up to e13d1127241404f1c3eb1379ac4dd100eaf385b4:

  hwmon: (tps23861) correct shunt LSB values (2021-06-10 08:40:09 -0700)

----------------------------------------------------------------
hwmon fixes for v5.13-rc6

Fixes for tps23861, scpi-hwmon, and corsair-psu drivers, plus a bindings
fix for TI ADS7828.

----------------------------------------------------------------
Nobuhiro Iwamatsu (1):
      dt-bindings: hwmon: Fix typo in TI ADS7828 bindings

Riwen Lu (1):
      hwmon: (scpi-hwmon) shows the negative temperature properly

Robert Marko (3):
      hwmon: (tps23861) define regmap max register
      hwmon: (tps23861) set current shunt value
      hwmon: (tps23861) correct shunt LSB values

Wilken Gottwalt (1):
      hwmon: (corsair-psu) fix suspend behavior

 Documentation/devicetree/bindings/hwmon/ti,ads7828.yaml |  2 +-
 drivers/hwmon/corsair-psu.c                             | 14 ++++++++++++++
 drivers/hwmon/scpi-hwmon.c                              |  9 +++++++++
 drivers/hwmon/tps23861.c                                | 17 +++++++++++++++--
 4 files changed, 39 insertions(+), 3 deletions(-)
