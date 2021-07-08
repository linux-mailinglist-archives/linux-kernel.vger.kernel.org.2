Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F89A3C1834
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhGHRgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhGHRgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:36:02 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE171C06175F;
        Thu,  8 Jul 2021 10:33:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a6so3688991ljq.3;
        Thu, 08 Jul 2021 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8as5+U+fUkwkcmcZ2ww9hFTp+JN+Md67nryC+hBSxw=;
        b=mv6qxhLzloqaQsgg3yWnQ0bdog4KqbISrbYI6fgzLD93cJXjkgieBVJh+0D2pPab9w
         ccbsyGQ0pDGL2hLlfagR03fJ3z/R3+QpWlUSpAmnTwSXL/sdpFSMDt7Mf7HmTdERXC+7
         uYnXR2H0kSl2LiFt2qFJoOU2Jw/xxIxFh47RLHpxG6kxrIZ7Za7RaBj+7tzlBMxQUveI
         4M9OGZZXI3Qsg79XqsTsCGTIlOhCVbqlLi5Kl8eY3eu8Ai4JQKmiByPsUqe5qILpEHvh
         B+QPUKO1Iyh3Uc5nF2ti1jD+vY0rz6yJKWWp56WcKb7YQggivRT8V2fJt/nd2OfAM92/
         YmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8as5+U+fUkwkcmcZ2ww9hFTp+JN+Md67nryC+hBSxw=;
        b=WBy6cElgJ/uLmZmUv5BTI4wUKLs3dvgGvq90lNnkClTSiAj/CaR5syXsOKS+Uft+Nh
         qb5ttr5V8szNCOYsV9NGJCQtasFuDN4yi0y7AscsTVF/qoDyxiJ1snil7KlW5urScyBh
         NibjZcO+EsT+DenX/E5oN8SXRwKajaA6kVLOVpAe9MNqhh+1NeTxfQX5bkK1bzJa5iSH
         ewx6SwalLVZhJif5XIYtwTGXpk3t5+17fPmdzgbDV7uLfau2JrEYf1+alXUgsrLFtL11
         Yviz/y6Iko9aJaeRALpBYKxJ/ezc3uhMEmgYdQ9oLKC+JyZrektuyO9ckmymGpLyUUJq
         hmuQ==
X-Gm-Message-State: AOAM530bm6q0pOQjkElKziURDoa0tdTCtwp+TwGXMa5lRwlDPSmV95WK
        euQxP8dXAWGqcktKG2vyreT7BBZw27yDpms4gYs=
X-Google-Smtp-Source: ABdhPJzXcWFdXI1S+Xc+K3K4T+wc48lSqLmrmir6aVgVYqsoemEs48d+917E8MnXcUgOZuzfYfJvrbBi4OL6KIBSVrM=
X-Received: by 2002:a2e:bb98:: with SMTP id y24mr12341008lje.507.1625765597906;
 Thu, 08 Jul 2021 10:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625709047.git.gayatri.kammela@intel.com>
In-Reply-To: <cover.1625709047.git.gayatri.kammela@intel.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Thu, 8 Jul 2021 13:32:51 -0400
Message-ID: <CAE2upjQK80HF+hADt+q9PQKpX6MntqQFQ+mcXRKkus1FvxvvRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add Alder Lake PCH-S support to PMC core driver
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     platform-driver-x86@vger.kernel.org, mgross@linux.intel.com,
        hdegoede@redhat.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vicamo.yang@canonical.com,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        linux-kernel@vger.kernel.org, tamar.mashiah@intel.com,
        gregkh@linuxfoundation.org, rajatja@google.com,
        Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com,
        mlimonci@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series looks good to me.

Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>

+ AMD folks

Hi Alex, Mario and Shaym - Perhaps AMD PMC files should also follow
the similar convention and it could probably evolve in future where
both x86 based PMC drivers might use some common library helper
functions. What do you think?


On Wed, Jul 7, 2021 at 10:10 PM Gayatri Kammela
<gayatri.kammela@intel.com> wrote:
>
> Hi,
> The patch series move intel_pmc_core* files to pmc subfolder as well as
> add Alder Lake PCH-S support to PMC core driver.
>
> Patch 1: Move intel_pmc_core* files to pmc subfolder
> Patch 2: Add Alderlake support to pmc_core driver
> Patch 3: Add Latency Tolerance Reporting (LTR) support to Alder Lake
> Patch 4: Add Alder Lake low power mode support for pmc_core
> Patch 5: Add GBE Package C10 fix for Alder Lake
>
> Changes since v1:
> 1) Add patch 1 to v2 i.e., Move intel_pmc_core* files to pmc subfolder
> 2) Modify commit message for patch 2.
>
> David E. Box (1):
>   platform/x86: intel_pmc_core: Add GBE Package C10 fix for Alder Lake
>     PCH
>
> Gayatri Kammela (4):
>   platform/x86: intel_pmc_core: Move intel_pmc_core* files to pmc
>     subfolder
>   platform/x86/intel: intel_pmc_core: Add Alderlake support to pmc_core
>     driver
>   platform/x86/intel: intel_pmc_core: Add Latency Tolerance Reporting
>     (LTR) support to Alder Lake
>   platform/x86/intel: intel_pmc_core: Add Alder Lake low power mode
>     support for pmc_core
>
>  drivers/platform/x86/Kconfig                  |  21 --
>  drivers/platform/x86/Makefile                 |   1 -
>  drivers/platform/x86/intel/Kconfig            |   1 +
>  drivers/platform/x86/intel/Makefile           |   1 +
>  drivers/platform/x86/intel/pmc/Kconfig        |  22 ++
>  drivers/platform/x86/intel/pmc/Makefile       |   5 +
>  .../x86/{ => intel/pmc}/intel_pmc_core.c      | 307 +++++++++++++++++-
>  .../x86/{ => intel/pmc}/intel_pmc_core.h      |  17 +
>  .../{ => intel/pmc}/intel_pmc_core_pltdrv.c   |   0
>  9 files changed, 350 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
>  create mode 100644 drivers/platform/x86/intel/pmc/Makefile
>  rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core.c (85%)
>  rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core.h (95%)
>  rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core_pltdrv.c (100%)
>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: David Box <david.e.box@intel.com>
> Cc: You-Sheng Yang <vicamo.yang@canonical.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
>
> base-commit: a931dd33d370896a683236bba67c0d6f3d01144d
> --
> 2.25.1
>


-- 
Thanks,
Rajneesh
