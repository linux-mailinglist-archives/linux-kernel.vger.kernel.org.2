Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C8D343720
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 04:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCVDHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230015AbhCVDGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616382412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGSGyikb+edIn7bTwEsdqdkd00y7AOsinPPrODeBW6o=;
        b=AHkrUGrhGJTBka3e7Y4OcLCPwcSSdlYbnEnhlrg7tV8vcOPstp1MsPfmH+yRuCeIcFs31A
        k8IQcL82hfFNwD9x8P6LslGFkYo0pK1e59ahkkYYkR6AaBWNw1QA7XfKVnyEp1K0Nea0C+
        6orqgts0yOwtb0GNX/nHBIh9FAMuRc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-ZmxVymkNMxi4D3AF6oeFog-1; Sun, 21 Mar 2021 23:06:48 -0400
X-MC-Unique: ZmxVymkNMxi4D3AF6oeFog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0BF5107ACCA;
        Mon, 22 Mar 2021 03:06:46 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-188.pek2.redhat.com [10.72.13.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D441E1001B2C;
        Mon, 22 Mar 2021 03:06:41 +0000 (UTC)
Subject: Re: vDPA: explain in Kconfig what vDPA is, capitalise it consistenly
To:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20210321163421.GA27314@amd>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <2739f8ce-70d2-337d-d952-fd8b6b26f8d8@redhat.com>
Date:   Mon, 22 Mar 2021 11:06:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210321163421.GA27314@amd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/3/22 上午12:34, Pavel Machek 写道:
> Not everyone knows what vDPA stands for, explain it in Kconfig.
>
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index ffd1e098bfd2..8cb37b3dd279 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -3,9 +3,9 @@ menuconfig VDPA
>   	tristate "vDPA drivers"
>   	depends on NET
>   	help
> -	  Enable this module to support vDPA device that uses a
> -	  datapath which complies with virtio specifications with
> -	  vendor specific control path.
> +	  Enable this module to support Virtual Data Path Acceleration


My understading is that "v" is short for "virtio" here.

Thanks


> +	  (vDPA) device that uses a datapath which complies with
> +	  virtio specifications with vendor specific control path.
>   
>   if VDPA
>   
> @@ -38,8 +38,8 @@ config MLX5_VDPA
>   	bool
>   	select VHOST_IOTLB
>   	help
> -	  Support library for Mellanox VDPA drivers. Provides code that is
> -	  common for all types of VDPA drivers. The following drivers are planned:
> +	  Support library for Mellanox vDPA drivers. Provides code that is
> +	  common for all types of vDPA drivers. The following drivers are planned:
>   	  net, block.
>   
>   config MLX5_VDPA_NET
> @@ -47,7 +47,7 @@ config MLX5_VDPA_NET
>   	select MLX5_VDPA
>   	depends on MLX5_CORE
>   	help
> -	  VDPA network driver for ConnectX6 and newer. Provides offloading
> +	  vDPA network driver for ConnectX6 and newer. Provides offloading
>   	  of virtio net datapath such that descriptors put on the ring will
>   	  be executed by the hardware. It also supports a variety of stateless
>   	  offloads depending on the actual device used and firmware version.
>

