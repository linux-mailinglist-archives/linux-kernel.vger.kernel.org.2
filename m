Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F4B336AFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 05:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhCKEKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 23:10:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231219AbhCKEJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 23:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615435798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jdAQbWiah1wIbz7ASMBtwGPTJV/VRpBrzA40HdI8Fpc=;
        b=iCnArzLF/Q8lMDv0vtOWUCfbeuBkiEhUqlb+Yp1ODIehH/DUu3j1z3l/MYVav7SRpEw+lG
        5rqClk1ZWyYIfcqDYfFi9hxYafeEd1PoIPladKRVW5AGTnUxG6jBS/T8nPHNvo9k0xp9VK
        bBA31RfSzcOgGhghwBGmUdQ9bq0Z4BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-61WH1gM4P7uItOx5uo40bQ-1; Wed, 10 Mar 2021 23:09:54 -0500
X-MC-Unique: 61WH1gM4P7uItOx5uo40bQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C12C01084D69;
        Thu, 11 Mar 2021 04:09:52 +0000 (UTC)
Received: from localhost (ovpn-12-68.pek2.redhat.com [10.72.12.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 221141002388;
        Thu, 11 Mar 2021 04:09:51 +0000 (UTC)
Date:   Thu, 11 Mar 2021 12:09:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guohan Lu <lguohan@gmail.com>,
        Joe LeVeque <jolevequ@microsoft.com>, akpm@linux-foundation.org
Subject: Re: [PATCH] kexec: Add kexec reboot string
Message-ID: <20210311040949.GG2962@MiWiFi-R3L-srv>
References: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/21 at 01:46pm, Paul Menzel wrote:
> From: Joe LeVeque <jolevequ@microsoft.com>
> 
> The purpose is to notify the kernel module for fast reboot.

Checked several modules which registered with reboot_notifier_list, the
passed string is not cared. Just curious, could you tell how you have
used or plan to use this string in your code?

No objection to this even though it's trivial if no real use case.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Upstream a patch from the SONiC network operating system [1].
> 
> [1]: https://github.com/Azure/sonic-linux-kernel/pull/46
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  kernel/kexec_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index a0b6780740c8..f04d04d1b855 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1165,7 +1165,7 @@ int kernel_kexec(void)
>  #endif
>  	{
>  		kexec_in_progress = true;
> -		kernel_restart_prepare(NULL);
> +		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();
>  
>  		/*
> -- 
> 2.30.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

