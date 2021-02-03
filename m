Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5D730DA9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhBCNGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:06:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231373AbhBCNG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612357499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZ/PnSF/Mht9gW5p6NbEzpwutRMrm7ZYBx9Q4GGL4MY=;
        b=DCe/mQwKoXE2BtPaagkecK5Gct6tcIIFxpdyVDtm1mNpN5Rn0hNzv7YstjminSSWiiiQIr
        zXqM3dJDld+OAdP4Nsn2QLlOo1uEJxES+SetUVT1MhkOFnbfkmapW6pw6AhGEC5xcTxnTg
        cq0Aw1Y9ZaT8YOtRxbWelYm7wuXwqKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-57E2bRiFNniJb7CUzZH3Gg-1; Wed, 03 Feb 2021 08:04:55 -0500
X-MC-Unique: 57E2bRiFNniJb7CUzZH3Gg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5D80BBEE4;
        Wed,  3 Feb 2021 13:04:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-27.ams2.redhat.com [10.36.113.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 650865D9E8;
        Wed,  3 Feb 2021 13:04:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2E517180063E; Wed,  3 Feb 2021 14:04:15 +0100 (CET)
Date:   Wed, 3 Feb 2021 14:04:15 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] drm/qxl: properly free qxl releases
Message-ID: <20210203130415.rqokinkpy6ivixmu@sirius.home.kraxel.org>
References: <20210126165812.1661512-1-kraxel@redhat.com>
 <20210126165812.1661512-6-kraxel@redhat.com>
 <YBp3zQqomQziZbPT@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBp3zQqomQziZbPT@phenom.ffwll.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	/*
> > +	 * Ask host to release resources (+fill release ring),
> > +	 * then wait for the release actually happening.
> > +	 */
> > +	qxl_io_notify_oom(qdev);
> > +	for (try = 0; try < 20 && atomic_read(&qdev->release_count) > 0; try++)
> > +		msleep(20);
> 
> A bit icky, why not use a wait queue or something like that instead of
> hand-rolling this? Not for perf reasons, just so it's a bit clear who
> waits for whom and why.

There isn't one ready for use, and adding a new one (to wait for the
garbage collection having released something) just for a clean shutdown
looked a bit like overkill.

But after digging a bit more and looking at the qxl_fence_wait() mess I
think adding a wait queue looks like a good idea ...

v5 coming soon ...

take care,
  Gerd

