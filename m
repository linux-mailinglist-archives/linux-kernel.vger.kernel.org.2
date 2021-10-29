Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDF943F9DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhJ2Jb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 05:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231464AbhJ2Jb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635499739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k31xok7yTKZNWgy4WhSw6JkbF2CozcwhIKdN9D6QVx8=;
        b=KCwSC4+Kvlpr9srGuqKUzg3bX7DZU6fXmlZJviyFm4u7SodpIj/v5t1DM37ZlgdbXAGa4a
        4T894WBHzVHdPxJxXSP8blgibNhmXUDZvukwBXfFnjm6ECfqjKc+QSKOZ47cH0+8YyoCjo
        1nMnTMW319+7diriEzbDNSf3JG0lE1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-PtTu6mknNpSw3-dgMBkL-Q-1; Fri, 29 Oct 2021 05:28:56 -0400
X-MC-Unique: PtTu6mknNpSw3-dgMBkL-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF6F310059CF;
        Fri, 29 Oct 2021 09:28:54 +0000 (UTC)
Received: from localhost (ovpn-12-171.pek2.redhat.com [10.72.12.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B00A69FB2;
        Fri, 29 Oct 2021 09:28:32 +0000 (UTC)
Date:   Fri, 29 Oct 2021 17:28:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     cgel.zte@gmail.com
Cc:     dyoung@redhat.com, kexec@lists.infradead.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, vgoyal@redhat.com, ye.guojin@zte.com.cn,
        zealci@zte.com.cn
Subject: Re: [PATCH v2] crash_dump: remove duplicate include in crash_dump.h
Message-ID: <20211029092830.GJ27625@MiWiFi-R3L-srv>
References: <20211020015357.GD27625@MiWiFi-R3L-srv>
 <20211020090659.1038877-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020090659.1038877-1-ye.guojin@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 at 09:06am, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> In crash_dump.h, header file <linux/pgtable.h> is included twice. This
> duplication was introduced in commit 65fddcfca8ad("mm: reorder includes
> after introduction of linux/pgtable.h") where the order of the header
> files is adjusted, while the old one was not removed.
> 
> Clean it up here.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>

Thanks, add Andrew to CC.

> ---
> v2:
> - update the commit log
> ---
>  include/linux/crash_dump.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index 0c547d866f1e..b7b255b23b99 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -8,8 +8,6 @@
>  #include <linux/pgtable.h>
>  #include <uapi/linux/vmcore.h>
> 
> -#include <linux/pgtable.h> /* for pgprot_t */
> -
>  /* For IS_ENABLED(CONFIG_CRASH_DUMP) */
>  #define ELFCORE_ADDR_MAX       (-1ULL)
>  #define ELFCORE_ADDR_ERR       (-2ULL)
> -- 
> 2.25.1
> 

