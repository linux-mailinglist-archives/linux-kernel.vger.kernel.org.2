Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B09D4379BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhJVPTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbhJVPTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:19:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D0C061766
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:17:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ec8so3033511edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4MK/SC9LFL9SsancIHGdAe9nGOATAXV3ivH0Dc1Xtac=;
        b=fBzV3FUSa/FHUPNIEmCob4Ye7RAYRihM3BgH3fmFFkewte3L+CYOnsd08CuS8+FadL
         WVI4nh+IepOWF8xxIRuS+l4b6Isg0ljpN24bkdrhpwLhnQ4w4msIKBaKgB8VqJY++bke
         GulOgU9Nnbz52I4VXajvHDioDXgAMRZw2ni1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4MK/SC9LFL9SsancIHGdAe9nGOATAXV3ivH0Dc1Xtac=;
        b=kXM0mth7NRnKnNDynX/KE1gLhVA4crfGwXDp687v99xj1Ju77hy/W7iEdWDuYM03fx
         jM+oI7hakSmf6FdwZ6hLNGTxUwG6MFAKZytAt25eGbuE0r7vTw0rWl5XrlWZzVwqQpOn
         9xKcJ16RBqUOlGb6fi4bZI4dR65X0isD2L4qmfese7ThFuInocf+CY/eN0fNj6fHyYgw
         kIkVf+oeYY6CjOk65VlvYVzGF3I6Ey/oowKM6XsT1FqbbCOj5TxYD/pGqUKlnASXF9MZ
         tyH6OiclcUx94r+YFpSvO71xOZWnAn98ZYPkfg6ofgNE2OWfQ4B6A09YjXFxZcvum4Fu
         kTVw==
X-Gm-Message-State: AOAM531sb7JMI/Y71/wV6YhUV5q6BNSvFY2WvDckjeIFDZLE/knSSgR3
        SCz/1xiEqnWgnop0Y0NqOkhVngmz2pQ=
X-Google-Smtp-Source: ABdhPJz5/lRxlfp/3fdeLm1+2zUJbmt/t/043GoFY1O4ScPNQ3pn/3ryF7J/XgtS5iPJpntvmx1xAg==
X-Received: by 2002:a17:907:6d8b:: with SMTP id sb11mr241100ejc.332.1634915831267;
        Fri, 22 Oct 2021 08:17:11 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.broadband.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id p10sm3894278ejf.45.2021.10.22.08.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 08:17:10 -0700 (PDT)
Date:   Fri, 22 Oct 2021 17:17:04 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 5.15-rc7
Message-ID: <YXLV8NeDTaBH3g/b@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.15-rc7

Syzbot discovered a race in case of reusing the fuse sb (introduced in this
cycle).  Fix by doing the s_fs_info initialization at the proper place.

Thanks,
Miklos

----------------------------------------------------------------
Miklos Szeredi (5):
      fuse: check s_root when destroying sb
      fuse: get rid of fuse_put_super()
      fuse: clean up fuse_mount destruction
      fuse: always initialize sb->s_fs_info
      fuse: clean up error exits in fuse_fill_super()

---
 fs/fuse/fuse_i.h    |  3 ++
 fs/fuse/inode.c     | 87 ++++++++++++++++++++++++-----------------------------
 fs/fuse/virtio_fs.c | 12 +++-----
 3 files changed, 46 insertions(+), 56 deletions(-)
