Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0B441FE30
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 23:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhJBVLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 17:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbhJBVLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 17:11:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4896EC061714;
        Sat,  2 Oct 2021 14:09:50 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i4so53984822lfv.4;
        Sat, 02 Oct 2021 14:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxVWflK9zpXBijrFY0ftzOts3Dk+lUJ247YDKOyiFAc=;
        b=oz8KSdimPB+gzkxD/Xhn4mUg/M+SZtIMoe08EH//suN2NVuGQBF3HSh20WxqqSWd+p
         z/ze3KFBc7lp3zcQZrfm/jrW31IXDLMaIVjYJDxES8p28Lz/n17RKJyS6ejVZgrgmw/b
         0/4uuCyhyMFg3blJGuWpBaHUMjqOa7zAu73t+hhQtgFyifqQcTy9qiRVh/ukZiZixZ4p
         baDJXr/fB+zpUj2l89TX5mSMM5CdH0O0dBEuxWwvPX1boybAbdxhfJYknpo35+ND9flY
         /0CIVMFhNyv8y+CaUOsrNnYdKu6pSsjZ4DhXFC3CNjSNgQlSFWRH5E6w9jXyE6Ktfeeh
         IjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxVWflK9zpXBijrFY0ftzOts3Dk+lUJ247YDKOyiFAc=;
        b=YfR0WlM3CR94BV1PuY9aRwfj3EhW9Y0BLd5aN10V+gBGLhtKFu/0/wlG2cJgYJYziU
         riUR3+8t5d+8j7L9ZtZnQK4aCPVHVOvVeYO1djVkugMOdmzkGCSImzpBxteLxRm+wSob
         jmklvGT3p2zzAw06uAChnYTFskVMniInpi+RFDQ6THmJxuNlpQO91un2hAG94kLMHD3I
         56zy4S8RNa5ldC0irUOpWCfReJdm8erUSofIf9awDPqeKvFcgRa5Z2BqEQuMtTuB2ZhH
         hvyINYOl4KJla7EGVvfBDwpnLvDtnxC9zqoYCanc9WbLu4MeQYvd8fmEv0jfZt6D221d
         U2PA==
X-Gm-Message-State: AOAM530hEMRrVajD84u3iaCxMcAqp8yRNCO8HFNxazwS3nMfrgidGpjo
        nQXStTE189/oVYJtkcisoK8=
X-Google-Smtp-Source: ABdhPJyXkHupuq294i47Y4hLPf0YTgK5zQV4FoH5aprUKestpPuJ/3vCguRdn1WzxZLojbGpnsJXxA==
X-Received: by 2002:a2e:8782:: with SMTP id n2mr5831276lji.177.1633208988469;
        Sat, 02 Oct 2021 14:09:48 -0700 (PDT)
Received: from localhost.localdomain (105-28-94-178.pool.ukrtel.net. [178.94.28.105])
        by smtp.gmail.com with ESMTPSA id l9sm279511lje.32.2021.10.02.14.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 14:09:48 -0700 (PDT)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     pauk.denis@gmail.com, Eugene Shalygin <eugene.shalygin@gmail.com>,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH 0/3] Update ASUS WMI supported boards.
Date:   Sun,  3 Oct 2021 00:08:53 +0300
Message-Id: <20211002210857.709956-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to nct6775:
* PRIME B360-PLUS
* PRIME X570-PRO
* ROG CROSSHAIR VIII FORMULA
* ROG STRIX B550-I GAMING
* ROG STRIX X570-F GAMING
* ROG STRIX Z390-E GAMING
* TUF GAMING B550-PRO
* TUF GAMING Z490-PLUS
* TUF GAMING Z490-PLUS (WI-FI)

Add sensors driver for ASUS motherboards to read sensors from the embedded 
controller. Based on https://github.com/zeule/asus-wmi-ec-sensors.

Could you please review?

@Andy Shevchenko, @Guenter Roeck should I split last patch in some way?
Should I add to MAINTAINERS:
--
ASUS WMI HARDWARE MONITOR DRIVER
M:     Eugene Shalygin <eugene.shalygin@gmail.com>
M:     Denis Pauk <pauk.denis@gmail.com>
L:     linux-hwmon@vger.kernel.org
S:     Maintained
F:     drivers/hwmon/asus_wmi_sensors.c
--


BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Co-developed-by: Eugene Shalygin <eugene.shalygin@gmail.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
Tested-by: matt-testalltheway <sefoci9222@rerunway.com>
Tested-by: Kamil Dudka <kdudka@redhat.com>
Tested-by: Robert Swiecki <robert@swiecki.net>
Tested-by: Kamil Pietrzak <kpietrzak@disroot.org>
Tested-by: Igor <igor@svelig.com>
Tested-by: Tor Vic <torvic9@mailbox.org>
Tested-by: Poezevara <nephartyz@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>

---
Denis Pauk (3):
  hwmon: (nct6775) Add additional ASUS motherboards.
  hwmon: (nct6775) Use custom scale for ASUS motherboards.
  hwmon: (asus_wmi_sensors) Support access via Asus WMI.

 drivers/hwmon/Kconfig            |  12 +
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/asus_wmi_sensors.c | 595 +++++++++++++++++++++++++++++++
 drivers/hwmon/nct6775.c          |  41 ++-
 4 files changed, 643 insertions(+), 6 deletions(-)
 create mode 100644 drivers/hwmon/asus_wmi_sensors.c

-- 
2.33.0

