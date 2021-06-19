Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E130F3AD837
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 08:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhFSGoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 02:44:22 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:51536 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbhFSGoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 02:44:21 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1luUg5-00029l-IH; Sat, 19 Jun 2021 06:42:01 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1luUg3-00029v-BT; Sat, 19 Jun 2021 07:42:01 +0100
Subject: Re: [PATCH] um: remove unneeded semicolon in um_arch.c
To:     Wan Jiabing <wanjiabing@vivo.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes.berg@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Corey Minyard <cminyard@mvista.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210619020301.77672-1-wanjiabing@vivo.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <4320e0ea-1339-e2c1-03c0-271dbcd6e22d@cambridgegreys.com>
Date:   Sat, 19 Jun 2021 07:41:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210619020301.77672-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2021 03:02, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./arch/um/kernel/um_arch.c:284:34-35: Unneeded semicolon
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>   arch/um/kernel/um_arch.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index f9f1463f0521..a149a5e9a16a 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -281,7 +281,7 @@ static void parse_host_cpu_flags(char *line)
>   	int i;
>   	for (i = 0; i < 32*NCAPINTS; i++) {
>   		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))
> -			set_cpu_cap(&boot_cpu_data, i);;
> +			set_cpu_cap(&boot_cpu_data, i);
>   	}
>   }
>   static void parse_cache_line(char *line)
> 

Thanks.

I do not think the patch which introduces this ([v7,1/3] um: Add support 
for host CPU flags and alignment) has been merged yet. I do not see it 
in the tree as of this morning.

I can see that it is already marked as done in patchwork so it is on its 
way.

Richard, what do you want me to do - reissue a fixed one or we should 
accept the fix once the original is merged?

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
