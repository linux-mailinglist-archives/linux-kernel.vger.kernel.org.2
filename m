Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC10F358920
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhDHQAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231791AbhDHQAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617897604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PNTuOs8cwmVPsb+XPqRB51lDxbRlJnUP7klH9+xffsY=;
        b=RlAYxJ85yy7pXQNicDShjHZInxuOLNNuC+3AvKOKP7568raqBUvp24apiKhvWrW1pLmxSU
        89sMu7HliA/dUu/vYaMMd0CjHOqQKW5DNbW3Jtc6xCrGmAYLNdhEr2woRBGqkEgwbvwQhI
        Gnd5mV7aH8EjuDNLKn4fF0Q1/sKPIOc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-Ug8bzuhaMnmOFDQnaFZ4iA-1; Thu, 08 Apr 2021 12:00:01 -0400
X-MC-Unique: Ug8bzuhaMnmOFDQnaFZ4iA-1
Received: by mail-wr1-f70.google.com with SMTP id s10so1187801wre.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 09:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PNTuOs8cwmVPsb+XPqRB51lDxbRlJnUP7klH9+xffsY=;
        b=IoV1Yu7lSjVMvUrUcj/2pu+GuVya1ehzdH7q0PY9a3nzehmZHY9s1WafZTrypA2wjE
         B7OsGHzT0SdgvKpUh4uvCDq10VX1+co0Ux8EIhLmYiy7bTbcx1L8ZjcwaNWcpuzL+as2
         We/L8Z+EuL3BmuNPwP75oKeO2r4zC/r0aN3J4AM5RdQnYrFyZ3M8YkQMM5gLJzGWhbeN
         jF/ZJj/zTXyqArOYutPsc0ZsrW7cOFZLasdq/lzWgDJr+FQoU8V9MbRSC4nZusUKOJnB
         IXat3cP7bVpYFxGQ4Hsromdiu8AO9rtuKmtovM1BIgBU/nXcj4sSh9JQBwGAt1jA/dlM
         6ESw==
X-Gm-Message-State: AOAM533A5G1fu3Br+AQV6w02GtQccLSloo9XQXHOvJ6MoHnPx255iYZl
        ITI+vv1rDYmPc0vnPb6m8bmuR706wXmpTi/v90X/1PlzQSL/bkArfW4/EQaH58Jid+EbKCPraPo
        rm1kcauHACnUv/jw/srfiSLoh
X-Received: by 2002:a05:600c:2e53:: with SMTP id q19mr9436932wmf.187.1617897599787;
        Thu, 08 Apr 2021 08:59:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqoM3onIvGeRXWXv4QE785/eHcNM4dldKx3uveQOhko4iWcZKhOBw/s+pXUoh6UaqBx9fHKw==
X-Received: by 2002:a05:600c:2e53:: with SMTP id q19mr9436917wmf.187.1617897599571;
        Thu, 08 Apr 2021 08:59:59 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
        by smtp.gmail.com with ESMTPSA id j14sm47053447wrw.69.2021.04.08.08.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:59:59 -0700 (PDT)
Date:   Thu, 8 Apr 2021 11:59:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, parav@nvidia.com, elic@nvidia.com
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
Message-ID: <20210408115834-mutt-send-email-mst@kernel.org>
References: <20210408082648.20145-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408082648.20145-1-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 04:26:48PM +0800, Jason Wang wrote:
> This patch mandates 1.0 for vDPA devices. The goal is to have the
> semantic of normative statement in the virtio spec and eliminate the
> burden of transitional device for both vDPA bus and vDPA parent.
> 
> uAPI seems fine since all the vDPA parent mandates
> VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.
> 
> For legacy guests, it can still work since Qemu will mediate when
> necessary (e.g doing the endian conversion).
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Hmm. If we do this, don't we still have a problem with
legacy drivers which don't ack 1.0?
Note 1.0 affects ring endianness which is not mediated in QEMU
so QEMU can't pretend to device guest is 1.0.





> ---
>  include/linux/vdpa.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 0fefeb976877..cfde4ec999b4 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -6,6 +6,7 @@
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
>  #include <linux/vhost_iotlb.h>
> +#include <uapi/linux/virtio_config.h>
>  
>  /**
>   * vDPA callback definition.
> @@ -317,6 +318,11 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
>  {
>          const struct vdpa_config_ops *ops = vdev->config;
>  
> +        /* Mandating 1.0 to have semantics of normative statements in
> +         * the spec. */
> +        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> +		return -EINVAL;
> +
>  	vdev->features_valid = true;
>          return ops->set_features(vdev, features);
>  }
> -- 
> 2.25.1

