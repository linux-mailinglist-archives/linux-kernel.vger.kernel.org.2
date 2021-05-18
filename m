Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587AF386E55
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 02:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbhERAbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 20:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233718AbhERAbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 20:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621297799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xCtpJl5wAKagxb9hM9Z4VWmYK67Am2vQEsG/WsS00BA=;
        b=IKbqof1Aj/Gb4VJBGKA5WeWGiL4XTJ0YE4iDcIKwHjtB3Sr1pdwYjPX3ZSylLLf2ThpJVH
        z0qM2kcc/+EflkVU6VtBDmMckv/i0q9f7u2DeV9AHwFyisaU7WWz2YFenYgaSEJxjypkZo
        zUBSXf56+c5NnFIOXI9jfxWJVxiLXkY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-Kv5nR3XBNRWIwn1qWCLM3g-1; Mon, 17 May 2021 20:29:58 -0400
X-MC-Unique: Kv5nR3XBNRWIwn1qWCLM3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A92601A8A61;
        Tue, 18 May 2021 00:29:56 +0000 (UTC)
Received: from T590 (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F99860C25;
        Tue, 18 May 2021 00:29:45 +0000 (UTC)
Date:   Tue, 18 May 2021 08:29:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, josef@toxicpanda.com, axboe@kernel.dk,
        idryomov@redhat.com, xiubli@redhat.com,
        Matteo Croce <mcroce@linux.microsoft.com>
Subject: Re: [PATCH] nbd: provide a way for userspace processes to identify
 device backends
Message-ID: <YKMKdHPFCNhR1SXx@T590>
References: <20210429102828.31248-1-prasanna.kalever@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429102828.31248-1-prasanna.kalever@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Prasanna,

On Thu, Apr 29, 2021 at 03:58:28PM +0530, Prasanna Kumar Kalever wrote:
> Problem:
> On reconfigure of device, there is no way to defend if the backend
> storage is matching with the initial backend storage.
> 
> Say, if an initial connect request for backend "pool1/image1" got
> mapped to /dev/nbd0 and the userspace process is terminated. A next
> reconfigure request within NBD_ATTR_DEAD_CONN_TIMEOUT is allowed to
> use /dev/nbd0 for a different backend "pool1/image2"
> 
> For example, an operation like below could be dangerous:

Can you explain a bit why it is dangerous?

> 
> $ sudo rbd-nbd map --try-netlink rbd-pool/ext4-image
> /dev/nbd0
> $ sudo blkid /dev/nbd0
> /dev/nbd0: UUID="bfc444b4-64b1-418f-8b36-6e0d170cfc04" TYPE="ext4"
> $ sudo pkill -9 rbd-nbd
> $ sudo rbd-nbd attach --try-netlink --device /dev/nbd0 rbd-pool/xfs-image
> /dev/nbd0
> $ sudo blkid /dev/nbd0
> /dev/nbd0: UUID="d29bf343-6570-4069-a9ea-2fa156ced908" TYPE="xfs"
> 
> Solution:
> Provide a way for userspace processes to keep some metadata to identify
> between the device and the backend, so that when a reconfigure request is
> made, we can compare and avoid such dangerous operations.
> 
> With this solution, as part of the initial connect request, backend
> path can be stored in the sysfs per device config, so that on a reconfigure
> request it's easy to check if the backend path matches with the initial
> connect backend path.
> 
> Please note, ioctl interface to nbd will not have these changes, as there
> won't be any reconfigure.

BTW, loop has similar issue, and patch of 'block: add a sequence number to disks'
is added for addressing this issue, what do you think of that generic
approach wrt. this nbd's issue? such as used the exposed sysfs sequence number
for addressing this issue?

https://lore.kernel.org/linux-block/YH81n34d2G3C4Re+@gardel-login/#r

Thanks,
Ming

