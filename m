Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2963394A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhCLRZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhCLRYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:24:47 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439B5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=A8DHxd3B4mLJMJjOm4DHg+SNyU281tj9AwvdPHJlO0k=; b=Ma0qzAO+wMIAeWzeWO5YvDOCeq
        x6m7hjIeDG/NUhpC4M0OmTTuVQkdGfQmqJsABrIVOgoTHflcZvdGmPE+I22xlI0y0MiS6tBYk4Ty+
        fArVbl0ZhQaT0nOSz2AjwQdcAiHYS/BOx7CGxkyaUjCt9b0XdWC870hv7BOJKKPVYua38N+mN/Ov2
        9hbn59aEpv5wWTImvZBKG3frLEqKAk2EVsJTd03eHNVM5CM/TdlGcfUhdyh0KqDN6JDV9qYoeJpD0
        b+rNaKuQxYm9vcmAieABdZUp6ueJxGeR4z94ZcCO5btztqkob4ulRTtu+5A/uVVfGJQFEHcKEA6/y
        K3yFwEFg==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKlWm-0014ZL-BR; Fri, 12 Mar 2021 17:24:44 +0000
Subject: Re: [PATCH] vdpa: fix build dependency of VIRTIO_PCI_LIB
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20210312093633.3948-1-jasowang@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <87031e3b-a1b4-023b-6f8d-cf3d5797b922@infradead.org>
Date:   Fri, 12 Mar 2021 09:24:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210312093633.3948-1-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 1:36 AM, Jason Wang wrote:
> The modern PCI device module should be built independently without
> VIRTIO. This patch fixes this.
> 
> Fixes: 7075992ba8873（“vdpa: introduce virtio pci driver")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


Thanks.

> ---
>  drivers/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index fd11b9ac4cc3..911ee117def4 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_DMADEVICES)	+= dma/
>  obj-y				+= soc/
>  
>  obj-$(CONFIG_VIRTIO)		+= virtio/
> +obj-$(CONFIG_VIRTIO_PCI_LIB)	+= virtio/
>  obj-$(CONFIG_VDPA)		+= vdpa/
>  obj-$(CONFIG_XEN)		+= xen/
>  
> 


-- 
~Randy

