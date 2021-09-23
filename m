Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD1E415A88
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbhIWJG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240063AbhIWJGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632387894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=POvmQFHwQedCHQCS5FtuCZbcIW6Qr+1gI9/W1ZBdgLg=;
        b=fBVdsWsON2J9RWOXd3+OIFz6AjJi3x81DQCNSogbNATeD8Mtya20j9/8w6W/hn9q1nG5a3
        leZqsX6VJtRctfnFkw52SpBgdYVPZVVhf/ABReSx1KdmekWBEqIcdTSw1u07qR/EuulAcM
        UqoMQAVfqZFZxwvG2DKFHSmzKoJhrfA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-p1btwL7bPbi_gvl4-IGQOA-1; Thu, 23 Sep 2021 05:04:52 -0400
X-MC-Unique: p1btwL7bPbi_gvl4-IGQOA-1
Received: by mail-ed1-f72.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so6159191edn.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 02:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=POvmQFHwQedCHQCS5FtuCZbcIW6Qr+1gI9/W1ZBdgLg=;
        b=gNDFv3rsoOSEBAr9qX2cajTfYrzBrTjISleqi+Qthc7m7KTACeHSm9kd6i6TBc4LmJ
         RiGchIJOWoa1heYgoUGLmEYcI9NqiD5UyVSneY1MKBGMN0yHpzC3dJybstDfSnW0Kk85
         8YiW6YJUtoihvbfnjOfeTmrLCcF3hZbxMshLRtRjix5bhILKNA8wEcFrc9hRya9ZdPg+
         A7DcuaukMOQ5Lj5FihPz7ykdHJq2joJr7/BPh+ANM1Oa+ExTSfXBoKVZP9xyXNMXyvPQ
         mxx461R9SMulyUK6S+7D3J6ULD+AKUiczEJQ4DNoTjIEHOslwXB0IsM17oK0E89VSAmd
         rNsQ==
X-Gm-Message-State: AOAM5320cgi/H2jk8tYwHHFUKtjQH33B1SojnLuBBR4Gtri9VrHL5iTJ
        673qUi8fO1ebiblJinY3xJnpER5DSyVu1vox7yFPMHUwC+G1sWr1/2bCvV1vZdeW7HHvyanvBKT
        F99eVU8EP1s+J1vUCZ0CHmRWF
X-Received: by 2002:a17:906:6a21:: with SMTP id qw33mr3949028ejc.326.1632387891521;
        Thu, 23 Sep 2021 02:04:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCoJwt7GfyvkgYCYqH43iz6MTmxVRiJkKQBqavUbmbjQFAeRzeRIe5taLYX66NvKp/emPI+A==
X-Received: by 2002:a17:906:6a21:: with SMTP id qw33mr3949010ejc.326.1632387891320;
        Thu, 23 Sep 2021 02:04:51 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t19sm2601334ejb.115.2021.09.23.02.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 02:04:50 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] Add general DVSEC/VSEC support
To:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        bhelgaas@google.com, andy.shevchenko@gmail.com
Cc:     mgross@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20210922213007.2738388-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <da8d9c79-d041-b7fa-6ee3-3abfcfcb0ef6@redhat.com>
Date:   Thu, 23 Sep 2021 11:04:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922213007.2738388-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/22/21 11:30 PM, David E. Box wrote:
> This patch enables general support for Intel defined PCIe VSEC and DVSEC
> capabilities in the Intel Platform Monitoring Technology (PMT) driver.
> Though the driver was written exclusively for PMT capabilities, newer DVSEC
> and VSEC IDs for other capabilities can exist on the same device requiring
> that the driver handle them.
> 
> V3 is mostly a resend of V2. It drops a platform/x86 patch that was picked
> up separately by Hans in the last cycle. It also adds a new patch to
> support an upcoming capability.
> 
> David E. Box (5):
>   PCI: Add #defines for accessing PCIE DVSEC fields
>   MFD: intel_pmt: Support non-PMT capabilities
>   MFD: intel_pmt: Add support for PCIe VSEC structures
>   MFD: intel_pmt: Add DG2 support
>   MFD: intel_extended_cap: Add support for Intel SDSi

Since this mostly touches drivers/mfd/intel_pmt.c, I assume this is
going to get merged through the MFD trees.

For the few small drivers/platform/x86 changes:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> 
>  drivers/mfd/intel_pmt.c                    | 258 +++++++++++++++------
>  drivers/platform/x86/intel/pmt/class.c     |   2 +
>  drivers/platform/x86/intel/pmt/crashlog.c  |   2 +-
>  drivers/platform/x86/intel/pmt/telemetry.c |   2 +-
>  include/uapi/linux/pci_regs.h              |   4 +
>  5 files changed, 191 insertions(+), 77 deletions(-)
> 

