Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425E83FE979
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 08:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242191AbhIBGwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 02:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbhIBGwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 02:52:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B4CC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iKiCgpE2RAx5gME3v9KQAcvDRUxt2sz+SQ5l2zSQS2Y=; b=GSYRQRH3hvmSCEXfuYL6oM6SN2
        WwXMxon0LE1dleknLZ37cDxjrlj5tIXIQ0y5a0TuQiTe3BBlou/zaUEsClrBSakAf4IKP+dr0hTv1
        4bcZK01UlYAL+IrHPSJenMR1D7xIZj8iRDiZjFHYDfLmy3Xhbje6zNFWHPtJ7FOotT3/x6K64qkrg
        xWgI85GvDXYnk0KqoTii7gftrem40pFOjj4/JFVGynYv5LAnoOiPp75Yh6a3hOdPmFcZx2WM9h/2U
        w6bXO+MkBl6TJQF4gP2nAtWTVn41x4lvLkJVmkF3iNqsjEULtGXpBuxqQBdYYBiG41RRdOvUAGtYg
        ZMaM7NVQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLgXu-003Bjy-DR; Thu, 02 Sep 2021 06:50:08 +0000
Date:   Thu, 2 Sep 2021 07:49:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] powerpc/signal64: Access function descriptor with
 user access block
Message-ID: <YTB0Fhlvg2kHV6hi@infradead.org>
References: <fd7938d94008711d441551c06b25a033669a0618.1629732940.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd7938d94008711d441551c06b25a033669a0618.1629732940.git.christophe.leroy@csgroup.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 03:35:51PM +0000, Christophe Leroy wrote:
> Access the function descriptor of the handler within a
> user access block.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/signal_64.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
> index 1831bba0582e..790c450c2de8 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -936,8 +936,18 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
>  		func_descr_t __user *funct_desc_ptr =
>  			(func_descr_t __user *) ksig->ka.sa.sa_handler;
>  
> -		err |= get_user(regs->ctr, &funct_desc_ptr->entry);
> -		err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
> +		if (user_read_access_begin(funct_desc_ptr, sizeof(func_descr_t))) {
> +			unsafe_get_user(regs->ctr, &funct_desc_ptr->entry, bad_funct_desc_block);
> +			unsafe_get_user(regs->gpr[2], &funct_desc_ptr->toc, bad_funct_desc_block);
> +		} else {
> +			goto bad_funct_desc;
> +bad_funct_desc_block:
> +			user_read_access_end();
> +bad_funct_desc:
> +			signal_fault(current, regs, __func__, funct_desc_ptr);
> +			return 1;
> +		}
> +		user_read_access_end();

Having a goto after an ele block, an then labels jumping into it is just
weird.

To make this somewhat readable just split it into a helper function:

static inline bool put_func_descr(func_descr_t __user *funct_desc_ptr,
		struct pt_regs *regs)
{
	if (!user_read_access_begin(funct_desc_ptr, sizeof(func_descr_t)))
		goto fault;
	unsafe_get_user(regs->ctr, &funct_desc_ptr->entry, uaccess_end);
	unsafe_get_user(regs->gpr[2], &funct_desc_ptr->toc, uaccess_end);
	user_read_access_end();
	return false;

uaccess_end:
	user_read_access_end();
fault:
	signal_fault(current, regs, __func__, funct_desc_ptr);
	return true;
}
