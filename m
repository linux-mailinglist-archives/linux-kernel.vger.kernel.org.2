Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487B8458CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhKVLBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:01:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229984AbhKVLBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637578707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=psTM8ISrjkyMgJwD8v5I4omETk3J8QMXgeddK2v/9Oo=;
        b=UlJGpV3w/eVYuHQRYce153GfsXzatRBfIDpgaCm93RNnPvSSjzGYn7La+m16hquE3o7Sc6
        2ZK1wXLhYEMcMCj5tHCCM5dIIVo51fu3Ek1zIGAk6DpVaaVudtXcdeY5gS84w+3y7vqOTi
        xAvSIX/rxgSnhsTPvnrJYYv/RrVuIqE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-PYe01drJNW6rLA5A28xR8Q-1; Mon, 22 Nov 2021 05:58:25 -0500
X-MC-Unique: PYe01drJNW6rLA5A28xR8Q-1
Received: by mail-ed1-f70.google.com with SMTP id w4-20020aa7cb44000000b003e7c0f7cfffso14454081edt.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 02:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=psTM8ISrjkyMgJwD8v5I4omETk3J8QMXgeddK2v/9Oo=;
        b=8C+AZ9J25csqam8vCfamcJOENZ178mQuvr1XkF+6Fcfjqfp04meDBUyx1Axwj+z6in
         toa6z6XWuvm2JyQjZNM8rMH2c8q3pWqQtaqzahdwFZnTM65qgNv0E198Y9gqmE0pzBpc
         T57hennBfOepD9rPxGFjlAVW2cdq+VJoLUkRnzOcy4nYbnNqttchgxy6KlBr0agsaFqI
         FKVF3w9jEqbEu9LPtpO2wL6BudyXh7r9alJ3imMRqYCHviHuxLZcL5HifCODFLAtsooU
         26Q2uVhCkhNKqlBlBsH7lraIdrYVBVNodB8p1B/N/g6IbMU2I24Q8E1fbJYUAMsBEg5r
         sJlw==
X-Gm-Message-State: AOAM530LWWVHvxlGrEvFy4w3wuFoAFrn5HSdvIVb6ms80QbEq+PiIYIZ
        jymwWFLotqTDz+0XjgECXzdlCpu4hloK4qqJk+FlU+JvXALPtEq//1oVw2+Gles5sEtheNRig4Q
        b/yrWgt9/PQRyYtyyypbH/ayJ
X-Received: by 2002:a17:906:bcce:: with SMTP id lw14mr39444157ejb.411.1637578704540;
        Mon, 22 Nov 2021 02:58:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5euxEOhXA4OuQ9nCYhyy7FrC86z4Kyu9dkiD0+vafLsMdUW/fn+csxa5thD15nAAx3gGTww==
X-Received: by 2002:a17:906:bcce:: with SMTP id lw14mr39444132ejb.411.1637578704379;
        Mon, 22 Nov 2021 02:58:24 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id w24sm3527362ejk.0.2021.11.22.02.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 02:58:24 -0800 (PST)
Date:   Mon, 22 Nov 2021 11:58:22 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        f.hetzelt@tu-berlin.de, david.kaplan@amd.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH] vsock/virtio: suppress used length validation
Message-ID: <20211122105822.onarsa4sydzxqynu@steredhat>
References: <20211122093036.285952-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211122093036.285952-1-mst@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 04:32:01AM -0500, Michael S. Tsirkin wrote:
>It turns out that vhost vsock violates the virtio spec
>by supplying the out buffer length in the used length
>(should just be the in length).
>As a result, attempts to validate the used length fail with:
>vmw_vsock_virtio_transport virtio1: tx: used len 44 is larger than in buflen 0
>
>Since vsock driver does not use the length fox tx and
>validates the length before use for rx, it is safe to
>suppress the validation in virtio core for this driver.
>
>Reported-by: Halil Pasic <pasic@linux.ibm.com>
>Fixes: 939779f5152d ("virtio_ring: validate used buffer length")
>Cc: "Jason Wang" <jasowang@redhat.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
> net/vmw_vsock/virtio_transport.c | 1 +
> 1 file changed, 1 insertion(+)

Thanks for this fix

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


I think we should also fix vhost-vsock violation (in stable branches 
too).
@Halil do you plan to send a fix? Otherwise I can do it ;-)

Thanks,
Stefano

