Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B283380B10
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbhENOHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhENOHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:07:35 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4398BC061574;
        Fri, 14 May 2021 07:06:24 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id c16so6984335ilo.1;
        Fri, 14 May 2021 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=p778h4mDEFACoY3jLIwbbMe6YCGbmf3vLibN4Bx2pk4=;
        b=nC8L4dQI89t4hzo3h+eXBqlhwLeHOghclMnHjZf+MAel5fuBM81cHhC1O25S5hW/il
         y96X3yCwwkPOdCOdVOy2asoa6gkK69mX1zff9NAlBLl6K+ClrrnSIn1pVwCH6EoKLNMJ
         kMe5RzAkqe7zgOFW/n9XniT6aIBB+GbQDxNcqMhouZEzOJyZo7/0X44tVsriScZCPh3D
         eZXSjREmV6hTeRWC6KuC+K3z85BfiZDhfLKc5qkOCbPNf65/8M4wf4Bcl1r7d+8VypAA
         0B6vBnLdxAC1qVfWxaecdHwSerGPqiAm9NE0QV+Oj6VJuXDBQL3C90Bk3+BJ5otjkZgr
         6r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=p778h4mDEFACoY3jLIwbbMe6YCGbmf3vLibN4Bx2pk4=;
        b=mXTgBdUZU2pp9He8hkMndlwVT+MBZSIh+AoxCD6zq6iV1qLb9keD249Kh80HCb71Gs
         USKCJgLPYRak1Vxp+7je2dIJkxJWnzibpzppyMMe8QSi2U63X8flRnuC2/R21t3nrYI3
         1NVaj4LShnio8uVwi6FLYyMhn4HtZ5XzUkCVxinl4b78XpnxM3LCSBC2fdp/dy9LM7m5
         xoHFB09BQF0+RWzE3Pem3DzoUU+OQ/F1B5TwD9Zlilh/nzOJFGhPzr5a3UdbX0jubmky
         DC3h9pcyR5uGto430GQ0YbkjvDikYOb74ip0kc5FRApL+5zkkymA0ia2XnoIJYw8ervU
         8ywQ==
X-Gm-Message-State: AOAM532w8G2XRvWt382tcWL+eZBejWRpCp7qSqsXXXBHT5LgePoykGZe
        9lTuMaV2iTvDH2BPMnhGMHUAO14HXYOw1A==
X-Google-Smtp-Source: ABdhPJzjePt6YwBAYgds4Vy4ai2dQpEtXYwz25hrD40aPq72dVFwZx8fW0JmXwVyeb7KNXlrQUn6AQ==
X-Received: by 2002:a92:ce90:: with SMTP id r16mr41615408ilo.220.1621001183633;
        Fri, 14 May 2021 07:06:23 -0700 (PDT)
Received: from [192.168.99.80] (142-79-211-230.starry-inc.net. [142.79.211.230])
        by smtp.gmail.com with ESMTPSA id q18sm3094808ile.33.2021.05.14.07.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 07:06:23 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] xen: Export dbgp functions when CONFIG_XEN_DOM0 is
 enabled
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <d160cee9b61c0ec41c2cd5ff9b4e107011d39d8c.1620952511.git.connojdavis@gmail.com>
 <291659390aff63df7c071367ad4932bf41e11aef.1620952511.git.connojdavis@gmail.com>
From:   Connor Davis <connojdavis@gmail.com>
Message-ID: <236c31fe-2373-be23-bed4-48012a6a9765@gmail.com>
Date:   Fri, 14 May 2021 08:06:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <291659390aff63df7c071367ad4932bf41e11aef.1620952511.git.connojdavis@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Greg and linux-usb

On 5/13/21 6:56 PM, Connor Davis wrote:
> Export xen_dbgp_reset_prep and xen_dbgp_external_startup
> when CONFIG_XEN_DOM0 is defined. This allows use of these symbols
> even if CONFIG_EARLY_PRINK_DBGP is defined.
>
> Signed-off-by: Connor Davis <connojdavis@gmail.com>
> Acked-by: Juergen Gross <jgross@suse.com>
> ---
>   drivers/xen/dbgp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/xen/dbgp.c b/drivers/xen/dbgp.c
> index cfb5de31d860..fef32dd1a5dc 100644
> --- a/drivers/xen/dbgp.c
> +++ b/drivers/xen/dbgp.c
> @@ -44,7 +44,7 @@ int xen_dbgp_external_startup(struct usb_hcd *hcd)
>   	return xen_dbgp_op(hcd, PHYSDEVOP_DBGP_RESET_DONE);
>   }
>   
> -#ifndef CONFIG_EARLY_PRINTK_DBGP
> +#if defined(CONFIG_XEN_DOM0) || !defined(CONFIG_EARLY_PRINTK_DBGP)
>   #include <linux/export.h>
>   EXPORT_SYMBOL_GPL(xen_dbgp_reset_prep);
>   EXPORT_SYMBOL_GPL(xen_dbgp_external_startup);
