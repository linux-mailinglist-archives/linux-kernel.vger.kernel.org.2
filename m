Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226E13A20B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 01:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhFIX3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 19:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhFIX3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 19:29:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CE7C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 16:27:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id md2-20020a17090b23c2b029016de4440381so2645796pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 16:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rPwFm+rW5VJo250kQOZcru/sRI6+UZ6fSWYAEKjNOl8=;
        b=koQ9XOS9Ahh++/EJkQYsM/lmckBNtNk3H15jg9UrEF+0vJyfvFlAa/gQhNntz9gu1w
         Oqs61SCcdSCMc9H5FE4ZdoooczAaIPcxe7jAJxGaFaFKASEslnvZ6mQDqd5rYc8npZmh
         0isbpH8z/+CjhFiJHWfargQyKl+5Ht4rUjK5jpkUo31LpnfC9GTUkrgEmEXjVgd4V0DC
         V6WlFXcSgBGg7EKnZDJcgXtuOk5CErlGosgLzxm0O0L+Gak1ws8U/hS7hyAv4/PA0bPh
         8K9yGOI3EaKetOMc1Ru2ifH5BxK58xfPsr/H8Q9ofhN51F4bQ43i8Vv6FFy7qXVo5p/z
         Sg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rPwFm+rW5VJo250kQOZcru/sRI6+UZ6fSWYAEKjNOl8=;
        b=gzLjjXQSUWV7c4Impbl6WnbA44uQXk4bx7UMUmzpGdbus7opsr7xBFivbb9alC1goM
         QxHP2mYjuJaQ1MFFb5yAd80T9jV9LGxuFEGJa2wiIgBM+EEnONygUcClfwv4mbn4VTb5
         H3hNcZy2TVBZODdT5tdZ3mvBS7UXSjCXX9SZQaLcUfe7M6yFlNEvxw1oGWvTqfFQCtQF
         808KSIRbxeXs0yuWIGW3rbf2Kwh4XoZfbTkgmGJF3IJW5tT0HW4j01Eu4s+1+syvI7ps
         Z7/og2A4ItTyZfBRZNX4xBiHLnH/D1gn+UHh6zhHaHfK99CHGmuZQZQjuvsemr+Khiso
         MC1Q==
X-Gm-Message-State: AOAM531oYEDtYEkJNiVQ+sYi0NFHBT0T0RTf9Ih9bv59Or3KgHIyGQ38
        KdqXOK7ycCLbrhEUQohFfXI3gw==
X-Google-Smtp-Source: ABdhPJx7y5w6Y2cekg09LzZc1GmAicnE6+tSkLAtxpBWIyREqveDAqIwuJX1FGXwpqEcOmgaufVpkg==
X-Received: by 2002:a17:90a:dc04:: with SMTP id i4mr135874pjv.75.1623281244893;
        Wed, 09 Jun 2021 16:27:24 -0700 (PDT)
Received: from n124-121-013.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id k1sm526783pfa.30.2021.06.09.16.27.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 16:27:24 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     sgarzare@redhat.com
Cc:     virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        mst@redhat.com, arseny.krasnov@kaspersky.com,
        jhansen@vmware.comments, cong.wang@bytedance.com,
        duanxiongchun@bytedance.com, xieyongji@bytedance.com,
        chaiwen.cc@bytedance.com, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Lu Wei <luwei32@huawei.com>,
        Alexander Popov <alex.popov@linux.com>, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC v1 0/6] virtio/vsock: introduce SOCK_DGRAM support
Date:   Wed,  9 Jun 2021 23:24:52 +0000
Message-Id: <20210609232501.171257-1-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements support of SOCK_DGRAM for virtio
transport.

Datagram sockets are connectionless and unreliable. To avoid unfair contention
with stream and other sockets, add two more virtqueues and
a new feature bit to indicate if those two new queues exist or not.

Dgram does not use the existing credit update mechanism for
stream sockets. When sending from the guest/driver, sending packets 
synchronously, so the sender will get an error when the virtqueue is full.
When sending from the host/device, send packets asynchronously
because the descriptor memory belongs to the corresponding QEMU
process.

The virtio spec patch is here: 
https://www.spinics.net/lists/linux-virtualization/msg50027.html

For those who prefer git repo, here is the link for the linux kernel：
https://github.com/Jiang1155/linux/tree/vsock-dgram-v1

qemu patch link:
https://github.com/Jiang1155/qemu/tree/vsock-dgram-v1


To do:
1. use skb when receiving packets
2. support multiple transport
3. support mergeable rx buffer


Jiang Wang (6):
  virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
  virtio/vsock: add support for virtio datagram
  vhost/vsock: add support for vhost dgram.
  vsock_test: add tests for vsock dgram
  vhost/vsock: add kconfig for vhost dgram support
  virtio/vsock: add sysfs for rx buf len for dgram

 drivers/vhost/Kconfig                              |   8 +
 drivers/vhost/vsock.c                              | 207 ++++++++--
 include/linux/virtio_vsock.h                       |   9 +
 include/net/af_vsock.h                             |   1 +
 .../trace/events/vsock_virtio_transport_common.h   |   5 +-
 include/uapi/linux/virtio_vsock.h                  |   4 +
 net/vmw_vsock/af_vsock.c                           |  12 +
 net/vmw_vsock/virtio_transport.c                   | 433 ++++++++++++++++++---
 net/vmw_vsock/virtio_transport_common.c            | 184 ++++++++-
 tools/testing/vsock/util.c                         | 105 +++++
 tools/testing/vsock/util.h                         |   4 +
 tools/testing/vsock/vsock_test.c                   | 195 ++++++++++
 12 files changed, 1070 insertions(+), 97 deletions(-)

-- 
2.11.0

