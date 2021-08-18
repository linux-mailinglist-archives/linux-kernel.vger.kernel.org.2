Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9698A3F0068
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhHRJ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231373AbhHRJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629278908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q9t8aE64CL1xo5txLMAa0dwZ+SjmOCP8ky9IEfoLYYU=;
        b=IcIR1BLtDacLd18UNIYwXINXxNFUjCjBlCzilL7d6FoGSvr5cm8tixdJsuJHhZBR65f0X+
        XDBjGoMlN7pdn9U6VWHMzdE3t67tA2BEPLSuPoIw5BGpeLbZRgeRSjc/Z70Wsvw9dzAeV+
        l5iylWOZ+VdG2VatNzrlCury8zKVUbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-k6wuv3VMP5mXdROmvyzfuw-1; Wed, 18 Aug 2021 05:28:25 -0400
X-MC-Unique: k6wuv3VMP5mXdROmvyzfuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0F8F1082925;
        Wed, 18 Aug 2021 09:28:23 +0000 (UTC)
Received: from localhost (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9BAD687D5;
        Wed, 18 Aug 2021 09:28:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/7] genirq/affinity: abstract new API from managed irq affinity spread
Date:   Wed, 18 Aug 2021 17:28:05 +0800
Message-Id: <20210818092812.787558-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

V2:
	- fix build failure in case of !CONFIG_SMP
	- fix commit log typo
	- fix memory leak in last patch
	- add reviewed-by

Since RFC:
	- remove RFC
	- rebase on -next tree

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

 block/blk-mq-cpumap.c      |  65 ++----
 include/linux/group_cpus.h |  14 ++
 kernel/irq/affinity.c      | 404 +---------------------------------
 lib/Makefile               |   2 +
 lib/group_cpus.c           | 428 +++++++++++++++++++++++++++++++++++++
 5 files changed, 467 insertions(+), 446 deletions(-)
 create mode 100644 include/linux/group_cpus.h
 create mode 100644 lib/group_cpus.c

-- 
2.31.1

