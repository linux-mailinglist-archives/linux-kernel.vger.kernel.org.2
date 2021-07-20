Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427943D0180
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 20:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbhGTRkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:40:46 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:39927 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhGTRkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:40:14 -0400
Received: by mail-pf1-f171.google.com with SMTP id b12so226292pfv.6;
        Tue, 20 Jul 2021 11:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GmwOijgstcywD2prqSs1UO+IWPMIECWjhibmRHUTSeQ=;
        b=pE3i5xZWTDTIG3MNwQAPWyNOtSNWg/dvbrURoSJ9ExxY8aFJ2IoSB5cEtcEAJAyUzX
         lLzZOPAkD8w/bBJ5qALzP5OF+h34N/ldjME77heShyJUI1IV5neAYp44OC3Ce1gNDBKo
         WNGWAzM82WQNVMAiFDNxdvoZPdMG/b+XLiZeaUSR4RJU4LodzftDux0dWqlmjYhxIw2S
         oR8HbedVUT2OzZrS9rKtxZ3h7Jt7jkebpxISg0Vr/++PxU9h9Ladogp56s1oKcBvN7Ix
         c4THBUxP2zohA4WXUZ3lOdpq/Bkk9j4NdsJHbmpkDaHNtE2fmt3Az8ikL5dvpVgCyIXj
         W30Q==
X-Gm-Message-State: AOAM531M4HHHOKoSKi05nw3wcuNlPnB7UkO2G9PVmhDh9RVetM3+MSS7
        2vhtmf0yGwQ/XpaKQol4kQE=
X-Google-Smtp-Source: ABdhPJwea4wx+Gse9jLKVcJyNReg5lt6o7eBJ2tadXtI13z/iv9rP5Xnrz01HCxlwMb9s+//HoB+dQ==
X-Received: by 2002:a63:6784:: with SMTP id b126mr1958989pgc.421.1626805251978;
        Tue, 20 Jul 2021 11:20:51 -0700 (PDT)
Received: from localhost ([191.96.121.239])
        by smtp.gmail.com with ESMTPSA id d20sm24147087pfn.219.2021.07.20.11.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 11:20:51 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/5] block: replace incorrect uses of GENHD_FL_UP
Date:   Tue, 20 Jul 2021 11:20:43 -0700
Message-Id: <20210720182048.1906526-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've bumped this from RFC to PATCH form as request by Christoph,
as it seems to line up with what he wants to do. As per Hannes
I also stuck to one form of naming, so went with blk_disk_added()
instead of blk_disk_registered() and used that instead of open
coding the flag check.

This is rebased onto next-20210720 and I've made the patch series
independent of my *add_disk*() error handling series. This goes
compile and boot tested.

Luis Chamberlain (5):
  block: add flag for add_disk() completion notation
  md: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED on is_mddev_broken()
  mmc/core/block: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
  nvme: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
  fs/block_dev: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED

 block/genhd.c                 |  8 ++++++++
 drivers/md/md.h               |  4 +---
 drivers/mmc/core/block.c      |  2 +-
 drivers/nvme/host/core.c      |  4 ++--
 drivers/nvme/host/multipath.c |  2 +-
 fs/block_dev.c                |  5 +++--
 include/linux/genhd.h         | 11 ++++++++++-
 7 files changed, 26 insertions(+), 10 deletions(-)

-- 
2.27.0

