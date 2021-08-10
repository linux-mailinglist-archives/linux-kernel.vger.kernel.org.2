Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0533E7BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbhHJPEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242555AbhHJPEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:04:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50BCC061798
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:04:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gs8so35972697ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0kGkCVXi9LMetkI7vjpLy4IPYSR246cc36MeCJtVGWY=;
        b=Vg3szelyZHeSc/dqdJwfjdyaNeVjX91LJTqrkmxo+eXKbQy5/j20lTRJpUcGxCvdtD
         jDOjwa3ZvEhSpKq9bVkeUwKlPtBxTcuLzIajGDGO3UXcNnY09bajB/YMlav5D/eRMa3N
         jPBiJhm/g9mnPytSQD2TI00r1An39xj/YQIJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0kGkCVXi9LMetkI7vjpLy4IPYSR246cc36MeCJtVGWY=;
        b=ND/Wbrpr2MB1+wr9molWQmFGf6/b2eB0myzkiP1ESJwNNA7Fz/EVRntcD9pk1gXhVo
         wRgKZ8Ma0Z3N1nrOaT9bSx0dZGOCeTZBWLuVs+yvF2h3MaQNh5grvLQqqiB7f/V2uonC
         b3c98wGdezBC2IjF6PcfK+MEUi4DnTG6UrsfvvzZQrzKunvPkWOvLvc/nskDFjQXHSu4
         Ic9uq40L7m3lYGnWfPzzCHmcX7x6GOVHm98CWqG8ilnspIWekHCTgV16r0OsfzP7AMHm
         nSyFbAwCDA4npT06nGPt/EEZ9OwI4z6Ph1QeRZl1XYN4bY7ikUagffKeAtoGLIqeR1HI
         XhPA==
X-Gm-Message-State: AOAM533q+zt8Ev74DH3kugirXRBb7jYAZHdoGPO48dcys+TCQKrbLdgl
        izLhdaKZboFAHm0T+u25krtyVg==
X-Google-Smtp-Source: ABdhPJxnq5BxlTa14rXURztYnwXAxPN8xl+/yaEV1Jt6ftczGTmT9LR5FamQjUkA/MlE9sSBl2vqDA==
X-Received: by 2002:a17:906:9c84:: with SMTP id fj4mr27408543ejc.264.1628607847156;
        Tue, 10 Aug 2021 08:04:07 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id c16sm2536466ejm.125.2021.08.10.08.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:04:06 -0700 (PDT)
Date:   Tue, 10 Aug 2021 17:04:03 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL v2] overlayfs fixes for 5.14-rc6
Message-ID: <YRKVYyeAUqJSJ5rk@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.14-rc6-v2

Fix several bugs in overlayfs.

Fixes have been in linux-next for a fair amount of time, the recent commit
timestamps are due to moving these fixes to the front of the patch queue.

v2: drop mmap denywrite fix.

Thanks,
Miklos

---
Amir Goldstein (1):
      ovl: skip stale entries in merge dir cache iteration

Miklos Szeredi (3):
      ovl: fix deadlock in splice write
      ovl: fix uninitialized pointer read in ovl_lookup_real_one()
      ovl: prevent private clone if bind mount is not allowed

---
 fs/namespace.c         | 42 ++++++++++++++++++++++++++++--------------
 fs/overlayfs/export.c  |  2 +-
 fs/overlayfs/file.c    | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/overlayfs/readdir.c |  5 +++++
 4 files changed, 80 insertions(+), 16 deletions(-)
