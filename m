Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F053B41FD03
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhJBQPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJBQPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 12:15:42 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9957CC0613EC;
        Sat,  2 Oct 2021 09:13:56 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id e66-20020a9d2ac8000000b0054da8bdf2aeso13418931otb.12;
        Sat, 02 Oct 2021 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/hcX/JYaM8DBc6e+4N3x+0nWfBmXtTSfCwfrAmAc1u0=;
        b=ayeXpmk2fNVD+hn0tD45NavkhgzGb/ejFpL42v9Da/d1KNZfViXvYOiZMpwT8aTylA
         6nWxgoblsTe0D/TRLCsykTLigT9l3vaJYDvXlOY/oh1mp78A67a4e6vIFNzOmITYmxdx
         lxlLkwR8y8By7W6P9XJsEyIhfRewkvOs+QySsRbjwMK59K2WuNiHHMYfYdsBY260DN1b
         ZFfxRUlxUCpwwnXL1NdXvJWPTABNKakbGwvbbVXs6CXIwKB/ms+YCvuoviuMi1medq+5
         VXGjCb/dr0rM9xvyq5O2lgavEGr1V5FcsCSxte6crfKrSnvjYu5GgplGvr6iErQDWxKc
         pF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=/hcX/JYaM8DBc6e+4N3x+0nWfBmXtTSfCwfrAmAc1u0=;
        b=YkR0fsUUdGa5PX6M8CWhT009gdEmS/j8N/JOZN5X19Kwp50izJLfXsDOnxW6Iqilwt
         V5IyLUlEH3JVVoccV/KTI0whTrDR89Dmb1WcZxsDOunIFxPTcwFpiTV4K2qrBNjQUr6y
         df2izv2dFaDpJXXJOsRs4y9Ldp5YxL+LpQoY91AHJEfWGbzZVMiglnsrUPi2d/E3CCm/
         ieyS9/jrZdYxG7hAg7wPszBQFOSUNVhQWVq3rvw23wMiu0AoIM9LWBgEYUkBr8JcwuXV
         DkXsGNEZf49UlpNAm4py29F+K4NMR+FC42HyWTceKG+PCU+mPVZ9bvjoOHa/adFh+/hr
         OVEA==
X-Gm-Message-State: AOAM533WihgWpysjInj46Du4MGsLrWXcOPFYRZzIV98j1+D0LqkotsG2
        w1ju3kxxnLD600DJus+pfUcESimKZMk=
X-Google-Smtp-Source: ABdhPJzt8th011/MEJfTnnaUNN5wyO6/oD8k3EQj/gH5x02dok8JH5PLJxn/yJnngYBh5xqUukdbqQ==
X-Received: by 2002:a9d:4e82:: with SMTP id v2mr3026711otk.376.1633191236054;
        Sat, 02 Oct 2021 09:13:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w184sm1743421oie.35.2021.10.02.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 09:13:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.15-rc4
Date:   Sat,  2 Oct 2021 09:13:53 -0700
Message-Id: <20211002161353.37484-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.15-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.15-rc4

Thanks,
Guenter
------

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.15-rc4

for you to fetch changes up to dd4d747ef05addab887dc8ff0d6ab9860bbcd783:

  hwmon: (w83793) Fix NULL pointer dereference by removing unnecessary structure field (2021-10-02 05:14:11 -0700)

----------------------------------------------------------------
hwmon fixes for v5.15-rc4

- Fixed various potential NULL pointer accesses in w8379* drivers
- Improved error handling, fault reporting, and fixed rounding in thmp421 driver
- Fixed error handling in ltc2947 driver
- Added missing attribute to pmbus/mp2975 driver
- Fixed attribute values in pbus/ibm-cffps, occ, and mlxreg-fan drivers
- Removed unused residual code from k10temp driver

----------------------------------------------------------------
Brandon Wyman (1):
      hwmon: (pmbus/ibm-cffps) max_power_out swap changes

Eddie James (1):
      hwmon: (occ) Fix P10 VRM temp sensors

Nadezda Lutovinova (3):
      hwmon: (w83791d) Fix NULL pointer dereference by removing unnecessary structure field
      hwmon: (w83792d) Fix NULL pointer dereference by removing unnecessary structure field
      hwmon: (w83793) Fix NULL pointer dereference by removing unnecessary structure field

Paul Fertser (3):
      hwmon: (tmp421) handle I2C errors
      hwmon: (tmp421) report /PVLD condition as fault
      hwmon: (tmp421) fix rounding for negative values

Uwe Kleine-König (1):
      hwmon: (ltc2947) Properly handle errors when looking for the external clock

Vadim Pasternak (2):
      hwmon: (mlxreg-fan) Return non-zero value when fan current state is enforced from sysfs
      hwmon: (pmbus/mp2975) Add missed POUT attribute for page 1 mp2975 controller

suma hegde (1):
      hwmon: (k10temp) Remove residues of current and voltage

 Documentation/hwmon/k10temp.rst | 17 ----------
 drivers/hwmon/k10temp.c         |  6 ----
 drivers/hwmon/ltc2947-core.c    |  8 +++--
 drivers/hwmon/mlxreg-fan.c      | 12 +++++--
 drivers/hwmon/occ/common.c      | 17 +++-------
 drivers/hwmon/pmbus/ibm-cffps.c | 10 ++++--
 drivers/hwmon/pmbus/mp2975.c    |  2 +-
 drivers/hwmon/tmp421.c          | 71 ++++++++++++++++++++++-------------------
 drivers/hwmon/w83791d.c         | 29 +++++++----------
 drivers/hwmon/w83792d.c         | 28 +++++++---------
 drivers/hwmon/w83793.c          | 26 +++++++--------
 11 files changed, 101 insertions(+), 125 deletions(-)
