Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E677345921
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCWH5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhCWH53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616486248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kcaHKFzhUNTLsAjpw1+KhOEgoZVwV6InNV5gxPVBjyI=;
        b=MUfTqaO83aYu+hjtQsFgMKNpGaxel7D+KSQeDEsf4F3a/QCig6Hq27jZD8G+wx1kAHIsca
        81TjNFl+4wFvtuCp6ZSz7yP3jaDCBdprDjnlt7Z6A/ryL9wx1B6l6JeS7YYj2PzU+9rkSF
        LrnwWUFPS2duzGh3el5SGxJ7Hf6OMNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-UUGRC1eVN0qqDt5fzuScAQ-1; Tue, 23 Mar 2021 03:57:24 -0400
X-MC-Unique: UUGRC1eVN0qqDt5fzuScAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F37EB87A83F;
        Tue, 23 Mar 2021 07:57:21 +0000 (UTC)
Received: from localhost (ovpn-13-5.pek2.redhat.com [10.72.13.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BDDB66A05;
        Tue, 23 Mar 2021 07:57:18 +0000 (UTC)
Date:   Tue, 23 Mar 2021 15:57:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] include: linux: Remove duplicate include of pgtable.h
Message-ID: <20210323075715.GA13786@MiWiFi-R3L-srv>
References: <20210323031352.258587-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323031352.258587-1-wanjiabing@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/21 at 11:13am, Wan Jiabing wrote:
> linux/pgtable.h has been included at line 11 with annotation.
> So we remove the duplicate one at line 8.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Thanks for your posting. But this resend is still not good. I have
pasted the suggested log, wondering why you just ignore it and send v2
without updating, and also not marking this is v2. Please read
Documentation/process/submitting-patches.rst before you post next time.
Anyway, I have ack-ed Tian Tao's patch since his patch log is good
enough.

Thanks
Baoquan

> ---
>  include/linux/crash_dump.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index a5192b718dbe..be79a45d7aa3 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -5,7 +5,6 @@
>  #include <linux/kexec.h>
>  #include <linux/proc_fs.h>
>  #include <linux/elf.h>
> -#include <linux/pgtable.h>
>  #include <uapi/linux/vmcore.h>
>  
>  #include <linux/pgtable.h> /* for pgprot_t */
> -- 
> 2.25.1
> 

