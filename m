Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239023EFE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 09:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbhHRHw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 03:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237962AbhHRHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 03:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629273110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PsxIbByc4MeeA9mh65w0Ji9CgAEac75Emzhzuys71nU=;
        b=EGr+bKQ3gMnODMk3faMARyrz27tfcuhW42G5W7KKa9SkOqlXoy/w8//avTX/2Y82rwWtH/
        p1nvQfq0IajaTtPcYYTZBXF/eBaQGBCc3aflOQksv1EtY5p2kB//W07dk/NCSQbZswIOH8
        cdVfRjIybUTdQYBw1TlM0AnsRFnxi14=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-EmMVN_POPfSL65vjt1Oc5Q-1; Wed, 18 Aug 2021 03:51:48 -0400
X-MC-Unique: EmMVN_POPfSL65vjt1Oc5Q-1
Received: by mail-ed1-f70.google.com with SMTP id e18-20020a0564020892b02903be9702d63eso600116edy.17
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 00:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PsxIbByc4MeeA9mh65w0Ji9CgAEac75Emzhzuys71nU=;
        b=mqlJ+wK4JcQfmIpGstDmRYMM/umL0q5zVYANJyN7he5OzO3A3azULJonkmBM4+Z34Z
         TqbO5Wen50DoFv+sx21tUL/J1v420TqCocJl7TUh1Fjxb0Ej0ZuzpVGcg1YFVnlFpNvL
         N7pIOt7cGXzOnpc07ucArtMUGIcLhEpW4/sC2Xjm8XQ3nke/lfYMPPlYbDNdkj67XQAp
         cSvaabaUwZe77tHEoZIO7BlvRv3CKJP3f4hatpokzmMJ7whWwxVlwm4LDlFwvy4TcuH8
         rC4MNcROIQcMWkonk9UAVjAxCm9zdY2+lAZ57GGRTVxKhKb/zvv5Q12he7dffbF6MK6/
         LaEg==
X-Gm-Message-State: AOAM533WMm75ZExm3AC8nsZzRcyowvT0ICdJfBZyzb7XRkZ/OuebRmUs
        /gSsVXIZ5priAWAgKLqKAnx5uOr2bHHKjV3+wc+5BVACZ9uj6g5MTOsDoLagxU3gZr3SPY/8Pdq
        JNe1ilf5M3yMoayvCuPepxt80
X-Received: by 2002:a50:d68e:: with SMTP id r14mr8766733edi.136.1629273106577;
        Wed, 18 Aug 2021 00:51:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq4bdN4/sZhvMzrI99gJ/UuBSRKuLfjrHyCXV6VEehTVciR93QOuMDBXhi00XCU33E70OJwA==
X-Received: by 2002:a50:d68e:: with SMTP id r14mr8766723edi.136.1629273106446;
        Wed, 18 Aug 2021 00:51:46 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id be23sm2154520edb.68.2021.08.18.00.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 00:51:46 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] MFD: intel_pmt: Add general DVSEC/VSEC support
To:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        mgross@linux.intel.com, bhelgaas@google.com,
        srinivas.pandruvada@intel.com, andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20210817224018.1013192-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <21f59d91-c9b9-2a7e-e5d9-a7697979b4bf@redhat.com>
Date:   Wed, 18 Aug 2021 09:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210817224018.1013192-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/18/21 12:40 AM, David E. Box wrote:
> This patch enables general support for Intel defined PCIe VSEC and DVSEC
> capabilities in the Intel Platform Monitoring Technology (PMT) driver.
> Though the driver was written exclusively for PMT capabilities, newer DVSEC
> and VSEC IDs for other capabilities can exist on the same device requiring
> that the driver handle them.
> 
> This 2nd revision drops the creation of a separate OOBMSM driver. Instead,
> all cell drivers will have a dependency on CONFIG_MFD_INTEL_PMT, whether or
> not they are PMT. Changes in this patchset to the current cell drivers
> located in platform/x86 are based on Hans for-next branch where they have
> been moved to the intel/pmt subfolder.
> 
> David E. Box (5):
>   PCI: Add #defines for accessing PCIE DVSEC fields
>   MFD: intel_pmt: Support non-PMT capabilities
>   MFD: intel_pmt: Add support for PCIe VSEC structures
>   platform/x86: intel_pmt_telemetry: Ignore zero sized entries

Since this patch is pretty much a stand alone patch I've picked
this one (4/5) up now.

The rest of the patches touch both MFD and pdx86 files, so these
should be picked up by Lee. But they rely on the patch moving
the pdx86 pmt code into the drivers/platform/x86/intel/pmt dir
which is currently only available in my for-next branch.

I think it is probably best to wait for 5.15-rc1 and then Lee
can merge the rest. Here is my ack for Lee picking up
the pdx86 bits:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Lee, alternatively you could also merge commit e184b1e589a7fbb80bfdd0364c11422999a17a26
from the pdx86 tree, that is only 1 commit ahead of my latest fixes
pull-req to Linus for 5.14, so in essence that is 5.14-rc? (?=5 I think)
+ just the commit which you need as base, then you could still merge
these this cycle. If you wish I can put a signed tag on that
for you (I will treat it as immutable either way).

Regards,

Hans




>   MFD: intel_pmt: Add DG2 support
> 
>  drivers/mfd/intel_pmt.c                    | 256 +++++++++++++++------
>  drivers/platform/x86/intel/pmt/class.c     |   2 +
>  drivers/platform/x86/intel/pmt/crashlog.c  |   2 +-
>  drivers/platform/x86/intel/pmt/telemetry.c |  10 +-
>  include/uapi/linux/pci_regs.h              |   4 +
>  5 files changed, 197 insertions(+), 77 deletions(-)
> 
> 
> base-commit: ca42c119fc6746e65423257e7eddf5fc9e96edc2
> 

