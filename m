Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6FF3235E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 03:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhBXCsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 21:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbhBXCsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 21:48:24 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FC1C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 18:47:43 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id k13so590925ejs.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 18:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=plyZ7GAQ1sguodJFZWB3Wyxamln+YuknxjJ8VQ+lmZk=;
        b=uU6NdlHQLS5/m8Y+LINo6vG60n9UKXoXhUiHlmlu29jVNsub+K0p/vq0FubPFDlcLE
         35hop0g4y2GKwmMcKxaOifKyhuS55u7KpxjbYh/uUEaV3JKDOBo3VGuUmsqB4gLC+NRd
         SHiJ+HUroN4NG7qJ7j/qyjD2mJKQ8upzL1C/2X3Rbixp2J3zJek73/2f/FpiWfgydaU8
         eSnaERxkwJGXLCSnFKiQ8eKFC19VGN4eE1ZhZ/Iq/QUQgYcaoNnM6DKGWMQsI/qUDmlO
         k8TYSQMudoWbhWXToIXMlN6rAkbw42Z3jiSHodBFsL+ykFwQCI8D6La+0kqC+O/Ykym9
         +Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=plyZ7GAQ1sguodJFZWB3Wyxamln+YuknxjJ8VQ+lmZk=;
        b=bY5oO003yyzrFu6LSzB770wDhhCG+epC6mPR1iBYNtDWj7byvW62Hrh4b1vconJL2P
         +E8eDJ+1f947AvVj+Md5bR/AejUbuxoNi3yQ7CUqkMgV13b/E8MqyIJVCodGg6hGjUX3
         kzfqroWwl085Y4QmqGPkqRRADAtslSq8FS8xfpyrVLl2JJtgX9JKkprzJxtvR4QomkiJ
         NKJwFT6tsjx41AxZ0BNklpVDWiIDV4sDYm3a1DlpsrmXFoUKk/rDFUspR1k4QmP3HSQR
         qTckV6whc4TFNDt5dXfTKAXofI50J+IbhkCjfwrrNXqbdEP+K/7y5exnZNDg6xJmNFoy
         KXzw==
X-Gm-Message-State: AOAM530Jwvs5q3OHyRPLiLTYUxMbYjh23LwqHTaHI2qAVzxzudcOpvqq
        mFhor0Sls4hxM7oMY1ckgwUWR7fV+/hUCagQlLzjjs72wysPfQ==
X-Google-Smtp-Source: ABdhPJx40sSr690z64AyYJ2UeMEz9ruKpjuG1fr9tJfQjzXttXEB1XNRfp68pnQ+aRSTwtGArdvDSxpkARfCXup4hfE=
X-Received: by 2002:a17:906:f18a:: with SMTP id gs10mr531359ejb.341.1614134862607;
 Tue, 23 Feb 2021 18:47:42 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Feb 2021 18:47:38 -0800
Message-ID: <CAPcyv4i1-mwp8B0Y_hR44rGh9qUPuDiZeiUFJ_TJzvPoENa-pQ@mail.gmail.com>
Subject: [GIT PULL] libnvdimm + device-dax for v5.12-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.12

...to receive some miscellaneous cleanups and a fix for v5.12. This
mainly continues the kernel wide effort to remove a return code from
the remove() callback in the driver model. The fix addresses a return
code polarity typo in the new sysfs attribute to manually specify a
device-dax instance mapping range. This has all appeared in -next with
no reported issues.

---

The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac=
:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.12

for you to fetch changes up to 64ffe84320745ea836555ad207ebfb0e896b6167:

  Merge branch 'for-5.12/dax' into for-5.12/libnvdimm (2021-02-23
18:13:45 -0800)

----------------------------------------------------------------
libnvdimm + device-dax for 5.12

- Fix the error code polarity for the device-dax/mapping attribute

- For the device-dax and libnvdimm bus implementations stop implementing
  a useless return code for the remove() callback.

- Miscellaneous cleanups

----------------------------------------------------------------
Dan Williams (1):
      Merge branch 'for-5.12/dax' into for-5.12/libnvdimm

Shiyang Ruan (1):
      device-dax: Fix default return code of range_parse()

Uwe Kleine-K=C3=B6nig (7):
      libnvdimm/dimm: Simplify nvdimm_remove()
      libnvdimm: Make remove callback return void
      device-dax: Prevent registering drivers without probe callback
      device-dax: Properly handle drivers without remove callback
      device-dax: Fix error path in dax_driver_register
      device-dax: Drop an empty .remove callback
      dax-device: Make remove callback return void

 drivers/dax/bus.c         | 24 +++++++++++++++++++++---
 drivers/dax/bus.h         |  2 +-
 drivers/dax/device.c      |  8 +-------
 drivers/dax/kmem.c        |  7 ++-----
 drivers/dax/pmem/compat.c |  3 +--
 drivers/nvdimm/blk.c      |  3 +--
 drivers/nvdimm/bus.c      | 13 +++++--------
 drivers/nvdimm/dimm.c     |  7 +------
 drivers/nvdimm/pmem.c     |  4 +---
 drivers/nvdimm/region.c   |  4 +---
 include/linux/nd.h        |  2 +-
 11 files changed, 36 insertions(+), 41 deletions(-)
