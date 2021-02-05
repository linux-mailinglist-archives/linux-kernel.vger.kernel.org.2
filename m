Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEFC310609
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 08:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBEHpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 02:45:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231466AbhBEHpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612511016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QkctUj4JntN0l9IjN3mm31aWsWyPBr920PgHhtiFxa4=;
        b=K2WCE6/yn+0pm+1o9GnzpbMki9nz0SdXy4NWpoynMoZ7xEv6RCyRpbBvCAo2Ff+NhvLUyh
        aBfPAQWTTjC6NaTnyn1FycU08WHksddYC65ozmVhKDNrtPs1mOlX5vC8AsS8UMStfypzze
        Caxg+nsMsX1OCox+BaR0xt/JJvXmlDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-Id3HAsG6MuSpw28xyN0ZAw-1; Fri, 05 Feb 2021 02:43:33 -0500
X-MC-Unique: Id3HAsG6MuSpw28xyN0ZAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EECD5192CC41;
        Fri,  5 Feb 2021 07:43:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-108.ams2.redhat.com [10.36.113.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF35C5C1B4;
        Fri,  5 Feb 2021 07:43:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 35D6918000B6; Fri,  5 Feb 2021 08:43:30 +0100 (CET)
Date:   Fri, 5 Feb 2021 08:43:30 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/qxl: do not run release if qxl failed to init
Message-ID: <20210205074330.zsb2lg5umgkxh2p3@sirius.home.kraxel.org>
References: <20210204163050.1232756-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204163050.1232756-1-ztong0001@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:30:50AM -0500, Tong Zhang wrote:
> if qxl_device_init() fail, drm device will not be registered,
> in this case, do not run qxl_drm_release()

How do you trigger this?

take care,
  Gerd

