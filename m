Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD17435A3F1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhDIQsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:48:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233961AbhDIQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617986912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Chg6IKEuKKojYi7mhUKaMLERMRmxIjzmO/LXSZ+TUHU=;
        b=V4nKrqQSuTyIG4IkWllGKcDGT8v7yAQiczF5Wbj9PqGZUXInrrSoFhdhYDqQS+bIVl3bGi
        1fPJEiyfSbmyX8yebyQWlJNvebsuvD/8p06u+Fw1BIS/u+wu4WUMeAfchfWQjdtUKJMLzL
        /p477A7kebgrVfra29ioqGSmkIlR+S4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-fGWmUC4VPKqM3l_tkhxqcA-1; Fri, 09 Apr 2021 12:48:20 -0400
X-MC-Unique: fGWmUC4VPKqM3l_tkhxqcA-1
Received: by mail-wr1-f69.google.com with SMTP id z12so2532092wro.22
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 09:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Chg6IKEuKKojYi7mhUKaMLERMRmxIjzmO/LXSZ+TUHU=;
        b=lGBXlZsPpjYuqtAmk8uZiHCmMqgE6YCmKdeH9FtFrJS2ixvXpEbjn/L9pV3PR93EOv
         RR7sFA2SXicYJxSCZeWTPsS68Jok8hLnu9QERzMvBnX+NoKhFyXXcrLBafc/P9AzCSXz
         jgL5OvUskyofO7pR6tK0pMiFUm0ucPX40XcGUt3GC+MBdhSDYs6t17U5RzP+XtbOk3fj
         RuhZ0adwP36B/aevouKZtJYYi332x6aIF+MrBulxi2TdzAhkL6Gc5CCtoYJTabGA37Me
         zQlPsfhS7Ihg8Fa9Ho56Mq87gKnyoS5r0udGyJQc2M16J03P40HYedngUzVvvG7ZNdV5
         XSlA==
X-Gm-Message-State: AOAM5324qN9+IcK7s6qnlBG+Dj6m0Qppuu6nL/kj7A8tvzB9AcySwCwI
        9ql0iYh66kU4CUDa/yll9yOeNXe8KS6Rfnd7Gt+gXJ50TPUjX/geawgp2idVHnVGzMwyaAQtfMk
        SMyyP+FSdexsZQsARI3zk5yWo
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr7681444wme.7.1617986899513;
        Fri, 09 Apr 2021 09:48:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2SClI5Njn6xjA2MPYxm2kpYJCEchwrX/9+aQChXy3FOe+I3afHnDGXz6jYj0V+5m4e1Tm6w==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr7681431wme.7.1617986899273;
        Fri, 09 Apr 2021 09:48:19 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
        by smtp.gmail.com with ESMTPSA id o25sm6618101wmh.1.2021.04.09.09.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:48:18 -0700 (PDT)
Date:   Fri, 9 Apr 2021 12:48:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        elic@nvidia.com, jasowang@redhat.com, mst@redhat.com,
        si-wei.liu@oracle.com
Subject: [GIT PULL] vdpa/mlx5: last minute fixes
Message-ID: <20210409124816-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to bc04d93ea30a0a8eb2a2648b848cef35d1f6f798:

  vdpa/mlx5: Fix suspend/resume index restoration (2021-04-09 12:08:28 -0400)

----------------------------------------------------------------
vdpa/mlx5: last minute fixes

These all look like something we are better off having
than not ...

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (4):
      vdpa/mlx5: Use the correct dma device when registering memory
      vdpa/mlx5: Retrieve BAR address suitable any function
      vdpa/mlx5: Fix wrong use of bit numbers
      vdpa/mlx5: Fix suspend/resume index restoration

Si-Wei Liu (1):
      vdpa/mlx5: should exclude header length and fcs from mtu

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  4 ++++
 drivers/vdpa/mlx5/core/mr.c        |  9 +++++++--
 drivers/vdpa/mlx5/core/resources.c |  3 ++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 40 +++++++++++++++++++++++---------------
 4 files changed, 37 insertions(+), 19 deletions(-)

