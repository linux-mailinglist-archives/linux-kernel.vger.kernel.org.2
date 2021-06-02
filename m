Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBEE398864
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhFBLaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFBLao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:30:44 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BEDC061574;
        Wed,  2 Jun 2021 04:29:00 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso2101925otu.7;
        Wed, 02 Jun 2021 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K5fevPJstUQJWiIm0P3H4bavRqRqEEJFThmsFsM+E6A=;
        b=ZawgTmAo1rihBgc+gnpPmyJWYyeRUK9qUmG1sTmbQkDAaASQDKobGgfbXbO7hFQqD7
         usX+Cov5uEFyMq3LWfL3PqPXVil/nl7Tq+xXdZBqRuzcGONN7pPjFvzz7g/XMSQLSX9G
         seVcNNsuS0IswJcVFbzNPV7YL/Ggx6Gu4+/xK3ZJZlcKbVVWxSXrVe3bkUfGRuUM6FRE
         XavD2Y+g6MaLzMmz6XrM044aHqnWdl2tu23iIPoZ5khxM0UahitCgEFQ/jnq6FKJDz0J
         UFy9bPVfgIwOr6/ennZPJbxPe9JtNxLmoRIKScFt1UzTIgBkjRqBOHHJ4hUyOUEjOIpY
         zw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=K5fevPJstUQJWiIm0P3H4bavRqRqEEJFThmsFsM+E6A=;
        b=sdgnnks84DrxXJwYT7T1be4LU21A1K3ebivvaDuBPMVCE2c9+37hFuMasu58lNtn3H
         W6TiX9cCDDQ4m5uFZWxNuy3YhFt4wRVkJI5341zX1rGHCcWCZkBGK247i2WSUPrGiVY4
         FwrIYROsnEINtV3l9kFKedBu9O/nXTYw9yCvTiMp1UNdV64FmzyOJI2g/rwjC70BPilv
         6bdwQyO4x77c6U3TWjLDPEilToC69g05vZ/i5ugmOf+qZsBgAZJ0jwGsj6H/+8VOgj5G
         2MdMXTH56mTh/EA/egQfP9ri9Uep+xkkb1VVUtFtDtvj5RSKs8hIsNVNrZL3rRvFQVxm
         eabw==
X-Gm-Message-State: AOAM533pXGgl0VoZlVSuJxb+eLXecUgPKYjU3Q8y/INaOQ8+g4inbhhs
        KhXlB8aT23ZsIue2pOWJiXPcYGNy6Ys=
X-Google-Smtp-Source: ABdhPJxDNso0jwHy6Uy9dR5fiZjfmxaI9hncHmrJd9UV75lEG0sm/unIAEhY9dqVEbmaFTFYYKIXnw==
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr25479203otl.18.1622633339867;
        Wed, 02 Jun 2021 04:28:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c205sm97121oob.38.2021.06.02.04.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 04:28:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v5.13-rc5
Date:   Wed,  2 Jun 2021 04:28:58 -0700
Message-Id: <20210602112858.2870288-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v5.13-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.13-rc4

Yes, I know, the tag name doesn't match the upcoming version, but looks like
I forgot to send the e-mail last week and I don't want to re-apply the tag.

Thanks,
Guenter
------

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.13-rc4

for you to fetch changes up to f0fb26c456a30d6009faa2c9d44aa22f5bf88c90:

  hwmon/pmbus: (q54sj108a2) The PMBUS_MFR_ID is actually 6 chars instead of 5 (2021-05-17 16:02:05 -0700)

----------------------------------------------------------------
hwmon fixes for v5.13-rc4

The most notable fix is for the q54sj108a2 driver to let it actually
instantiate. Also attribute fixes for pmbus/isl68137, pmbus/fsp-3y,
and dell-smm-hwmon drivers.

----------------------------------------------------------------
Armin Wolf (1):
      hwmon: (dell-smm-hwmon) Fix index values

Chu Lin (1):
      hwmon/pmbus: (q54sj108a2) The PMBUS_MFR_ID is actually 6 chars instead of 5

Grant Peltier (1):
      hwmon: (pmbus/isl68137) remove READ_TEMPERATURE_3 for RAA228228

Václav Kubernát (1):
      hwmon: (pmbus/fsp-3y) Fix FSP-3Y YH-5151E VOUT

 drivers/hwmon/dell-smm-hwmon.c   |  4 ++--
 drivers/hwmon/pmbus/fsp-3y.c     | 32 +++++++++++++++++++++++++-------
 drivers/hwmon/pmbus/isl68137.c   |  4 ++--
 drivers/hwmon/pmbus/q54sj108a2.c |  2 +-
 4 files changed, 30 insertions(+), 12 deletions(-)
