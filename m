Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D85337A19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCKQxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:53:37 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:33584 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCKQx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:53:26 -0500
Received: by mail-io1-f45.google.com with SMTP id n132so22671861iod.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tLgGyS2Z81PUU2Dg5WInviB0T/N8U/MXgyafSYZmI3k=;
        b=j3o0fPAQ7zZTkw7LlD1NeiE7jBI6PbyEcO2vHNWH7kM14+taX6cHvygy5X0n4AoBdj
         m9o3mX0pu+BOPygxdJSz8vWHF46wG1rZDO4BqzDQfk8SeI+c8YGN7FHVTRQw6UQ11Va7
         ZGPVo+Tb5ORsZlIctZYxjnkYCYiTLbggTzczHTv0y9RUtBBvxwli5B0NAUwkXa6eUY8f
         IJ3KZFvJPDv2UfrlZ+1W2Vwzy6te2FInQE6D3ettlcAeD7T7SCQmDt44H5xYzz2qJxEG
         d/+RPhU6SxadksRmCMkGkLVOl/G3+MawW1uYex0bMvD5N/MhZdbulezje2VPv/7tpVBP
         HFnw==
X-Gm-Message-State: AOAM533M+2OQXeD3/TZTP9Ivsywa9zvYgnrbH1CXIAVz4nCnHX2LFQqz
        hB5Ks+nJsjpYNLTASMKk2rzsVdmovw==
X-Google-Smtp-Source: ABdhPJzbjzdoGiRC6qqM0Soa2DSWMI4uf+CZ/mBOR47+32K0X7LbrDnT3NMXptXC+hVHug9D8mUT4A==
X-Received: by 2002:a05:6638:d47:: with SMTP id d7mr4575924jak.2.1615481605929;
        Thu, 11 Mar 2021 08:53:25 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x16sm1547383ilp.44.2021.03.11.08.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 08:53:24 -0800 (PST)
Received: (nullmailer pid 861179 invoked by uid 1000);
        Thu, 11 Mar 2021 16:53:22 -0000
Date:   Thu, 11 Mar 2021 09:53:22 -0700
From:   Rob Herring <robh@kernel.org>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     kexec@lists.infradead.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Hari Bathini <hbathini@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Re: [PATCH v2] powerpc/kexec_file: Restore FDT size estimation for
 kdump kernel
Message-ID: <20210311165322.GA860702@robh.at.kernel.org>
References: <20210220005204.1417200-1-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220005204.1417200-1-bauerman@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Feb 2021 21:52:04 -0300, Thiago Jung Bauermann wrote:
> Commit 2377c92e37fe ("powerpc/kexec_file: fix FDT size estimation for kdump
> kernel") fixed how elf64_load() estimates the FDT size needed by the
> crashdump kernel.
> 
> At the same time, commit 130b2d59cec0 ("powerpc: Use common
> of_kexec_alloc_and_setup_fdt()") changed the same code to use the generic
> function of_kexec_alloc_and_setup_fdt() to calculate the FDT size. That
> change made the code overestimate it a bit by counting twice the space
> required for the kernel command line and /chosen properties.
> 
> Therefore change kexec_fdt_totalsize_ppc64() to calculate just the extra
> space needed by the kdump kernel, and change the function name so that it
> better reflects what the function is now doing.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  arch/powerpc/include/asm/kexec.h  |  2 +-
>  arch/powerpc/kexec/elf_64.c       |  2 +-
>  arch/powerpc/kexec/file_load_64.c | 26 ++++++++------------------
>  3 files changed, 10 insertions(+), 20 deletions(-)
> 
> Applies on top of next-20210219.
> 
> Changes since v1:
> 
> - Adjusted comment describing kexec_extra_fdt_size_ppc64() as suggested
>   by Lakshmi.
> 

Applied, thanks!
