Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AA3428928
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhJKIwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbhJKIwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:52:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DC3C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 01:50:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e3so20073694wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sk2vwHpDMapSB20kMOT3PpeVWQ3nV2u+hdesFvlhlXY=;
        b=sQAx9Y55PmndkkUA9JgbLSEHf3wecXknr9PmN8XlAGjxLyHPxu+BHmo1eXm9nYNm8H
         EhgZTCAikbV4yKa5OEEV9/sNqub8qLpMgx07yHaMbB1MwZSFwO7vMTjTBIbYDcJRTC4D
         uHh5ZHWqw7gnMN9popQqddpv4yE+SKKA+mjSlefLb2ZOC25Agj+2S+SoJqdENxlkELTN
         js52PoywEeVWqdQz836ClJ6+Q6wdubCG8sQYQYCJYXPD80YePUXmkgJAvArP0gEQaa5o
         flZ8DHcxIkiQVesPqVbKEaWwo480lb2JwDOSVFwNfhTqQpQL6qtj+2PypAO0EtgGDBWo
         ivPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sk2vwHpDMapSB20kMOT3PpeVWQ3nV2u+hdesFvlhlXY=;
        b=pYIc1GFY0G5EOGfmgH6L4CxKuqYybYs8G3RYzRwXN27CuCkxyRZBt9y8L+cN+J6Lom
         1HoTLoOZcpjyjxqmJ6qBJEKCeMjzhmcRzOPm5+kS3znMbtu2GnmK0yxhyICgJrYif0Jx
         bpm4WTJePxOWx56ZRs4Jz8hkzjJwnFoVLDIMm9eAP8w7unKBcgz5Y4m4yd0qgbIUVkot
         hmT0MS8UqUcmbXhJW9oCHhxUW3i8j+J8hbSnIvdvOvSa1tf5SaOLOqqjretx3kd/Sl6M
         PzanaxWLvLsdGf9d+fqggvgEE8f2r/A+MQtfRYAKVk/n9+2SZZD63YjUMpjhAcpV7XoT
         gQqQ==
X-Gm-Message-State: AOAM533XDzO9pBiczP5Dr95W07iOj2eDh1E85Kfp3AtLV6dAX5vexDMC
        6+PW9MUm33dutlNJGgs7smUo+w==
X-Google-Smtp-Source: ABdhPJzU/1wA9A5uHZLtCS/EoNkG6y371Lka8wmYuBYDzHsaXCr/VdFzCzKHlkRdGz3TZTk0YVvlOQ==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr13026461wml.68.1633942220114;
        Mon, 11 Oct 2021 01:50:20 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id g188sm7226525wmg.46.2021.10.11.01.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 01:50:19 -0700 (PDT)
Date:   Mon, 11 Oct 2021 09:49:57 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Liu Yi L <yi.l.liu@intel.com>,
        alex.williamson@redhat.com, hch@lst.de, jasowang@redhat.com,
        joro@8bytes.org, kevin.tian@intel.com, parav@mellanox.com,
        lkml@metux.net, pbonzini@redhat.com, lushenming@huawei.com,
        eric.auger@redhat.com, corbet@lwn.net, ashok.raj@intel.com,
        yi.l.liu@linux.intel.com, jun.j.tian@intel.com, hao.wu@intel.com,
        dave.jiang@intel.com, jacob.jun.pan@linux.intel.com,
        kwankhede@nvidia.com, robin.murphy@arm.com, kvm@vger.kernel.org,
        iommu@lists.linux-foundation.org, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        nicolinc@nvidia.com
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <YWP6tblC2+/2RQtN@myrica>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com>
 <YVanJqG2pt6g+ROL@yekko>
 <20211001122225.GK964074@nvidia.com>
 <YWPTWdHhoI4k0Ksc@yekko>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWPTWdHhoI4k0Ksc@yekko>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 05:02:01PM +1100, David Gibson wrote:
> qemu wants to emulate a PAPR vIOMMU, so it says (via interfaces yet to
> be determined) that it needs an IOAS where things can be mapped in the
> range 0..2GiB (for the 32-bit window) and 2^59..2^59+1TiB (for the
> 64-bit window).
> 
> Ideally the host /dev/iommu will say "ok!", since both those ranges
> are within the 0..2^60 translated range of the host IOMMU, and don't
> touch the IO hole.  When the guest calls the IO mapping hypercalls,
> qemu translates those into DMA_MAP operations, and since they're all
> within the previously verified windows, they should work fine.

Seems like we don't need the negotiation part?  The host kernel
communicates available IOVA ranges to userspace including holes (patch
17), and userspace can check that the ranges it needs are within the IOVA
space boundaries. That part is necessary for DPDK as well since it needs
to know about holes in the IOVA space where DMA wouldn't work as expected
(MSI doorbells for example). And there already is a negotiation happening,
when the host kernel rejects MAP ioctl outside the advertised area.

Thanks,
Jean

