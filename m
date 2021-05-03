Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94909371264
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhECIVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhECIU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620030006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1iQg39S7/yQcUAfdd2josWY92R4FYw1/luzJ6UFBUE=;
        b=ibHbSmRaAq+XPv1liziHCEBf+UJmrN7Q7577y7usOQ+0xzvWxUODGIkguVuF87cgwQnRWU
        S73SAyFYQJzXm+Hh8f0+pslDOmHtq7WGtHJQPOCMEBSCfd/5KuaBY7sd+kS7a2OiO4cdOU
        zCpemh7i46lvi9F0ihzbfvqiwc2Pm7Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-9C13PJZ1Px-GGVjYSt4Big-1; Mon, 03 May 2021 04:20:04 -0400
X-MC-Unique: 9C13PJZ1Px-GGVjYSt4Big-1
Received: by mail-wr1-f71.google.com with SMTP id t18-20020adfdc120000b02900ffe4432d8bso3490917wri.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 01:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y1iQg39S7/yQcUAfdd2josWY92R4FYw1/luzJ6UFBUE=;
        b=qzOMLH0MJW/UT56f3EiKIm0hq26a550EiWLnIw68QRZFXlEs6Gpe3bjPr1pf1W5TyN
         VMdtJNZfghdZgm1y4j/1Trc+Vu8rD2IGYhfPsMNf32cNr7SuDVFe17I8dIY7ovtwYlm4
         eCRTzQw/XQlSipZz4+uMthyMLdEMKgzj5DCxwlxkxQZeWK33C7g9TSMOEMjOhypzL1a1
         LvxsmsLTLu0GwL/OadlvNgKcnXZ2WDueKg4KdLKCjSSWCvjXyRXHPHBLEdiCzSU1B3/K
         crTWGIZAaD8M/KpxZWhGWd3fOM3KTWyI4ow04xpPBGRghPEVf54tE9z80qb8R+tagbCb
         o1hg==
X-Gm-Message-State: AOAM532PmFnvQ2BTr97dJhKzUAcRZ7D07aWze+32Bl0h1w0yE8HhrEMR
        58ZAHxGB/znIhAVxsjKSTnW0xStHE6lAe/+4ia4wqhyzCH3KaVhwY13ZiESdh5Jhc5jTREOh/fq
        an1ghYHG0/saRIA+B+GOlwalC
X-Received: by 2002:a05:600c:249:: with SMTP id 9mr20341799wmj.175.1620030003796;
        Mon, 03 May 2021 01:20:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqXbKqLMVYj7jCfahNg53ORbH8cpXtpuR0Wp8+7ALOqrnsRfqpqjRjjxsQkluF9/EwSQpkcg==
X-Received: by 2002:a05:600c:249:: with SMTP id 9mr20341784wmj.175.1620030003623;
        Mon, 03 May 2021 01:20:03 -0700 (PDT)
Received: from redhat.com (bzq-79-178-133-9.red.bezeqint.net. [79.178.133.9])
        by smtp.gmail.com with ESMTPSA id b7sm3449828wri.83.2021.05.03.01.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 01:20:03 -0700 (PDT)
Date:   Mon, 3 May 2021 04:20:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] sound: virtio: correct the function name in kernel-doc
 comment
Message-ID: <20210503041943-mutt-send-email-mst@kernel.org>
References: <20210415052645.14465-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415052645.14465-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:26:45PM -0700, Randy Dunlap wrote:
> Fix kernel-doc warning that the wrong function name is used in a
> kernel-doc comment:
> 
> ../sound/virtio/virtio_ctl_msg.c:70: warning: expecting prototype for virtsnd_ctl_msg_request(). Prototype was for virtsnd_ctl_msg_response() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: alsa-devel@alsa-project.org

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Pls feel free to apply to the correct tree.

> ---
>  sound/virtio/virtio_ctl_msg.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210414.orig/sound/virtio/virtio_ctl_msg.c
> +++ linux-next-20210414/sound/virtio/virtio_ctl_msg.c
> @@ -61,7 +61,7 @@ void *virtsnd_ctl_msg_request(struct vir
>  }
>  
>  /**
> - * virtsnd_ctl_msg_request() - Get a pointer to the response header.
> + * virtsnd_ctl_msg_response() - Get a pointer to the response header.
>   * @msg: Control message.
>   *
>   * Context: Any context.

