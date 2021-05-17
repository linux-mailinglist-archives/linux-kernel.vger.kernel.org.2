Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC8E3827D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbhEQJKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbhEQJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E02BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b21so2798408plz.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YR11qvzWYk4EOs2Pv2qw2ndLxond67V9khUckij1qqk=;
        b=d6OOr2xWvF+TLJ1q3QGp6peoBs0THD1TDlg16lHiBwiXajEx9lm1G/bW2WaPo6eoO0
         xr5O3Rnmxg4lEFpG7dVXLRpGtN9Gx6PdFyRJZc1wIwGpMHaT/Bc8V40EokphdZxOTQ45
         /9G9JoAs4X0KNW3yoUuUpNlM42spIO74F57NyJKadf1tJM9Y8dqzmh+4l3TPipaJ8A55
         i+T0UDj+BvTGDIjJfypviwEzT3c+clI37duzbfqH2oQCB+Gaz6eRYG7VxAhiqqdokUkj
         Lfb32asaCDktdK4PWRXs5n//fJCFVFIXxncZDzbe+pAiYV3Ub109I2hO857CZ4W9uiMy
         dSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YR11qvzWYk4EOs2Pv2qw2ndLxond67V9khUckij1qqk=;
        b=n5OaU2LT1/lPq+TxXOkgl8O3CUpH90FnEZeC9ddXNKzVe6BBv55+dSsXml+SvQPeof
         WrJauyJfFJF+SOx/H8xgdsa8CFBvG74h1014g3zpSqSFCyzmHjGzONPuUninlQr3A1GK
         sw0HP/l+8ImuYqQgf382K6Eb1iKojGfxbjJBUqjVk/73XHEH1mLoZ/X36f0EN2dbPsYC
         Av/mtpvJln6VZhaGyeR1AYECJhEI+Q9mBlWBWV/b4hFa0ngx4Q7JtLccqyeRB0C1FnYT
         83Fis67gfEUUoc8qE97UrIK/j2jpF2a7pt2CdxqEW1BL0srUGz39Sucxd4vMEPtc0YMj
         VALw==
X-Gm-Message-State: AOAM531s3LJDjzJGHdYDxKxCaM2QgqDirR2tPuR1WehZRk/52amwTTGX
        CJAb5XQ2UfIk2ZYAleirZTU9
X-Google-Smtp-Source: ABdhPJwQXRU+LBcGYMrTFuIKyjE7JjBMPilV95/d1tSYyBJ/LYjA29CaFyVEg099UhQ6eTQ2C0X2BA==
X-Received: by 2002:a17:90a:3fca:: with SMTP id u10mr25756938pjm.76.1621242541761;
        Mon, 17 May 2021 02:09:01 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id e6sm9380506pfd.219.2021.05.17.02.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:01 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/17] Add validation for used length
Date:   Mon, 17 May 2021 17:08:19 +0800
Message-Id: <20210517090836.533-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current virtio device drivers may trust the used length returned
in virtqueue_get_buf()/virtqueue_get_buf_ctx(). But the used length
might come from an untrusted device when VDUSE[1] is enabled. To
protect this case, this series tries to add validation for the
used length.

Since many legacy devices will also set the used length incorrectly,
we did not add the validation unconditionally. Instead, we will do
the validation only when the device driver needs the used length.
A NULL len passed to virtqueue_get_buf()/virtqueue_get_buf_ctx()
will mean the used length is not needed by the device driver.

[1] https://lore.kernel.org/kvm/20210331080519.172-1-xieyongji@bytedance.com/

Xie Yongji (17):
  virtio_ring: Avoid reading unneeded used length
  virtio-blk: Remove unused used length
  virtio_console: Remove unused used length
  crypto: virtio - Remove unused used length
  drm/virtio: Remove unused used length
  caif_virtio: Remove unused used length
  virtio_net: Remove unused used length
  mac80211_hwsim: Remove unused used length
  virtio_pmem: Remove unused used length
  rpmsg: virtio: Remove unused used length
  virtio_scsi: Remove unused used length
  virtio_balloon: Remove unused used length
  virtio_input: Remove unused used length
  virtio_mem: Remove unused used length
  virtiofs: Remove unused used length
  vsock: Remove unused used length
  virtio_ring: Add validation for used length

 drivers/block/virtio_blk.c                 |  3 +--
 drivers/char/virtio_console.c              | 12 ++++--------
 drivers/crypto/virtio/virtio_crypto_algs.c |  6 ++----
 drivers/gpu/drm/virtio/virtgpu_vq.c        |  3 +--
 drivers/net/caif/caif_virtio.c             |  3 +--
 drivers/net/virtio_net.c                   | 10 ++++------
 drivers/net/wireless/mac80211_hwsim.c      |  3 +--
 drivers/nvdimm/nd_virtio.c                 |  3 +--
 drivers/rpmsg/virtio_rpmsg_bus.c           |  3 +--
 drivers/scsi/virtio_scsi.c                 |  3 +--
 drivers/virtio/virtio_balloon.c            | 21 ++++++++++-----------
 drivers/virtio/virtio_input.c              |  6 ++----
 drivers/virtio/virtio_mem.c                |  3 +--
 drivers/virtio/virtio_ring.c               | 28 +++++++++++++++++++++++-----
 fs/fuse/virtio_fs.c                        |  6 ++----
 net/vmw_vsock/virtio_transport.c           |  3 +--
 16 files changed, 56 insertions(+), 60 deletions(-)

-- 
2.11.0

