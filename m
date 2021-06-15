Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F33A7771
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 08:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFOG6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 02:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhFOG6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:58:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D88C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 23:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GCTN830Yp9doPgPY7pu2XF+Fwldsm+mzIOYdbShiloE=; b=gMNzpGI3YiXqfEOvxDoQ/kfFiy
        xwichaSc9hs+Oh//p75TJLSFdwWG4+mPqDVSZnXmmfIx0lQmouL8L27PQyduFKtudue5EW0s1a/Dv
        LrU6ZE/x1U6rz+Rzkx2Cfbhs4ooUh1kBl1NVoHdaYxlrnBeOD8gPmWGUW3+6Rkfv3bOTtH6vU+awZ
        a39leE69VA2pzrgLSWj+LJIOlxfDzf96fSClPQSj4El+Nc4eCJ0l812CcwakOMa9OAAzk/YLNDDVL
        eW26t4P1Jvwm6r4VLAEUZric599ENx7GpAQUgvO5E1KOtptJ0qPZq82OKj6vDTgrfLN72II8KDlw0
        TylkxA9w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lt2yw-006BSj-GV; Tue, 15 Jun 2021 06:55:37 +0000
Date:   Tue, 15 Jun 2021 07:55:30 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] powerpc/signal: Use unsafe_copy_siginfo_to_user()
Message-ID: <YMhO4oiqh4F+ZEW8@infradead.org>
References: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
 <8b4b640746523f5efb1c9a9fd97465bac4f00cae.1623739212.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4b640746523f5efb1c9a9fd97465bac4f00cae.1623739212.git.christophe.leroy@csgroup.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -836,14 +830,19 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
>  		asm("dcbst %y0; sync; icbi %y0; sync" :: "Z" (mctx->mc_pad[0]));
>  	}
>  	unsafe_put_sigset_t(&frame->uc.uc_sigmask, oldset, failed);
> +#ifndef CONFIG_COMPAT
> +	unsafe_copy_siginfo_to_user(&frame->info, &ksig->info, failed);
> +#endif
>  
>  	/* create a stack frame for the caller of the handler */
>  	unsafe_put_user(regs->gpr[1], newsp, failed);
>  
>  	user_access_end();
>  
> -	if (copy_siginfo_to_user(&frame->info, &ksig->info))
> +#ifdef CONFIG_COMPAT
> +	if (copy_siginfo_to_user32(&frame->info, &ksig->info))
>  		goto badframe;
> +#endif

Shouldn't the compat case be handled the same way?
