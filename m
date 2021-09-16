Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A138B40DA52
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbhIPMvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239623AbhIPMvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631796601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=49Dsryiv3dcLfpmVKNAA9Sv+OZpWhSmz8iP/O9CxmMg=;
        b=XXjHWzQIRoCEm25f6xHRWTnGOPcFWkwHVNCz/tGMlYbzLhy3D9BLqs87siNGhuVE7mJR9J
        zZzEi+J9/4rWqanqmClUcBOrI2IxEVYK4eLzYmOQvDNXt21ziuHZ9pHh/vdtTqJwBmMQ7m
        M8xDR46IO9PoRcDybSi3GyZDTTDEwOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-mQK3Q4erOR2RNLBVC9E4LQ-1; Thu, 16 Sep 2021 08:49:58 -0400
X-MC-Unique: mQK3Q4erOR2RNLBVC9E4LQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD94B802934;
        Thu, 16 Sep 2021 12:49:56 +0000 (UTC)
Received: from T590 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC3925D9CA;
        Thu, 16 Sep 2021 12:49:48 +0000 (UTC)
Date:   Thu, 16 Sep 2021 20:49:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [patch v8 5/7] nbd: clean up return value checking of sock_xmit()
Message-ID: <YUM9d4TiBPNx4kgq@T590>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
 <20210916093350.1410403-6-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916093350.1410403-6-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 05:33:48PM +0800, Yu Kuai wrote:
> Check if sock_xmit() return 0 is useless because it'll never return
> 0, comment it and remove such checkings.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/block/nbd.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

