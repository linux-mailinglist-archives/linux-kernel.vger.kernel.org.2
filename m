Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE4A32C32A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355580AbhCDAHK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Mar 2021 19:07:10 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:4450 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1389049AbhCCVb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 16:31:59 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DrRxd2k33z9ttBL;
        Wed,  3 Mar 2021 22:30:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id EOp0jFdqMqTs; Wed,  3 Mar 2021 22:30:45 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DrRxd0kG9z9ttRk;
        Wed,  3 Mar 2021 22:30:45 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 6B58D65A; Wed,  3 Mar 2021 22:33:58 +0100 (CET)
Received: from 37.173.125.231 ([37.173.125.231]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Wed, 03 Mar 2021 22:33:58 +0100
Date:   Wed, 03 Mar 2021 22:33:58 +0100
Message-ID: <20210303223358.Horde.OAg4JN_IZgwz7hkYuMwiTg3@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     maqiang <maqianga@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        paulus@samba.org, benh@kernel.crashing.org, mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc: remove redundant space
In-Reply-To: <20210303115710.30886-1-maqianga@uniontech.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

maqiang <maqianga@uniontech.com> a écrit :

> These one line of code don't meet the kernel coding style,
> so remove the redundant space.

There seems to be several other style issues in this function and in  
the following one too. You should fix them all at once I think.


>
> Signed-off-by: maqiang <maqianga@uniontech.com>
> ---
>  arch/powerpc/kernel/syscalls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
> index 078608ec2e92..9248288752d5 100644
> --- a/arch/powerpc/kernel/syscalls.c
> +++ b/arch/powerpc/kernel/syscalls.c
> @@ -81,7 +81,7 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
>  int
>  ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set  
> __user *exp, struct __kernel_old_timeval __user *tvp)
>  {
> -	if ( (unsigned long)n >= 4096 )
> +	if ((unsigned long)n >= 4096)
>  	{
>  		unsigned long __user *buffer = (unsigned long __user *)n;
>  		if (!access_ok(buffer, 5*sizeof(unsigned long))
> --
> 2.20.1


