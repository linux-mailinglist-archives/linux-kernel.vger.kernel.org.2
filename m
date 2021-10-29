Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F7D43F9EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhJ2Jfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 05:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhJ2Jf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635499980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7tfeb0HKytIhVqT5P55ARF+KxzdK/QUGLHX6976FgLg=;
        b=S1ElMer5iaJmiwcP+xqlteirYY8o5nkF+OKvCxmGzzBqd5+cGefvL2QCe3L4idrnt5h3Dk
        LZNZlXRMxjGy1TCL0gZtrOSzEYUTZtJsi+OpWKIO9GMPlKzjk+4a+oRo3aZLZXYD23679j
        x+lkZA90p8K/Qm+XIlFNdjgoVYqywG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-J4k8dgW0NIG_oTE6dTRRnw-1; Fri, 29 Oct 2021 05:31:22 -0400
X-MC-Unique: J4k8dgW0NIG_oTE6dTRRnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F04421023F4D;
        Fri, 29 Oct 2021 09:31:20 +0000 (UTC)
Received: from localhost (ovpn-12-171.pek2.redhat.com [10.72.12.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7AC21815D;
        Fri, 29 Oct 2021 09:31:09 +0000 (UTC)
Date:   Fri, 29 Oct 2021 17:31:07 +0800
From:   Baoquan He <bhe@redhat.com>
To:     cgel.zte@gmail.com
Cc:     dyoung@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] crash_dump: fix boolreturn.cocci warning
Message-ID: <20211029093107.GK27625@MiWiFi-R3L-srv>
References: <20211020083905.1037952-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020083905.1037952-1-deng.changcheng@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 at 08:39am, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> ./include/linux/crash_dump.h: 119: 50-51: WARNING: return of 0/1 in
> function 'is_kdump_kernel' with return type bool
> 
> Return statements in functions returning bool should use true/false
> instead of 1/0.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Looks good to me, thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  include/linux/crash_dump.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index 0c547d866f1e..979c26176c1d 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -116,7 +116,7 @@ extern void register_vmcore_cb(struct vmcore_cb *cb);
>  extern void unregister_vmcore_cb(struct vmcore_cb *cb);
>  
>  #else /* !CONFIG_CRASH_DUMP */
> -static inline bool is_kdump_kernel(void) { return 0; }
> +static inline bool is_kdump_kernel(void) { return false; }
>  #endif /* CONFIG_CRASH_DUMP */
>  
>  /* Device Dump information to be filled by drivers */
> -- 
> 2.25.1
> 

