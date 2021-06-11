Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD223A468F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhFKQfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:35:09 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40943 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFKQfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:35:08 -0400
Received: by mail-wr1-f45.google.com with SMTP id y7so6714673wrh.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43YwbbFUjt8PFhuUjKzii9hmVIqVWxK+JjxZuZko7uI=;
        b=YnHeUkeW8R3Cq7lpsbOLRkvy0ucJBZlS4fM+HqqU3pCg+8wge7hj0UlSiMIJozL/dF
         ebrp1biaMzv+SxiX+utsJb+vns1NqxYMjv9Qs7gx4HwHedrRz3MquBlNj7CyXxs0zyLu
         gBkhF1lwOCbhBUnRMZREWzXKb37UaavKMl6sWwJfzdB8T15f1LVTbyypUZ2k779YJkGp
         wH7Zioqksqij0Q4zSCdKm0QLVbpx2nwOpJJBBDoEWhCDmcJ827mu3O3L3dmgpp3NgG64
         x1j2OwsZ5pqOnyXshV97v12EQXwgwF7+jV/jGuB6ftkuwBJz28dYAe1fFm3kzHKZ19qt
         l9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43YwbbFUjt8PFhuUjKzii9hmVIqVWxK+JjxZuZko7uI=;
        b=YwByd/IpJE0nhkofGOQunnajeX0axJHNlCgjcKXxxBFftbgJWKFkUZ+xNEAftcDHqv
         2aTkxnCbEx16KM+wW0+m6yzQk3zGO5SNoad4shjCF6p8HxH54aWIoJMbRiVNRZeCsJaX
         ysZ/SDOqdXT0zxmKY1sHbkeTE9uTk4pfU5LQvYfhik6k0jyBKBQRF2iOO15jqJUVh21x
         +J8+zVFUpTe/GPwTbokwISrABM+ZCVBesASqBm31WkgN+EqrgyIzh25TEE77jZ9Ue9UI
         0Antylv7eyEHffxfcnPIaKXDJ8rlmbyy/wC0mlYS6huVs8OEYiS5WN8sKlvfLcd6mdvM
         fo3A==
X-Gm-Message-State: AOAM531aHdUvkMxT8WKA4y3azuMVs5G9R5z8fUooLyhOyXmpsxxHxOmD
        f7HvamqyVIXVHU/GWcW36lo=
X-Google-Smtp-Source: ABdhPJxS44qmqu2/9J1vEq4hXASoe0gdnhz5wncchQStVJ7A7rqtIlk07GXvE7PnGkDGfpf529XKQg==
X-Received: by 2002:adf:ec10:: with SMTP id x16mr5124817wrn.83.1623429129794;
        Fri, 11 Jun 2021 09:32:09 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o5sm7766169wrw.65.2021.06.11.09.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 09:32:08 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] regulator: Changes for v5.14-rc1
Date:   Fri, 11 Jun 2021 18:33:45 +0200
Message-Id: <20210611163345.3566326-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Liam,

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/for-5.14-regulator

for you to fetch changes up to 380d2b2d5a0491e47dfa250b40e3d849a922871d:

  regulator: core: Add regulator_sync_voltage_rdev() (2021-06-01 12:13:30 +0200)

This is a dependency for some code that's going to go in via the Tegra
tree and has Mark's Acked-by on it. There should be no need to pull this
into the regulator tree, but I'm sending it out for completeness so this
is available in case you need it to resolve a conflict.

Thanks,
Thierry

----------------------------------------------------------------
regulator: Changes for v5.14-rc1

This adds regulator_sync_voltage_rdev(), which is used as a dependency
for new Tegra power domain code.

----------------------------------------------------------------
Dmitry Osipenko (1):
      regulator: core: Add regulator_sync_voltage_rdev()

 drivers/regulator/core.c         | 23 +++++++++++++++++++++++
 include/linux/regulator/driver.h |  1 +
 2 files changed, 24 insertions(+)
