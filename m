Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1883E833B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhHJStA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231414AbhHJStA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628621317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uGh9fA/6SL05Y4+mEAteYPx6YCipxcI5JZ/cNQGYfos=;
        b=FTSluNRFRa922gvXfScfHh6EV08e/2Z40BgXZHBmbibHEqmG/lD+yna/NGxb1R289AMpD+
        PZTX95nP7UbZ4RhtpCpeZKpBEA1azfHlSt+DOqkQgydhxrB3huufsamdr+85wgbZNUiC/i
        gtV+wvYsCZWK5/M3XRCTd7rBKYYspVo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-GFUerK91PNeTkHexBg-QnQ-1; Tue, 10 Aug 2021 14:48:34 -0400
X-MC-Unique: GFUerK91PNeTkHexBg-QnQ-1
Received: by mail-qk1-f199.google.com with SMTP id p14-20020a05620a22eeb02903b94aaa0909so5365481qki.15
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uGh9fA/6SL05Y4+mEAteYPx6YCipxcI5JZ/cNQGYfos=;
        b=BJ5VU+YGxTjk8jDh2v/ExhpbkIVwss/DNl0sh7cBgpYa5gz1+eS8QA1a1YLmnMLHs3
         784x2+nApgGlC++vp0A/cd7lxBbvdTIeexsiQ1K2NNpypW3AavBIBwA74N+N9nheepH6
         kSIm6KPmLaVoV3CPSWw6Bwc4L1D5zgHgYnkG5IgiUbScHbXUQgDw9IvQ6s26vxSAK9dQ
         KPNnsoJ7rE10PYGvdjIwyVQeHdDiCB6nsNCTcopYq//9XrAHwWSAsvZJiLNwWdTTLWBv
         2XTEYgSpnlC0YGGhwa8VjTY/Hs4Irch6FHOIs3XBIi5SYpTPfGejwOmXXipmRYoiSohm
         +BoQ==
X-Gm-Message-State: AOAM530Z14D2z8CZDIBFs54LNqeYIlZ52/o+f3nD9IhyFyH/k0aK+1RL
        bO5rqmckxppeqnrUXsl4b1SnGA6kEAOccd0vk+m/rvHg82niurpxOImsxVb2rAghnVodrBn4cOx
        MJkExzkVzPjLOoETbz1UqwmvV
X-Received: by 2002:a05:620a:2101:: with SMTP id l1mr14790458qkl.104.1628621313805;
        Tue, 10 Aug 2021 11:48:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIyq0bJKC/A97FVUFNlJ4uivR7xL4lKUeKBCJnJ5l4dPxGWD2CLEAIiMGQtQn39x+UaF2hrA==
X-Received: by 2002:a05:620a:2101:: with SMTP id l1mr14790443qkl.104.1628621313591;
        Tue, 10 Aug 2021 11:48:33 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id a24sm8898750qtj.43.2021.08.10.11.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 11:48:32 -0700 (PDT)
Date:   Tue, 10 Aug 2021 14:48:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 3/7] vfio/pci: Use vfio_device_unmap_mapping_range()
Message-ID: <YRLJ/wdiY/fnGj2d@t490s>
References: <162818167535.1511194.6614962507750594786.stgit@omen>
 <162818325518.1511194.1243290800645603609.stgit@omen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162818325518.1511194.1243290800645603609.stgit@omen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 11:07:35AM -0600, Alex Williamson wrote:
> @@ -1690,7 +1554,7 @@ static int vfio_pci_mmap(struct vfio_device *core_vdev, struct vm_area_struct *v
>  
>  	vma->vm_private_data = vdev;
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
> +	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);

This addition seems to be an accident. :) Thanks,

-- 
Peter Xu

