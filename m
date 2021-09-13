Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000854082BA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 03:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbhIMBzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 21:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236880AbhIMBzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 21:55:17 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA95C06175F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 18:54:02 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id a66so8947372qkc.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 18:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=+PfhPG9W/lVy5ramZlbvodr40rH8UAo/+DD6H/rYHgU=;
        b=RRw5BTtqAvrwS9+emiwJjMqd2O39pRgO3Zd3l5FJNxz3o2Hrm6wuIgWuEvYJeGLuiS
         NZDi+GQt2jNdsAoTzmoVu+FBqU1KrxU5cPyzWnCm0p3waCNglVKYCvf4rVZLr5V5Inzu
         CBRk4OaF1GT+b4FFidVfQieGY21560FxDis9VeeXvFJ+WhBxzwqxGl6FoqVbBt0ADvwz
         7KPF2QRTlOjt5dXmG9xPG4IgtGnumwCKO9Kz1I5k17CNhBmAjXFV+EkN+Z9FDDQNtE2y
         RJOFMketDAz/+GIDL4v7ZhxBm2Firm1lrroKJ98UiuVsq/mTQe2/+jsZY7EY79PBW5fi
         ucwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=+PfhPG9W/lVy5ramZlbvodr40rH8UAo/+DD6H/rYHgU=;
        b=2Wg0Byf9IWpGP/jM/oKaIe4er75f9GhrWgtML0ZNvSSx1hc522akF3mgH00DOG+drt
         2iz5CQ4VYJAQbRNWNtJeKii4f+UNKeBzTVyN1Fbh7OFnkH0toywre+llG4MYhuaHtXnn
         3BE0yNSmL3R8FAuKimSJifIvixmn+KFWBr9On+FyAM7rwyN7ffsQcKWUx8DuBbRzVl8V
         8/vuYIP+/mMj8AJ7BzvJoI+/i5G/CaxOTNRGVa6U3hr6HEmpq74hBzVQgdtaJtTbB+sH
         cQUWxZT8c0wmk7JnurMsVqevm6zeNmwCDmVezCx7kEqH0yps2/mZvGxX1c0wdZ21YoPs
         sLAg==
X-Gm-Message-State: AOAM532ZHObQNJGT13n6y6+AeBeKDfsJr+DYudpRvMkWTLnrGJdDa2c/
        x2Y+OwFT/RFyq57Uh9NVixskRmDxsgZYWQ==
X-Google-Smtp-Source: ABdhPJz1tPyRLt5iDx3vqQcqvJmS7pHTx2yQurIdV5JfgES/R1rDULM39SqHER96PakPtfNvMl/11w==
X-Received: by 2002:a05:620a:1403:: with SMTP id d3mr7747441qkj.67.1631498041280;
        Sun, 12 Sep 2021 18:54:01 -0700 (PDT)
Received: from xanadu.home (modemcable108.170-21-96.mc.videotron.ca. [96.21.170.108])
        by smtp.gmail.com with ESMTPSA id t188sm4412807qkf.22.2021.09.12.18.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 18:54:01 -0700 (PDT)
Date:   Sun, 12 Sep 2021 21:54:00 -0400 (EDT)
From:   Nicolas Pitre <npitre@baylibre.com>
To:     Len Baker <len.baker@gmx.com>
cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        linux-i3c@lists.infradead.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: Prefer kcalloc over open coded
 arithmetic
In-Reply-To: <20210912155135.7541-1-len.baker@gmx.com>
Message-ID: <0611r11-rsq7-2n9-n834-9o31rq8qo737@onlyvoer.pbz>
References: <20210912155135.7541-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2021, Len Baker wrote:

> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
> 
> [1] https://www.kernel.org/doc/html/v5.14/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>

Acked-by: Nicolas Pitre <npitre@baylibre.com>

> ---
>  drivers/i3c/master/mipi-i3c-hci/hci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> index 80beb1d5be8f..f109923f6c3f 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> @@ -98,7 +98,7 @@ struct hci_xfer {
> 
>  static inline struct hci_xfer *hci_alloc_xfer(unsigned int n)
>  {
> -	return kzalloc(sizeof(struct hci_xfer) * n, GFP_KERNEL);
> +	return kcalloc(n, sizeof(struct hci_xfer), GFP_KERNEL);
>  }
> 
>  static inline void hci_free_xfer(struct hci_xfer *xfer, unsigned int n)
> --
> 2.25.1
> 
> 
