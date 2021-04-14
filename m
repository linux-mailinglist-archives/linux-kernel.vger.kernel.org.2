Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC60D35F736
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhDNPJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233404AbhDNPI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618412914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H+zD0Y4qdqSV4NAs5HyIWKEsmhKVQCCIdVlrxpqso7s=;
        b=GGJZLyL6a1+/92TbgTvWKyEYBcBt6QzW4Xxd+HU/azV2tpOHskS96M3G6+vPch0t5D1Wi3
        xantVtG19LOpAkz9c4vaDwk+4JKKj31XpMF6duahbjTJaj1jxYE6XzmUpBTFUfKlKB6Z7Y
        SQwfoE69fimRpA1VT2P8CDIT75ohVkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-mnQTtDBhPu6LXN-xHY6JUQ-1; Wed, 14 Apr 2021 11:08:15 -0400
X-MC-Unique: mnQTtDBhPu6LXN-xHY6JUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54627107ACCD;
        Wed, 14 Apr 2021 15:08:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.25])
        by smtp.corp.redhat.com (Postfix) with SMTP id EBC985D6D7;
        Wed, 14 Apr 2021 15:08:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 14 Apr 2021 17:08:13 +0200 (CEST)
Date:   Wed, 14 Apr 2021 17:08:10 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     He Zhe <zhe.he@windriver.com>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ptrace: is_syscall_success: Add syscall return code
 handling for compat task
Message-ID: <20210414150810.GA19371@redhat.com>
References: <20210414080245.25476-1-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414080245.25476-1-zhe.he@windriver.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audit maintainers...

On 04/14, He Zhe wrote:
>
> When 32-bit userspace application is running on 64-bit kernel, the 32-bit
> syscall return code would be changed from u32 to u64 in regs_return_value
> and then changed to s64. Hence the negative return code would be treated
> as a positive number and results in a non-error in, for example, audit
> like below.

Sorry, can understand. At least on x86_64 even the 32-bit syscall returns
long, not u32.

Hmm. And afaics on x86 is_compat_task() is only defined if !CONFIG_COMPAT,
so this patch looks wrong anyway.

Oleg.

> type=SYSCALL msg=audit(1611110715.887:582): arch=40000028 syscall=322
> success=yes exit=4294967283
> 
> This patch forces the u32->s32->s64 for compat tasks.
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  include/linux/ptrace.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
> index b5ebf6c01292..bc3056fff8a6 100644
> --- a/include/linux/ptrace.h
> +++ b/include/linux/ptrace.h
> @@ -260,7 +260,9 @@ static inline void ptrace_release_task(struct task_struct *task)
>   * is an error value.  On some systems like ia64 and powerpc they have different
>   * indicators of success/failure and must define their own.
>   */
> -#define is_syscall_success(regs) (!IS_ERR_VALUE((unsigned long)(regs_return_value(regs))))
> +#define is_syscall_success(regs) (!IS_ERR_VALUE(is_compat_task() ? \
> +	(unsigned long)(s64)(s32)(regs_return_value(regs)) : \
> +	(unsigned long)(regs_return_value(regs))))
>  #endif
>  
>  /*
> -- 
> 2.17.1
> 

