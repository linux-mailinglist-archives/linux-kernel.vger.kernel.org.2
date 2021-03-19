Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D82341D09
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhCSMjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229756AbhCSMi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616157537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Nh6bcyuWZCqRSHSG44N4kRbYxNxawsK0voffZty4Fo=;
        b=QtkCktcc2O1SX5hqykOlBzkImEN8PgizBWl3GjluckbWep17AurXhidjMiJPoEwu1ppHqz
        miuHC3Tl5W3jti5CMAfFHjik/I/cmQb01ix4ldGZB3f6LFzrpaEOyWwwsDcf5xmhWxJ07F
        4YZcLgZaalUXX3unzljNQmsG33b06i0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-Xjn3G3yyMqKO2ca5tH47EA-1; Fri, 19 Mar 2021 08:38:53 -0400
X-MC-Unique: Xjn3G3yyMqKO2ca5tH47EA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 487F6801817;
        Fri, 19 Mar 2021 12:38:52 +0000 (UTC)
Received: from localhost (ovpn-12-153.pek2.redhat.com [10.72.12.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C566E60CCB;
        Fri, 19 Mar 2021 12:38:47 +0000 (UTC)
Date:   Fri, 19 Mar 2021 20:38:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     menglong8.dong@gmail.com
Cc:     dyoung@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, tiantao6@hisilicon.com,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH] crash_dump: remove duplicate include in crash_dump.h
Message-ID: <20210319123845.GA2289@MiWiFi-R3L-srv>
References: <20210313103521.364854-1-zhang.yunkai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313103521.364854-1-zhang.yunkai@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/21 at 02:35am, menglong8.dong@gmail.com wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> 
> 'linux/pgtable.h' included in 'crash_dump.h' is duplicated.
> It is also included in the 8th line.

Tian Tao posted one to address the same issue, his log is better. Please
update with below to repost.

linux/pgtable.h is included more than once, Remove the one that isn't
necessary.

> 
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> ---
>  include/linux/crash_dump.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index a5192b718dbe..6bd8a33cb740 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -8,8 +8,6 @@
>  #include <linux/pgtable.h>
>  #include <uapi/linux/vmcore.h>
>  
> -#include <linux/pgtable.h> /* for pgprot_t */
> -
>  #ifdef CONFIG_CRASH_DUMP
>  #define ELFCORE_ADDR_MAX	(-1ULL)
>  #define ELFCORE_ADDR_ERR	(-2ULL)
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

