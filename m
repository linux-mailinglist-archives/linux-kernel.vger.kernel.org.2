Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7716306CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 06:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhA1FXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 00:23:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhA1FXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 00:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611811342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=biRqszkHP+pvKFYG307Vk8Bx3khhjfa4Uut3UTzeY2s=;
        b=WcOwdshXKHCjPw8AYVT3JmIxDIIGYoMOkQBYs/LQNY90tWzbsx5lmTJ+t7zXs18FYcj9Z0
        6uL8DEXapy9mWVWdI+82BgsJiM23F8JLJJWGaR6sLFPNw7wcDzuPzTlJY+eowQ+6F1NFNl
        l1FiUxhNY3jFrjrZnTbLGNNoWeKvbE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-0XJ-QC08PHSmBbvjBIXOHA-1; Thu, 28 Jan 2021 00:22:15 -0500
X-MC-Unique: 0XJ-QC08PHSmBbvjBIXOHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5730180DE08;
        Thu, 28 Jan 2021 05:22:12 +0000 (UTC)
Received: from localhost (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 49F1C60C13;
        Thu, 28 Jan 2021 05:22:10 +0000 (UTC)
Date:   Thu, 28 Jan 2021 13:22:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, tyhicks@linux.microsoft.com,
        pmladek@suse.com, ebiederm@xmission.com, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 1/1] kexec: dump kmessage before machine_kexec
Message-ID: <20210128052208.GB2339@MiWiFi-R3L-srv>
References: <20210126204125.313820-1-pasha.tatashin@soleen.com>
 <20210126204125.313820-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126204125.313820-2-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/26/21 at 03:41pm, Pavel Tatashin wrote:
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
> ---
>  kernel/kexec_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 4f8efc278aa7..e253c8b59145 100644
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
> @@ -1180,6 +1181,7 @@ int kernel_kexec(void)
>  		machine_shutdown();
>  	}
>  
> +	kmsg_dump(KMSG_DUMP_SHUTDOWN);
>  	machine_kexec(kexec_image);

Looks good to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>

>  
>  #ifdef CONFIG_KEXEC_JUMP
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

