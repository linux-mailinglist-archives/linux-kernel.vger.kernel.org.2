Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A5D333093
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhCIVAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:00:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232163AbhCIVAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 16:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615323641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zEDHqyfPxaSCwDrLc/eNhwpsIDH/uLpGH/glGZEDrKg=;
        b=Gihbkwc8EXAjFHSwqUMKgBV/Ptp8PfxecbGJXmFgVCUhMVM4DNk1VoLfIdc/PVLs3FoOvG
        BBsjgV51Z1zXjDiNs2zCDtRCitK5LUm8qrv1/X5zrxvhgF/Aoy7kHg7i/VdzKD05ss1zr2
        qPuwMDDAGYOGfyPJNa0PkTyJ1LimzWY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-zUJRmtW8N_6TlqEV1dITEA-1; Tue, 09 Mar 2021 16:00:39 -0500
X-MC-Unique: zUJRmtW8N_6TlqEV1dITEA-1
Received: by mail-qt1-f198.google.com with SMTP id r32so4224025qtd.16
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 13:00:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zEDHqyfPxaSCwDrLc/eNhwpsIDH/uLpGH/glGZEDrKg=;
        b=ZEPO3T/iPPJHdoDpTAfs3VVcVvscMcYJpWTJ8zaP4t62T0E8ChXa1ulPbzgddVDtf3
         /V8CNBWdcv+PfdnE8rcIK1UNCuTTCGK6a8ddeBugi38meixZL01QEIlDIS8kEBlPRHo/
         YkxGv8NOyIm6KU2Yw805fn7ZzyJGSEQzNQhTDxFRBvgb8na6ilIozkWcGU0Ri9+xaynw
         FDk9hnYE4qhOQ7RMWSjNOQ8Z1aGk3F/tQz0TA2dQxTXrE96PGm8NsU/OpZvuKdyPHj+m
         wadHRebFLzgfLN7QWPoRgHCnztv7Emj9rxlICkIcB8+1+seCOBBPPPJ4HFfjwDGYWdOY
         l7Cw==
X-Gm-Message-State: AOAM533BgC+IRISEp4xlZxd5j9i6aYIocMQZ2lv0O8csCsAgWm2qOhfR
        uq/Oj/s3SaTDpQXFUj4NGdtUQKe72LJleKK/HNTCcgULDeV5Q5VSS/vMxdmunG1OhnSNzwtIuu+
        NXBMZgiE3CjDYB5+qSQwxv1Rk
X-Received: by 2002:ac8:5396:: with SMTP id x22mr327281qtp.200.1615323638944;
        Tue, 09 Mar 2021 13:00:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4iZuTfjkzO/vROK1UQhdfU5F5cKYWdO/WWEA5sckQat4k25SSvvPY0Vt9/xnXl4k8ABQENA==
X-Received: by 2002:ac8:5396:: with SMTP id x22mr327264qtp.200.1615323638762;
        Tue, 09 Mar 2021 13:00:38 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id 73sm11241489qkk.131.2021.03.09.13.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:00:38 -0800 (PST)
Date:   Tue, 9 Mar 2021 16:00:36 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Michel Lespinasse <walken@google.com>,
        Jann Horn <jannh@google.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] vfio/pci: make the vfio_pci_mmap_fault reentrant
Message-ID: <20210309210036.GJ763132@xz-x1>
References: <20210308132106.49da42e2@omen.home.shazbot.org>
 <20210308225626.GN397383@xz-x1>
 <6b98461600f74f2385b9096203fa3611@hisilicon.com>
 <20210309124609.GG2356281@nvidia.com>
 <20210309082951.75f0eb01@x1.home.shazbot.org>
 <20210309164004.GJ2356281@nvidia.com>
 <20210309184739.GD763132@xz-x1>
 <20210309122607.0b68fb9b@omen.home.shazbot.org>
 <20210309194824.GE763132@xz-x1>
 <20210309131104.1094b798@omen.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309131104.1094b798@omen.home.shazbot.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 01:11:04PM -0700, Alex Williamson wrote:
> > It's just that the initial MMIO access delay would be spread to the 1st access
> > of each mmio page access rather than using the previous pre-fault scheme.  I
> > think an userspace cares the delay enough should pre-fault all pages anyway,
> > but just raise this up.  Otherwise looks sane.
> 
> Yep, this is a concern.  Is it safe to have loops concurrently and fully
> populating the same vma with vmf_insert_pfn()?

AFAIU it's safe, and probably the (so far) best way for an userspace to quickly
populate a huge chunk of mmap()ed region for either MMIO or RAM.  Indeed from
that pov vmf_insert_pfn() seems to be even more efficient on prefaulting since
it can be threaded.

Thanks,

-- 
Peter Xu

