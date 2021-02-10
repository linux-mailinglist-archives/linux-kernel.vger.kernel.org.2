Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD53D315E28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 05:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhBJES6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 23:18:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhBJES4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 23:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612930650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XogBkdyBYNnsPgb8O5lpSxrAmm+YqRAreRdEUUxEYQU=;
        b=P2E9fjzhnglo7hkI6CbXBoJdcxazXaQAoQOEIEipaKDZC7AZUP+Q3ErTiUU0DDJVIaDKMc
        hjC+SF0V5nfUQH/dUpjeYU2dX5kF8XaKvi0Z6GpAqEG18Q91CjlYteNpE28Tk0BjWDgmwH
        yG55LXwcy0yifutVRd5NNdS4x/ZG17k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-_S6FvGMlO3GKG8vrmWID7g-1; Tue, 09 Feb 2021 23:17:28 -0500
X-MC-Unique: _S6FvGMlO3GKG8vrmWID7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BD30192AB78;
        Wed, 10 Feb 2021 04:17:27 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EC7519C66;
        Wed, 10 Feb 2021 04:17:20 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
To:     Stefano Garzarella <sgarzare@redhat.com>,
        Eli Cohen <elic@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@nvidia.com>, linux-kernel@vger.kernel.org
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210209054302.GA210455@mtl-vdi-166.wap.labs.mlnx>
 <20210209090014.xolf5kxri3xdmacz@steredhat>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <cdd75885-3610-8685-14f3-5467a8ef1501@redhat.com>
Date:   Wed, 10 Feb 2021 12:17:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209090014.xolf5kxri3xdmacz@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/9 下午5:00, Stefano Garzarella wrote:
> On Tue, Feb 09, 2021 at 07:43:02AM +0200, Eli Cohen wrote:
>> On Mon, Feb 08, 2021 at 05:17:41PM +0100, Stefano Garzarella wrote:
>>> It's legal to have 'offset + len' equal to
>>> sizeof(struct virtio_net_config), since 'ndev->config' is a
>>> 'struct virtio_net_config', so we can safely copy its content under
>>> this condition.
>>>
>>> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 
>>> devices")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Acked-by: Eli Cohen <elic@nvidia.com>
>>
>> BTW, same error in vdpa_sim you may want to fix.
>>
>
> Commit 65b709586e22 ("vdpa_sim: add get_config callback in 
> vdpasim_dev_attr") unintentionally solved it.
>
> Since it's a simulator, maybe we can avoid solving it in the stable 
> branches. Or does it matter?


I think not, since the module depends on RUNTIME_TESTING_MENU.

Thanks




>
> Thanks,
> Stefano 

