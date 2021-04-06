Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3818355087
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhDFKJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:09:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:42401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233604AbhDFKJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617703768;
        bh=8BFgwwQsCdpZB3KEkBauG0JI1pthdfTr1AMrrHOMCU4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Pb/LIDXHOkmFGq19jLe5HlMh4Rp+H7shmdi4SwxwRYrv5TonK6vhDB1Uj3EPKCbIY
         Ik+bI3d5MmYAM8/eQCQ6nOCRx3BqVkCvNN/Q76Hj2XsKubHBnRz2n9OtxBEmIp66UE
         12ZBv8o9uiLfNZQQyVHk8/+rlXQb2jl+aVFfVp50=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.164.142]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGN2-1lBdni2wQY-00JLiy; Tue, 06
 Apr 2021 12:09:28 +0200
Subject: Re: [PATCH] parisc: avoid a warning on u8 cast for cmpxchg on u8
 pointers
To:     Gao Xiang <xiang@kernel.org>, linux-parisc@vger.kernel.org
Cc:     Liam Beguin <liambeguin@gmail.com>, linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@redhat.com>
References: <20210406045929.30331-1-xiang@kernel.org>
From:   Helge Deller <deller@gmx.de>
Message-ID: <ee2016b1-926e-93b1-ba92-d5f4975f06c9@gmx.de>
Date:   Tue, 6 Apr 2021 12:08:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210406045929.30331-1-xiang@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IMq8tYVDnfb+yXN9zYAV2GpvJp5AfJb1AhkxL3SLvTL2UXobw24
 SpowhBscXc5LnCcamG0aBWy9F8LWm8uD2losKI0lhiPHMevQowWdy9UUrcof0Hn11yUGSU2
 QMPCoIwuSWRijTqCtyyd9hGHC3kw2lMLvEYmmBMzQxntoWW1kal0ZxidlpsUXVALPrmmaPO
 id4xE9WGQVeNfJscJWyZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BX+CrpIVLRo=:zjNdnI96rrhSeSK3OIhLvY
 we5WvufCqUS/e6KD3GTuD1JNDG8s+7DnSDvy7PTyzwcoyVxaGPcFvsl050hXxV3k0hSqT8gGL
 NAJ3iP/L/+8meSIut3LNiWAEWDN9uWrB4BMen6LSpYfDFyOGOcQxcRxu7sHb42612rpFZmiT5
 MpO3HeA8mgTKemzS/CZFFRe9B3/Q6NK9Peo46RrENYvUaYAX+VPzhwgHF3VQBDlvMSCObDvZd
 BSMipQAWPX+FNbA4Wfzp1ImFW1k5+7jhkrrM/EYDH2ttJxA8z0xFkmQVkIyqx+zeUB15jSzbp
 2mgos34G+egHKyivFlQGGbZWM5wlQuNhYOiEivjLbG9oMBZAe8yFX6CjEu/GFs0G3epaQhkYM
 DGndoNQpEs5RYaeIpEEUa/NYS8wOKZxfjLEwlFOZurSvR5r+E2z7VnMbgIL17L4HQ7uXbTOpy
 TvSiBYt6is0eQfiqAIb2uu6mCE/oLCINM9XAiurj+1zQ6DZJoZLVt5GwWbi0rQQny6t1Y+9lD
 6l65rNMHAXGiwZXd0L0aLsDLSA9B9TCLYuCqur5D5c1hDg9LYnPs+J89JGzFYfJTHIGLxgHwX
 KlBb0A3swwsx7jdZCJXGf4shq7dVLobfAqUnl4xrUlzjz2yzGOzKo5X5sQQFKVawDn92qiI1O
 ftO+r7Gd1hNpzAqLXADGBxshk9AJlV5Cxkw9/eSYJUNIPdjjcZK/Y6I4QII3naiRwDoXdCeBk
 R27EEHOAUkN2H3rusvABkYBC83+fr7fsdm+dhZx38wwzqyXIkiox7pJ/ebShzmidFHtkGHTHv
 gFya6uq2t7OsmXXzIP6NWWtvruLIaXAu07HrEagHcMQ4KkunYHe9O/ZTLUAZ5eOpbpmKO6OXe
 lnkUtv19/WXWLoT/p20sXJqYSlj1mQ3DqblvrME4sPf6B0V6/fzJkTNISWrrtgFAm67s9QMCq
 KbJgQ+n57R9GuSDnGivNsuwVWC8oRNm69B62p+GBbzNbZanAXDJ0bYYXkrAl3BuyHOac1nixv
 885puCHz7N/+abjTBeDCQ8aDe/U5/aUUnotN9ROojviU2Gm8Mc9TsGkRaAebPO2rsog8z1fUG
 9T+aw/UVK+XG6QTICQcwKcZz8sCgRbe+lXwZxFtCqlYowymS7UNb4MrREq59JZ7BA55lBvoql
 0i6hyxOVZI/07eMcT4910J62a9Jp/Mu+G0+uOHnhfdUSlg4XNBL+6ucJZfRjND0sgAhC4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 6:59 AM, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
>
> commit b344d6a83d01 ("parisc: add support for cmpxchg on u8 pointers")
> can generate a sparse warningi ("cast truncates bits from constant
> value"), which has been reported several times [1] [2] [3].
>
> The original code worked as expected, but anyway, let silence such
> sparse warning as what others did [4].
>
> [1] https://lore.kernel.org/r/202104061220.nRMBwCXw-lkp@intel.com
> [2] https://lore.kernel.org/r/202012291914.T5Agcn99-lkp@intel.com
> [3] https://lore.kernel.org/r/202008210829.KVwn7Xeh%25lkp@intel.com
> [4] https://lore.kernel.org/r/20210315131512.133720-2-jacopo+renesas@jmo=
ndi.org
> Cc: Liam Beguin <liambeguin@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

applied to the parisc for-next git tree.
(I fixed up the typo above too)

Thanks!
Helge

> ---
>   arch/parisc/include/asm/cmpxchg.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm=
/cmpxchg.h
> index cf5ee9b0b393..84ee232278a6 100644
> --- a/arch/parisc/include/asm/cmpxchg.h
> +++ b/arch/parisc/include/asm/cmpxchg.h
> @@ -72,7 +72,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsig=
ned long new_, int size)
>   #endif
>   	case 4: return __cmpxchg_u32((unsigned int *)ptr,
>   				     (unsigned int)old, (unsigned int)new_);
> -	case 1: return __cmpxchg_u8((u8 *)ptr, (u8)old, (u8)new_);
> +	case 1: return __cmpxchg_u8((u8 *)ptr, old & 0xff, new_ & 0xff);
>   	}
>   	__cmpxchg_called_with_bad_pointer();
>   	return old;
>

