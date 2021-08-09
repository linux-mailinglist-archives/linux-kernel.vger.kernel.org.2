Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16F33E4A69
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 19:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhHIRAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 13:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhHIRAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:00:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1705C061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 10:00:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w5so6024007ejq.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ml8YWeKENdHttM1M37Ea6CjN02UFHxweJafrawItaBc=;
        b=ln5imeQ87VkBFUlqtYVfWXqdJetMsvLgTtfMiqAEN8nh1jVvxqWZkV7Fpa8UaVvCUU
         Zrm60uxKIc1jrGXyA6Vsjw5DzOqVR3FkcD2YdlRU/EdJa6Q/BB7IIQax8Kok+0cPG44o
         kGpmStxWa91MVQx4aePEhkdLsRjSmA32pumZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ml8YWeKENdHttM1M37Ea6CjN02UFHxweJafrawItaBc=;
        b=sA874ZhzMTPdClP2YJBoV8GdIeeDSfJe/aLuJjRf/TLCSQJPR8l3z3YWmgsyIC30IR
         G21M1VZR9zb7drZ93l2oUWERxD7qZoiCh41AGJmcYcrvpA1qZBX2aK+LACRE4Zt+DwQV
         aVQt1sQSY7PbgOXccAH89M7O75rRbRj927gyryob/Xap4GPzPaPeTTPNsHuz3I9gzi+c
         yNxQVpqUHXFFIx2L9BT4K3NM3cuumoFOIUudC6ubFhqHxAECBtj4W2NKYZ7nkO7LNChp
         Uh/XoTKAoHhrT0AMUuf8uDc2NwIV2lM6ErsBKhLnWPEjkQynchFAs5zrtI/Bg4+wMpIQ
         siqw==
X-Gm-Message-State: AOAM533+rIMOxCDEygbK0mSeevvqWxTJ+OEVKFsTMfWzmcxZCPSh1bks
        wX3374ELmkWvUUg6J4Vz3h0dpw==
X-Google-Smtp-Source: ABdhPJzZ8H3OPD8jmRICfWorFIzvInFqHIYHkom1mfksGHpupWKEL6M6eINvJBub13WD3yVvcgdzjA==
X-Received: by 2002:a17:906:4808:: with SMTP id w8mr4857408ejq.56.1628528417320;
        Mon, 09 Aug 2021 10:00:17 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id q14sm8465317edr.0.2021.08.09.10.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 10:00:16 -0700 (PDT)
Date:   Mon, 9 Aug 2021 19:00:10 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 5.14-rc6
Message-ID: <YRFfGk5lHL0W27oU@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.14-rc6

Fix several bugs in overlayfs.

Thanks,
Miklos

---
Amir Goldstein (1):
      ovl: skip stale entries in merge dir cache iteration

Miklos Szeredi (4):
      ovl: fix mmap denywrite
      ovl: fix deadlock in splice write
      ovl: fix uninitialized pointer read in ovl_lookup_real_one()
      ovl: prevent private clone if bind mount is not allowed

---
 fs/namespace.c         | 42 +++++++++++++++++++++++++++--------------
 fs/overlayfs/export.c  |  2 +-
 fs/overlayfs/file.c    | 51 ++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/overlayfs/readdir.c |  5 +++++
 include/linux/mm.h     |  2 +-
 mm/mmap.c              |  2 +-
 mm/util.c              | 27 +++++++++++++++++++++++++-
 7 files changed, 111 insertions(+), 20 deletions(-)
