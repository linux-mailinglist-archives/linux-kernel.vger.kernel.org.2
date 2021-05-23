Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35B038DBA9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhEWPyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 11:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhEWPyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 11:54:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC58C061574;
        Sun, 23 May 2021 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=mBnaGlo+AM90jd7F38xerX7fyMsXOuFnmwzK7Lrx6bc=; b=rvhTrCkLDNDRhCuFEFi4etgSie
        Y05fnN2Noe3dDiRHP/TLFndhq2TUgbRMNAwOrwxm2k0/vLGw6m/3IHDWtAcCpKjqGkFt4WBdcTbd1
        uy2j5J+kpYit4TbrdRiSTOGnxK/NEf90B2ePnGPSVNDwBJZk/TWwGApR5b8NYeMGYq2R14Ff67nyB
        SvHx0jtb2GIVQJzF2KIX2jY8LUV0no93CIiLulrBtxGZy7NGwz4aLiM/77+sksvzeQPtZP3CLudd6
        3EJ+1DNvv8GFniCJPFOLf4DqJ8EpflMWX1TrsOLK5FukWXVMSooiO1yKhwyuphwk/UQIROcVGaLq9
        8PPU18Dg==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkqPB-000U4i-Is; Sun, 23 May 2021 15:52:41 +0000
Subject: Re: [PATCH] iommu/vt-d: fix kernel-doc syntax in file header
To:     Aditya Srivastava <yashsri421@gmail.com>, will@kernel.org
Cc:     lukas.bulwahn@gmail.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
References: <20210523143245.19040-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e61efeb6-1a04-dc29-81ae-792fde6aa857@infradead.org>
Date:   Sun, 23 May 2021 08:52:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210523143245.19040-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/21 7:32 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for drivers/iommu/intel/pasid.c follows this syntax, but
> the content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warnings from kernel-doc:
> warning: Function parameter or member 'fmt' not described in 'pr_fmt'
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/iommu/intel/pasid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 72646bafc52f..aaffb226a6a9 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * intel-pasid.c - PASID idr, table and entry manipulation
>   *
>   * Copyright (C) 2018 Intel Corporation
> 


-- 
~Randy

