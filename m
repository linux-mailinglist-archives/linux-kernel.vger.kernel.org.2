Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745DF3FEE12
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344762AbhIBMwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhIBMwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:52:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ECFC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 05:51:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lc21so4074405ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oBtvw9RLZz5FiMU8tP1KGG7ayEexwXszGesiGUpyM7c=;
        b=CZV3QxQDYOZ4sA6RDYakDFAaxGnXwXVMjsjFysxH8aP03rp+JlkXUPc7WgK8FGpX/L
         SXGuMEp+ppKVLvddgbBX0ixeNJqxg4VSqP1TDRDBjvPQ5VKMCmLqqkl9AJZfBi3l5/7x
         FRcUlQdxgFS5T4X7fWcunJi/PnebZvrR12cgPxE/DLA+M3YhxO/lbDEoOyp+g2/LW1Jx
         DX6pC3l7XJYiWPp1IXI/Ac9M+08dGoMbdF+te/nB3LOheviQx5PNuf1FxfHa01E+xToK
         SritC5zqmjTg3cZs8yl/SSYVerMp9pqN7lPtFv7U2XR7zP4a0R1mkgHfAJGHK1UQZ/42
         rIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBtvw9RLZz5FiMU8tP1KGG7ayEexwXszGesiGUpyM7c=;
        b=WQxuIIkOkQjucm8MnQ0js16JAFjtLDHEYKwy5+59QWcWaDpj72nC4yqcjqYc/ND7sn
         le10YPhdfeLuD1kKuim0SASbCTThMUayLSKYt6iPgDthtL0Va4+BsJkFJEAtBc2CqKkq
         hHQjFDxfYTfngWIKPqy+YMuUqNukdU+pjlpgUWsfNDDBjcH4tlbUizzsc5+89a7LpozV
         8urZrLHblUZ2Ly1WOrpDFlSEDwfKGQqgVEasrM+v00d6XKOn3dvlnaK/fJo7jKj7Hxjc
         K+mAiGVVuLPZuJtVN1bmh+Qs0QTJaf+twkreIB4ySOVVbI5Eum2iauACHQRfwrXrzika
         1U4A==
X-Gm-Message-State: AOAM5338Bdkj3FB1RtSezhLsMQXbAVr/WiCxu7pY+9rx1kvMlTjkv7Vt
        dtEm4O8xZpSUPohkyVSWBmf3t/GtDNfvNEi9dg07Vg==
X-Google-Smtp-Source: ABdhPJygSZC8fluO7Inqdaqw8JmKePWM0x239rNniJ2NKvF8HoUFS95pa4d4JBGyUMUeWRE3aBaYUS/L2g/2y3bv5Us=
X-Received: by 2002:a17:906:3a57:: with SMTP id a23mr3646914ejf.469.1630587113883;
 Thu, 02 Sep 2021 05:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
 <CGME20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2@eucas1p2.samsung.com>
 <01314d70-41e6-70f9-e496-84091948701a@samsung.com> <f3087045-1f0e-aa1a-d3f7-9e88bccca925@arm.com>
In-Reply-To: <f3087045-1f0e-aa1a-d3f7-9e88bccca925@arm.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 2 Sep 2021 14:51:43 +0200
Message-ID: <CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI devices
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Wang Xingang <wangxingang5@huawei.com>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        joro@8bytes.org, helgaas@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, xieyingtai@huawei.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sept 2021 at 11:58, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-09-01 09:59, Marek Szyprowski wrote:
> > On 21.05.2021 05:03, Wang Xingang wrote:
> >> From: Xingang Wang <wangxingang5@huawei.com>
> >>
> >> When booting with devicetree, the pci_request_acs() is called after the
> >> enumeration and initialization of PCI devices, thus the ACS is not
> >> enabled. And ACS should be enabled when IOMMU is detected for the
> >> PCI host bridge, so add check for IOMMU before probe of PCI host and call
> >> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
> >> devices.
> >>
> >> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
> >> configuring IOMMU linkage")
> >> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> >
> > This patch landed in linux-next as commit 57a4ab1584e6 ("iommu/of: Fix
> > pci_request_acs() before enumerating PCI devices"). Sadly it breaks PCI
> > operation on ARM Juno R1 board (arch/arm64/boot/dts/arm/juno-r1.dts). It

We've seen this on ARM Juno R2 boards too in the Linaro testfarm.

The problem is that the device can't get the "SATA link up" while booting.

see https://lkft.validation.linaro.org/scheduler/job/3416767#L577

When reverting this patch we are able to see the "SATA link up".

Cheers,
Anders
