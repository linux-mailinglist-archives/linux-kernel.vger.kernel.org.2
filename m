Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73993CC413
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhGQPfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234255AbhGQPfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626535968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPx5lscN4uL5j5r5RwYLU17Da84bWZ603ZzJhrNc8ho=;
        b=TjCfW/fTsUi0xGM56Jt66OO1afZo8YsBqGJtGNgdgeFC180zhHT1Q4d1ncsIwnekmwg9nO
        7AxOyVgO0U1HO8ZSsYNmd56itcwhWK8wEdcofuxvVv8fdxnRdDrp4yqS4yrGnygS2Cfr/u
        iTiTNH0TxPSq9LiorjhnYYDqouguXN8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-H88yS9uaPm2Ce6Bq-GUUDA-1; Sat, 17 Jul 2021 11:32:47 -0400
X-MC-Unique: H88yS9uaPm2Ce6Bq-GUUDA-1
Received: by mail-ed1-f69.google.com with SMTP id cw12-20020a056402228cb02903a4b3e93e15so6469626edb.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 08:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kPx5lscN4uL5j5r5RwYLU17Da84bWZ603ZzJhrNc8ho=;
        b=Fw6PHfnN9kS3CZzUq4UidgTIjp/Fxjz4LIjIJeRTIrH7lezTT2GMR6i8xXx6Z3X36o
         t2I0CF1orCDCkZxSVXR+s1Pm7Pqsnx0+gfzdwpOGMHCtUJLzESlLnLju1QuI1PH//vBP
         6APt0gtgilVGGK05o8PXwmgIjEEiQ03rcoflXhu+UMdNBR9wYfan8LIDHdH1ZM2GiO3i
         MdhxHxB86/6l4qclR9++nB8H6zTfXrVq//LeoA3k7FntPVkAGN6ChkMqBv0zCUbVVKbh
         icCqD/iMhv2UY3dWLyCYahY4WhSS6NqlGFUqc1/GwkGflnNHjdby6+MraftSvbhlwrJu
         cZ4w==
X-Gm-Message-State: AOAM530L6lds6Z/EVG8XKPP2wiyrAOSFLgIXwrTn/nKSvsRFawyNHjVN
        ApPur97FBXnNd49FIlfNi+8ug7JiKbbyONVdSrCS5CNTqgpSe35RN69cKiE/JriiXfU47CbZDH9
        ImOW9/n3BNg4Ih90V9be6r4z+
X-Received: by 2002:a05:6402:2899:: with SMTP id eg25mr22305934edb.13.1626535966440;
        Sat, 17 Jul 2021 08:32:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvEeHXTbnIqQjLgBnN+499hJOrKn4KHt9H2RXK7mwNrjqaOTiZ0IrY5GKZmGSI1sZuXHL1Vg==
X-Received: by 2002:a05:6402:2899:: with SMTP id eg25mr22305916edb.13.1626535966309;
        Sat, 17 Jul 2021 08:32:46 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b10sm5014305edd.91.2021.07.17.08.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 08:32:46 -0700 (PDT)
Subject: Re: [PATCH v5 0/5] Add Alder Lake PCH-S support to PMC core driver
To:     Gayatri Kammela <gayatri.kammela@intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     mgross@linux.intel.com, irenic.rajneesh@gmail.com,
        andriy.shevchenko@linux.intel.com, vicamo.yang@canonical.com,
        srinivas.pandruvada@intel.com, david.e.box@intel.com,
        linux-kernel@vger.kernel.org, tamar.mashiah@intel.com,
        gregkh@linuxfoundation.org, rajatja@google.com,
        Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com,
        mlimonci@amd.com
References: <cover.1626459866.git.gayatri.kammela@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2a5ef70e-7194-1dcf-6653-9901c7470ace@redhat.com>
Date:   Sat, 17 Jul 2021 17:32:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1626459866.git.gayatri.kammela@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/16/21 8:38 PM, Gayatri Kammela wrote:
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
> 
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
>  drivers/platform/x86/intel/pmc/Makefile       |   5 +
>  .../{intel_pmc_core.c => intel/pmc/core.c}    | 309 +++++++++++++++++-
>  .../{intel_pmc_core.h => intel/pmc/core.h}    |  17 +
>  .../pmc/pltdrv.c}                             |   0
>  10 files changed, 352 insertions(+), 27 deletions(-)
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
> 
> base-commit: d936eb23874433caa3e3d841cfa16f5434b85dcf

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

