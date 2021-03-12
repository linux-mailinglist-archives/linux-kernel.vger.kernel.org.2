Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7D3338FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhCLOXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:23:53 -0500
Received: from 7.mo51.mail-out.ovh.net ([46.105.33.25]:43980 "EHLO
        7.mo51.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhCLOX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:23:29 -0500
X-Greylist: delayed 2985 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Mar 2021 09:23:28 EST
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.180])
        by mo51.mail-out.ovh.net (Postfix) with ESMTPS id 4340A26B8C7;
        Fri, 12 Mar 2021 14:33:41 +0100 (CET)
Received: from kaod.org (37.59.142.102) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 12 Mar
 2021 14:33:40 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-102R004b7259aef-f689-42a7-b071-f92d816709c3,
                    795EE61F3CDF5270877287A62BE336BF03444C93) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 86.201.91.229
Subject: Re: [PATCH] powerpc: define the variable 'uaccess_flush' as static
To:     He Ying <heying24@huawei.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <dja@axtens.net>, <akpm@linux-foundation.org>,
        <rppt@kernel.org>, <aneesh.kumar@linux.ibm.com>
CC:     <johnny.chenyi@huawei.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
References: <20210312110638.178974-1-heying24@huawei.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a06a0dc8-c717-da4c-c5ad-eaf56bbbd896@kaod.org>
Date:   Fri, 12 Mar 2021 14:33:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210312110638.178974-1-heying24@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 1ace6534-db93-4101-b025-eb5d269ce8cc
X-Ovh-Tracer-Id: 7905224723001674744
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledruddvvddgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgedvieejfedvhfduhfffueevheeludffhfdvkeehleegtddttdfhieegveeghfffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehhvgihihhnghdvgeeshhhurgifvghirdgtohhm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 12:06 PM, He Ying wrote:
> The variable 'uaccess_fulsh' is not referenced outside the file. Perhaps we
> should define it as static to avoid the warning as follows:
> 
> arch/powerpc/kernel/setup_64.c:953:6: warning: symbol 'uaccess_flush'
> was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>  arch/powerpc/kernel/setup_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 560ed8b975e7..22aca271496b 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -950,7 +950,7 @@ static bool no_entry_flush;
>  static bool no_uaccess_flush;
>  bool rfi_flush;
>  bool entry_flush;

I think this is the case also for entry_flush. compiling with W=1 will tell you more.

Thanks,

C. 

> -bool uaccess_flush;
> +static bool uaccess_flush;
>  DEFINE_STATIC_KEY_FALSE(uaccess_flush_key);
>  EXPORT_SYMBOL(uaccess_flush_key);
>  
> 

