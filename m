Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3223B6996
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbhF1UTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbhF1UTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:19:54 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1DAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:17:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m2so16437367pgk.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=GSQg9ymS8GvPrlP1FVmOn6neJl/c9BeL585Za1HKNOE=;
        b=k5rtMwoQ6gUNx0iX8yth66KHJbELVwYUJ5gdvRUCZreG+7XhbXmRSBc6amPBB291a1
         WbXxEmF56HMrTHRLfnjhZm0RT+mS4EqMOuHoT7ai2wC8sP5l8hvmSb//TXvlOSj78Lum
         osp5aLnSBxPOEOvKrHJFIZ0ZWyfSOC9Ce2RTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GSQg9ymS8GvPrlP1FVmOn6neJl/c9BeL585Za1HKNOE=;
        b=B5MyiYLqh6kn9hqDh1/IH3Z+YFZwdhk7wm8NjdfzXVjCHT0QaN3udSuTt9+0q3/w9e
         AWZe8zVHC2oLCebFKPQ5T79eEIVwvMxsNPYebSg+9LtGmW4Ff1yDcz5RN79UstnOUH3V
         HKafUfVGuMI88lF3upwc4MZVv2/sJhGU97GMgh7HbwIexA00sixh/f6ZCuYaqVTkA+bA
         V/FOIzPAj3XoBECtOaycMf6dd+rx6kWbbtnnFA8W5p+i/DfCQtADCIepIBgSedZ+M4RN
         zcPf7UzVxKV2KoUhvPQiE7Sju326/Xc5J3tvixDM6BEHrYtYN5cOhs9mh6XeopwvTX+R
         Q6aQ==
X-Gm-Message-State: AOAM531afs1kzLjvyrhOCC209MAz4WxHxkuZxIeNgNUx417ydmB1cIA6
        KJ41bdzGGWzmILjDcPnbH/0/Ug==
X-Google-Smtp-Source: ABdhPJw14ur9y9ST4OSUYxPyb3oGskzhFinasP/BDSsCDteeQA008KzEamfPxPZuRYuAmsbLKimHwg==
X-Received: by 2002:a65:6544:: with SMTP id a4mr18739908pgw.280.1624911447735;
        Mon, 28 Jun 2021 13:17:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 73sm15386588pfy.83.2021.06.28.13.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 13:17:27 -0700 (PDT)
Date:   Mon, 28 Jun 2021 13:17:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Christoph Hellwig <hch@lst.de>,
        Colin Cross <ccross@android.com>,
        Pu Lehui <pulehui@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [GIT PULL] pstore updates for v5.14-rc1
Message-ID: <202106281313.18DF59A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore updates for v5.14-rc1.

Thanks!

-Kees

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.14-rc1

for you to fetch changes up to 1d1f6cc5818c750ac69473e4951e7165913fbf16:

  pstore/blk: Include zone in pstore_device_info (2021-06-16 21:09:31 -0700)

----------------------------------------------------------------
pstore updates for v5.14-rc1

Use normal block device I/O path for pstore/blk. (Christoph Hellwig,
Kees Cook, Pu Lehui)

----------------------------------------------------------------
Kees Cook (5):
      pstore/blk: Improve failure reporting
      pstore/blk: Move verify_size() macro out of function
      pstore/blk: Use the normal block device I/O path
      pstore/blk: Fix kerndoc and redundancy on blkdev param
      pstore/blk: Include zone in pstore_device_info

 Documentation/admin-guide/pstore-blk.rst |  14 +-
 drivers/mtd/mtdpstore.c                  |  10 +-
 fs/pstore/blk.c                          | 403 ++++++++++++-------------------
 include/linux/pstore_blk.h               |  27 +--
 4 files changed, 171 insertions(+), 283 deletions(-)

-- 
Kees Cook
