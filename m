Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2733E8408
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 21:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhHJUAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhHJT76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628625576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5SYx2j9EQ5pdzV1C9IH+mYuJFsFKmzgLPRyNEkIdI+s=;
        b=Xkdkxe5T/awZUJ8HBBunAMgm3la0mgGP0TT666B0+ltbRAahtrDDb05ciuk7ktvmW4YFoU
        5Aiy8mqpWuB0y1/GG86DN9b7BcinDSpBCuf52Cp4P6bnlN27FFxzFrafndPxhYAX+8fSa/
        zWZCvaPYFBYwPZ90nelWilg/pJcHNmw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-Af6caAX3O-OnFDO3CFVqgg-1; Tue, 10 Aug 2021 15:59:34 -0400
X-MC-Unique: Af6caAX3O-OnFDO3CFVqgg-1
Received: by mail-ot1-f72.google.com with SMTP id n4-20020a9d64c40000b02904f40ca6ab63so138216otl.14
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 12:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5SYx2j9EQ5pdzV1C9IH+mYuJFsFKmzgLPRyNEkIdI+s=;
        b=t7UNs6h/FPm4U1/cpvlZNhcmJsVKUKuhEaYi3O4KFdTriG6nQ/x6zGWBrlkHTtwCM0
         Ysyl+PodNrIgNLw/uTx6pE4p2Mf0DsGVwEvd2viY1ZSCR6SYtpHu0b6Vy6XV0Gwikifp
         KzelyuwbCpQxKrheuQdhRBREcIhO9Uv8/uJkrQmcJPomFoGCw4vhvIjkPNXnxIMeb/nq
         2eDb1sayUDRu60Yb05eTZ0cmxZSBnfwyQ4wsQuN/Noj/1O0Z29dkE2aNOCHEPy39eXNO
         lhOeNHNfBZ8kXu08j+J2ITrzDGuFWLBZbZ1J63EwO+57vzoLeGI88tqhY2tDWDZIf7Th
         dGlg==
X-Gm-Message-State: AOAM53382nqJ8jqpWKvQOGTKT6gc5E4yTTgz92WqBXIFLi358oqjg2Dg
        eMUxMfpAkaq0JYF69Env2119tU3WvzTMLLruTjfxdZ39phQ3JANzEMNtLVCSQckstLFa/sL2j2Z
        xyrEF8tiozusQdr4JDNCs8Rwk
X-Received: by 2002:aca:2b07:: with SMTP id i7mr4975586oik.97.1628625574203;
        Tue, 10 Aug 2021 12:59:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK3rE75lK3h+wUTcVv/Hzo5wpFsQe+Kjjbim3d5l0FAevt8Ld9ndoIzQ5mbMXYi918sGGsWQ==
X-Received: by 2002:aca:2b07:: with SMTP id i7mr4975578oik.97.1628625574071;
        Tue, 10 Aug 2021 12:59:34 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id b11sm674139ooi.0.2021.08.10.12.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 12:59:33 -0700 (PDT)
Date:   Tue, 10 Aug 2021 13:59:32 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 3/7] vfio/pci: Use vfio_device_unmap_mapping_range()
Message-ID: <20210810135932.6825833b.alex.williamson@redhat.com>
In-Reply-To: <YRLJ/wdiY/fnGj2d@t490s>
References: <162818167535.1511194.6614962507750594786.stgit@omen>
        <162818325518.1511194.1243290800645603609.stgit@omen>
        <YRLJ/wdiY/fnGj2d@t490s>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 14:48:31 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Thu, Aug 05, 2021 at 11:07:35AM -0600, Alex Williamson wrote:
> > @@ -1690,7 +1554,7 @@ static int vfio_pci_mmap(struct vfio_device *core_vdev, struct vm_area_struct *v
> >  
> >  	vma->vm_private_data = vdev;
> >  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > -	vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
> > +	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);  
> 
> This addition seems to be an accident. :) Thanks,

Nope, Jason noted on a previous version that io_remap_pfn_range() is
essentially:

  remap_pfn_range(vma, addr, pfn, size, pgprot_decrypted(prot));

So since we switched to vmf_insert_pfn() I added this page protection
flag to the vma instead, then it gets removed later when we switch back
to io_remap_pfn_range().  Thanks,

Alex

