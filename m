Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B4E3E8352
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhHJS4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231465AbhHJS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628621771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aeyIMXFzQ8OzGR9pMLrY5l1FOe7kguJjNVeE5rzOXJQ=;
        b=ElPVFFOpMvXAdrm5TMy3YVz78Zp+k3cWBfz3+9kyL7jFvewCe7NcNp3sNNJb2vUeSxyIia
        O2/7YWq44q/ST+YvWFwQISnXbm480vQmskibnihUrgECXu7+CdjqU84JmjgNmIr8NDfdqp
        TCHJ9npb7uHQY4EhnTNYtNLDuChuQjA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-I99Z-FobN3SimwHg9TLs2A-1; Tue, 10 Aug 2021 14:56:09 -0400
X-MC-Unique: I99Z-FobN3SimwHg9TLs2A-1
Received: by mail-qv1-f69.google.com with SMTP id bo13-20020a05621414adb029035561c68664so5942629qvb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aeyIMXFzQ8OzGR9pMLrY5l1FOe7kguJjNVeE5rzOXJQ=;
        b=pZdoqdP5gcWY/p05+rbj+OA1kj1gVJ9b4Z8rTm0vwlXWfb0CXaJLwiC1H12MUNQ4de
         mkT9GiBtrMZvMLAVk3DWYM3ggopUQb+zGcT1T2H6A3gPQHnbdVwaGwp7I0Qfh86UViAU
         Qb3r9pDvi6ePNirh+a/nNRRjnILIOfAU3GoBW3AqYrymovFtZ506NoY1zRhybl10OpAd
         BD+jmJda/H8ckQ0urdwRnKgBsFVsLgLQP+kDcoJaxCTO2Rlm21GAAIMRVig7rnibAWTQ
         tk65J+K3483QWQEeKtdQSaRRUUW9R8fxAtTK9TMoVU+58+TIBrhRxcAybPpwkuGlkTTd
         4WsQ==
X-Gm-Message-State: AOAM5305xh4YSzf6CuXp72sQZujwpFrTAQJU//AO6X/eRDKEIl4Ee4GH
        N9OrrFWgiNlELEeripnjri8ghPCzqCdQQUpUMOjE0xy5X9A0Lpd5rwFDktMI5rIqtYABxfSwOIh
        8FcSPFGYh0CY6PFBEBc2LCZ6N
X-Received: by 2002:ad4:4801:: with SMTP id g1mr19233071qvy.34.1628621769275;
        Tue, 10 Aug 2021 11:56:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY/8eH8qraAlg3QzXb5kdVEZIVe5XqgOyT/w9ICdKgY1ZKVgnUtZNKNx1/TkE7BD326QwTlw==
X-Received: by 2002:ad4:4801:: with SMTP id g1mr19233063qvy.34.1628621769108;
        Tue, 10 Aug 2021 11:56:09 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id x125sm11300960qkd.8.2021.08.10.11.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 11:56:08 -0700 (PDT)
Date:   Tue, 10 Aug 2021 14:56:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, jgg@nvidia.com
Subject: Re: [PATCH 2/7] vfio: Export unmap_mapping_range() wrapper
Message-ID: <YRLLx5O6gleDqsMR@t490s>
References: <162818167535.1511194.6614962507750594786.stgit@omen>
 <162818324222.1511194.15934590640437021149.stgit@omen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162818324222.1511194.15934590640437021149.stgit@omen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 11:07:22AM -0600, Alex Williamson wrote:
> +void vfio_device_unmap_mapping_range(struct vfio_device *device,
> +				     loff_t start, loff_t len)
> +{
> +	unmap_mapping_range(device->inode->i_mapping, start, len, true);

(not a big deal, but still raise this up)

It seems to me VFIO MMIO regions do not allow private maps, so even_cow==true
should be the same with even_cow==false. even_cow==true will just check the
page mapping for each pte even though they should just all match, imho, so
logically "false" should work the same and should be tiny-little faster.

Thanks,

> +}
> +EXPORT_SYMBOL_GPL(vfio_device_unmap_mapping_range);

-- 
Peter Xu

