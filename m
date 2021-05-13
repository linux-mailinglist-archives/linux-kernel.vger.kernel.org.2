Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2293037FA27
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhEMPB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhEMPBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:01:53 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7BC061574;
        Thu, 13 May 2021 08:00:39 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id q5so13894826qvv.6;
        Thu, 13 May 2021 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gINGHNIp9fLgKFmTm97LYNhcTzUb6kk121jS5ZhlgcA=;
        b=LYx2xLu8KnyfPq3uZbX8GywTEOddG7iHv6eb3hP5UBJ+Ji/n69qYoZowwHCt3N4RCP
         9wkJLTNSCuQrG9U3eTFJhWpCV/0+YDsTWeJjG5vbZ3WR7pu+tZMeu6WRnEFm/63o1H1s
         Qv1MIVAE6gin4h+aW7Gc0HsRz6DeDS6hpSuX7/TfC+S9rA1faHWtOdg9zWp7U5qoTfWd
         oX0UMxk6kI8EmLujDXOcl+d6pjy47fFtJ5Mw14aLSQkDC5mx3GsZfizdTC1pHjhZ+3ea
         OVUddAWO6UJNSryEZk75uA0+17vazX9yic9RZ1Nb/3CR08C9qV3k4WV4Gj8GLxGhXFec
         emuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=gINGHNIp9fLgKFmTm97LYNhcTzUb6kk121jS5ZhlgcA=;
        b=adVfv5yVSIwONIEdkTD/1n1jdjr4PulFNGG9ma3HPzEXfqXQQVl5vGJ7PwX99RLSM9
         WbsGyTZPdDbNHWvUZE75NQzBF+Ljw9ZmpFVjThw6IK4pbI8stR+1178vThXiBwDvsB+B
         ZOY7muWcjmY6DDYJv6U0YoktuhoJfVqzPQEIucL//FuuMiu0SKKb77XRg0U6bCEw/bLm
         tAfkHoIFa5w+pAoorhnuNo8i/WF2vBbYUF52TpYt8Q2GhCmsyMI4bPTNuAzALNz81TW1
         Ay7kKchdZjVZF6bGA0xpFDM95bi75hbkPnge5Sfj6hXSIsJBWvnaGv9rQ81nU5nZhfYs
         J+hg==
X-Gm-Message-State: AOAM531gqte8EjhcrVvtl+jw7qzHpnw5JdDLq3rxcw7wo+iAATHP96sx
        mHNwv5/FAV+pVEhp4vcQtGmZznYrFag=
X-Google-Smtp-Source: ABdhPJw5LU5sFHaoynPuoMZgUWAim20P1KUZSjWJ3qcZPp8a1jXzrcVE7axCcxXvARdasKpkbXHgdA==
X-Received: by 2002:a05:6214:19ed:: with SMTP id q13mr41505413qvc.58.1620918038983;
        Thu, 13 May 2021 08:00:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i9sm2735830qtg.18.2021.05.13.08.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 08:00:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.13-rc2
Date:   Thu, 13 May 2021 08:00:36 -0700
Message-Id: <20210513150036.3199353-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.13-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.13-rc2

Thanks,
Guenter
------

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.13-rc2

for you to fetch changes up to 3b5169c2eb81e822445469a077223f8eb0729a59:

  hwmon: (adm9240) Fix writes into inX_max attributes (2021-05-12 18:53:11 -0700)

----------------------------------------------------------------
hwmon fixes for v5.13-rc2

Fix bugs/regressions in adm9240, ltc2992, pmbus/fsp-3y, and occ drivers,
plus a minor cleanup in the corsair-psu driver.

----------------------------------------------------------------
Andy Shevchenko (1):
      hwmon: (ltc2992) Put fwnode in error case during ->probe()

Eddie James (1):
      hwmon: (occ) Fix poll rate limiting

Guenter Roeck (1):
      hwmon: (adm9240) Fix writes into inX_max attributes

Václav Kubernát (1):
      hwmon: (pmbus/fsp-3y) Fix FSP-3Y YH-5151E non-compliant vout encoding

Wan Jiabing (1):
      hwmon: (corsair-psu) Remove unneeded semicolons

 drivers/hwmon/adm9240.c      |  2 +-
 drivers/hwmon/corsair-psu.c  |  4 ++--
 drivers/hwmon/ltc2992.c      |  8 ++++++--
 drivers/hwmon/occ/common.c   |  5 +++--
 drivers/hwmon/occ/common.h   |  2 +-
 drivers/hwmon/pmbus/fsp-3y.c | 27 +++++++++++++++++++++++++--
 6 files changed, 38 insertions(+), 10 deletions(-)
