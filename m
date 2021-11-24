Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2384245B113
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 02:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhKXBUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 20:20:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhKXBUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 20:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637716665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6dBeN3vtQdRRtduQs8zdPXryTVnl6esgRTFkRT4qKrA=;
        b=XVKB68N+u39ZiDeiZfITDDjcdvyffVQqVFOWjK1/Gchd3ppiMBj7+lse2mbuN7YjCLh7dZ
        Z9L4nRpDa3GKvTWd+kTWhRB1EtxhgXeraD/fFm55wv802RqoHmyuVvzq+bE7cYVwnsztDd
        5tRbNu1ApBR1Hl3mNR66EE4hTaZ0jXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-G2NHz_W0N5qB6BDkG62UZQ-1; Tue, 23 Nov 2021 20:17:42 -0500
X-MC-Unique: G2NHz_W0N5qB6BDkG62UZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F8E180BCA8;
        Wed, 24 Nov 2021 01:17:39 +0000 (UTC)
Received: from localhost (ovpn-13-8.pek2.redhat.com [10.72.13.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98FDE19733;
        Wed, 24 Nov 2021 01:17:35 +0000 (UTC)
Date:   Wed, 24 Nov 2021 09:17:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC v1 1/8] crash: fix minor typo/bug in debug message
Message-ID: <20211124011733.GA23043@MiWiFi-R3L-srv>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
 <20211118174948.37435-2-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118174948.37435-2-eric.devolder@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/21 at 12:49pm, Eric DeVolder wrote:
> The pr_debug() intends to display the memsz member, but the
> parameter is actually the bufsz member (which is already
> displayed). Correct this to display memsz value.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/x86/kernel/crash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e8326a8d1c5d..9730c88530fc 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -407,7 +407,7 @@ int crash_load_segments(struct kimage *image)
>  	}
>  	image->elf_load_addr = kbuf.mem;
>  	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> -		 image->elf_load_addr, kbuf.bufsz, kbuf.bufsz);
> +		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);

Good catch, thx.

Acked-by: Baoquan He <bhe@redhat.com>

>  
>  	return ret;
>  }
> -- 
> 2.27.0
> 

