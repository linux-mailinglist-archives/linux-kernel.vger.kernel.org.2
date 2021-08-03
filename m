Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7693DEDC7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbhHCMTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235721AbhHCMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627993164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKllgZqDNUBBC6rgv3VV5T2yXUlWf+TdmBOkkk4c3IQ=;
        b=X9560ldffDEPHy1DGopr9aeNH/D40f292J/iZ+JSsKmsKQTCvCzEttbUuXyg5k1UJG6r/e
        fQVSQL8TpT5/Ceer+19woAQeJonyVhsCXJu/L6vHyl1p35Tqu7tNE0kKKMPUTEswzFZRIS
        ZBvd8BPhFuhyGlHTWNfQPb0bA5zlkTs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-NFLC6K3lPXGrGfxzJE4Kfw-1; Tue, 03 Aug 2021 08:19:23 -0400
X-MC-Unique: NFLC6K3lPXGrGfxzJE4Kfw-1
Received: by mail-ej1-f69.google.com with SMTP id zp23-20020a17090684f7b02905a13980d522so1915324ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 05:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dKllgZqDNUBBC6rgv3VV5T2yXUlWf+TdmBOkkk4c3IQ=;
        b=tQ1237/0QYrffUuHQm/Mpp+hSdmKDAryxZC4oCEY8vjeSzwQ4X5XgMcNaZRxKIX1hL
         dIN3fq1EozEDw9MX2V3EO+SED/mJNWIQTzZezxGe7dAymF49JwNNw2vqNiwfZ7y0RURe
         TPbeqEumAgOZ3h98QN73k5Ahc0rnSDuh+B0vatec3Mz405t5w4GUvu3yX+8HMnRHvqgD
         9gVtbstcUYvhTCHeL3+ymVUtBR7x2dXpyWmcRu07lkdwT81UjhlhX3votcS2VaBQ7LzK
         wjbJ5xnLsHWhRHPntgu5Zv1PQLUqmPdFILnLlU5F68Lo8GsvWiPRe5clocMCr+kaD2bm
         5a4g==
X-Gm-Message-State: AOAM530aRdMLIjq17Ngx0p8+xZiTMsdMpR/A/fi3O9FLbpl5tEa6HBnt
        kvnlu0IYOnc6HPwlevAx8Cd+92Hl6s5jvIh/hBS1VYF147pGGdK/Iov2pgQtq+c1jWLG0eOJPJe
        u9sOsF1bTKj2Cp4Hqbxm/8YtJ
X-Received: by 2002:a17:906:34da:: with SMTP id h26mr20126930ejb.376.1627993161832;
        Tue, 03 Aug 2021 05:19:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+2eadLJkmTgs9ED+DDj0V5KhT2ZlCXjLWbDNt+Ag1X5IVOtQcMkaGyG113X/vgkoXnQ0ElQ==
X-Received: by 2002:a17:906:34da:: with SMTP id h26mr20126907ejb.376.1627993161647;
        Tue, 03 Aug 2021 05:19:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h10sm7046364edb.74.2021.08.03.05.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 05:19:21 -0700 (PDT)
Subject: Re: [PATCH v6 0/5] Add Alder Lake PCH-S support to PMC core driver
To:     Gayatri Kammela <gayatri.kammela@intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     mgross@linux.intel.com, irenic.rajneesh@gmail.com,
        andriy.shevchenko@linux.intel.com, vicamo.yang@canonical.com,
        srinivas.pandruvada@intel.com, david.e.box@intel.com,
        chao.qin@intel.com, linux-kernel@vger.kernel.org,
        tamar.mashiah@intel.com, gregkh@linuxfoundation.org,
        rajatja@google.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, mlimonci@amd.com
References: <cover.1627710765.git.gayatri.kammela@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e28d7d75-a7f2-eae2-f884-9a21ff6555d7@redhat.com>
Date:   Tue, 3 Aug 2021 14:19:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1627710765.git.gayatri.kammela@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gayatri,


On 7/31/21 8:07 AM, Gayatri Kammela wrote:
> Hi,
> The patch series move intel_pmc_core* files to pmc subfolder as well as
> add Alder Lake PCH-S support to PMC core driver.
> 
> Patch 1: Move intel_pmc_core* files to pmc subfolder
> Patch 2: Add Alderlake support to pmc core driver
> Patch 3: Add Latency Tolerance Reporting (LTR) support to Alder Lake
> Patch 4: Add Alder Lake low power mode support for pmc core
> Patch 5: Add GBE Package C10 fix for Alder Lake
> 
> Changes since v1:
> 1) Add patch 1 to v2 i.e., Move intel_pmc_core* files to pmc subfolder.
> 2) Modify commit message for patch 2.
> 
> Changes since v2:
> 1) Dropped intel_pmc_ prefix from the file names.
> 
> Changes since v3:
> 1) Fixed an error reported by lkp.
> 
> Changes since v4:
> 1) Updated MAINTAINERS
> 
> Changes since v5:
> 1) Fixed an module name error reported by Chao Qin

Thank you for fixing this.

I expect that you will send a new version addressing Andy's remarks,
so I'm going to drop this version from my queue.

Regards,

Hans


> David E. Box (1):
>   platform/x86/intel: pmc/core: Add GBE Package C10 fix for Alder Lake
>     PCH
> 
> Gayatri Kammela (4):
>   platform/x86/intel: intel_pmc_core: Move intel_pmc_core* files to pmc
>     subfolder
>   platform/x86/intel: pmc/core: Add Alderlake support to pmc core driver
>   platform/x86/intel: pmc/core: Add Latency Tolerance Reporting (LTR)
>     support to Alder Lake
>   platform/x86/intel: pmc/core: Add Alder Lake low power mode support
>     for pmc core
> 
>  MAINTAINERS                                   |   2 +-
>  drivers/platform/x86/Kconfig                  |  21 --
>  drivers/platform/x86/Makefile                 |   1 -
>  drivers/platform/x86/intel/Kconfig            |   1 +
>  drivers/platform/x86/intel/Makefile           |   1 +
>  drivers/platform/x86/intel/pmc/Kconfig        |  22 ++
>  drivers/platform/x86/intel/pmc/Makefile       |   6 +
>  .../{intel_pmc_core.c => intel/pmc/core.c}    | 309 +++++++++++++++++-
>  .../{intel_pmc_core.h => intel/pmc/core.h}    |  17 +
>  .../pmc/pltdrv.c}                             |   0
>  10 files changed, 353 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
>  create mode 100644 drivers/platform/x86/intel/pmc/Makefile
>  rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/core.c} (85%)
>  rename drivers/platform/x86/{intel_pmc_core.h => intel/pmc/core.h} (95%)
>  rename drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/pltdrv.c} (100%)
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: David Box <david.e.box@intel.com>
> Cc: You-Sheng Yang <vicamo.yang@canonical.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
> Cc: Chao Qin <chao.qin@intel.com>
> 
> base-commit: c7d102232649226a69dddd58a4942cf13cff4f7c
> 

