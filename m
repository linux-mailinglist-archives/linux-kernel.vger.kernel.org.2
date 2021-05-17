Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29063382865
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhEQJgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbhEQJgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:36:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF14C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:34:54 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h7so2824724plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKUnZ0MXaqroEgfF5ZkPt8GGjGGax0v1QWVdecKJ4CI=;
        b=goTkXd3VYcB9wx2hxfOkkyBZnIPnWigWVuU5a5XusKEJ5b0vlFvDFJVch8uwD+jGsf
         cv1T8jBHtKBoLxUKZc5dOkbTOioz1cExvfzfcK5T87p8bDA/WMCtoV0Fv4sNQK7rg3x4
         bgWp9XQ7q0mdvK2zDVvb1dsN+iQjnpjsP4e8T+T2cieeEza46x+D2589U7l9G843+/jg
         yJlbvJ1Dz9f37CXo2yML/VvZ9Gnx76uPp8O1Q5XBc5EyRa1E4gkW+Da+zJI9sxsB8EgG
         8PKmOGu7P0TW8ko0zrqXwWN2ez2LnqVCFn8RnT2fK2HA863f3T1xfpy3QFrYndEmQLXI
         lHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vKUnZ0MXaqroEgfF5ZkPt8GGjGGax0v1QWVdecKJ4CI=;
        b=JUfYeRxpvuvywX0dItkVBZ0EQqIy2DqXVspvuALRhAsvtQ6cc8S+OMCKHlgfGVppsX
         KZNaAuqFFdHlzQJiCEelyhcZi+XrtaU1VyFqCsOjg2VNz1VqJ+UkqPT/UDiabuxGvIvY
         3bIuQefblORun2LHVGgOq0iJedCsKPVp8pyQjT+JcPuysfXJatuSOwaPAV+z7MWuyM7c
         otPGt6ZWW8lh61X9LEdVAYjWh5Er5o0auQRZ7qzXbpISs2w7x8Uxw3ia/ccl7R36RTaX
         AQ5iaxW/kXQwHPHB7D2BjEte8DhhDPPXmbsWhmyxt5VrV0DWv9io7g+ztm3mJmBSL79a
         Wykw==
X-Gm-Message-State: AOAM53352P/hj1ZlIZQjhKV+YP9sNnmmXpVNgkO6DwndRlm5oP5xkMkx
        6SqKQ/NEuUS7Kiwn8mwa8yB9
X-Google-Smtp-Source: ABdhPJzshjqkQIyHLhvL8UxpoNtPDNHmGHL5pbuYhGhRh5xFDovuT0pzfIQVQJVmtvKe9v+jw9JpnQ==
X-Received: by 2002:a17:902:bd0b:b029:ef:8970:281c with SMTP id p11-20020a170902bd0bb02900ef8970281cmr26048354pls.35.1621244094409;
        Mon, 17 May 2021 02:34:54 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id b12sm6518769pgs.52.2021.05.17.02.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:34:53 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/15] Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:13 +0800
Message-Id: <20210517093428.670-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we would trigger a BUG_ON() when we get an invalid status in
virtio_device_ready() during probe and suspend/resume. But
returning invalid status might happen in VDUSE[1] case where
the device becomes untrusted. So this series tries to remove the 
BUG_ON() and return error to the caller so that the device driver
can handle the error correctly.

Now this series is based on my another fix[2].

[1] https://lore.kernel.org/kvm/20210331080519.172-1-xieyongji@bytedance.com/
[2] https://lore.kernel.org/lkml/20210517083557.172-1-xieyongji@bytedance.com/

Xie Yongji (15):
  virtio_config: Add return value to virtio_device_ready()
  virtio-blk: Handle virtio_device_ready() failure
  virtio_console: Handle virtio_device_ready() failure
  virtio_crypto: Handle virtio_device_ready() failure
  drm/virtio: Handle virtio_device_ready() failure
  virtio-iommu: Handle virtio_device_ready() failure
  virtio-net: Handle virtio_device_ready() failure
  rpmsg: virtio: Handle virtio_device_ready() failure
  virtio_scsi: Handle virtio_device_ready() failure
  virtio: Handle virtio_device_ready() failure
  virtio-balloon: Handle virtio_device_ready() failure
  virtio-input: Handle virtio_device_ready() failure
  virtio-mem: Handle virtio_device_ready() failure
  virtiofs: Handle virtio_device_ready() failure
  9p/trans_virtio: Handle virtio_device_ready() failure

 drivers/block/virtio_blk.c                 | 13 +++++++++++--
 drivers/char/virtio_console.c              | 14 ++++++++++++--
 drivers/crypto/virtio/virtio_crypto_core.c |  8 ++++++--
 drivers/gpu/drm/virtio/virtgpu_kms.c       |  8 +++++++-
 drivers/iommu/virtio-iommu.c               |  4 +++-
 drivers/net/virtio_net.c                   | 19 +++++++++++++-----
 drivers/rpmsg/virtio_rpmsg_bus.c           | 31 ++++++++++++++++++------------
 drivers/scsi/virtio_scsi.c                 | 13 ++++++++++---
 drivers/virtio/virtio.c                    |  9 +++++++--
 drivers/virtio/virtio_balloon.c            | 13 +++++++++++--
 drivers/virtio/virtio_input.c              | 11 +++++++++--
 drivers/virtio/virtio_mem.c                |  6 +++++-
 fs/fuse/virtio_fs.c                        |  4 +++-
 include/linux/virtio_config.h              |  8 ++++++--
 net/9p/trans_virtio.c                      |  6 +++++-
 15 files changed, 128 insertions(+), 39 deletions(-)

-- 
2.11.0

