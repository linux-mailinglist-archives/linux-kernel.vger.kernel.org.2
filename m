Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B913B464B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhFYPHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 11:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24355 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231772AbhFYPHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 11:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624633490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U784+kGQqcCr9NWBnyFTpTP/sKm8NiDEcS8cZIq6yn8=;
        b=S6dIAlSheseIQRfdczSNkQrehkhub4a+OfE1IM3dlZkPOtZTVmZsFe5KoLEy9zNXvnOKIn
        4qdOwl1o/fPGfFHNhAV43KTJbqwTAABszqLyYyHyo/G2RY6npqVAIuSHuFplesNztmtTiW
        jC1g7tVY6WhD+fWW8qHX25AD6Mjx/k0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-qVUQnLogMg2AL1XsjP9MiA-1; Fri, 25 Jun 2021 11:04:49 -0400
X-MC-Unique: qVUQnLogMg2AL1XsjP9MiA-1
Received: by mail-io1-f70.google.com with SMTP id q7-20020a5d87c70000b02904eff8ce1ea0so2711660ios.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 08:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=U784+kGQqcCr9NWBnyFTpTP/sKm8NiDEcS8cZIq6yn8=;
        b=BW0zEhc9HUXIzT+5UVpLj76p3+lkVpKa48dZyCsz4nQ9N4YbpPgfV/T1hAxVkv6OUB
         ZDhuXqg0Iw+FMJ/bdAUYtzEch4JJrkzmClrOOSeB6nAUGSxxl79HXGoo6VSvraqqC2xi
         G5nqG2VHlGdsGk/1gy4h/K0+8+EQE1QO3pQA+D5g9IGBBU5TvLBvxSWGcRgY7jTD9TCv
         nUcghoXNzoc3cRn3vxEv7AwguqWgTuH/BnOjGFltuMuu3vOnK8W6Uq8YGp+bkWJoPyxx
         h7x4vNqLFV46N74wH19fYHoB0mTHIZEUV2F0VtPlNWEo6bCresaMJVf2XYAaNsl3nSX0
         0XqA==
X-Gm-Message-State: AOAM530gncH5J41LtWsQfmavz0/MxMEkQDKhQPKQ8gqQtX9f+3udr+Jc
        Te3rOxp3h6IHF1M2IKez1XIPgORuzrRUlTAkJ7M/hKwlr7g9qfvB+eKxmq9knWWmsEI46K7L9lc
        l1Bfce6r48VGaroK8SN9CsaTn
X-Received: by 2002:a05:6638:22b8:: with SMTP id z24mr9807421jas.45.1624633488178;
        Fri, 25 Jun 2021 08:04:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzHo3Pd4rMQyb88LBoWup/eibouQovuOWOs36nrmVeMMSDgJerkFrYbrEbXTS/xEUTpliAzg==
X-Received: by 2002:a05:6638:22b8:: with SMTP id z24mr9807409jas.45.1624633488077;
        Fri, 25 Jun 2021 08:04:48 -0700 (PDT)
Received: from redhat.com (c-73-14-100-188.hsd1.co.comcast.net. [73.14.100.188])
        by smtp.gmail.com with ESMTPSA id m184sm3393220ioa.17.2021.06.25.08.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 08:04:47 -0700 (PDT)
Date:   Fri, 25 Jun 2021 09:04:46 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] vfio/mdpy: Fix memory leak of object
 mdev_state->vconfig
Message-ID: <20210625090446.46da71e7.alex.williamson@redhat.com>
In-Reply-To: <20210622183710.28954-1-colin.king@canonical.com>
References: <20210622183710.28954-1-colin.king@canonical.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 19:37:10 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where the call to vfio_register_group_dev fails the error
> return path kfree's mdev_state but not mdev_state->vconfig. Fix this
> by kfree'ing mdev_state->vconfig before returning.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: 437e41368c01 ("vfio/mdpy: Convert to use vfio_register_group_dev()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  samples/vfio-mdev/mdpy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/samples/vfio-mdev/mdpy.c b/samples/vfio-mdev/mdpy.c
> index 7e9c9df0f05b..393c9df6f6a0 100644
> --- a/samples/vfio-mdev/mdpy.c
> +++ b/samples/vfio-mdev/mdpy.c
> @@ -261,6 +261,7 @@ static int mdpy_probe(struct mdev_device *mdev)
>  
>  	ret = vfio_register_group_dev(&mdev_state->vdev);
>  	if (ret) {
> +		kfree(mdev_state->vconfig);
>  		kfree(mdev_state);
>  		return ret;
>  	}

Applied to vfio next branch for v5.14, thanks!

Alex

