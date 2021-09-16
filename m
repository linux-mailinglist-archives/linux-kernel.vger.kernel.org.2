Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F1040DA49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbhIPMtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:49:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239589AbhIPMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631796508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PdupuFQGInFG1eViG9JsMWXfCGz3ZYcsR+xV+6+JqlU=;
        b=V57MIvFi1JlNBtD2/oeW6pcURX7CuwYqaC31Qd85G/OjrmeNv8aNfcNSe13hDn6eDrArrp
        fSt45U5ikDSnSLlKvFp6tugvrewx94oLaBfqn1PKjXNKnHzJR5LOVXeCjG1+jZ+TTwVLrj
        i6A/hZxsBWKHOV28CZi5TOCM6ZJ1Azo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-WDT2rreOM0aMAQa1ZZj2Bg-1; Thu, 16 Sep 2021 08:48:26 -0400
X-MC-Unique: WDT2rreOM0aMAQa1ZZj2Bg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF5359126F;
        Thu, 16 Sep 2021 12:48:20 +0000 (UTC)
Received: from T590 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB9A45C1D1;
        Thu, 16 Sep 2021 12:48:12 +0000 (UTC)
Date:   Thu, 16 Sep 2021 20:48:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [patch v8 4/7] nbd: don't start request if nbd_queue_rq() failed
Message-ID: <YUM9GIBBttUG9DcX@T590>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
 <20210916093350.1410403-5-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916093350.1410403-5-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 05:33:47PM +0800, Yu Kuai wrote:
> commit 6a468d5990ec ("nbd: don't start req until after the dead
> connection logic") move blk_mq_start_request() from nbd_queue_rq()
> to nbd_handle_cmd() to skip starting request if the connection is
> dead. However, request is still started in other error paths.
> 
> Currently, blk_mq_end_request() will be called immediately if
> nbd_queue_rq() failed, thus start request in such situation is
> useless. So remove blk_mq_start_request() from error paths in
> nbd_handle_cmd().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

