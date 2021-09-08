Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0DC403424
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 08:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347696AbhIHGRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 02:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhIHGRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:17:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4748EC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 23:16:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n4so638523plh.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 23:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBHRTJis02t5NHbVpsn7FcWLrdPlDkUd3aly8ckXp2A=;
        b=uGZYOkMQ0oxoXFAXwN4WsRVYxvsIpE+F6t/rBD436q5dPKy8+KpJNqyAAN1GEVpuE6
         Q8ATFiodGWQ2tko+LaU/MhMq1lESZyoQrx8gHqN21fGp3Fm4RUoUPvQOe1EYLUxg3Ma0
         SuhQoekfUoqhWtLvxVl9jGLhLsZtu5O0Qu6wzKFq6OUgN4O+8D4pFBBHUehHUgk/qLrk
         UnxjJOUlyNrTOch8MNNjVZwEhk7rXhFP/Ls1xE9FDhs7wH8U/WwTVklJujOJC9zAGwC2
         XcgICIRdl7qruXGQ+pJgTKlTgBOwJkcGouJdMYlYq9eoQ6HFUaWYyIeXoLUwwvwm7pdy
         hnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBHRTJis02t5NHbVpsn7FcWLrdPlDkUd3aly8ckXp2A=;
        b=bQFkzz6LUQ71gCfbJf1wT6m6m/sw64K8ZqLcGm1bOY4LKYo3uhaMkWfKVF+8h+8TX+
         +oYioUkqqYpSwKZYB+4hGkfcW4K/piOpfNXTpy0a8/Dr+1edi3fbo0Qv0JWVRrMXOZtT
         6mqJkDNuhB2vin0oNSMrFXp7sUp8U/XpzttfCYILObIfKCeNPT8R1u7zBkmqEe/1frUd
         5p5eZxsAPx1IQHXSDM6QKPThpfE0QKSWuq0osu6HOkW6WIFgiG4pPovgGB+XmmvhJx7Q
         ez8NODo1Qxa0hJ5DwC241IXoFS8VCm6LSGFAZpGGKqap0OBpwTdk3yVo1JocJo/a087Z
         FBew==
X-Gm-Message-State: AOAM532eeVcf+43Mout1WaLf+arKchTJuODY4SOeTS+8RTN+OZe7NMKd
        Js8ayTA9G9ZWoT7abPgLfZo83QGyiHpZaovg
X-Google-Smtp-Source: ABdhPJxETxzi0g5gl3RUyFq2zu9ocPPeVjaau0w3XyrUMBpoPDhfEKgmgY7/b1kMTYZjj0muVDHQOw==
X-Received: by 2002:a17:90a:d596:: with SMTP id v22mr2395580pju.51.1631081797744;
        Tue, 07 Sep 2021 23:16:37 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id n1sm971730pfv.209.2021.09.07.23.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 23:16:37 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Shunsuke Mie <mie@igel.co.jp>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        dhobsong@igel.co.jp, taki@igel.co.jp, etom@igel.co.jp
Subject: [RFC PATCH 0/3] RDMA/rxe: Add dma-buf support
Date:   Wed,  8 Sep 2021 15:16:08 +0900
Message-Id: <20210908061611.69823-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add a support for rxe driver.

A dma-buf based memory registering has beed introduced to use the memory
region that lack of associated page structures (e.g. device memory and CMA
managed memory) [1]. However, to use the dma-buf based memory, each rdma
device drivers require add some implementation. The rxe driver has not
support yet.

[1] https://www.spinics.net/lists/linux-rdma/msg98592.html

To enable to use the memories in rxe rdma device, add some changes and
implementation in this patch series.

This series consists of three patches. The first patch changes the IB core
to support for rdma drivers that have not real dma device. The second
patch extracts a memory mapping process of rxe as a common function to use
a dma-buf support. The third patch adds the dma-buf support to rxe driver.

Related user space RDMA library changes are provided as a separate
patch.

Shunsuke Mie (3):
  RDMA/umem: Change for rdma devices has not dma device
  RDMA/rxe: Extract a mapping process into a function
  RDMA/rxe: Support dma-buf as memory region

 drivers/infiniband/core/umem_dmabuf.c |   2 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |   3 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 186 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  36 +++++
 4 files changed, 193 insertions(+), 34 deletions(-)

-- 
2.17.1

