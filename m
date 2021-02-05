Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA21310D79
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 16:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBEOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232152AbhBEONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612540201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+vT+jbN1YVSVSpzQpXP9jC5D0CiFueilUGvKuUc6MhE=;
        b=Pl8mWrGNOndtC9XADvofyiyNyA7yNr4jLV7fQ7HkTEv01iiYkZkhAqR1yM5YzaiN2YhWb5
        MeHkfHu52tMdBcTxgPy5RPhFUZ9AC1jE/zzxwjz08MStHDGOBD3cn945gDqRCx5womwJPI
        LH+ynVwpC7f/9zBHw/+9+Dssweb3xU0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-2u-k6pQiNYyt1WdvzfkPvA-1; Fri, 05 Feb 2021 10:45:26 -0500
X-MC-Unique: 2u-k6pQiNYyt1WdvzfkPvA-1
Received: by mail-ed1-f71.google.com with SMTP id bo11so7174411edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 07:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+vT+jbN1YVSVSpzQpXP9jC5D0CiFueilUGvKuUc6MhE=;
        b=nGhN74j+LMA7J9pFg6xnr7rdPugh0MnNUo+2dGM3acO0e2ZfFk3SQ9L0BV0alvKx/X
         FokICRydaCAsTt9mUFp28lUx+myb0sSDggvtsmlXrvjiQuXj8OBiUsOyDSE6QaeknJrn
         Iedd88M82yeWxeyAZQ2LP9Ihei0ye9FI9H5PjnD5VaA54nYuT98f1BusTkwI4Tsu/QAC
         hTkpoVN2a+GBA52B2Q9W2M1hnTCo+J35tqP6EG+fTd1y+C5XvK/efiW76hG2f6Q93kX7
         OyLKW3ad1L2XoOp8zqHuAyAGHCvq30jvT25NOS/9DFPtAVuZSKYxNWPhpiBzPKeqGz7c
         tNkw==
X-Gm-Message-State: AOAM533UlRWEFtVVGmZViOgss0bz8EpXYau2jPjdM62xq2o+JdLWkQl+
        DefA/ENNbnF3y5NMQ6/3SrAyGHM4COhWFasNp2Jy0tinXnIS0c6msnIEgqon6vI9nwHCuqG95mR
        KCyBlttitfiZP6miUW66xvw+H
X-Received: by 2002:a17:906:8292:: with SMTP id h18mr4553200ejx.342.1612539924139;
        Fri, 05 Feb 2021 07:45:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqBUHpbvPYDpBnMWonVBrhZuXG+GwON2f3pVr2d/bLWj6ekzRtN+o9kgto+FKOSFfskxHUQg==
X-Received: by 2002:a17:906:8292:: with SMTP id h18mr4553187ejx.342.1612539923963;
        Fri, 05 Feb 2021 07:45:23 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id y8sm4030809eje.37.2021.02.05.07.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 07:45:23 -0800 (PST)
Date:   Fri, 5 Feb 2021 10:45:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        elic@nvidia.com, jasowang@redhat.com, mst@redhat.com
Subject: [GIT PULL] vdpa: last minute bugfix
Message-ID: <20210205104520-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 710eb8e32d04714452759f2b66884bfa7e97d495:

  vdpa/mlx5: Fix memory key MTT population (2021-01-20 03:47:04 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to b35ccebe3ef76168aa2edaa35809c0232cb3578e:

  vdpa/mlx5: Restore the hardware used index after change map (2021-02-05 10:28:04 -0500)

----------------------------------------------------------------
vdpa: last minute bugfix

A bugfix in the mlx driver I got at the last minute.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (1):
      vdpa/mlx5: Restore the hardware used index after change map

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

