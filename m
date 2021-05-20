Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C340389A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 02:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhETAZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 20:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhETAZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 20:25:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E92C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 17:24:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t3so17335171edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 17:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOGPCygeGm574jrl8IBVZpfRYMLEqBwpFNqsk8f8+tI=;
        b=qMKqlCPaMAWpZHfXzZKHA7jX+XfwqBNpHw+03AyLdOAletf5oJRmg2TJv3hhgI51g/
         EkMIcNh7Gk6bLCivWMSTaVnTXwkGRLeDMlLbL5wL1fbM3W6MYEs3nKQMBCsOKOOEexJr
         oLeJBLcvx/4b5FSQgMRb87KcIexbJX+PL3vqUQQley4r+bCAPNY4T4qY13B5JZW4mCjs
         I9EESq+GEU2VAmAvoiaN2LAevH+uHo1Eu3WviuUUvL3qVyPzV02MSPttu6SHjTYJqNn+
         Ez45/K348f5szv7SyEiWjezNjv/qnqAkIJlqDzW8ybdjeq0g8JmgYGUe4t4GhgDyFyd2
         sEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOGPCygeGm574jrl8IBVZpfRYMLEqBwpFNqsk8f8+tI=;
        b=RQcuLhsYKACxmYWC+8LTNI8/Xpvp2fJ17/VCfciXtYH4L3YWRbaqI4T+SNckFsY1gE
         4lF3OyTYpButksa73K4QGRysMSEied4F5TyHeo/FdkXUY4+yaXM/uGEEssopb61gPBxl
         z/66pRkmtCtmSUaH8heJtoI9Rk9ojegZfbZvl1xkNFRfGLm7aJ6WBP3MrjoSx9xZt75U
         u1SiIGD2iUTivCtvp+iH+aH0D/iAzhPlXFLdaOwl/kIqVrGBKOmo0krASGsAWXGiJKAT
         wYcMKyRfd0Gy6z+jGQCtDYGxMCziNSGL35zvHsY0xQTnV4/134HVpy6WJ2XmjIG/poYv
         Nr+Q==
X-Gm-Message-State: AOAM5313ruWp5oSa+q1PFBZCpfXakl2YVc1naQ4pxm3GkfL2JkafuTF1
        qgIxZrCyY4Qu7Em0JiQWV1DoLHKvNiOlvpW5sVNL9g==
X-Google-Smtp-Source: ABdhPJxXlcnRqzUtPMdtnerJMEe6JXxL+MdSKqM+G0z1rrdmKNcd22lTPvn5Wgqroye1VbyrgXTfNSfi0Kn+DBcIxc8=
X-Received: by 2002:a05:6402:128f:: with SMTP id w15mr1939034edv.354.1621470251888;
 Wed, 19 May 2021 17:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210506223654.1310516-1-ira.weiny@intel.com>
In-Reply-To: <20210506223654.1310516-1-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 May 2021 17:24:01 -0700
Message-ID: <CAPcyv4g0n0eHv13b+Uy9sjXWVMtf3gB0Trxf9Ns0HhPtp2f6hg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Map register blocks individually
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 3:37 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> User space will want to map some register blocks.

The motivation is not to allow userspace access. The motivation is a
bug fix for hardware implementations that mix component and device
registers into the same BAR and the fact that the driver stack has
independent mapping implementations for those 2 cases. It is a happy
side-effect that this also allows finer grained pci-mmap exclusion.

> Currently BARs are mapped in
> their entirety and pointers to the register blocks are created into those
> mappings.  This will prevent mappings from user space.
>
> This series has 3 clean up patches followed by a patch to mapping the register
> blocks individually.
>
> Unfortunately, the information for the register blocks is contained inside the
> BARs themselves.  Which means the BAR must be mapped, probed, and unmapped
> prior to the registers being mapped individually.
>
> The probe stage creates list of register maps which is then iterated to map
> the individual register blocks.
>
> Ira Weiny (4):
>   cxl/mem: Fully decode device capability header
>   cxl/mem: Reserve all device regions at once
>   cxl/mem: Introduce cxl_decode_register_block()
>   cxl/mem: Map registers based on capabilities
>
>  drivers/cxl/core.c |  84 ++++++++++++++++++++------
>  drivers/cxl/cxl.h  |  34 +++++++++--
>  drivers/cxl/pci.c  | 147 +++++++++++++++++++++++++++++++++++----------
>  3 files changed, 211 insertions(+), 54 deletions(-)
>
> --
> 2.28.0.rc0.12.gb6a658bd00c9
>
