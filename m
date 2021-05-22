Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDBC38D643
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 17:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhEVPLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhEVPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 11:11:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8AFC061574;
        Sat, 22 May 2021 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=GH2mOBNX+XONeUL9wOPO8w6Hzq2geF/gsdvnEgGHARM=; b=o5QiuCeOylxsThRB1fFFONEBmd
        iseDMDCLETC5yuMhVcyMlEGS9GgTDYIDwCrzfsVF0ACYBV04jmz4YsLf90/94OFy9iVg3woixW318
        K1HX9VYV3pavqhVdPW4psXdCZM5keZFvhAF+q+7VtSVmKxf5VSwyXXb2JOyno3U0GxFU9mQtwAv4r
        Am+R6q6Ykbsq+lgcq9q1EyS97r9wZ1sAdBrM1XWOfvD1kMjAd+dUOljKICg1O5ZtzwpErn9J0zFjH
        rptEH0qGhRGnufMxhb9f9TP9ySbH/Y+hDl78OY0c/doCtWiDbgoQrwMlWHBTycrohrGjI/FKMMx4y
        xFRxdLUA==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkTGA-0008Zi-If; Sat, 22 May 2021 15:09:50 +0000
Subject: Re: [PATCH] USB: gadget: udc: fix kernel-doc syntax in file headers
To:     Aditya Srivastava <yashsri421@gmail.com>, balbi@kernel.org
Cc:     lukas.bulwahn@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210522115227.9977-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4869ba22-58e0-e101-c0df-51816abd0da9@infradead.org>
Date:   Sat, 22 May 2021 08:09:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210522115227.9977-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/21 4:52 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for drivers/usb/gadget/udc/trace files follows this syntax, but
> the content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc.
> For e.g., running scripts/kernel-doc -none drivers/usb/gadget/udc/trace.h
> emits:
> warning: expecting prototype for udc.c(). Prototype was for TRACE_SYSTEM() instead
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/usb/gadget/udc/trace.c | 2 +-
>  drivers/usb/gadget/udc/trace.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/trace.c b/drivers/usb/gadget/udc/trace.c
> index 7430624c0bd7..19e837de2a20 100644
> --- a/drivers/usb/gadget/udc/trace.c
> +++ b/drivers/usb/gadget/udc/trace.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * trace.c - USB Gadget Framework Trace Support
>   *
>   * Copyright (C) 2016 Intel Corporation
> diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
> index 2d1f68b5ea76..98584f6b6c66 100644
> --- a/drivers/usb/gadget/udc/trace.h
> +++ b/drivers/usb/gadget/udc/trace.h
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * udc.c - Core UDC Framework
>   *
>   * Copyright (C) 2016 Intel Corporation
> 


-- 
~Randy

