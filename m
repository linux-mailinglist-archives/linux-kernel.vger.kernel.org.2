Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638EB31605D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhBJHvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhBJHvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:51:20 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87922C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 23:50:40 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e12so756267pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 23:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dTtAvYfpCAcrkzC7wHtQialOzV1hp5H4iMa/77gI7mk=;
        b=eWZSDwoGqrZMTV/VLE4FtZw4sBdMmTx5WkshbNDjoBWjyGkvjUTjehzIsjlRTNGBIj
         xqMIV+Ec57zH1hmba6n6ajF40OkNARptoo/pOdXdQCsg1UuyhQbGGW7jNI6GwgUQ89uX
         MasfuQ6fQwPsLeBDrdTGPI0Ba6lT7ipg9eOXwKWeh341v+G1LCyi/6k5/eBH+jtj2bSF
         PXtQqaPG0UMv7Ocl/SpeoKHWixb5hfWx4XhxdmQflO1H74aMROGangUw7aAPPHvj/uuO
         +KXvTx6eoP51cJ3lpv4+X8f3FBYakq0uYrcowrTiZuXAt00NDZ36ANqcdtiONfeILL7+
         +omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dTtAvYfpCAcrkzC7wHtQialOzV1hp5H4iMa/77gI7mk=;
        b=ImVcryOTIHKB0YAlFXonsKB/oz+Ds7zK4ysku4GNbnJsnNZmNCwYA6/ny2Ampu45k5
         VTzR2/K8lQdHakvl/e8QNtqRLfOzOggU8va0FtpLzzhF9jOOLqv/HyCaxgW7BhfKo5s+
         /hmuozbdMrV6rtKXjNAsfseV3Jk762dIxetXzmRn2biAJ5uDdZQJISqZfdweeOwnPmW+
         cOQ8AjUs26ufoSvTJZvZeIrrIBR5SJfXHPbPLHcm4hWcInnx5UQK8op6jwhD4jxfeN2E
         OMUCY94bJ53Oc/TZJ7lZZRhdnS3O5qvlExHHKxCso7/PhWFQXclHsR314WVGgNGQXbSK
         SzQw==
X-Gm-Message-State: AOAM532B4n51l+yPPNK835henAnT1ZoKio9DMNofJ57i7Kwlcs7pIJGI
        Y6UJLu/nVPtKp1ifcRyDp80pXQ==
X-Google-Smtp-Source: ABdhPJxHIKSl0BtQ9fc8/TOqMq2PgYbqhBz09VnwjEFmn4XRd1fL1x4zXAjRA452FJMkcpPJfsZGJw==
X-Received: by 2002:a17:90a:6944:: with SMTP id j4mr1938527pjm.48.1612943440074;
        Tue, 09 Feb 2021 23:50:40 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:7b19:df69:92d6:528e])
        by smtp.gmail.com with ESMTPSA id b25sm1261710pfp.26.2021.02.09.23.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 23:50:39 -0800 (PST)
From:   Drew Fustini <drew@beagleboard.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v2 0/2] pinctrl: pinmux: Add pinmux-select debugfs file
Date:   Tue,  9 Feb 2021 23:49:45 -0800
Message-Id: <20210210074946.155417-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series first converts the debugfs files in the pinctrl subsystem to
octal permissions and then adds a new debug file "pinmux-select".
Function name and group name can be written to "pinmux-select" which
will cause the function and group to be activated on the pin controller.

Notes for PATCH v2:
- create patch series that includes patch to switch all the debugfs
  files in pinctrl subsystem over to octal permission
- write function name and group name, instead of error-prone selector
  numbers, to the 'pinmux-select' file
- switch from static to dynamic allocation for the kernel buffer filled
  by strncpy_from_user()
- look up function selector from function name using
  pinmux_func_name_to_selector()
- validate group name with get_function_groups() and match_string()
- look up selector for group name with pinctrl_get_group_selector()

Notes for PATCH v1:
- posted seperate patch to switch all the debugfs files in pinctrl
  subsystem over to octal permission [1]
- there is no existing documentation for any of the debugfs enteries for
  pinctrl, so it seemed to have a bigger scope than just this patch. I
  also noticed that rst documentation is confusingly named "pinctl" (no
  'r') and started thread about that [2]. Linus suggested chaning that
  to 'pin-control'. Thus I am planning a seperate documentation patch
  series where the file is renamed, references changed and a section on
  the pinctrl debugfs files is added.

Notes for RFC v2 [3]:
- rename debugfs file "pinmux-set" to "pinmux-select"
- renmae pinmux_set_write() to pinmux_select()
- switch from memdup_user_nul() to strncpy_from_user()
- switch from pr_warn() to dev_err()

[1] https://lore.kernel.org/linux-gpio/20210126044742.87602-1-drew@beagleboard.org/
[2] https://lore.kernel.org/linux-gpio/20210126050817.GA187797@x1/
[3] https://lore.kernel.org/linux-gpio/20210123064909.466225-1-drew@beagleboard.org/

Drew Fustini (2):
  pinctrl: use to octal permissions for debugfs files
  pinctrl: pinmux: Add pinmux-select debugfs file

 drivers/pinctrl/core.c    |   6 +--
 drivers/pinctrl/pinconf.c |   4 +-
 drivers/pinctrl/pinmux.c  | 110 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 113 insertions(+), 7 deletions(-)

-- 
2.25.1

