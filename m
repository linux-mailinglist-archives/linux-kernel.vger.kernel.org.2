Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF5B4035CA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347581AbhIHICA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346759AbhIHIB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631088051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TB2ekSSIcbQoZxt/un7RjNKMTM5toctciF/7FP+Yn0s=;
        b=J1y87QYrZ89H9U1UcssU4LWwoP4JG7P1VZ/hHaEauNIKooTO68VB8Xw2s7qoofccGpO9X7
        YByiqeVxZBN9O/K1LhNKhpZoLFNy+zxSY4dEKO7CBgVPYUZeKQQFCHbHOiRgC+hiGvqUzr
        +ZWCrp70y8q5btROJXddBhVUiE0JwD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-psUk2-QYPEyMtlModTSVtg-1; Wed, 08 Sep 2021 04:00:48 -0400
X-MC-Unique: psUk2-QYPEyMtlModTSVtg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F4D1501E8;
        Wed,  8 Sep 2021 08:00:47 +0000 (UTC)
Received: from T590 (ovpn-12-207.pek2.redhat.com [10.72.12.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CED2B60BD8;
        Wed,  8 Sep 2021 08:00:40 +0000 (UTC)
Date:   Wed, 8 Sep 2021 16:00:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v4 2/6] nbd: convert to use blk_mq_find_and_get_req()
Message-ID: <YThtq154oyROxBj9@T590>
References: <20210907140154.2134091-1-yukuai3@huawei.com>
 <20210907140154.2134091-3-yukuai3@huawei.com>
 <YThmhhI1/fZd29b1@T590>
 <e295605c-bc8e-cbb9-ca51-1355fdfc0264@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e295605c-bc8e-cbb9-ca51-1355fdfc0264@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 03:37:06PM +0800, yukuai (C) wrote:
> On 2021/09/08 15:30, Ming Lei wrote:
> 
> > > +put_req:
> > > +	if (req)
> > > +		blk_mq_put_rq_ref(req);
> > >   	return ret ? ERR_PTR(ret) : cmd;
> > 
> > After the request's refcnt is dropped, it can be freed immediately, then
> > one stale command is returned to caller.
> 
> Hi, Ming
> 
> It's right this patch leave this problem. Please take a look at patch 3
> and patch 4, the problem should be fixed with these patches.

Not see it is addressed in patch 3 & 4, and it is one obvious fault in
patch 2, please fix it from beginning by moving the refcnt drop
into recv_work().

BTW, the approach in patch 3 looks fine, which is very similar with
SCSI's handling.

Thanks,
Ming

