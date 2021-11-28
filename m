Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E98D460912
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 19:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352948AbhK1Svb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 13:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbhK1St1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 13:49:27 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA19C061746;
        Sun, 28 Nov 2021 10:46:10 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id e3so62458997edu.4;
        Sun, 28 Nov 2021 10:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1aHLX1viH/WS2n9CHSEXBPwORlSxbTiU2QKC9Iz83+A=;
        b=ldo+RRt2xa0TkaYt9nsluh77KQr0+Jagv+Lle+tA/35vASAhKmcRbcmdMg8WYhPtJk
         qaRjTYNVT8VdzpQdTBBTMeVLvcLuAk6l62+/CelJfAadDE3OYQAViCbJ6WIPX9RIjL5H
         ZDOJQPtrmhGCsz6rQCnTXOnn8rBxgQfB+nETnBXmgxUfO0QC+JAH7AvYAjnwDnBOw1VB
         +muceCz+yVLXWU5qSuuoiTbr49ZHrkX5Mf+NxgQV8o71pfvKzHdhR6OHR3pE+FEY+O9c
         dPr0AYKCK8jSX/7zK+7vXsu50FNg5gqkll8Tq4sLhbvNM2EPsKK3NtvTk/6tvmrq6hRG
         Y48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1aHLX1viH/WS2n9CHSEXBPwORlSxbTiU2QKC9Iz83+A=;
        b=P17OXokvLUlTHw8tmBPKVZWWmy+7yvfE5dcVbtuz/REsBBNYhx+0zeErldaPKVJd4p
         lDRZye7oz/c+88HKT60u5OclGfwf9jc5o+JCdrwSh7pnZeMMBTbwjVOA+fblOPLLUBBf
         dg2woFesBbN9xPZRy/+f+R2w/QKtwm9i3CecF6DoX/kfYt9NTa9VfP2qjEypMxr+Hl4q
         eYbhaNcMccIF8fi5lHYfuTwxRoYHwsePTHAymY7nK8Km8IbyUPsihgBKrPtuUcdayjWG
         2efSwnav8DzSzcSm7aF6xg88QyMaFQoCetk79lrvyLPb4ikCq5r8Js8YTdN3vlrMqLrB
         M11w==
X-Gm-Message-State: AOAM532Va6Kuf28wpecP9w7Sg3TK+zjtRUgz3YuAhLYypW6QNtJWuJsB
        peTMCjIVQzjbXYDD3d/u8bI=
X-Google-Smtp-Source: ABdhPJzTyp53JAn92mdY4kUb6yEuYbaKSh7TQrat2sTl5Z4dctCJGJBn7D5jEC4vynTHOF7Cm1tSYQ==
X-Received: by 2002:a05:6402:1a4f:: with SMTP id bf15mr67289121edb.260.1638125169115;
        Sun, 28 Nov 2021 10:46:09 -0800 (PST)
Received: from localhost.localdomain ([94.179.32.10])
        by smtp.gmail.com with ESMTPSA id g1sm6072900eje.105.2021.11.28.10.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 10:46:08 -0800 (PST)
From:   Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, platform-driver-x86@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] hwmon: (nct6775) Support lock by ACPI mutex
Date:   Sun, 28 Nov 2021 20:45:45 +0200
Message-Id: <20211128184549.9161-1-pauk.denis@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock by a ACPI mutex that is required for support ASUS MAXIMUS VII HERO 
motherboard. In other case, all methods are returned zero instead of real 
values. Code uses acpi mutex before any IO operations in case when such 
acpi mutex is known.

Patch series adds additional check for chip ID, and if method returned 
zero, all calls by acpi_wmi are disabled. 

@Andy Shevchenko: 
>> Do you need string_helpers.h after this change?
It was not required in the original patch, as it was included as part of 
some other header and I have left includes without changes.

I have a little bit changed conditionals in "add MAXIMUS VII HERO", code 
can change access variable several times: 
* By the default, access is set to direct, 
* after code has checked that wmi methods can return something useful,
* and as the last step code has checked that mutext is existed and set 
  access back to direct.

But as for me, it should be less confusing.

What do you think?

---

Changes in v2:
- Fix commit message.
- Remove default acpi_board_ANY and use NULL instead.
- Use chip ID everywhere.
- Use an anonymous union for mutexes.
- Use temporary status varibale in acpi calls.
---

Denis Pauk (3):
  hwmon: (nct6775) Use lock function pointers in nct6775_data
  hwmon: (nct6775) Implement custom lock by ACPI mutex
  hwmon: (nct6775) add MAXIMUS VII HERO

 drivers/hwmon/nct6775.c | 364 +++++++++++++++++++++++++++++-----------
 1 file changed, 263 insertions(+), 101 deletions(-)


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.33.0

