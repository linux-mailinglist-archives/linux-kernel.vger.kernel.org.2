Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B864309DE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 16:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343911AbhJQOvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 10:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237785AbhJQOvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 10:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634482146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Ip6ZgePH8xwpK2sHmkpaBxfB7ZKPtwdcnXkOJDJISgI=;
        b=YFWxJ3HRMfFiZkEBYmkUiDf7hTAIiD7VzyXTE8szJXDPl80boNFLdDBmUv80YNO+k43qFA
        TvacWhTNv0A97FRAqSqecJJ05UM7+CCryQdY8GIJe3fMPB5woOXgUm40HafkqTwDBfn3go
        x7yJTHzKQTVRvjgEbJDQlykpZWllXII=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-RUbkX6I1NJGbG-28IJSrnA-1; Sun, 17 Oct 2021 10:49:05 -0400
X-MC-Unique: RUbkX6I1NJGbG-28IJSrnA-1
Received: by mail-wm1-f70.google.com with SMTP id s22-20020a1ca916000000b0030dcdcd37c5so2311271wme.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 07:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Ip6ZgePH8xwpK2sHmkpaBxfB7ZKPtwdcnXkOJDJISgI=;
        b=kmy9z+0Xm+F2Q62vUU6U/aUMaFMnvtnXUuCZWP6Ws9ZGxVfi4ErPPjMg911HyMDBhJ
         vJdqjES76vuyW8ADohqcISUdE9Uw9Z41CqUzEeQ6U7oarvbzjRTFvWqkp2uol21PEbaJ
         5Smex3243pkJHahzaI9X9XrV3b5etw75qIynplg0r9D946hnuvUohyadtdgnXKEU5JzG
         QQvtugiEBbuSbc+6FtGrxBpVzggv8s+IR9jfDHvoedQFFiHtW1kVp9tcmwe0/9eJl83z
         eI6Y5mVzYGdRV+mEbPL0VNOHb/eScSV8Zoyj8fKPJbPOtFcavAhDMUVLLdZz6Qxziv6q
         ND0Q==
X-Gm-Message-State: AOAM532jg3UMVgOf0aANd8QON0r9vZaSFIrS1+6IQBXlp6yEvc84OxBX
        vHIivrZ11FGwRFt0NZzeUsK4uHLZQ3jI39TtwOeWjoPII3DWSk+vUAqua4PklPZGLvwJ5KFmUs0
        SaaFmKOOjhVqp6uh3AWM2IKdO
X-Received: by 2002:a05:6000:1683:: with SMTP id y3mr15124348wrd.314.1634482144581;
        Sun, 17 Oct 2021 07:49:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFBg10YCOIJdS2cG0k9v/rSms6MDVN0cXyAC9SocqmtQ9OZq/KfKELZOAfWYN7H7AEZxW3lg==
X-Received: by 2002:a05:6000:1683:: with SMTP id y3mr15124332wrd.314.1634482144347;
        Sun, 17 Oct 2021 07:49:04 -0700 (PDT)
Received: from redhat.com ([2.55.147.75])
        by smtp.gmail.com with ESMTPSA id a2sm11630293wrq.9.2021.10.17.07.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 07:49:03 -0700 (PDT)
Date:   Sun, 17 Oct 2021 10:49:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, jasowang@redhat.com, linux-doc@vger.kernel.org,
        lulu@redhat.com, markver@us.ibm.com, mst@redhat.com,
        pasic@linux.ibm.com, rdunlap@infradead.org, stable@vger.kernel.org,
        wuzongyong@linux.alibaba.com, xieyongji@bytedance.com
Subject: [GIT PULL] virtio,vdpa: fixes
Message-ID: <20211017104900-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit be9c6bad9b46451ba5bb8d366c51e2475f374981:

  vdpa: potential uninitialized return in vhost_vdpa_va_map() (2021-09-14 18:10:43 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to bcef9356fc2e1302daf373c83c826aa27954d128:

  vhost-vdpa: Fix the wrong input in config_cb (2021-10-13 08:42:07 -0400)

----------------------------------------------------------------
virtio,vdpa: fixes

Fixes up some issues in rc5.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Cindy Lu (1):
      vhost-vdpa: Fix the wrong input in config_cb

Halil Pasic (1):
      virtio: write back F_VERSION_1 before validate

Michael S. Tsirkin (1):
      Revert "virtio-blk: Add validation for block size in config space"

Randy Dunlap (1):
      VDUSE: fix documentation underline warning

Wu Zongyong (1):
      vhost_vdpa: unset vq irq before freeing irq

 Documentation/userspace-api/vduse.rst |  2 +-
 drivers/block/virtio_blk.c            | 37 ++++++-----------------------------
 drivers/vhost/vdpa.c                  | 10 +++++-----
 drivers/virtio/virtio.c               | 11 +++++++++++
 4 files changed, 23 insertions(+), 37 deletions(-)

