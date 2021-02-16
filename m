Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF431D312
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 00:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhBPXpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 18:45:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhBPXpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 18:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613519022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CSP5TYqu650KhYGvjztOmE5csI9NW0yzVVbY0leWkZI=;
        b=DrTSy3kafGd7ffVdU1taQe9jO/Spb5kDV2AlsM+bxFAqYGh2CjQMnxHuDAN+6wXsiytC7H
        JF01K23QH2Z5hUnffvO+08R6AuaSac29/T9TwLgrw4AO6PNuKnilghn1eTZtfDfAeivwX3
        wMVnmM7AqSefGozLK9//KGA5b//8LCg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-KH1cdqC8PtC2Gs6aghlgkQ-1; Tue, 16 Feb 2021 18:43:40 -0500
X-MC-Unique: KH1cdqC8PtC2Gs6aghlgkQ-1
Received: by mail-qt1-f200.google.com with SMTP id z3so2937999qtv.20
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 15:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CSP5TYqu650KhYGvjztOmE5csI9NW0yzVVbY0leWkZI=;
        b=pjr+u1tYyzxFuWtZruk/XyLzR+cDB2fadk8bwMYy7zhsNdJDDcYlZ1hCaKZbzC2n+r
         A8TynUKaKulq8cyc8VFPYRcD4sbTlnkE86orkmSO6Sdh7TWb1vnbh1bUpwgZZGlEdd8C
         xt7T1JKhM+urB/ud3ZvpB9TncRrRI3OQ1mp5bqNXXD9anL4C36yIFGo4hP1Vb/6sPmgp
         lyd+JlxHZMMvWFKG0GLrCUtJJECIzk6dk2/3S5PneHiDZ/shlnyOBbDihQJAnraHOQp3
         WY3Hb7TAe1ZipQ4YdkRt43KG3K/y2QcOv3ssWkiAP4KZToVK96d1LUjFTCAw0/08T48Z
         ZcXw==
X-Gm-Message-State: AOAM53028m7O9QJlqkI8Ni0BaK1y6Dub/v1LQu1NjrtmwH6PSonFqPeq
        ww/apkKtMUQE+ibt3OXvz7MraNKGP59R2NIrfHx0wUF+pnI5t19hDO9rWXKzvFU5xwo/Kv8uBez
        FbOiNbDtFPt9xeb5bLlQMA49o
X-Received: by 2002:a05:620a:cd6:: with SMTP id b22mr21492229qkj.451.1613519020094;
        Tue, 16 Feb 2021 15:43:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoewrF38Q6wgd1ErfBYD6lARPXXVDP/Bm9c/cbXWNMU4YW9mO/tBw/lLitRcK/s+IpTQcsSQ==
X-Received: by 2002:a05:620a:cd6:: with SMTP id b22mr21492214qkj.451.1613519019928;
        Tue, 16 Feb 2021 15:43:39 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id d17sm418815qkc.40.2021.02.16.15.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 15:43:39 -0800 (PST)
Date:   Tue, 16 Feb 2021 18:43:37 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     cohuck@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com, jgg@nvidia.com
Subject: Re: [PATCH v2] vfio/type1: Use follow_pte()
Message-ID: <20210216234337.GE91264@xz-x1>
References: <161351571186.15573.5602248562129684350.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <161351571186.15573.5602248562129684350.stgit@gimli.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 03:49:34PM -0700, Alex Williamson wrote:
> follow_pfn() doesn't make sure that we're using the correct page
> protections, get the pte with follow_pte() so that we can test
> protections and get the pfn from the pte.
> 
> Fixes: 5cbf3264bc71 ("vfio/type1: Fix VA->PA translation for PFNMAP VMAs in vaddr_get_pfn()")
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

