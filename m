Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839EF3D5529
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhGZHec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhGZHec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:34:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C783C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:15:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id go31so1397622ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lYPdbRk9NzuoNJUglE6NuLhP3wUwwX0fk3ZFMcXvP/U=;
        b=EAfH77y0T9DVi60ddgTxfiNjVbCkRZDnGy7sUciUJR8aVdP1qOrB2yFz9zft4tSwyK
         h3o1PyOTWU7bnLEIm1BK5Y3c3iso8WYqSImsfo07C6TTdXS9E254YhrUPkSFM0EaMFF3
         F9gXUmffTab0iU9CLaHRX9SpepJQvunKcStC67hdbv1lIybQdZ2TKpcKpRCvw+TMOX4W
         cngneCV5GAgn9g7Ccn6FVxd3mfaEzXzL5OypdyFn/uuHo31xdAA2oP4+m5iwLiaNlZS+
         xZXyemQM1pI0rJelm4HCJ+DaZ6gKAs4OsXMBaXNPcKh6U2FvN6B7JYPgUdLd2sRqMd+z
         k1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lYPdbRk9NzuoNJUglE6NuLhP3wUwwX0fk3ZFMcXvP/U=;
        b=UHZVY2s9ZgJ2t4vaGIbaruugs9+K9nujttlPNPBvlO6egcsTHmxAdZQK4dLvicWbCe
         wIkHiPrAUCI0Z8RqgAyooQoqDB/6LMeEkSx9w3ep6Oc7thp53fptM2o2TPshEdohUtez
         C4XzQpMlc6e5x5DariOpKzB0AqIov4ExBG63w3y6iICfhKXCf0Z851dVOOjDmiE1D7Rr
         /VQ0YRfkM+M/bODioyz0hpEXepUkglD11oMyibE7qdhK14viOLV2Cf7+xXf4O8JtyGhr
         vAuiYPYjmbrBJbxWDoGoLX640RdJ2GJyPyaAh7g+K1lli+CCtht5UheVlxFF1MnPUQ+z
         0yZw==
X-Gm-Message-State: AOAM532FFfSzzdRM30xNq5C4kHt044jgCilShM9QM9A3QFgKH9oLi0h2
        kVHrNaqnImpHC3zcxJC8m7vQTg==
X-Google-Smtp-Source: ABdhPJwcWhMt07hFfYz3oKUeMDexBTevTaRnXbZLHsRRWc1FmkyQoTlAXPWEQn1VXvq4ZHIZjwge1Q==
X-Received: by 2002:a17:906:580c:: with SMTP id m12mr13853095ejq.32.1627287299669;
        Mon, 26 Jul 2021 01:14:59 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id gx11sm14042132ejc.33.2021.07.26.01.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 01:14:59 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:14:36 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Alex Williamson (alex.williamson@redhat.com)" 
        <alex.williamson@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Wang <jasowang@redhat.com>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shenming Lu <lushenming@huawei.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <YP5u7Fk2pylHNGeY@myrica>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Fri, Jul 09, 2021 at 07:48:44AM +0000, Tian, Kevin wrote:
> /dev/iommu provides an unified interface for managing I/O page tables for 
> devices assigned to userspace. Device passthrough frameworks (VFIO, vDPA, 
> etc.) are expected to use this interface instead of creating their own logic to 
> isolate untrusted device DMAs initiated by userspace. 
> 
> This proposal describes the uAPI of /dev/iommu and also sample sequences 
> with VFIO as example in typical usages. The driver-facing kernel API provided 
> by the iommu layer is still TBD, which can be discussed after consensus is 
> made on this uAPI.

The document looks good to me, I don't have other concerns at the moment

Thanks,
Jean

