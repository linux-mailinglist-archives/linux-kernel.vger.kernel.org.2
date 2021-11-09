Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4803144A522
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 04:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242312AbhKIDFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 22:05:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242285AbhKIDFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 22:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636426952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PbN9P372b4zfsNQXGyxa6f7PkAhvEGlp6qQZjPVPkKs=;
        b=Nf8r6rM67Yw7tSNmAik+PoeJ893swk6dFSjYaYl3idp8sk+jejMJwUvoYYmYXOa9ujapyA
        l2mO+o4WNvUXOeD3IdwDBuoWtrplCpA+lP7zoV9Ce5k+ZUtogWq/TlsUEjvCx2qve+AkJ5
        FzbdEiUUII+Hunt0LELM8TA8FbF/5mI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-zPLC8p2oMSiYmNba_b4oLg-1; Mon, 08 Nov 2021 22:02:30 -0500
X-MC-Unique: zPLC8p2oMSiYmNba_b4oLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE2C8108087A;
        Tue,  9 Nov 2021 03:02:28 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B2E760CC4;
        Tue,  9 Nov 2021 03:02:16 +0000 (UTC)
Date:   Tue, 9 Nov 2021 11:02:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kashyap.desai@broadcom.com,
        hare@suse.de
Subject: Re: [PATCH RFT 1/3] blk-mq: Drop busy_iter_fn blk_mq_hw_ctx argument
Message-ID: <YYnks3nfRCIuekD2@T590>
References: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
 <1635852455-39935-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635852455-39935-2-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 07:27:33PM +0800, John Garry wrote:
> The only user of blk_mq_hw_ctx blk_mq_hw_ctx argument is
> blk_mq_rq_inflight().
> 
> Function blk_mq_rq_inflight() uses the hctx to find the associated request
> queue to match against the request. However this same check is already
> done in caller bt_iter(), so drop this check.
> 
> With that change there are no more users of busy_iter_fn blk_mq_hw_ctx
> argument, so drop the argument.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

