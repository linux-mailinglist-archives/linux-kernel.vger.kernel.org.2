Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753263791C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbhEJPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:01:09 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:47071 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhEJO6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:58:53 -0400
Received: by mail-ot1-f53.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso14620026otb.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QS25KxaAmrmE71ETQUlr3bP16oKKQZ2rMVy5vz0jD/0=;
        b=WdLWuqXBE2g9Wx/8jmp8fyTknaKKZp3IIMPZ4s83W6+HhBdR9B5bPbx9BASonP9ObL
         AK+nxEgFTrG1ZlQNRtPW9Iis+VGrsvejRH8GT0wxt1nUbo+KHfkdJJ1NzaQhD4pfTAlW
         ByE3GAF+joFWsgYizJ0pP7NjEvg7wW/kgr+Pjqe4zQeoejSKsSwmT6xicuWCOh6iIvKc
         9fG6nLJPf9Fmnr/I6CXUEJ+SrWdYDN72kpnGXTxEQ1zzCzUnucwwY5zWtTwpQGJ79ls+
         a40aBHntJuTMGMpELMRbyLQnj93+WVg6mpWv96zIzfa8oI/ATuIdqfbUaOj62MWUDtdS
         J/lw==
X-Gm-Message-State: AOAM532mhehXNnkRxPLmFf2Vtve6EsA2JhugGVl7CqnY/GwMPhRdhHGP
        /GAvO3AmzAuzBQCEXeNSrVf55B6xeFIcXJXbh+E=
X-Google-Smtp-Source: ABdhPJyJPwqCwQJmy9QcJFla5rgoIrwzYuUBvkxpzajL3MY4cdW5B35zOFxrhlb5y1BxdpxZIefveNNquNaGoBMJn2w=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr21422234otb.260.1620658668207;
 Mon, 10 May 2021 07:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210510095613.3302755-1-andy.shevchenko@gmail.com>
In-Reply-To: <20210510095613.3302755-1-andy.shevchenko@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 May 2021 16:57:37 +0200
Message-ID: <CAJZ5v0hLYHOSvh+695XbZZgqk=mt7gFHwPMi3Bfviq5sWcOs_w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] device property: Retrieve fwnode from of_node via accessor
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 11:57 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> OF provides a specific accessor to retrieve fwnode handle.
> Use it instead of direct dereferencing.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/base/property.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 1421e9548857..dd98759d688b 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -21,7 +21,7 @@
>  struct fwnode_handle *dev_fwnode(struct device *dev)
>  {
>         return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> -               &dev->of_node->fwnode : dev->fwnode;
> +               of_fwnode_handle(dev->of_node) : dev->fwnode;
>  }
>  EXPORT_SYMBOL_GPL(dev_fwnode);
>
> @@ -763,7 +763,7 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
>         struct fwnode_handle *fwnode = NULL, *next;
>
>         if (dev->of_node)
> -               fwnode = &dev->of_node->fwnode;
> +               fwnode = of_fwnode_handle(dev->of_node);
>         else if (adev)
>                 fwnode = acpi_fwnode_handle(adev);
>
> --

Applied as 5.14 material, thanks!
