Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B243D530B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 08:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhGZF2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhGZF2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:28:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A75C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 23:09:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so5463644wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fs/qMW+zCQPBZoUzNXy1A88u02WLrjhFdFexEEelAZE=;
        b=fWSOVnu0bm2MWyRGIQz25MGM8/MU5L2FQwlEkfAFE2TUWTTLoPJiNNE6aKCcykbHC9
         hsBqYWklnDby93Dkq+PljyFW1dXOAZSArNcj5MY+WejFMo04xKr5bpIKU6RpnE/ViRRi
         EX97NDejVrJYpa6WDTDp97pYD0fGpcGqqv3L66cPxAYrfjIzfVj43tPMVG2p2CsYmIcZ
         IZ9AbiFRufHClTbE7vxm9AW2a8+d2i+B+PU+FGbqbLGr5v7aePLbu2pgxN2r2ZlNkqze
         7zTw9HwOq5ndsUO5Lay2tyVMcXSZto2ICsgtKauqHvMsteO+fyRqqKPKQsL84Xs4Vz9g
         RNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fs/qMW+zCQPBZoUzNXy1A88u02WLrjhFdFexEEelAZE=;
        b=WufPDKr7/DMkK3k3Y9TsXkj4eEGD15Fc/XrSaxGjmZq5QgE15qPBUTEYQxEV5kGRzc
         6r7U7DfWueI/J8OB98iuMKM63dL4trN1TUhd1We0vYPvRYiQGVjQuzS3+p6+vkN8TrSw
         /6WGLvDZ9FPWeLQaSc9RBiI4uZymzgbViAcaFrdJyki95FqYCmRnKKBPxvBC50GQf+4q
         IrgO12x7ALLgqderP9Gl8TJaJc+UokveCfnJh87UAvmHRpcXaLAr4sn0JPl552/2UqNE
         5dJq5CCm90jZDAhZnvL29FgK7CfedzRguyJp146OjwwiAxwjzb4Ok3PNAHkkiRfFhqqU
         GnHw==
X-Gm-Message-State: AOAM530wbGdiPcVAu4UOX/2jBHUYYbWKySpIdEJkNgPNZfML1tEnBBT3
        bc067OlAypN0iVPKefluryo=
X-Google-Smtp-Source: ABdhPJzids5i79f84ChWXUAzzYA4qPfgWcx00yP2mkCfTQCIK7koHv/gRtQJKSI5H/l/AJ8/9NBadw==
X-Received: by 2002:a05:600c:1d0b:: with SMTP id l11mr8434949wms.2.1627279750969;
        Sun, 25 Jul 2021 23:09:10 -0700 (PDT)
Received: from lb01399.fkb.profitbricks.net (p200300ca572b5e23c4ffd69035d3b735.dip0.t-ipconnect.de. [2003:ca:572b:5e23:c4ff:d690:35d3:b735])
        by smtp.gmail.com with ESMTPSA id j2sm5817548wrd.14.2021.07.25.23.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 23:09:10 -0700 (PDT)
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.j.williams@intel.com, jmoyer@redhat.com, david@redhat.com,
        mst@redhat.com, cohuck@redhat.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com,
        pankaj.gupta.linux@gmail.com, Pankaj Gupta <pankaj.gupta@ionos.com>
Subject: [RFC v2 0/2] virtio-pmem: Asynchronous flush
Date:   Mon, 26 Jul 2021 08:08:53 +0200
Message-Id: <20210726060855.108250-1-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Gupta <pankaj.gupta@ionos.com>

 Jeff reported preflush order issue with the existing implementation
 of virtio pmem preflush. Dan suggested[1] to implement asynchronous flush
 for virtio pmem using work queue as done in md/RAID. This patch series
 intends to solve the preflush ordering issue and also makes the flush
 asynchronous for the submitting thread.

 Submitting this patch series for review. Sorry, It took me long time to
 come back to this due to some personal reasons.

 RFC v1 -> RFC v2
 - More testing and bug fix.

 [1] https://marc.info/?l=linux-kernel&m=157446316409937&w=2

Pankaj Gupta (2):
  virtio-pmem: Async virtio-pmem flush
  pmem: enable pmem_submit_bio for asynchronous flush

 drivers/nvdimm/nd_virtio.c   | 72 ++++++++++++++++++++++++++++--------
 drivers/nvdimm/pmem.c        | 17 ++++++---
 drivers/nvdimm/virtio_pmem.c | 10 ++++-
 drivers/nvdimm/virtio_pmem.h | 14 +++++++
 4 files changed, 91 insertions(+), 22 deletions(-)

-- 
2.25.1

