Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33E5387621
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbhERKKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241553AbhERKKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621332571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r098tHE0nlpPy8H+tzPNv+PPdJXPs/G8lc3vpf4k9jM=;
        b=g9u0046UYJ+Z39qMOqgKV6Yva4f+VpzH08c+Gz8HpQIbDAs7C9RB93CGsr0UFSmFjmsmda
        xianPFbIepiYakmASE+k3unDZRIXP7JuNABiRtZ4QW1PRpxsUJs/JKucRcIXIZ0Dab28YG
        xPvBfI9Ym4h+UIiFYjBIFI9D4CGizn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-lX7iFzYyPlmd8sTiiq0pqw-1; Tue, 18 May 2021 06:09:30 -0400
X-MC-Unique: lX7iFzYyPlmd8sTiiq0pqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C8BF802B78;
        Tue, 18 May 2021 10:09:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-0.ams2.redhat.com [10.36.114.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 663FC5D703;
        Tue, 18 May 2021 10:09:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BBDEF180079B; Tue, 18 May 2021 12:09:25 +0200 (CEST)
Date:   Tue, 18 May 2021 12:09:25 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/virtio: Fixes a potential NULL pointer
 dereference on probe failure
Message-ID: <20210518100925.uvddw6y5ya4ddope@sirius.home.kraxel.org>
References: <20210517084913.403-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517084913.403-1-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 04:49:11PM +0800, Xie Yongji wrote:
> The dev->dev_private might not be allocated if virtio_gpu_pci_quirk()
> or virtio_gpu_init() failed. In this case, we should avoid the cleanup
> in virtio_gpu_release().

Pushed all three to drm-misc-next.

thanks,
  Gerd

