Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8BF41BDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 06:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243102AbhI2EVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 00:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbhI2EVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 00:21:02 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F31BC061746
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 21:19:21 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so1294516otq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 21:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3pnOoOe4H3uxisLbZYlvxtJ/hfJYJIe9/PJe31s9cPs=;
        b=NKFeRVZewTzimFlcsgeFS3uSkCR4J87AN7Ccy2GhzJvJs61zvHTCbIrXcXuF9A37Z3
         bOAczXU1HRiNyEokRPa4xvFlmLTUqSX2ieVAcFATfw24gsBJK1LfJxj6uUhCOM2M0yUM
         hwQ0u6udUkzg4mMpVYK8Ckebdrb8V8gT0ndANmFXxsDAogwCcZrwvaB58nL/P9Gf2Jlr
         jYoC6GYrCjWlFuM8CBLMcbMxi350112bv+4s89WjKlkG2bTHlLSQ2vSkapSpsaa/eY5O
         TmhV6DgYEnoyGjTgV7tQovgi6B1rQld0vC+8aiBh9VI+KiBrYj9fe0UuWdazT8V2MXI8
         7FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3pnOoOe4H3uxisLbZYlvxtJ/hfJYJIe9/PJe31s9cPs=;
        b=pChct+SSspTPcTBQUBVpJfkgqyx72Y3cdNCl2IE+oGQ9gUH/WvgkVUKWMajeAff89x
         NFZ0EDlN901aL5RDWgSs2G/3DWxR1doN5iSJ9oe0eF2PYskioUcBhiuI4DneqMwOVl6z
         s1Z4fmQckimx1Q/fEGkQ+wC57QzD1IywqzK8RC4D5GhK2ZcDON07+snFGRXLbmt8e0eG
         rfV8OwHfUoRUyX7V40BT0CPKtrrydiEC28noz02hdMeTazY5AhTSQ33mNEh23rRElW7e
         CJH/9AtK4Lwfrn/CJx+YJtBSuD4j7FbrzlbQOEoYke/WNNttQtNkDv4eYzSUunMgJYEb
         Oh6g==
X-Gm-Message-State: AOAM532tqisawcr2PW0PvBc6UqPdGtvaWClDwKOgbJ6oOOg0wt821B64
        4el/Jbz65/POL1hBy6Jso0w7+A==
X-Google-Smtp-Source: ABdhPJwp25Cz3J0zfuH70GHFOw3bQVPteyKSacgNo4gNqbV449fcUU2N51PPLDIKqcNUaNIegMPbuA==
X-Received: by 2002:a9d:184:: with SMTP id e4mr8359740ote.209.1632889160876;
        Tue, 28 Sep 2021 21:19:20 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id p2sm240861ooe.34.2021.09.28.21.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 21:19:20 -0700 (PDT)
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
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, dhobsong@igel.co.jp, taki@igel.co.jp,
        etom@igel.co.jp
Subject: [RFC PATCH v2 0/2] RDMA/rxe: Add dma-buf support
Date:   Wed, 29 Sep 2021 13:19:03 +0900
Message-Id: <20210929041905.126454-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add a dma-buf support for rxe driver.

A dma-buf based memory registering has beed introduced to use the memory
region that lack of associated page structures (e.g. device memory and CMA
managed memory) [1]. However, to use the dma-buf based memory, each rdma
device drivers require add some implementation. The rxe driver has not
support yet.

[1] https://www.spinics.net/lists/linux-rdma/msg98592.html

To enable to use the dma-buf memory in rxe rdma device, add some changes
and implementation in this patch series.

This series consists of two patches. The first patch changes the IB core
to support for rdma drivers that has not dma device. The secound patch adds
the dma-buf support to rxe driver.

Related user space RDMA library changes are provided as a separate patch.

v2:
* Rebase to the latest linux-rdma 'for-next' branch (5.15.0-rc1+)
* Instead of using a dummy dma_device to attach dma-buf, just store
  dma-buf to use software RDMA driver
* Use dma-buf vmap() interface
* Check to pass tests of rdma-core
v1: https://www.spinics.net/lists/linux-rdma/msg105376.html
* The initial patch set
* Use ib_device as dma_device.
* Use dma-buf dynamic attach interface
* Add dma-buf support to rxe device

Shunsuke Mie (2):
  RDMA/umem: Change for rdma devices has not dma device
  RDMA/rxe: Add dma-buf support

 drivers/infiniband/core/umem_dmabuf.c |  20 ++++-
 drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 118 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  34 ++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h |   2 +
 include/rdma/ib_umem.h                |   1 +
 6 files changed, 173 insertions(+), 4 deletions(-)

-- 
2.17.1

