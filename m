Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA93CD156
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 12:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhGSJRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 05:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231928AbhGSJRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 05:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626688663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aUN3/emhwmvuaofhRmHp7VsKSUUpToQZASEb+G5R1TM=;
        b=HnlCvn/OfmFBrcA5GYW9eBF9eWmPX0ndzgocrRYINn+7LOREaT8839QrAyepx3VEgM7LqV
        /BDlfwaPa4j8UeC8WwnQaX7x3R5pUvDXXXTFjLpaIdM1ry6qYviYky/Dx6CfoSA1/WfXtI
        PJTCyXlv/DqdzHHByLQzh6kT5mSxm48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-4wxgnciNPCKh4ATBLnQzmw-1; Mon, 19 Jul 2021 05:57:42 -0400
X-MC-Unique: 4wxgnciNPCKh4ATBLnQzmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34B95100C609;
        Mon, 19 Jul 2021 09:57:41 +0000 (UTC)
Received: from localhost (ovpn-12-118.pek2.redhat.com [10.72.12.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C6E817A9B;
        Mon, 19 Jul 2021 09:57:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 0/7] genirq/affinity: abstract new API from managed irq affinity spread
Date:   Mon, 19 Jul 2021 17:57:22 +0800
Message-Id: <20210719095729.834332-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

irq_build_affinity_masks() actually grouping CPUs evenly into each managed
irq vector according to NUMA and CPU locality, and it is reasonable to abstract
one generic API for grouping CPUs evenly, the idea is suggested by Thomas
Gleixner.

group_cpus_evenly() is abstracted and put into lib/, so blk-mq can re-use
it to build default queue mapping.

Please comments!

Thanks,

Ming Lei (7):
  genirq/affinity: remove the 'firstvec' parameter from
    irq_build_affinity_masks
  genirq/affinity: pass affinity managed mask array to
    irq_build_affinity_masks
  genirq/affinity: don't pass irq_affinity_desc array to
    irq_build_affinity_masks
  genirq/affinity: rename irq_build_affinity_masks as group_cpus_evenly
  genirq/affinity: move group_cpus_evenly() into lib/
  lib/group_cpus: allow to group cpus in case of !CONFIG_SMP
  blk-mq: build default queue map via group_cpus_evenly()

 block/blk-mq-cpumap.c      |  64 ++----
 include/linux/group_cpus.h |  28 +++
 kernel/irq/affinity.c      | 404 +-----------------------------------
 lib/Makefile               |   2 +
 lib/group_cpus.c           | 413 +++++++++++++++++++++++++++++++++++++
 5 files changed, 465 insertions(+), 446 deletions(-)
 create mode 100644 include/linux/group_cpus.h
 create mode 100644 lib/group_cpus.c

-- 
2.31.1

