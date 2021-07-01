Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380D63B9064
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 12:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhGAKRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 06:17:52 -0400
Received: from foss.arm.com ([217.140.110.172]:50478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235864AbhGAKRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 06:17:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6243D6E;
        Thu,  1 Jul 2021 03:15:20 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4E383F718;
        Thu,  1 Jul 2021 03:15:19 -0700 (PDT)
Subject: Re: [PATCH v2] drm/panfrost:report the full raw fault information
 instead
To:     Chunyou Tang <tangchunyou@163.com>
Cc:     tomeu.vizoso@collabora.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alyssa.rosenzweig@collabora.com,
        ChunyouTang <tangchunyou@icubecorp.cn>
References: <20210617062054.1864-1-tangchunyou@163.com>
 <2dcbb36a-b550-4c9d-cff8-73ca4b5abb11@arm.com>
 <20210619111852.00003e52@163.com>
 <23f675e9-698d-840d-104f-33aa594dcb96@arm.com>
 <20210622094000.00004f7e@163.com>
 <04bc1306-f8a3-2e3c-b55d-030d1448fad2@arm.com>
 <20210625174937.0000183f@163.com>
 <14b2a3c8-4bc2-c8f9-627b-9ac5840cad11@arm.com>
 <20210629110453.00007ace@163.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <3fe0e553-ac73-0d97-4404-c597fd4993a0@arm.com>
Date:   Thu, 1 Jul 2021 11:15:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629110453.00007ace@163.com>
Content-Type: text/plain; charset=gb18030
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2021 04:04, Chunyou Tang wrote:
> Hi Steve,
> 	thinks for your reply.
> 	I set the pte in arm_lpae_prot_to_pte(),
> ***********************************************************************
> 	/*
> 	 * Also Mali has its own notions of shareability wherein its
> Inner
> 	 * domain covers the cores within the GPU, and its Outer domain
> is
> 	 * "outside the GPU" (i.e. either the Inner or System domain in
> CPU
> 	 * terms, depending on coherency).
> 	 */
> 	if (prot & IOMMU_CACHE && data->iop.fmt != ARM_MALI_LPAE)
> 		pte |= ARM_LPAE_PTE_SH_IS;
> 	else
> 		pte |= ARM_LPAE_PTE_SH_OS;
> ***********************************************************************
> I set pte |= ARM_LPAE_PTE_SH_NS.
> 
> 	If I set pte to ARM_LPAE_PTE_SH_OS or
> 	ARM_LPAE_PTE_SH_IS,whether I use singel core GPU or multi core
> 	GPU,it will occur GPU Fault.
> 	if I set pte to ARM_LPAE_PTE_SH_NS,whether I use singel core
> 	GPU or multi core GPU,it will not occur GPU Fault.

Hi,

So this is a difference between Panfrost and kbase. Panfrost (well
technically the IOMMU framework) enables the inner-shareable bit for all
memory, whereas kbase only enables it for some memory types (the
BASE_MEM_COHERENT_LOCAL flag in the UABI controls it). However this
should only be a performance/power difference (and AFAIK probably an
irrelevant one) and it's definitely required that "inner shareable"
(i.e. within the GPU) works for communication between the different
units of the GPU.

You didn't answer my previous question:

> Is this device working with the kbase/DDK proprietary driver?

What you are describing sounds like a hardware integration issue, so it
would be good to check that the hardware is working with the proprietary
driver to rule that out. And perhaps there is something in the kbase for
this device that is setting a chicken bit to 'fix' the coherency?

Steve
