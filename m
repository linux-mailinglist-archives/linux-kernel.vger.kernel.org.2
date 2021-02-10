Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB1C317362
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhBJWbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbhBJWbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:31:01 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91F3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:30:20 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id b145so2251396pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+QJXkuBE0EcskODI67dDLG/EouRi6CorwRUDEaVztU=;
        b=cDckGXbaJyAfxdfRYA2hh9GVQLzR2nSd+LnIUI1ZKVs2XITR7aOVAyKsRmqHeNqWEY
         koWMWbDZIyOVAHtPtgVmMZZVTe73DRmxwVHTN4uD/1jpFgAXC4KZuKl6oQNMj0IzT49j
         2YOuh95DgOGBWk0CB5W9nYejqAEqcZxsT2cXzSjydKUMrMsIA90pcmd9YjRtEStYd+zy
         FB4pE1XT/0vVYOhAi+I2Fr3x7HBXRaDAF0LSDGnpHyIOHBHLshEgPXYi2o2tWaHH8+8Z
         b5g0rGen2FWzsm3cn3GwemYygFzaN8TlbO7f6uDXIYAjJHhxkrd4AjdBtoJdTcRv5d/H
         CX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r+QJXkuBE0EcskODI67dDLG/EouRi6CorwRUDEaVztU=;
        b=dQeHq/cGU0U/0BCq+gc6K2m8wqY/jhCASB35S4o46lC8l1oocJQbooYtw32OmmGq7y
         9tDD/D8yCnaZMBNIQrR5G02ZEojXjmgzcddETXJLMjqP8YGP/6jnIZ1Mb4+sXk1rhdtW
         eXxMH1VhXg0oryYk7mw8s5aJN0UV18RclL/pG8vVyhnxULOOu1HlHs3X5Ee63286ouhO
         cDfxA4TKmhICq+bI59mYxVpwniJDxmG9GpNUQR1umhWJ8gf8waUqi3sRf2Z0y++2sc3f
         hW1nsAxF9CW7eExpSDguIRHajJCWYvVZAMejnfLON4LsVzBZpJ4XzjjLPp8bLxT+WzqU
         FM4g==
X-Gm-Message-State: AOAM530hcmk1HPemAsVQtSNJZkZ+U+6uT4HqBHiSf2mWRC26Ab67icGA
        5UvuFDJD2mW99YVk9qve2ECFYg==
X-Google-Smtp-Source: ABdhPJxsUwH76rLptCf2BhfCdx+phjW+Q5xAxtrXnTUfNHqs+XHNxhWsEhKIyIomjJTwSW4/ZPF4bw==
X-Received: by 2002:a05:6a00:138f:b029:1b8:b9d5:3a2c with SMTP id t15-20020a056a00138fb02901b8b9d53a2cmr5480406pfg.10.1612996220223;
        Wed, 10 Feb 2021 14:30:20 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:7b19:df69:92d6:528e])
        by smtp.gmail.com with ESMTPSA id t17sm3686307pgk.25.2021.02.10.14.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:30:19 -0800 (PST)
From:   Drew Fustini <drew@beagleboard.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v4 0/2] pinctrl: pinmux: Add pinmux-select debugfs file
Date:   Wed, 10 Feb 2021 14:28:50 -0800
Message-Id: <20210210222851.232374-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series first converts the debugfs files in the pinctrl subsystem to
octal permissions and then adds a new debugfs file "pinmux-select".

Function name and group name can be written to "pinmux-select" which
will cause the function and group to be activated on the pin controller.

Notes for PATCH v4:
- correct the commit message in the second patch to reference function
  and group name instead of integer selectors. Apologies for not fixing
  that in v3
- fix typos in cover letter

Notes for PATCH v3:
- add Suggested-by: Andy Shevchenko to the "pinctrl: use to octal
  permissions for debugfs files" patch
- change the octal permissions from 0400 to 0444 to correctly match the
  symbolic permissions (thanks to Joe Perches and Geert Uytterhoeven)
- note that S_IFREG flag is added to the mode in __debugfs_create_file()
  (thanks to Andy for highlighting this and Joe for suggesting I should
  add a note to the commit message)
- fix order of the goto labels so that the buffers are freed correctly
  as suggested by Dan Carpenter
- move from devm_kzalloc() to kzalloc() as the buffers are only used
  inside the pinmux_select() function and not related to the lifetime
  of the pin controller device (thanks to Andy for pointing this out)
- correct the pinmux-select example in commit message to use the
  function and group name instead of selector (thanks to Geert)

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
 drivers/pinctrl/pinmux.c  | 111 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 114 insertions(+), 7 deletions(-)

-- 
2.25.1

