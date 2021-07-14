Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DB53C88ED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbhGNQuK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jul 2021 12:50:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50930 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237127AbhGNQuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:50:09 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GQ3M84JMBzB8Hs;
        Wed, 14 Jul 2021 18:47:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0IiR9O4UV1kh; Wed, 14 Jul 2021 18:47:16 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GQ3M82K49zB84P;
        Wed, 14 Jul 2021 18:47:16 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 3FAD3638; Wed, 14 Jul 2021 18:52:24 +0200 (CEST)
Received: from 37.164.227.125 ([37.164.227.125]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Wed, 14 Jul 2021 18:52:24 +0200
Date:   Wed, 14 Jul 2021 18:52:24 +0200
Message-ID: <20210714185224.Horde.SuBZAzTXvfB6J6HsqQkOog6@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Yi Zhuang <zhuangyi1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        hegdevasant@linux.vnet.ibm.com, paulus@samba.org,
        benh@kernel.crashing.org
Subject: Re: [PATCH v2] powerpc/rtas_flash: fix a potential buffer overflow
In-Reply-To: <20210714122753.76021-1-zhuangyi1@huawei.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yi Zhuang <zhuangyi1@huawei.com> a écrit :

> Since snprintf() returns the possible output size instead of the
> actual output size, the available flash_msg length returned by
> get_validate_flash_msg may exceed the given buffer limit when
> simple_read_from_buffer calls copy_to_user
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: a94a14720eaf5 powerpc/rtas_flash: Fix validate_flash buffer  
> overflow issue
> Signed-off-by: Yi Zhuang <zhuangyi1@huawei.com>
> ---
>  arch/powerpc/kernel/rtas_flash.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/rtas_flash.c  
> b/arch/powerpc/kernel/rtas_flash.c
> index a99179d83538..062f0724c2ff 100644
> --- a/arch/powerpc/kernel/rtas_flash.c
> +++ b/arch/powerpc/kernel/rtas_flash.c
> @@ -470,9 +470,14 @@ static int get_validate_flash_msg(struct  
> rtas_validate_flash_t *args_buf,
>  	if (args_buf->status >= VALIDATE_TMP_UPDATE) {
>  		n = sprintf(msg, "%d\n", args_buf->update_results);
>  		if ((args_buf->update_results >= VALIDATE_CUR_UNKNOWN) ||
> -		    (args_buf->update_results == VALIDATE_TMP_UPDATE))
> +		    (args_buf->update_results == VALIDATE_TMP_UPDATE)) {
>  			n += snprintf(msg + n, msglen - n, "%s\n",
>  					args_buf->buf);
> +			if (n >= msglen) {

n cannot be greater than msglen


> +				n = msglen;
> +				printk(KERN_ERR "FLASH: msg too long.\n");
> +			}
> +		}
>  	} else {
>  		n = sprintf(msg, "%d\n", args_buf->status);
>  	}
> --
> 2.26.0.106.g9fadedd


