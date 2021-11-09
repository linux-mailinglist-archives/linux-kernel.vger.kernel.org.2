Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E591844A52B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 04:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbhKIDIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 22:08:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238738AbhKIDIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 22:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636427145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/DB+ecIvLm4RLKgaYYMmfgFiKR820I9FT3zdqxU7+I=;
        b=M1AXpwpDAHOQdXExLPpfKqdefRB4h6ydad11y3ffP+OtuQ9AHttCLFs7tDCNEJqPaQGc+h
        gXsu6tXSvhNfvuFIXbuBizi60qqDpuLQb9z4VZ9vP0XSwSzl0iRX5q/5ZeWCGYEJaKGAhS
        Rr1WoGZ9MHFi5ihUN68TrbiWlDiqLZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-jhfvtLSlOle-2Ns3e-_pxw-1; Mon, 08 Nov 2021 22:05:42 -0500
X-MC-Unique: jhfvtLSlOle-2Ns3e-_pxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DCEA19057A4;
        Tue,  9 Nov 2021 03:05:41 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24380101E594;
        Tue,  9 Nov 2021 03:05:06 +0000 (UTC)
Date:   Tue, 9 Nov 2021 11:05:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kashyap.desai@broadcom.com,
        hare@suse.de
Subject: Re: [PATCH RFT 2/3] blk-mq: Delete busy_iter_fn
Message-ID: <YYnlXgDFAFvD/sX9@T590>
References: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
 <1635852455-39935-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635852455-39935-3-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 07:27:34PM +0800, John Garry wrote:
> Typedefs busy_iter_fn and busy_tag_iter_fn are now identical, so delete
> busy_iter_fn to reduce duplication.
> 
> It would be nicer to delete busy_tag_iter_fn, as the name busy_iter_fn is
> less specific.
> 
> However busy_tag_iter_fn is used in many different parts of the tree,
> unlike busy_iter_fn which is just use in block/, so just take the
> straightforward path now, so that we could rename later treewide.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

