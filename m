Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9692E445494
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhKDOOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:14:18 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:53006 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhKDOOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:14:16 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1midSe-0002xX-Up; Thu, 04 Nov 2021 14:11:25 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1midSc-0000PJ-HV; Thu, 04 Nov 2021 14:11:24 +0000
Subject: Re: [PATCH] um: use swap() to make code cleaner
To:     davidcomponentone@gmail.com, jdike@addtoit.com
Cc:     richard@nod.at, johannes.berg@intel.com, yang.guang5@zte.com.cn,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
References: <20211104061609.1496503-1-yang.guang5@zte.com.cn>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <7f95e669-fba3-32e6-cdb9-41fb415b3b82@cambridgegreys.com>
Date:   Thu, 4 Nov 2021 14:11:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211104061609.1496503-1-yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/11/2021 06:16, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>   arch/um/os-Linux/sigio.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
> index 9e71794839e8..1eb15f3cfdc8 100644
> --- a/arch/um/os-Linux/sigio.c
> +++ b/arch/um/os-Linux/sigio.c
> @@ -50,7 +50,7 @@ static struct pollfds all_sigio_fds;
>   
>   static int write_sigio_thread(void *unused)
>   {
> -	struct pollfds *fds, tmp;
> +	struct pollfds *fds;
>   	struct pollfd *p;
>   	int i, n, respond_fd;
>   	char c;
> @@ -77,9 +77,7 @@ static int write_sigio_thread(void *unused)
>   					       "write_sigio_thread : "
>   					       "read on socket failed, "
>   					       "err = %d\n", errno);
> -				tmp = current_poll;
> -				current_poll = next_poll;
> -				next_poll = tmp;
> +				swap(current_poll, next_poll);
>   				respond_fd = sigio_private[1];
>   			}
>   			else {
> 

You should include minmax.h for the swap macro. While there is a very significant likelihood that it will be pulled up by another something else, it is better to do that explicitly.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
