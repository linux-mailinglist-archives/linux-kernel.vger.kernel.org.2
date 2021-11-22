Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168414596AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 22:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhKVVcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 16:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhKVVcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 16:32:12 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF9EC061574;
        Mon, 22 Nov 2021 13:29:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d24so35268687wra.0;
        Mon, 22 Nov 2021 13:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YU04lNfSw6056ENwW5csldH8LgLJmhuf/rxtXEphcoU=;
        b=HXoISZE70aA5DDHoEVLz7DmaYsveCifR+QMkfPVic7M6QWJwR9pYK5OoAH6Vsm/XyO
         p9lJV/I6elOyyWJXkyCpqcuJrzdfJXCbkX/3UwL3j6XxiEkO0Q+sBKxj3dR+cCa5w+5B
         ApSbp/Z5YhqFye0V/3JMgCOU0hdDP46dpq0aGly8ijcE0dTnmNN9pYcKHv/nVwnsZycG
         KfBQuAXI0aI3mbcyGML4flyiFlBKO8mdQtbj09JBGxv5xXwHKFnGY4BAc58TQitGeRJt
         99CxEuYXg7frCu1fEF48zDl0j7xM1a9yN1iyCsK+bsJ2Ly/7IgRdqWWD6OJrQh6CeAY2
         8e1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YU04lNfSw6056ENwW5csldH8LgLJmhuf/rxtXEphcoU=;
        b=sxFtcudcL1Qj38mrMnfDGV5PbEkJrpZuYIEGlqTXFG5nc4vCnxKSJIekyzHNXXvv8/
         r4/6QUgWAUcwRQ+ZUgrqGMWJA/zcLSmwSb9AAhBqS2CLN+NzvflWwuGv5QHSnoRD7qoE
         s5bTBCQZn8OhW6tSD7+03woKoLJpDz+G67X5Mt4B23o4NN2zrN90wgUOyoB4hHfZdGfV
         9L2LR5ktoLpjVOPFrVu9/Wlg0lMzhZbiB8LjicUvFByaYbaDr189bZz/n6rPK3+RrvMO
         xOwxjuLb9owwHz8ilc/nEdRCiLGaCMAUDG7ipnFS+dmjMsFI/GbiV7aVY/GIPhV5Q4T2
         ArTA==
X-Gm-Message-State: AOAM532BT2gZo6LlHt3ZQAcWzukNBL3HdqPdnLhdUTZ4Aaw5H4cjS2pw
        EFqLYx4x+pnIMuo8PAKw3/UFD2n8zQzcEQ==
X-Google-Smtp-Source: ABdhPJyuj49EFk3Dr9T0ATIMCiynQw5lRpDWlCzxQX1jX0LvirdarrPgCsBim1jWUMmycRMf33+ViQ==
X-Received: by 2002:adf:ea0a:: with SMTP id q10mr428797wrm.1.1637616543976;
        Mon, 22 Nov 2021 13:29:03 -0800 (PST)
Received: from localhost.localdomain (149-45-179-94.pool.ukrtel.net. [94.179.45.149])
        by smtp.gmail.com with ESMTPSA id k8sm9767928wrn.91.2021.11.22.13.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:29:03 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        thomas@weissschuh.net, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] hwmon: (nct6775) Support lock by ACPI mutex
Date:   Mon, 22 Nov 2021 23:28:47 +0200
Message-Id: <20211122212850.321542-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock by ACPI mutex that is required for support ASUS MAXIMUS VII HERO 
motherboard. In other case, all methods are returned zero instead of real 
values. Code uses acpi mutex before any IO operations in case when such 
acpi mutex is known.

Patch series adds additional check for ChipID, and if method returned 
zero, all calls by acpi_wmi are disabled. 

Could you please review? Is it correct usage of ACPI mutex or better 
to use some other method for reuse same ACPI mutex?

---

Denis Pauk (3):
  hwmon: (nct6775) Use nct6775_*() lock function pointers in
    nct6775_data.
  hwmon: (nct6775) Implement custom lock by ACPI mutex.
  hwmon: (nct6775) add MAXIMUS VII HERO.

 drivers/hwmon/nct6775.c | 358 +++++++++++++++++++++++++++++-----------
 1 file changed, 259 insertions(+), 99 deletions(-)


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.33.0

