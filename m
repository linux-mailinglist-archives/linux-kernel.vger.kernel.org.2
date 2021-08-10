Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E897B3E517C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 05:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbhHJD2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 23:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236662AbhHJD2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 23:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628566070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yOmYoCRgGWoxX4Ig7wMcZct6gYjWHtKD2JHpEcgfojM=;
        b=ACjnbefypvlXbxtEAXivssUngv1pzAMvdibfQvYlP1/MR+8IMOp/0OPtt03tOSxptuYwGG
        t6JThX/mypYWNe8fU9qra+0kons0XDm6zJSppGfmO62ikide5NnYIUVyFiZ+wnJHu5qfVm
        xSD715DmqXk3iaBcly1aSNGBCgykX98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-iTpxUWxQPN6WB6ifkHsvSw-1; Mon, 09 Aug 2021 23:27:07 -0400
X-MC-Unique: iTpxUWxQPN6WB6ifkHsvSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B85251008060;
        Tue, 10 Aug 2021 03:27:05 +0000 (UTC)
Received: from T590 (ovpn-13-190.pek2.redhat.com [10.72.13.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45D385C23A;
        Tue, 10 Aug 2021 03:26:58 +0000 (UTC)
Date:   Tue, 10 Aug 2021 11:26:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH V4 0/7] loop: cleanup charging io to mem/blkcg
Message-ID: <YRHx/qaKgEqWdXOP@T590>
References: <20210806080302.298297-1-ming.lei@redhat.com>
 <20210809064159.GA19070@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809064159.GA19070@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chritoph,

On Mon, Aug 09, 2021 at 08:41:59AM +0200, Christoph Hellwig wrote:
> FYI, I am still of the firm opinion that the current cgroup support in
> the loop driver needs to be reverted and be redone cleanly from scratch
> without impacting the normal non-cgroup path at all.

This patchset basically re-writes the original patches much or less, and the
normal non-cgroup path is basically not changed compared with before
87579e9b7d8d ("loop: use worker per cgroup instead of kworker").
Original way is to use kthread_work, now it is switched to queue_work()
for unifying the code, but all commands are just added to one list and run
batching in the single worker context, which is very similar with kthread_worker.

Can you share us what your expectations are in the re-write? Such as:

1) no impact on normal non-cgroup path
2) ...
3) ...

Thanks,
Ming

