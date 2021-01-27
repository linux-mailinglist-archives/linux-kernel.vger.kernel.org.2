Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDA3305E15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhA0OUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbhA0OSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:18:20 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E119DC061786
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:17:39 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id n7so1794389qkc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=xgrneNriPGg5dEDkiPR8ZwISgtJKtfMcVRnE4vAzyu4=;
        b=wsQpJbJwrnFBoofLk8KXpG+FD0EsmUkaxc4Nylsr12F3MOSm6NxWF2XzSem3idA4uG
         HhT6VmYppovxpA87VSfZIlfh8PGpg2jxktYW5TYS7NAgWKYDXHHHvpl4qNB42RJZRarA
         XqPi1MtMU0c/mu1uPLcgZwLYNWXzNUmglZJF1wRjfVdZhAMVFXPDUjo+bLg94Q6/TA0o
         G+LDsA5iLu9u6TW5JhQok08pf+hMC93j6MhLG/7CxdCOgqy+hPX7AJLayW3630I7NtAj
         t5wfyEuneHNfWMcQw4Tm6BdKnv+pTNDdvI6ev3NZtE+m5372q1sWKiDvGLIYDjHo8bUX
         9ZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=xgrneNriPGg5dEDkiPR8ZwISgtJKtfMcVRnE4vAzyu4=;
        b=n0xTdfgqKe/Zm7UCQLfoMWqMv2LeEb9MMpkBhmNlNPn+CSDgfhkWIU2jeYjmrsOXvm
         kX9F786fZWifVmtaofeHD7AyzOjucbmHooU7zfJqaY44oQ+DKyAaZTvfkrsVwAVqRANP
         RWB2kXuqzcrYffN00EmoVg0G/W5lM97KxkYd8tUUtKK3+RVaZBq4ycurioe9bNtTlZui
         fJZw4EQv+5QXCcTnOii+0ByfUCXehf91t93f1UhQOmDwdz6LgMgGiw3UaS8MZ99PJThF
         Cacb9oEvr3mkQ6d8eK6yH9JSvQ/mdX8sOqlw/IOxoAgt+S0jqhcZDpkXwXNAQApjsTw8
         WZSQ==
X-Gm-Message-State: AOAM531aTBCP/cSqy2oiw/HSMqeyhvPQziU4r1G/kBiQw4aXlkHet5me
        QKO6ukuVj2Jpqljb+sYCpikUnA==
X-Google-Smtp-Source: ABdhPJzWsQ7wMz4QVnx1NG/c5ml7ukIOD1gcs+yReAwLA/kWnmTpR8wmdkxFMxE1HgVYM6/wzMexqg==
X-Received: by 2002:a37:59c5:: with SMTP id n188mr10787922qkb.170.1611757059133;
        Wed, 27 Jan 2021 06:17:39 -0800 (PST)
Received: from xanadu.home (modemcable076.50-203-24.mc.videotron.ca. [24.203.50.76])
        by smtp.gmail.com with ESMTPSA id q25sm1262249qkq.32.2021.01.27.06.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:17:37 -0800 (PST)
Date:   Wed, 27 Jan 2021 09:17:36 -0500 (EST)
From:   Nicolas Pitre <npitre@baylibre.com>
To:     David Gow <davidgow@google.com>
cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: Specify HAS_IOMEM dependency
In-Reply-To: <20210127040636.1535722-1-davidgow@google.com>
Message-ID: <r830819p-o571-4nqo-qr36-15863r4791q@onlyvoer.pbz>
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
