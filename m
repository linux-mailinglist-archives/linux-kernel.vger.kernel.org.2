Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CB63BF971
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhGHMBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231561AbhGHMBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625745502;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dshXb9jn8eIm6Bc2LZzQNFCS56+vnABkiUTQb4CJn2U=;
        b=eAMi73DZTS+sV4DpJM8UwxNmE+6yWW4OtuKz1BuIjXQM2ggDjDTH1LdaQ4JWwbi7iNYGgc
        EP1NtQMq1rmMoiZ/eRxEuMXhjlx8Igg1e9JvXqBoZRvnX8Za52KQ8ClCGCgkdB+KlKCNnn
        wX5rkDLMTXfdKJyi0OKv1iX7Y/9/HxU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-HfZF-znfP-CAYnuMdiGxww-1; Thu, 08 Jul 2021 07:58:21 -0400
X-MC-Unique: HfZF-znfP-CAYnuMdiGxww-1
Received: by mail-wr1-f71.google.com with SMTP id w4-20020a05600018c4b0290134e4f784e8so1846874wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 04:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=dshXb9jn8eIm6Bc2LZzQNFCS56+vnABkiUTQb4CJn2U=;
        b=J6iz6TXO8DcHj2EWTR5Ac+Ms/3i6Pv5Whc/uxG/hjiwfmthF5oqCe6ryXwVlC6FJxG
         GBcRpVnuyiqmg5t+wP42IIFH74SWLd+iaJHxj9IHkAHrHFNkwD1W3zNGuzoRqQNqdkvf
         2h6HueMo31fTIDn2daE5JDr69NB450QuqTLXzwotOoZoxqmhp3VwcR17flMekIeqDLry
         sfeD1XLDuyH0mPwxFrArrsOCvt4KhHC8IMknuVo0kNwlI8GD7EMJjC7pudfzTs6MvgQ5
         xb+KC96rjfV/MItRkuXUpk6g8RiN1LZEaCp/9Qjg9Ss5cKqcebQyUGCuJEMybqploJtI
         nhjQ==
X-Gm-Message-State: AOAM5339I417Kq0IZrjMo9r45aer62Vgd7O5k7u2HadK9BjAn0grNqrH
        kqlFslShlyuYPFiWVNeRZLKicV89pXtftvhEFGF4tBjj9hFA0l5EmcqF1+/Nxio116HsXwOJR/K
        3J19b22YeYwqZ4CI7rQ9GTRGt
X-Received: by 2002:adf:f346:: with SMTP id e6mr16953048wrp.28.1625745500696;
        Thu, 08 Jul 2021 04:58:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxozFjMyAziG3KZbbDgZO1MZs3Mlv2ma3E1vYF8tuWG6EYbU0l54aPD4L8qQkEAA6YUMnh1Lw==
X-Received: by 2002:adf:f346:: with SMTP id e6mr16953035wrp.28.1625745500565;
        Thu, 08 Jul 2021 04:58:20 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id c7sm2064945wrs.23.2021.07.08.04.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 04:58:20 -0700 (PDT)
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2] misc/pvpanic-pci: Allow automatic loading
To:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        mihai.carabas@oracle.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com
Cc:     arnd@arndb.de, pizhenwei@bytedance.com, pbonzini@redhat.com,
        joe@perches.com, drjones@redhat.com
References: <20210629072214.901004-1-eric.auger@redhat.com>
From:   Eric Auger <eric.auger@redhat.com>
Message-ID: <3e006cfb-f965-67b8-7167-dc2fcf342361@redhat.com>
Date:   Thu, 8 Jul 2021 13:58:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210629072214.901004-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 6/29/21 9:22 AM, Eric Auger wrote:
> The virtual machine monitor (QEMU) exposes the pvpanic-pci
> device to the guest. On guest side the module exists but
> currently isn't loaded automatically. So the driver fails
> to be probed and does not its job of handling guest panic
> events.
>
> Instead of requiring manual modprobe, let's include a device
> database using the MODULE_DEVICE_TABLE macro and let the
> module auto-load when the guest gets exposed with such a
> pvpanic-pci device.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
Maybe I misunderstood your question on the v1. This patch does not
result from an issue found by a tool/script but was identified while
exercising the pvpanic-pci use case "manually".

Thanks

Eric
>
> ---
>
> v1 -> v2:
> - enhance the commit message with additional info (Greg, Andy)
> ---
>  drivers/misc/pvpanic/pvpanic-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
> index 9ecc4e8559d5d..30290d42d8aa8 100644
> --- a/drivers/misc/pvpanic/pvpanic-pci.c
> +++ b/drivers/misc/pvpanic/pvpanic-pci.c
> @@ -122,4 +122,6 @@ static struct pci_driver pvpanic_pci_driver = {
>  	},
>  };
>  
> +MODULE_DEVICE_TABLE(pci, pvpanic_pci_id_tbl);
> +
>  module_pci_driver(pvpanic_pci_driver);

