Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FFB3770CD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 11:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhEHJOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 05:14:46 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:54666 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHJOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 05:14:45 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lfJ1r-0005sH-PC; Sat, 08 May 2021 09:13:43 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lfJ1p-0005PV-L8; Sat, 08 May 2021 10:13:43 +0100
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eduard-Gabriel Munteanu <maxdamage@aladin.ro>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210508032239.2177-1-thunder.leizhen@huawei.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <01f2ebc7-effd-19f1-53cf-648cf81f811b@cambridgegreys.com>
Date:   Sat, 8 May 2021 10:13:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210508032239.2177-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2021 04:22, Zhen Lei wrote:
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
> 
> Fixes: 89df6bfc0405 ("uml: DEBUG_SHIRQ fixes")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   arch/um/drivers/chan_user.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
> index d8845d4aac6a..6040817c036f 100644
> --- a/arch/um/drivers/chan_user.c
> +++ b/arch/um/drivers/chan_user.c
> @@ -256,7 +256,8 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
>   		goto out_close;
>   	}
>   
> -	if (os_set_fd_block(*fd_out, 0)) {
> +	err = os_set_fd_block(*fd_out, 0);
> +	if (err) {
>   		printk(UM_KERN_ERR "winch_tramp: failed to set thread_fd "
>   		       "non-blocking.\n");
>   		goto out_close;
> 
Acked-By: anton.ivanov@cambridgegreys.com

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
