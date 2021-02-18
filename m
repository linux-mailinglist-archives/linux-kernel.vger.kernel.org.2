Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6830831ECE6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhBRRIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:08:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231540AbhBROYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613658192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B0Np6RmIQw2V0BL+Pl69+jda/IWr90txxGD9/gHBjqQ=;
        b=KcEFaySIemdJpk5jSG1d72JjVzCA2EwGUHsV/7hsGLKa5MwlkUA0E3Oo5EnhgfwDcwNz9B
        dRnmY1cVsRl7Slzv9HTVliQ785OE9HYptJUbDB1aKZGSU/KtlRPCsfdrXJpAKLhZyCS7ja
        KlzntGSmY9QXy01YuNLBCzlB4EWFmeI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-MrPlxZAFN1-CBrxEqE7XnQ-1; Thu, 18 Feb 2021 09:23:10 -0500
X-MC-Unique: MrPlxZAFN1-CBrxEqE7XnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D26980197C;
        Thu, 18 Feb 2021 14:23:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com [10.36.114.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BCD0019D9F;
        Thu, 18 Feb 2021 14:23:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9A48118000B7; Thu, 18 Feb 2021 15:23:06 +0100 (CET)
Date:   Thu, 18 Feb 2021 15:23:06 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 10/11] drm/qxl: rework cursor plane
Message-ID: <20210218142306.zlogw344is46q3yl@sirius.home.kraxel.org>
References: <20210217123213.2199186-1-kraxel@redhat.com>
 <20210217123213.2199186-11-kraxel@redhat.com>
 <6a5581b2-8e62-1310-d42e-abfa301edc88@suse.de>
 <20210218115044.7tsi2szbdlw6lvdi@sirius.home.kraxel.org>
 <2d7a649c-bf1d-aa41-8d3c-af9746b94bc0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d7a649c-bf1d-aa41-8d3c-af9746b94bc0@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > Well.  I suspect I could easily spend a month cleaning up and party
> > redesign the qxl driver (specifically qxl_draw.c + qxl_image.c).
> > 
> > I'm not sure I'll find the time to actually do that anytime soon.
> > I have plenty of other stuff on my TODO list, and given that the
> > world is transitioning to virtio-gpu the priority for qxl isn't
> > that high.
> 
> Well, in that case:
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> for patches 9 and 10. Having the vmap calls fixed is at least worth it.

Thanks.  Any chance you can ack 8/11 too (only patch missing an ack).

take care,
  Gerd

