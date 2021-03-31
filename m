Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C721345973
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCWIPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229992AbhCWIO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616487298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F7K6Lh/BNZuQrbqNqcyksNAihXl0YSqISZq+0vfi9Ww=;
        b=YPrFVUcg8ovZmejr6KGPViLSeZ9CMTOCkcq2M53zXoAJEV37qdO9CIex8K3++rjwO6crSq
        F9l+dY+N4IjnSdHMromoFgc70q4N2ndite1lcQtCWBUuObML+H9gez8S7DotHhHrlwST1x
        ZbV3JDD1So/p0GU+vInVATF8UEsH9hM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-wuS5JpfkMiidJHFaeq4bXA-1; Tue, 23 Mar 2021 04:14:56 -0400
X-MC-Unique: wuS5JpfkMiidJHFaeq4bXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 750F6800D53;
        Tue, 23 Mar 2021 08:14:54 +0000 (UTC)
Received: from localhost (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AD6160BD8;
        Tue, 23 Mar 2021 08:14:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] blktrace: fix trace buffer leak and limit trace buffer size
Date:   Tue, 23 Mar 2021 16:14:38 +0800
Message-Id: <20210323081440.81343-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blktrace may pass big trace buffer size via '-b', meantime the system
may have lots of CPU cores, so too much memory can be allocated for
blktrace.

The 1st patch shutdown bltrace in blkdev_close() in case of task
exiting, for avoiding trace buffer leak.

The 2nd patch limits max trace buffer size for avoiding potential
OOM.


Ming Lei (2):
  block: shutdown blktrace in case of fatal signal pending
  blktrace: limit allowed total trace buffer size

 fs/block_dev.c          |  6 ++++++
 kernel/trace/blktrace.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

-- 
2.29.2

