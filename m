Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539263F5CED
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbhHXLNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236462AbhHXLNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629803536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sp6r3OzWSMu57KiEYb4z4Sr1QBf9aXwrMsxdCi+UL3c=;
        b=LnaeJtdnvz+wt9mV7wf6yrYySFJSe+PR7Kxt0NeeHv1rz71UVGb+kQQszA1jNvyKvgFnUS
        gNkR2qacvPoA33fDQFBMueHDjoBn4/Z5+5qA0c3yKMHNqi0sICGdhTgaYtVOmOzEi8E9P+
        02Km4iX82Y25gwrtbMTf3DHTAJWFh6Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-0JI5Cvu2NHWTx9-_X4asrw-1; Tue, 24 Aug 2021 07:12:15 -0400
X-MC-Unique: 0JI5Cvu2NHWTx9-_X4asrw-1
Received: by mail-ej1-f69.google.com with SMTP id gg1-20020a170906e281b029053d0856c4cdso6884213ejb.15
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 04:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sp6r3OzWSMu57KiEYb4z4Sr1QBf9aXwrMsxdCi+UL3c=;
        b=T7Xx1cDsKRemssFyIz7zMvXdz5ejnstPcEpLYJ7B5UzKZyt1muJbbiXNG7FQasFght
         zMweKMGMW5aTe01lKKh4OFEgE6TERcdr1e5v6OJaKeHY5MjKINIIJIlgiqWTx7xrcKhE
         44SDjgF9Qbh3KLhNAOOhv/RZFNN6pSpV/5Bqq7hR9kEYFeibOsgcA6tL1GWoUsSlzJ8M
         DEFqH2nevPomGMMdE7ijuz6pb++0KIWP7B34jyHpUP8H8WYTVojwZGPrso65MRJzwgrr
         YWZaM/FGt7df8H7bOBmXgAg3UBXRmhfLzLPfWxVKqg1dXutDRMF4rm3SioIRNWdLeE11
         ajEw==
X-Gm-Message-State: AOAM5303aLXVKjWaLwxGcryDQLvbFZnQPvl+g0iDArTL014SeMA+pWAE
        XafsTci+PfXUSRNwIKfZv8jRXx6Aef7KiWbZz4TysvO00IjFqQ2rzT3HhhZ4u2tf1tkg0CgGI5A
        M0gEjIfXElXLepuoSEUKk+Y/t
X-Received: by 2002:a17:906:1701:: with SMTP id c1mr40193376eje.425.1629803534056;
        Tue, 24 Aug 2021 04:12:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDklZBFBy5QnXrgs3+cqOF2EU5CCgdvdd15GqRk67R8P3Nj6qlQx0g2cCYgrph1uoICqAc7Q==
X-Received: by 2002:a17:906:1701:: with SMTP id c1mr40193358eje.425.1629803533933;
        Tue, 24 Aug 2021 04:12:13 -0700 (PDT)
Received: from steredhat (host-79-45-8-152.retail.telecomitalia.it. [79.45.8.152])
        by smtp.gmail.com with ESMTPSA id h21sm331619ejb.101.2021.08.24.04.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:12:13 -0700 (PDT)
Date:   Tue, 24 Aug 2021 13:12:07 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com, robin.murphy@arm.com,
        songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 05/12] vhost-vdpa: Handle the failure of vdpa_reset()
Message-ID: <20210824111207.ppvop52hyq5xyny5@steredhat>
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-6-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210818120642.165-6-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 08:06:35PM +0800, Xie Yongji wrote:
>The vdpa_reset() may fail now. This adds check to its return
>value and fail the vhost_vdpa_open().
>
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> drivers/vhost/vdpa.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

