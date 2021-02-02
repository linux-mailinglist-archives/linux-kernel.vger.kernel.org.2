Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A930C8F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbhBBSFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:05:16 -0500
Received: from foss.arm.com ([217.140.110.172]:54812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233934AbhBBSDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:03:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2F92ED1;
        Tue,  2 Feb 2021 10:02:22 -0800 (PST)
Received: from [10.57.49.26] (unknown [10.57.49.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CCAC3F73B;
        Tue,  2 Feb 2021 10:02:21 -0800 (PST)
Subject: Re: [PATCH 2/2] iommu: add Unisoc iommu basic driver
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>
References: <20210202073258.559443-3-zhang.lyra@gmail.com>
 <20210202104257.736836-1-zhang.lyra@gmail.com>
 <20210202140101.GA32671@8bytes.org>
 <992fad43-c457-d809-3bd7-7fd5b6e8fa22@arm.com>
 <20210202144126.GC32671@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5e766b74-ab51-8c47-66c1-ca65bc5743cd@arm.com>
Date:   Tue, 2 Feb 2021 18:02:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202144126.GC32671@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-02 14:41, Joerg Roedel wrote:
> On Tue, Feb 02, 2021 at 02:34:34PM +0000, Robin Murphy wrote:
>> Nope, I believe if Arm Ltd. had any involvement in this I'd know about it :)
> 
> Okay, got confused by thinking of ARM as the CPU architecture, not the
> company :)
> But given the intel/ and amd/ subdirectories refer to company names as
> well, the same is true for arm/.

Right, trying to group IOMMU drivers by supposed CPU architecture is 
already a demonstrable non-starter; does intel-iommu count as x86, or 
IA-64, or do you want two copies? :P

I somehow doubt anyone would license one of Arm's SMMUs to go in a 
RISC-V/MIPS/etc. based SoC, but in principle, they *could*. In fact it's 
precisely cases like this one - where silicon vendors come up with their 
own little scatter-gather unit to go with their own display controller 
etc. - that I imagine are most likely to get reused if the vendor 
decides to experiment with different CPUs to reach new market segments.

Robin.
