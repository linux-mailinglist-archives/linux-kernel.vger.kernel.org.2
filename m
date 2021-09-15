Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2F40BFA4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhIOGbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 02:31:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229484AbhIOGbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631687385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+C6oOXnSiXCMxV5e9+CpUPoeNdMOGB3oYk9FF4IqK+A=;
        b=K/xAV+MNx8+dY51mER+d6topI/LDgJyYuwnX6McpVt+KT2r1c/+36UZvu9v7TkkweycvFf
        Zsr2wc0kZsykjxE0wWrWDD5DRxmMAWdDIt1R5krGow+IHHk/fd2Vd3eLW7ZIWvAp1X/An4
        y0/2/6NcXXx/8mqQSSiMnK333SKb/YY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-PpDkW-RaNMSdhiRoBpC_4w-1; Wed, 15 Sep 2021 02:29:44 -0400
X-MC-Unique: PpDkW-RaNMSdhiRoBpC_4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3146824FAF;
        Wed, 15 Sep 2021 06:29:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A68666D982;
        Wed, 15 Sep 2021 06:29:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DF43618003BF; Wed, 15 Sep 2021 08:29:40 +0200 (CEST)
Date:   Wed, 15 Sep 2021 08:29:40 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "H. Peter Anvin (Intel)" <hpa@zytor.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bochs: add Bochs PCI ID for Simics model
Message-ID: <20210915062940.m3q2fwbipkq7ki6s@sirius.home.kraxel.org>
References: <20210910010655.2356245-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910010655.2356245-1-hpa@zytor.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 06:06:55PM -0700, H. Peter Anvin (Intel) wrote:
> Current (and older) Simics models for the Bochs VGA used the wrong PCI
> vendor ID (0x4321 instead of 0x1234).  Although this can hopefully be
> fixed in the future, it is a problem for users of the current version,
> not the least because to update the device ID the BIOS has to be
> rebuilt in order to see BIOS output.
> 
> Add support for the 4321:1111 device number in addition to the
> 1234:1111 one.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>

Pusged to drm-misc-next.

thanks,
  Gerd

