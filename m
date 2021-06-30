Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C43B8A56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 00:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhF3WMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 18:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232459AbhF3WMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 18:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625091002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ReCbrtMP/cxLMRe/lZJL4GXF42nMx1vpMXEPSI0hvQ=;
        b=KAkRhiD8lqEvL133a/SsRTuJ3V3X6QTJbHgZDmSbP5Fo4A9hp4Rg8tb+AximmvOuFzsUrH
        XVggwiAQVukZO+7MhQJ/1ceKftRhCprdXfPu1UecDbuC8RWTrt7HPooQ6XTcK5F5rjmohq
        haIbDGgRzphVCvhpPbVn3gi026jO7JE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-HKJg-v_xNK-tXuCScQNCQw-1; Wed, 30 Jun 2021 18:10:01 -0400
X-MC-Unique: HKJg-v_xNK-tXuCScQNCQw-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc3100000b02901d849b41038so3547859wmj.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 15:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ReCbrtMP/cxLMRe/lZJL4GXF42nMx1vpMXEPSI0hvQ=;
        b=ic8/EUSISs0N3Fmr9yBeZwBPBlSqCUvjtQVR6YCL41r2rzvZClaQ6Q8RVGRvQywy+f
         D6qJJ5H2trQef0GBWuwPFNjYhEX1Hqsv7mTpYI7ZqoVoi3wGFeCm/qborIi8ELAo7FeZ
         xArByMQhoR5cmm9RUvZTsNlgi8jVBZ+prJwdh+1FPaV4uWQ1/TIxuxLtKRlPV9xCwl6r
         L1Jd7up0TLzQ5kR6gnQ5re6GyYBIWULPhsE4T3BAPBu5U1a9Cn3J1EMv4PXWTf5ktNvb
         7XVCU8G88uIpQGUpBIIk3OPuMkMSkkEZXEU0rBQ4NGMF/oKB6wW86iCVcPlnvUQlDlnS
         V89g==
X-Gm-Message-State: AOAM533w0/KLicGoUrG+o5hjd6fgNR2k3kbj4c6IcWdZHoHTIG2NpYGV
        Ve4qpUG/m1HtTIFSQleDy4bCMmumar25tjz4mSPOB3dFPWmzroSWFWnxQavESNQkV5bxYfVYcTx
        EQv7/LcDbhBp7W351vCULdIb0
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr16882650wmg.117.1625091000111;
        Wed, 30 Jun 2021 15:10:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlU5TtFXVLyohpWwUCLVR70qKXp8D+c6+g8CDe44j7e9CNHSYRynn3Hnx7Cwjxfz20NWN+Rw==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr16882631wmg.117.1625090999901;
        Wed, 30 Jun 2021 15:09:59 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id d17sm9611715wro.93.2021.06.30.15.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 15:09:59 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
References: <20210630203030.GA4178852@bjorn-Precision-5520>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <51276875-658e-e6fe-5433-b5d795b253ff@redhat.com>
Date:   Thu, 1 Jul 2021 00:09:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630203030.GA4178852@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/21 10:30 PM, Bjorn Helgaas wrote:
> On Wed, Jun 30, 2021 at 09:59:58PM +0200, Javier Martinez Canillas wrote:

[snip]

>>
>> But maybe you can also add a paragraph that mentions the CONFIG_DEBUG_SHIRQ
>> option and shared interrupts? That way, other driver authors could know that
>> by enabling this an underlying problem might be exposed for them to fix.
> 
> Good idea, thanks!  I added this; is it something like what you had in
> mind?
> 

Thanks a lot for doing this rewording. I just have a small nit for the text.

>     Found by enabling CONFIG_DEBUG_SHIRQ, which calls the IRQ handler when it
>     is being unregistered.  An error during the probe path might cause this
>     unregistration and IRQ handler execution before the device or data
>     structure init has finished.
> 

The IRQ handler is not called when unregistered, but it is called when another
handler for the shared IRQ is unregistered. In this particular driver, both a
"pcie-sys" and "pcie-client" handlers are registered, then an error leads to
"pcie-sys" being unregistered and the handler for "pcie-client" being called.

So maybe the following instead?

    Found by enabling CONFIG_DEBUG_SHIRQ, which calls the IRQ handlers when a
    handler for the shared IRQ is unregistered. An error during the probe path
    might cause this unregistration and handler execution before the device or
    data structure init has finished.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

