Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20202434320
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 03:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhJTB4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 21:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJTB4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 21:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634694857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mUBCNZ9SYLw/kVAHggWY4GseZhCveJH2gyIMBPeVR2Y=;
        b=M45Uj3Qb3Sdl88gXvChKq7QPiahPAGsl43k0A6w8proQk8ATZ0er4Uwo4oXeky0JmuHpL8
        j9L9A46fppggA3K888bEsPZpdB0Y4eg8XH6TSERU30ta0V/o9EyavfCxZi/vj9TpsqWOSX
        /V7tVCsElOKImWt/AkHkZiwwSUiSls0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-Hc1YDvmJN-WwXpeNxClHCg-1; Tue, 19 Oct 2021 21:54:15 -0400
X-MC-Unique: Hc1YDvmJN-WwXpeNxClHCg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E0FD1006AA2;
        Wed, 20 Oct 2021 01:54:14 +0000 (UTC)
Received: from localhost (ovpn-13-116.pek2.redhat.com [10.72.13.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6D9564188;
        Wed, 20 Oct 2021 01:53:59 +0000 (UTC)
Date:   Wed, 20 Oct 2021 09:53:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     cgel.zte@gmail.com
Cc:     dyoung@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, rppt@linux.ibm.com
Subject: Re: [PATCH] crash_dump: remove duplicate include in crash_dump.h
Message-ID: <20211020015357.GD27625@MiWiFi-R3L-srv>
References: <20211020012318.1035952-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020012318.1035952-1-ye.guojin@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 at 01:23am, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> 'linux/pgtable.h' included in 'crash_dump.h' is duplicated.
> it's also included at line 8.

OK, in below commit the including order is adjusted, but the old one was
not removed.
commit 65fddcfca8ad("mm: reorder includes after introduction of linux/pgtable.h")

Could you rephrase the commit log? , the below sentences is for your reference.

============
In crash_dump.h, header file linux/pgtable.h is included twice. This
duplication was introduced in commit 65fddcfca8ad("mm: reorder includes
after introduction of linux/pgtable.h") where the order of include is
adjusted, while the old one was not removed.

Clean it up here.
============

Thanks for fixing this. when you finish polishing the patch log, please
feel free to add:

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
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
>  #define ELFCORE_ADDR_MAX	(-1ULL)
>  #define ELFCORE_ADDR_ERR	(-2ULL)
> -- 
> 2.25.1
> 

