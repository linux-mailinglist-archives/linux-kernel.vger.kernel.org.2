Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722A3438D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 04:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhJYC5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 22:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229665AbhJYC5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 22:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635130483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kHLzd1yN1HItmCmiyo6e0YvO6hbI30slfLz3N4utYS8=;
        b=VVGKDqQJtm5m5GIJUbdgsDFnnWCBbR1dTUDEPNgy+0oK38td3BDDnx7smNfP5kt3wOfYuS
        MY1hUJTmYtxg2S+rBhxClmM4Ei25p8ZI32CF/ys87Zg63YPM11eVhTg7U1/mSlPkzXQjQ0
        n5PVR1uVrowBAoTbTxqMJg+TI3B86IY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-5NyMsUJ2PjqsX07MCK3nXA-1; Sun, 24 Oct 2021 22:54:40 -0400
X-MC-Unique: 5NyMsUJ2PjqsX07MCK3nXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB7AF10A8E01;
        Mon, 25 Oct 2021 02:54:38 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5C4D19D9D;
        Mon, 25 Oct 2021 02:54:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/4] zram: fix two races and one zram leak
Date:   Mon, 25 Oct 2021 10:54:22 +0800
Message-Id: <20211025025426.2815424-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Fixes three issues reported by Luis Chamberlain with one simpler approach:

- race between between zram_reset_device() and disksize_store() (1/4)

- zram leak during unloading module, which is one race between resetting
and removing device (2/4)

- race between zram_remove and disksize_store (3/4)

Also replace replace fsync_bdev with sync_blockdev since no one opens
it.(4/4)

V3:
	- no code change
	- update commit log or comment as Luis suggested
	- add reviewed-by tag

V2:
	- take another approach to avoid failing of zram_remove()
	- add patch to address race between zram_reset_device() and
	  disksize_store()


Ming Lei (4):
  zram: fix race between zram_reset_device() and disksize_store()
  zram: don't fail to remove zram during unloading module
  zram: avoid race between zram_remove and disksize_store
  zram: replace fsync_bdev with sync_blockdev

 drivers/block/zram/zram_drv.c | 39 ++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

-- 
2.31.1

