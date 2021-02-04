Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B34930F371
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhBDMuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:50:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235753AbhBDMuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:50:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11F4464DF8;
        Thu,  4 Feb 2021 12:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612442961;
        bh=evq41kJogdMign7eZfsMLjpvkEQt0WpyoEhGnh7ALbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5ESek0ogYAsRxTgPFKCH2o4S7NHSkwWHsah5+WgKQ4R/NRNs8uKwOJpG2MbprQlh
         d2rBQMD0wt5M7hFw44yRDrzBEMaCF7nVCHPiCwxOifB0iD9inaqeUjHTkVjy0ECQ/B
         EpEHJ5xcmcIWyxRAsqp3bbuQeW1zftjtzUhAbpxiAIJHQ9a/SpIVB7HrxlBP2hx7Rw
         wUw/tHH1S/PZtziQBzQffSQKIhmLJRtOaL/jubf2IXPAIjPZGdCsjMROfrDlzHfla4
         hQtkFBEmfZUqcYHjY9+p0hyrqlsbmXwaISOU1f2O5KDRajgYCoi+k4tBfdwkaew/gG
         jUfoa0i0RZqCg==
Date:   Thu, 4 Feb 2021 12:49:14 +0000
From:   Will Deacon <will@kernel.org>
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        dan.j.williams@intel.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        catalin.marinas@arm.com, ardb@kernel.org, andreyknvl@google.com,
        broonie@kernel.org, linux@roeck-us.net, rppt@kernel.org,
        tyhicks@linux.microsoft.com, robin.murphy@arm.com,
        vincenzo.frascino@arm.com, gustavoars@kernel.org,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: Re: [PATCH v2 0/4] arm64: kasan: support CONFIG_KASAN_VMALLOC
Message-ID: <20210204124914.GC20468@willie-the-truck>
References: <20210109103252.812517-1-lecopzer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109103252.812517-1-lecopzer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 06:32:48PM +0800, Lecopzer Chen wrote:
> Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> ("kasan: support backing vmalloc space with real shadow memory")
> 
> Acroding to how x86 ported it [1], they early allocated p4d and pgd,
> but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
> by not to populate the vmalloc area except for kimg address.

The one thing I've failed to grok from your series is how you deal with
vmalloc allocations where the shadow overlaps with the shadow which has
already been allocated for the kernel image. Please can you explain?

Thanks,

Will
