Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A75631EA83
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhBRNla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:41:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230326AbhBRLw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613649051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZgRuDjJn+XJlmluwHnTnZxFl0mplVCMFhoWOz62X0g=;
        b=gEm+cEDB01FqUigDZk7+gjMDpGPeMe7Z5qdxbHP6PQvqEnRwqp1+Qf2NFoUjdU8/WvgyQU
        9Bo44vfSfTUiUsgZsy7uKMxIPZS70U+AHYRAiswL0qAHO7CUcJk60JXiJfjT2ERB9Rvgo9
        7tAQXl1rsCjd4oD6ahcN4RJxlHfY5Ys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-vQKdb8bWO8mrdebz26uNYQ-1; Thu, 18 Feb 2021 06:50:48 -0500
X-MC-Unique: vQKdb8bWO8mrdebz26uNYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FFF9100CCD0;
        Thu, 18 Feb 2021 11:50:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com [10.36.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B8B05D6A1;
        Thu, 18 Feb 2021 11:50:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id AC76618000BB; Thu, 18 Feb 2021 12:50:44 +0100 (CET)
Date:   Thu, 18 Feb 2021 12:50:44 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH v2 10/11] drm/qxl: rework cursor plane
Message-ID: <20210218115044.7tsi2szbdlw6lvdi@sirius.home.kraxel.org>
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-11-kraxel@redhat.com>
 <6a5581b2-8e62-1310-d42e-abfa301edc88@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a5581b2-8e62-1310-d42e-abfa301edc88@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> I'm still trying to wrap my head around the qxl cursor code.
> 
> Getting vmap out of the commit tail is good, but I feel like this isn't
> going in the right direction overall.
> 
> In ast, these helper functions were only good when converting the drvier to
> atomic modesetting. So I removed them in the latst patchset and did all the
> updates in the plane helpers directly.

I see the helper functions more as a way to get some structure into the
code flow.  The callbacks are easier to read if they just call helper
functions for stuff which needs more than a handful lines of code
(patch 9/11 exists for the same reason).

The helpers also make it easier move work from one callback to another,
but that is just a useful side-effect.

I had considered making that two separate patches, one factor out code
into functions and one moving the calls.  Turned out to not be that easy
though, because the old qxl_cursor_atomic_update() code was a rather
hairy mix of qxl_create_cursor() + qxl_primary_apply_cursor() +
qxl_primary_move_cursor().

> For cursor_bo itself, it seems to be transitional state that is only used
> during the plane update and crtc update . It should probably be stored in a
> plane-state structure.
> 
> Some of the primary plane's functions seem to deal with cursor handling.
> What's the role of the primary plane in cursor handling?

It's a quirk.  The qxl device will forget the cursor state on
qxl_io_create_primary(), so I have to remember the cursor state
and re-establish it by calling qxl_primary_apply_cursor() again.

So I'm not sure sticking this into plane state would work.  Because of
the quirk this is more than just a handover from prepare to commit.

> For now, I suggest to merge patch 1 to 8 and 11; and move the cursor patches
> into a new patchset.

I can merge 1-8, but 11 has to wait until the cursor is sorted.
There is a reason why 11 is last in the series ;)

> I'd like ot hear Daniel's opinion on this. Do you have
> further plans here?

Well.  I suspect I could easily spend a month cleaning up and party
redesign the qxl driver (specifically qxl_draw.c + qxl_image.c).

I'm not sure I'll find the time to actually do that anytime soon.
I have plenty of other stuff on my TODO list, and given that the
world is transitioning to virtio-gpu the priority for qxl isn't
that high.

So, no, I have no short-term plans for qxl beyond fixing pins +
reservations + lockdep.

take care,
  Gerd

