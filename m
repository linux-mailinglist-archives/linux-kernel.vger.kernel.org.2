Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402933A0CF6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbhFIHCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234137AbhFIHC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623222032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6hIZj5McJwNKEs212yGJXp2y36I81CvD5+PXaLps0Hg=;
        b=I9p1LTQN6m1GKeQ4Hgi1KLpxgr2TOptXJRT3qtV3Po4124YWm2NbKOG05/m4QYj9KYTDtv
        /kxYqD/Of5gnyvs3mjmI3TMb6SY7cxc1dgpyg95yPdDEhgUw9TRgCmzTGYRsehGwOhxNVc
        2aMCAfLxKTxlrix7oDHPodrwnkIFYSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-xQCyc86KPvisvcAPrxDywg-1; Wed, 09 Jun 2021 03:00:30 -0400
X-MC-Unique: xQCyc86KPvisvcAPrxDywg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEB8A8042A6;
        Wed,  9 Jun 2021 07:00:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-69.ams2.redhat.com [10.36.113.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 111C419C45;
        Wed,  9 Jun 2021 07:00:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7770C18003B6; Wed,  9 Jun 2021 09:00:23 +0200 (CEST)
Date:   Wed, 9 Jun 2021 09:00:23 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        Alon Levy <alevy@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: qxl: ensure surf.data is ininitialized
Message-ID: <20210609070023.zp53qaopkbx2ol3a@sirius.home.kraxel.org>
References: <20210608161313.161922-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608161313.161922-1-colin.king@canonical.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 05:13:13PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The object surf is not fully initialized and the uninitialized
> field surf.data is being copied by the call to qxl_bo_create
> via the call to qxl_gem_object_create. Set surf.data to zero
> to ensure garbage data from the stack is not being copied.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Pushed to drm-misc-next.

thanks,
  Gerd

