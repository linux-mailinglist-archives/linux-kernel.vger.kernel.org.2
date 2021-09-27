Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B78141A2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbhI0Wbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26753 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237679AbhI0Wbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632781811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=eCL0AZojEkxKxjkt+7Wlncn1gJOK+2tgTrPIC34EBbc=;
        b=F7NLL47YIt4QFYMyfG9mA6LIRK8MDfmkWNDV/4Hrm88+O2xvbbS8et8Wem34J7WJk+HRwT
        cUKqhczRQ4e8E2HllC40rphSb0Dqg3gXav8jG0PY3mvz39yKln+VQVrce8HHrpXTRCCH8a
        1+e50a3vBAGFVgrAqSqtpXvzS4VcUQY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-GtMMDc57O_KvJrdIeeCN4w-1; Mon, 27 Sep 2021 18:30:10 -0400
X-MC-Unique: GtMMDc57O_KvJrdIeeCN4w-1
Received: by mail-wm1-f70.google.com with SMTP id u14-20020a7bcb0e0000b0290248831d46e4so476365wmj.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eCL0AZojEkxKxjkt+7Wlncn1gJOK+2tgTrPIC34EBbc=;
        b=B50/xQ29lLD/ie69OjFPDAJSBmLc8F66r3bDvgYcLTraoW0QlDdxJPL3D+2jo9b4QO
         JOwUEEwOKtAWT57khb9mYqCNri7AvivhDQgnKBu0vx8zscaALqHfhY500T+UXOajnrhP
         pSy2z/LDi8nLofjqZpdpr4+nuCDdJN3H29OwuHjyMlKoT1XUgwgd6+ju7qobV4Uo1d/z
         m5Tr4toUMjeIv+BacMwUxqfuGEn/iTYOvCodk5jSPJkGgT5QXD/qje36eNxFquyXirqD
         ifhPle5OWh/xhDg35HuXgTpQe21PFMNfVxGNQfH8v+7SCWOvb3n9xtjNt3qUMT5oZzlZ
         7zAQ==
X-Gm-Message-State: AOAM533M3utMtfsVVQKpF8InfdqZO6i5c5QCXw6MY5eqOB5KmRfGDJpt
        uP2saGcmboQo1GWJQjYBkV3Xa+F4Ddj6VyAwk654cjc4j9C3U6aefXXIh5Er5Wh1pXvoRD5bPsV
        8Y00gL9+s2rT24iNPVDYnGn9E
X-Received: by 2002:a05:6000:d2:: with SMTP id q18mr2722613wrx.4.1632781809009;
        Mon, 27 Sep 2021 15:30:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrsPsib+hEYb8pFtjMLnI7CifdC97NAniAu5m3nBLmbR4U5TSkin30Vu44yOu2ox2ibxz4Yg==
X-Received: by 2002:a05:6000:d2:: with SMTP id q18mr2722587wrx.4.1632781808842;
        Mon, 27 Sep 2021 15:30:08 -0700 (PDT)
Received: from redhat.com ([2.55.4.59])
        by smtp.gmail.com with ESMTPSA id w18sm2490799wrt.79.2021.09.27.15.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:30:08 -0700 (PDT)
Date:   Mon, 27 Sep 2021 18:30:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        aik@ozlabs.ru, arnd@arndb.de, dan.carpenter@oracle.com,
        elic@nvidia.com, jasowang@redhat.com, linux@roeck-us.net,
        mst@redhat.com, viresh.kumar@linaro.org, xieyongji@bytedance.com
Subject: [GIT PULL] virtio,vdpa: fixes
Message-ID: <20210927183003-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to be9c6bad9b46451ba5bb8d366c51e2475f374981:

  vdpa: potential uninitialized return in vhost_vdpa_va_map() (2021-09-14 18:10:43 -0400)

----------------------------------------------------------------
virtio,vdpa: fixes

Fixes up some issues in rc1.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dan Carpenter (2):
      vduse: missing error code in vduse_init()
      vdpa: potential uninitialized return in vhost_vdpa_va_map()

Eli Cohen (2):
      vdpa/mlx5: Clear ready indication for control VQ
      vdpa/mlx5: Avoid executing set_vq_ready() if device is reset

Michael S. Tsirkin (1):
      virtio: don't fail on !of_device_is_compatible

Xie Yongji (1):
      vduse: Cleanup the old kernel states after reset failure

 drivers/vdpa/mlx5/net/mlx5_vnet.c  |  5 +++++
 drivers/vdpa/vdpa_user/vduse_dev.c | 10 +++++-----
 drivers/vhost/vdpa.c               |  2 +-
 drivers/virtio/virtio.c            |  7 ++++++-
 4 files changed, 17 insertions(+), 7 deletions(-)

