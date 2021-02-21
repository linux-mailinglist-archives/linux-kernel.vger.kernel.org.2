Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC632320DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 22:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhBUVP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 16:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhBUVPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 16:15:22 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81741C061786
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 13:14:42 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id s3so2750462qvn.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 13:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hF003MFwp+K0lX9kpA6fMysR2+yjkMKAKOs+TriaFiQ=;
        b=YjYpXwL5MJ3DWcDR7RHx1XzYw+RXLJU9bb7dKSvgiZ0JRZFYlyhd8jvv4AS9DJ/VQX
         fF2mvJI5wEtZigGCDl0x9749koC+Apbx4aZpHfRwBoad4FhCm68+jKK8xn1Lsy8DJRbt
         BVK5cAaNix4gZJG/IaJLHvmHTe4HoxsVMjT/olhPu8JF8+wesB1FtPpfenzV3OUXPEbr
         EP5drf0tivvNqXpUqCLOR+Lbea28FaTihfy+XupOnWigNgWSvi33bN6Z663eLyM3Z3Jz
         g/83Ld3IMgXnq0oT+tMgOB2tepO/T8d+N+FB0aIZdLxBuOFGapskdsBU++GyUZ7sHk0J
         6gpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=hF003MFwp+K0lX9kpA6fMysR2+yjkMKAKOs+TriaFiQ=;
        b=JO5xcKwRnRenJu/HfXoTpLZ8o5PI0IiFehRas16hdq96B5f41lAPCRd55zWk2hVx72
         3oZGvfu59ptShkwp+MAFDQSYuT0/oNFJ+HeD4FeUaJ1JrwYI4GDElZiijURKx0I/M5+m
         snHv8ycgH/wjjcG5ft5oNuA+bxjQYFPeYg4QwJPyckhWu7iJ3ofZVo/54Sm+fudEhXtZ
         qI/825gVzST3t81S4k/DDxf9DfiqoiWSTm74eK2bhMWGc+dfhJh7zYy85Z4EtNh+wT54
         gHO+gebagLzHmTjwE1PC0sTKH3F7HpBBMG7NBlOf8Jd4M5DCv2pIoj1NN55hqtDR2p1V
         KkoQ==
X-Gm-Message-State: AOAM531RVPknicUMJ1DqKOfUQxFQ+eFInZ2kHnJTI3HZrmTyc5fjg86m
        Ne8Jp+dFOVplrhqvNgWdBDM=
X-Google-Smtp-Source: ABdhPJxaImelsZgZdnXY6O0l9K9gbEuG0LNwrC4I218WzODN4xIprCY1o6hNO/kco3wxJQ5QkmrvUg==
X-Received: by 2002:a05:6214:1302:: with SMTP id a2mr1321637qvv.37.1613942081650;
        Sun, 21 Feb 2021 13:14:41 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id o11sm2402171qta.1.2021.02.21.13.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 13:14:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 21 Feb 2021 16:14:40 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] workqueue changes for v5.12-rc1
Message-ID: <YDLNQFGN0fi8plof@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Tracepoint and comment updates only.

Thanks.

The following changes since commit 1e2a199f6ccdc15cf111d68d212e2fd4ce65682e:

  Merge tag 'spi-fix-v5.11-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi (2021-01-18 11:23:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.12

for you to fetch changes up to e9ad2eb3d9ae05471c9b9fafcc0a31d8f565ca5b:

  workqueue: Use %s instead of function name (2021-01-27 09:42:48 -0500)

----------------------------------------------------------------
Menglong Dong (1):
      workqueue: fix annotation for WQ_SYSFS

Stephen Zhang (1):
      workqueue: Use %s instead of function name

Zqiang (1):
      workqueue: tracing the name of the workqueue instead of it's address

 include/linux/workqueue.h        | 2 +-
 include/trace/events/workqueue.h | 6 +++---
 kernel/workqueue.c               | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
tejun
