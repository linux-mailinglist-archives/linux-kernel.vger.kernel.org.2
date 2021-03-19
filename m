Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB36034263A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhCSTcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:32:09 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52734 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhCSTby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:31:54 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1ECB120B39C5;
        Fri, 19 Mar 2021 12:31:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1ECB120B39C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1616182311;
        bh=N17r/UB5T4m4Bg9gnzCLztHW3VZmUbzxtoNM3DmwHFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9Ntx43/LlZ/VyuRPZxURRFTXbXCKyPCJPrdLaW8ihR1pSVc6E7mLW0fIr0JISiuo
         bRBNd4oTjgp8p9fEEgfGkaL6M3uyVoFrHw14qHeGzbSbTgmHi+sS6QAVXy2fvfdp/S
         AvmKuXgUComq/EOfW8UY4PU4wNA9VQ1mUVY8nqkY=
Date:   Fri, 19 Mar 2021 14:31:38 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, pmladek@suse.com,
        ebiederm@xmission.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v3 1/1] kexec: dump kmessage before machine_kexec
Message-ID: <20210319193138.GA235401@sequoia>
References: <20210319192326.146000-1-pasha.tatashin@soleen.com>
 <20210319192326.146000-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319192326.146000-2-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-19 15:23:26, Pavel Tatashin wrote:
> kmsg_dump(KMSG_DUMP_SHUTDOWN) is called before
> machine_restart(), machine_halt(), machine_power_off(), the only one that
> is missing is  machine_kexec().
> 
> The dmesg output that it contains can be used to study the shutdown
> performance of both kernel and systemd during kexec reboot.
> 
> Here is example of dmesg data collected after kexec:
> 
> root@dplat-cp22:~# cat /sys/fs/pstore/dmesg-ramoops-0 | tail
> ...
> <6>[   70.914592] psci: CPU3 killed (polled 0 ms)
> <5>[   70.915705] CPU4: shutdown
> <6>[   70.916643] psci: CPU4 killed (polled 4 ms)
> <5>[   70.917715] CPU5: shutdown
> <6>[   70.918725] psci: CPU5 killed (polled 0 ms)
> <5>[   70.919704] CPU6: shutdown
> <6>[   70.920726] psci: CPU6 killed (polled 4 ms)
> <5>[   70.921642] CPU7: shutdown
> <6>[   70.922650] psci: CPU7 killed (polled 0 ms)
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  kernel/kexec_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index a0b6780740c8..6ee4a1cf6e8e 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -37,6 +37,7 @@
>  #include <linux/compiler.h>
>  #include <linux/hugetlb.h>
>  #include <linux/objtool.h>
> +#include <linux/kmsg_dump.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -1179,6 +1180,7 @@ int kernel_kexec(void)
>  		machine_shutdown();
>  	}
>  
> +	kmsg_dump(KMSG_DUMP_SHUTDOWN);
>  	machine_kexec(kexec_image);
>  
>  #ifdef CONFIG_KEXEC_JUMP
> -- 
> 2.25.1
> 
