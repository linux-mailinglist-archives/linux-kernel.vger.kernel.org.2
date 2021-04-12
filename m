Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DF335C370
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbhDLKMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:12:15 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:48300 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239401AbhDLKLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:11:14 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AKVLbDq5jqzvyzHwlgwPXwZCBI+orLtY04lQ7?=
 =?us-ascii?q?vn1ZYxY9SKClvuqpm+kW0gKxtS0YX2sulcvFFK6LR37d8pAd2/h1AZ6JWg76tG?=
 =?us-ascii?q?y0aLxz9IeK+UyDJwTS/vNQvJ0KT4FQE9v1ZGIRse/b502CH88k0J279smT69v2?=
 =?us-ascii?q?61dIYUVUZ7p77wF/YzzrcXFeYAVdH5I2GN69y6N8yAaIQngcYsSlCnRtZYGqm/?=
 =?us-ascii?q?TxmJ3rehIADRI8gTPusRqT9LX4HxKEty1/bxpzwKwv+WWAswv16rTLiYDD9jbg?=
 =?us-ascii?q?1nTe55kTpd35ytErPr3rtuEpLFzX5zqAVcBEU72GsCtdmpDJ1H8a1P/WoxkhOM?=
 =?us-ascii?q?xv63TeOkGNyCGdvzXd7A=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.82,216,1613430000"; 
   d="scan'208";a="502749185"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 12:10:54 +0200
Date:   Mon, 12 Apr 2021 12:10:54 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     tawahpeggy <tawahpeggy98@gmail.com>
cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] Staging: Remove line to fix checkpatch
 error
In-Reply-To: <20210411204933.GA3524@peggy-Lenovo-V130-15IKB>
Message-ID: <alpine.DEB.2.22.394.2104121208530.6734@hadrien>
References: <20210411204933.GA3524@peggy-Lenovo-V130-15IKB>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Apr 2021, tawahpeggy wrote:

> remove one empty line.CHECK: Please don't use multiple blank lines

Did something go wrong with the patch generation?  You say that you are
removing one line, but the diff information looks like you are adding a
file.  Normally a patch has only the changed lines and a few lines before
and after.

> Signed-off-by: tawahpeggy <tawahpeggy98@gmail.com>

You need to put your real name when contributing to the Linux kernel.

For example, I would put:

Julia Lawall <julia.lawall@inria.fr>

julia

>
> ---
>  drivers/staging/comedi/comedi_pcmcia.mod.c | 1 -
>  1 file changed, 0 insertion(+), 1 deletion(-)
>  create mode 100644 drivers/staging/comedi/comedi_pcmcia.mod.c
>
> diff --git a/drivers/staging/comedi/comedi_pcmcia.mod.c b/drivers/staging/comedi/comedi_pcmcia.mod.c
> index 0904b8765afs96..3984db1a39c8
> --- /dev/null
> +++ b/drivers/staging/comedi/comedi_pcmcia.mod.c
> @@ -0,0 +1,31 @@
> #include <linux/module.h>
> #define INCLUDE_VERMAGIC
> #include <linux/build-salt.h>
> #include <linux/vermagic.h>
> #include <linux/compiler.h>
>
> BUILD_SALT;
>
> MODULE_INFO(vermagic, VERMAGIC_STRING);
> MODULE_INFO(name, KBUILD_MODNAME);
>
> __visible struct module __this_module
> __section(".gnu.linkonce.this_module") = {
> 	.name = KBUILD_MODNAME,
> 	.init = init_module,
> #ifdef CONFIG_MODULE_UNLOAD
> 	.exit = cleanup_module,
> #endif
> 	.arch = MODULE_ARCH_INIT,
> };
>
> #ifdef CONFIG_RETPOLINE
> MODULE_INFO(retpoline, "Y");
> #endif
>
> MODULE_INFO(staging, "Y");
>
> MODULE_INFO(depends, "pcmcia,comedi");
>
> -
> MODULE_INFO(srcversion, "ED971F2E01020DFA2B04486");
> --
> 2.17.1
> h-Hartman <gregkh@linuxfoundation.org>
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20210411204933.GA3524%40peggy-Lenovo-V130-15IKB.
>
