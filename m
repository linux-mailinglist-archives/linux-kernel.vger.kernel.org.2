Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375D443CEDA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbhJ0QoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:44:20 -0400
Received: from ale.deltatee.com ([204.191.154.188]:58398 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhJ0QoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:To:cc:content-disposition;
        bh=pmjG/w9KCFogpcwmZfTMs+jpYYxMw7C07k2WYJPP/Wg=; b=IDsB7W6HOLVGj26AXLzaTju8k7
        /SkRM4ou8KT3q3l+C4mb/9LMD9cmlDW38b7v7ewZ+iyYLdA6Z7J9WU21YmAwjkRMDwup8PaxTjQV9
        +vC7Dsh3Q9RhFKDvONgowJDfqAGDdpfryBcEOvayqdyNHlrauWeHFQ9JvYmUHamxbN2iViKpjNklt
        QcIv7N9SdBsMEtuOC/z/d04snokfLqgO6iKQMEcunent+teB0aQl2Iyt8DFnFEqO7ci8TRhKPw3s/
        p5Dus1AfQCYJWJq3ezuxry15lcIQX8nr6IolQg5g7aURNHQ4yFdpaLHtLfLu/MSjRA2Nirv4Tuz5C
        F/d17mHA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1mflzr-000k0W-Kd; Wed, 27 Oct 2021 10:41:52 -0600
To:     Marshall Midden <marshallmidden@gmail.com>, joro@8bytes.org,
        will@kernel.org, linux-kernel@vger.kernel.org
References: <CAD2CkAWjS8=kKwEEN4cgVNjyFORUibzEiCUA-X+SMtbo0JoMmA@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d8434a1a-b813-958f-69d7-34007faa49b7@deltatee.com>
Date:   Wed, 27 Oct 2021 10:41:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAD2CkAWjS8=kKwEEN4cgVNjyFORUibzEiCUA-X+SMtbo0JoMmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, will@kernel.org, joro@8bytes.org, marshallmidden@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: v5.15-rc7 AMD no kernel dump, spews "scsi_dma_map failed: request
 for 36 bytes!"
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021-10-27 10:08 a.m., Marshall Midden wrote:
> v5.15-rc7 AMD no kernel dump, spews "scsi_dma_map failed: request for 36 bytes!"
> 
> With v5.15-rc (1 through 7), AMD processor kernel crash dumps do not occur,
> instead spews:
>         "scsci_dma_map failed: request for 36 bytes!"
> Works on Intel machines, and in v5.14.0 (and v5.14.14) - as well as previous
> kernels (down to v5.3.x.)
> git bisect torvalds repository shows: dabb16f67215918c48cf3ff1fc4bc36ca421da2b
> Reverse patch to tag v5.15-rc7 allows kernel crash dumps to occur/happen.
> 

On careful review I think I see what might be causing this. Can you
please try the following patch?

Thanks,

Logan

--

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index cd0f1a593997..3bfb5da87802 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1028,7 +1028,8 @@ static int iommu_dma_map_sg(struct device *dev,
struct sc>

        if (static_branch_unlikely(&iommu_deferred_attach_enabled)) {
                ret = iommu_deferred_attach(dev, domain);
-               goto out;
+               if (ret)
+                       goto out;
        }

        if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
