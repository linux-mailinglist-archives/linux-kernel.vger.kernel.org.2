Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AD434D091
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhC2Mz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231267AbhC2My4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:54:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 411E2614A5;
        Mon, 29 Mar 2021 12:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617022495;
        bh=gD8OAL8ZgrZxmhmfXI5U0FkI+CeYRCz8TgCwsSh8ha0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQIvO4y/SdhfupNIesMRydJjNf02VMTjYdEQVa5Vmz0fAuzU2QZWHfmCPBCFkHqB6
         OHocQmKEPGCOKUAvcNoyL2owm0o3O4UYX4zbkIVC1O54ZvGVfVRzSTfbhSreOwJ1P5
         xBbSmmn/RUV0Iz7Bm5pEmdmy8twaTwZAfmMqdh31wbOwy3hwYS1ogL4FrH6j0Pupci
         UmJ8ggu1V1fnHg/sjHYn8LXC79uzEevjsmeQ/SjEYg8a3wn9VpJDegL/QQHkYcKzue
         vZ/IxUmJjFVrRe6T2QizkS/CEhbB+4E0NSIr+VXCjNN274kIlkTNlCQrLKrsNtOX7T
         WQqiMsrOf40zw==
Date:   Mon, 29 Mar 2021 13:54:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, catalin.marinas@arm.com,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, akpm@linux-foundation.org,
        tyhicks@linux.microsoft.com, maz@kernel.org, rppt@kernel.org,
        linux@roeck-us.net, gustavoars@kernel.org, yj.chiang@mediatek.com
Subject: Re: [PATCH v4 5/5] arm64: Kconfig: select KASAN_VMALLOC if
 KANSAN_GENERIC is enabled
Message-ID: <20210329125449.GA3805@willie-the-truck>
References: <20210324040522.15548-1-lecopzer.chen@mediatek.com>
 <20210324040522.15548-6-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324040522.15548-6-lecopzer.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 12:05:22PM +0800, Lecopzer Chen wrote:
> Before this patch, someone who wants to use VMAP_STACK when
> KASAN_GENERIC enabled must explicitly select KASAN_VMALLOC.
> 
> From Will's suggestion [1]:
>   > I would _really_ like to move to VMAP stack unconditionally, and
>   > that would effectively force KASAN_VMALLOC to be set if KASAN is in use
> 
> Because VMAP_STACK now depends on either HW_TAGS or KASAN_VMALLOC if
> KASAN enabled, in order to make VMAP_STACK selected unconditionally,
> we bind KANSAN_GENERIC and KASAN_VMALLOC together.
> 
> Note that SW_TAGS supports neither VMAP_STACK nor KASAN_VMALLOC now,
> so this is the first step to make VMAP_STACK selected unconditionally.

Do you know if anybody is working on this? It's really unfortunate that
we can't move exclusively to VMAP_STACK just because of SW_TAGS KASAN.

That said, what is there to do? As things stand, won't kernel stack
addresses end up using KASAN_TAG_KERNEL?

Will
