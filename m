Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F01314ED3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBIMSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:18:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229517AbhBIMSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612872995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ByUjskTTLoPD2OajNMiA8UoGsbWTnUgXFSxuqEGtMYU=;
        b=LjQ21l8+g965qkfYqorGpywS9dBVqbpVtqapWWClGPuTy0Ywk/5AYZmzIw0skfi9eQmuja
        ngZgM3fuTSl40Bw07o8wfemeu1KOerpeoMUe9PV0vwR4iZaY9hlszlYMbgm1FkNmktBjYz
        vF3r7q9aRVCReNGn0QHN34DkQ5qkM8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-MIC4sTsyMaC8ql-oRLNTXg-1; Tue, 09 Feb 2021 07:16:33 -0500
X-MC-Unique: MIC4sTsyMaC8ql-oRLNTXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7FB01005501;
        Tue,  9 Feb 2021 12:16:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-170.ams2.redhat.com [10.36.112.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A965171F4;
        Tue,  9 Feb 2021 12:16:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 737F41800395; Tue,  9 Feb 2021 13:16:29 +0100 (CET)
Date:   Tue, 9 Feb 2021 13:16:29 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/qxl: properly handle device init failures
Message-ID: <20210209121629.vb3yu6zkr4npnskz@sirius.home.kraxel.org>
References: <20210208104149.423758-1-kraxel@redhat.com>
 <E07153A4-9B42-4050-903E-8BBB99D8ED8E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E07153A4-9B42-4050-903E-8BBB99D8ED8E@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 12:07:01PM -0500, Tong Zhang wrote:
> Does this patch fix an issue raised previously? Or should they be used together?
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2466541.html 
> 
> IMHO using this patch alone won’t fix the issue

This patch on top of drm-misc-next fixes the initialization error issue
reported by you in my testing.

take care,
  Gerd

