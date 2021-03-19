Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005C6342389
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhCSRlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229960AbhCSRlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:41:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8E2661925;
        Fri, 19 Mar 2021 17:41:10 +0000 (UTC)
Date:   Fri, 19 Mar 2021 17:41:08 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        ardb@kernel.org, andreyknvl@google.com, broonie@kernel.org,
        linux@roeck-us.net, rppt@kernel.org, tyhicks@linux.microsoft.com,
        robin.murphy@arm.com, vincenzo.frascino@arm.com,
        gustavoars@kernel.org, lecopzer@gmail.com
Subject: Re: [PATCH v3 0/5] arm64: kasan: support CONFIG_KASAN_VMALLOC
Message-ID: <20210319174108.GD6832@arm.com>
References: <20210206083552.24394-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206083552.24394-1-lecopzer.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lecopzer,

On Sat, Feb 06, 2021 at 04:35:47PM +0800, Lecopzer Chen wrote:
> Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> ("kasan: support backing vmalloc space with real shadow memory")
> 
> Acroding to how x86 ported it [1], they early allocated p4d and pgd,
> but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
> by not to populate the vmalloc area except for kimg address.

Do you plan an update to a newer kernel like 5.12-rc3?

> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Acked-by: Andrey Konovalov <andreyknvl@google.com>
> Tested-by: Andrey Konovalov <andreyknvl@google.com>
> Tested-by: Ard Biesheuvel <ardb@kernel.org>

You could move these to individual patches rather than the cover letter,
assuming that they still stand after the changes you've made. Also note
that Andrey K no longer has the @google.com email address if you cc him
on future patches (replace it with @gmail.com).

Thanks.

-- 
Catalin
