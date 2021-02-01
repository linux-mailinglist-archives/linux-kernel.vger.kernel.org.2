Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC0530AC7F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhBAQTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBAQTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:19:20 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03B4C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 08:18:38 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id s77so3333285qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 08:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=PZPy7UuU1m89CqE6Ujqo89pfGymoz3TNkAhBIsQ4ftk=;
        b=b50IC0A7+YwOShtI3lVdvYnTMyg/RIdFTJK6qX5h/7VICPpSxnO+EJoYFvMopauEti
         bOlUJTMuYE6lPDWe9klcC8QwL//wXYTJsnwCGEihqAK2qw6MpHnF2brWJEMtI44vcP3I
         mqGjFf/+l5lhj1+NmhhG8roIrx1WbchEbLM3nwpTJqQCu7wna6sYziJ2FQ3SWN+EhvOT
         8/nEQLcsl34JXeRUGI2MhSUZnlGEmtobJm58ugBZfG+dq1GhgJfu9pLpbmwEXsdos7ju
         3Z5FVm+IXMNBs1pVlzyvmZdRK1ja8SNZJPA8HzjlJwIkPWSZ1/ExOdEC3jSBcID5BKlW
         iXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=PZPy7UuU1m89CqE6Ujqo89pfGymoz3TNkAhBIsQ4ftk=;
        b=gjwK9TzllrOGgh36n9x8eA4FqYIkLy4nFDYUxmYgx1ZxpIH35EojdAoRdpc/nzXEjg
         A9Pu8e935W9xB9ZHZ78Ou633TjE572mLctp7yma8dovOZNnukWjA1lneZQoTBLiaPykT
         s44X0VnB+9xCMwZQ3i2RgLHB40rTL90X7LaqOEVXEVt2vQbYQZiv1Ts0G4sKqM/rFaeL
         ay613MrJANbbmZ482BAqEjB1DfeD7TQsDWw1ETwukzZV3ij4DkHU8bYxiWKg7qc32EeY
         HZFB3xL5zPjRUOAB0hCltDAqmcSRAbk26t1DCkqI7yAShBnod9vKcURXKRGwfM84Ysr0
         5wKw==
X-Gm-Message-State: AOAM532GzvBKYIZY76Srnb0zncddF0GraKMkDOudM1Y2h7W9ebGr5zDv
        DsDEpZQ7sDjcCFYMIgOE6GTPDQ==
X-Google-Smtp-Source: ABdhPJxCgBtVnjR4SVBuGufGMJ+u1XFal/gdEYmXcjkC/kITEPyeUp1hs6S3ABt09dQ2cxSGKo84BA==
X-Received: by 2002:a37:458c:: with SMTP id s134mr17213587qka.142.1612196318177;
        Mon, 01 Feb 2021 08:18:38 -0800 (PST)
Received: from xanadu.home (modemcable076.50-203-24.mc.videotron.ca. [24.203.50.76])
        by smtp.gmail.com with ESMTPSA id e5sm14189013qtp.86.2021.02.01.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 08:18:37 -0800 (PST)
Date:   Mon, 1 Feb 2021 11:18:37 -0500 (EST)
From:   Nicolas Pitre <npitre@baylibre.com>
To:     David Gow <davidgow@google.com>
cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: Specify HAS_IOMEM dependency
In-Reply-To: <20210127040636.1535722-1-davidgow@google.com>
Message-ID: <9s6n963q-poro-6qnq-q510-83rr59785on@onlyvoer.pbz>
References: <20210127040636.1535722-1-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021, David Gow wrote:

> The MIPI i3c HCI driver makes use of IOMEM functions like
> devm_platform_ioremap_resource(), which are only available if
> CONFIG_HAS_IOMEM is defined.
> 
> This causes the driver to be enabled under make ARCH=um allyesconfig,
> even though it won't build.
> 
> By adding a dependency on HAS_IOMEM, the driver will not be enabled on
> architectures which don't support it.
> 
> Fixes: 9ad9a52cce28 ("i3c/master: introduce the mipi-i3c-hci driver")
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Nicolas Pitre <npitre@baylibre.com>


> ---
>  drivers/i3c/master/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
> index e68f15f4b4d0..afff0e2320f7 100644
> --- a/drivers/i3c/master/Kconfig
> +++ b/drivers/i3c/master/Kconfig
> @@ -25,6 +25,7 @@ config DW_I3C_MASTER
>  config MIPI_I3C_HCI
>  	tristate "MIPI I3C Host Controller Interface driver (EXPERIMENTAL)"
>  	depends on I3C
> +	depends on HAS_IOMEM
>  	help
>  	  Support for hardware following the MIPI Aliance's I3C Host Controller
>  	  Interface specification.
> -- 
> 2.30.0.280.ga3ce27912f-goog
> 
> 
> -- 
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c
> 
