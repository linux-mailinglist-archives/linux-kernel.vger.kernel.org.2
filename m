Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B7C32F10E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhCERWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:22:23 -0500
Received: from 6.mo52.mail-out.ovh.net ([188.165.49.222]:51942 "EHLO
        6.mo52.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhCERWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:22:17 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.89])
        by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 91BA2247D5E;
        Fri,  5 Mar 2021 18:22:13 +0100 (CET)
Received: from kaod.org (37.59.142.98) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 18:22:12 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-98R0028d3f4780-093e-46d9-9ca6-335c229312b5,
                    A3005A4F36DF08AD97B2C2D73D5B520F0C45B7E8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 86.201.91.229
Subject: Re: [PATCH] arch/powerpc/include/asm/book3s/64/: remove duplicate
 include in mmu-hash.h
To:     <menglong8.dong@gmail.com>, <mpe@ellerman.id.au>
CC:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <aneesh.kumar@linux.ibm.com>,
        <rdunlap@infradead.org>, <ganeshgr@linux.ibm.com>,
        <zhang.yunkai@zte.com.cn>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
References: <20210304024251.187564-1-zhang.yunkai@zte.com.cn>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <899a2027-d7e8-334d-d7ad-36ee143cfbce@kaod.org>
Date:   Fri, 5 Mar 2021 18:22:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210304024251.187564-1-zhang.yunkai@zte.com.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 0822bdb6-c61c-4633-ace2-03d601973089
X-Ovh-Tracer-Id: 7549440352677891061
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddtiedgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejkeduueduveelgeduueegkeelffevledujeetffeivdelvdfgkeeufeduheehfeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehmvghnghhlohhnghekrdguohhnghesghhmrghilhdrtghomh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/21 3:42 AM, menglong8.dong@gmail.com wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> 
> 'asm/bug.h' included in 'arch/powerpc/include/asm/book3s/64/mmu-hash.h'
> is duplicated.It is also included in the 12th line.
> 
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index f911bdb68d8b..3004f3323144 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -18,7 +18,6 @@
>   * complete pgtable.h but only a portion of it.
>   */
>  #include <asm/book3s/64/pgtable.h>
> -#include <asm/bug.h>
>  #include <asm/task_size_64.h>
>  #include <asm/cpu_has_feature.h>
>  
> 

