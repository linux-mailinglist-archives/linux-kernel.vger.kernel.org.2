Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFFE44EC7F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhKLSSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 13:18:46 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]:33645 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhKLSSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 13:18:44 -0500
Received: by mail-qv1-f41.google.com with SMTP id bu11so6886909qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 10:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cop4I1aJy8z6ak0PjU3E7DI7v06o5jsLWL60m/FXBfk=;
        b=PxaidTedkk8t+5o+adwu9/8YjBf8LHeP0D+4jZLM1wdM+iVSoMm+ag1ELijDaN6HOo
         3ZYCmoXkObDkU7/sLqXFK6PZ4HkiWmAgUN9vENpV1KuIwx7UCHD0iNMXuutMSKneIjhB
         vAy4sheX/IWJ6XtgCBXmVl3drKHWIHKYJRNv0Pvjq+Kfre3WO8a42FuA7yH5EtZqWx6c
         5pUM+kBnR4VCZTGxrHuSay5rxOQAg/HcuLVWFnLNGpwHOsFoqxHHSO67gh81pq86VKZ1
         uF/bGPHMVTB43tbTl/7mBtariqolaU/MAmw0YYPmx+gXgEjLb7DivxGKdWuyvNe5/pER
         SSOQ==
X-Gm-Message-State: AOAM531IhJUWV2851JMN9MdFqzw/W5IiF0cqrjnlrMZUY11b6ry2UEKv
        B+PG1li42f34APEd04laeYQ=
X-Google-Smtp-Source: ABdhPJyOaTMeyqagIIw4gBdML86eGkUddV2vICZg3GXua3oB54KGmh7wnYdATKXU8i8nGv70D94D0w==
X-Received: by 2002:a0c:eec3:: with SMTP id h3mr16595518qvs.17.1636740953456;
        Fri, 12 Nov 2021 10:15:53 -0800 (PST)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id l15sm3592323qtx.77.2021.11.12.10.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 10:15:52 -0800 (PST)
Date:   Fri, 12 Nov 2021 13:15:51 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/1] printk: Remove printk.h inclusion in percpu.h
Message-ID: <YY6vV2zUTdH5SNt5@fedora>
References: <20211112140749.80042-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112140749.80042-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Nov 12, 2021 at 04:07:49PM +0200, Andy Shevchenko wrote:
> After the commit 42a0bb3f7138 ("printk/nmi: generic solution for safe printk
> in NMI") the printk.h is not needed anymore in percpu.h.
> 
> Moreover `make headerdep` complains (an excerpt)
> 
> In file included from linux/printk.h,
>                  from linux/dynamic_debug.h:188
>                  from linux/printk.h:559 <-- here
>                  from linux/percpu.h:9
>                  from linux/idr.h:17
> include/net/9p/client.h:13: warning: recursive header inclusion
> 
> Yeah, it's not a root cause of this, but removing will help to reduce
> the noise.
> 
> Fixes: 42a0bb3f7138 ("printk/nmi: generic solution for safe printk in NMI")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/percpu.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/percpu.h b/include/linux/percpu.h
> index 98a9371133f8..ae4004e7957e 100644
> --- a/include/linux/percpu.h
> +++ b/include/linux/percpu.h
> @@ -6,7 +6,6 @@
>  #include <linux/preempt.h>
>  #include <linux/smp.h>
>  #include <linux/cpumask.h>
> -#include <linux/printk.h>
>  #include <linux/pfn.h>
>  #include <linux/init.h>
>  
> -- 
> 2.33.0
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Hey Andrew, it doesn't seem like I have anything big coming through
percpu, do you mind taking this. I might have some stuff due to sh, but
I'm still working on that with them.

Thanks,
Dennis
