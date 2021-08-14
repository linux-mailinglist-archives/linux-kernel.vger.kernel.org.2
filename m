Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD2C3EC5D3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 00:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhHNWeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 18:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhHNWek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 18:34:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC032C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 15:34:11 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d17so16375297plr.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PI1rHatEWX0PgsdhvR2pdSj/thVQ6y4q8Nxx0pg39jc=;
        b=p1x9t2aNBaHGnyuVrfa0m2kZyWdjSl9cvL9d3DGvYfBiyEB0/lw5NuAI0V3pag+5qB
         uB6hPfMRQJcIha1zyl4CzIsWy+84RscMQG+CkRQPPWntIvgFymDdzb3FHVhrNbB8Ql5r
         uO/mF7xfoXK2LnJU3wCi+wkEaHCTgER7NHVbrlTR4JCksOIkDH9dQlf1b5MbiEqeTRS8
         ewL49oWwRGyc6bfIxZ3rLw2TmwfY9SWFxqHMBLZ804BCxbCneNSPMr14qMNSTZie/MTf
         qvj0fotsHMx3xAanWjjZfFr6tefzB7+viOcutPM2ekBioEwo6bM7ui+g9ML06G6GoriU
         vn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PI1rHatEWX0PgsdhvR2pdSj/thVQ6y4q8Nxx0pg39jc=;
        b=TV06Y1fP2wGvSOzWgQ9ycjS/eyjCQLNyZ/hSq8PWDxh5f36CJBnpeP3Cjewhjw5QfH
         wPuBAdV4jgRGQ4o8r9FC3kgylm4C+JJ45WDkF7qN2/cbZFDDB9tghVrUWtyLXkd9ryuV
         MaohjOSDa4A4EfOR0ipY6/XkbnsaeiE61qxhCJoTDx78rUb3d/av/X2OH+EWOQw5BNpC
         aqO9gStF/3NK64lC0ASTwNaXMXwkhG9Zlff2XUUYPjnKj8NWBdPJvpa2Pb1e+7IGVVqD
         9P4MDf/e/cqNaZE7RsHNydWel1h0siNjPdEr+M95eT2HdLAIX1mcrkan9KRCthZIKMIb
         H4FA==
X-Gm-Message-State: AOAM5332oDPksWfUTN7OPemdv4pUCtb5x6cxHTGypeKBuKPhAYzQMn0u
        2yqIL0iCQinaKU6Xsk73uu09O8cplJG/JVGtBWvQtg==
X-Google-Smtp-Source: ABdhPJz0PO4aWETtYavvTshIi+MXSwuUyXdhr+bFQ+jlbKCm6IGWh/rBqWCC7E9Z1jXxNkSbK7i8HO9LeBFTzuYFid4=
X-Received: by 2002:a05:6a00:16c6:b029:32d:e190:9dd0 with SMTP id
 l6-20020a056a0016c6b029032de1909dd0mr8666336pfc.70.1628980451450; Sat, 14 Aug
 2021 15:34:11 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 14 Aug 2021 15:34:00 -0700
Message-ID: <CAPcyv4iDA0og-BpZWnXY=6pi1GJ9KYpq-f7UkTqSpin1E7rUvg@mail.gmail.com>
Subject: [GIT PULL] libvdimm + dax fixes for v5.14-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.14-rc6

...to receive a couple fixes for long standing bugs, a warning fixup,
and some miscellaneous dax cleanups.

The bugs were recently found due to new platforms looking to use the
ACPI NFIT "virtual" device definition, and new error injection
capabilities to trigger error responses to label area requests. Ira's
cleanups have been long pending, I neglected to send them earlier, and
see no harm in including them now. This has all appeared in -next with
no reported issues.

---

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-fixes-5.14-rc6

for you to fetch changes up to 96dcb97d0a40a60b9aee9f2c7a44ce8a1b6704bc:

  Merge branch 'for-5.14/dax' into libnvdimm-fixes (2021-08-11 12:04:43 -0700)

----------------------------------------------------------------
libnvdimm fixes for v5.14-rc6

- Fix support for NFIT "virtual" ranges (BIOS-defined memory disks)

- Fix recovery from failed label storage areas on NVDIMM devices

- Miscellaneous cleanups from Ira's investigation of dax_direct_access
  paths preparing for stray-write protection.

----------------------------------------------------------------
Dan Williams (4):
      ACPI: NFIT: Fix support for virtual SPA ranges
      libnvdimm/region: Fix label activation vs errors
      tools/testing/nvdimm: Fix missing 'fallthrough' warning
      Merge branch 'for-5.14/dax' into libnvdimm-fixes

Ira Weiny (3):
      fs/fuse: Remove unneeded kaddr parameter
      fs/dax: Clarify nr_pages to dax_direct_access()
      dax: Ensure errno is returned from dax_direct_access

 drivers/acpi/nfit/core.c         |  3 +++
 drivers/dax/super.c              |  2 +-
 drivers/nvdimm/namespace_devs.c  | 17 +++++++++++------
 fs/dax.c                         |  2 +-
 fs/fuse/dax.c                    |  6 ++----
 tools/testing/nvdimm/test/nfit.c |  2 +-
 6 files changed, 19 insertions(+), 13 deletions(-)
