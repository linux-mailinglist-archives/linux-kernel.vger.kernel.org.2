Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04729333814
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhCJJDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCJJDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:03:02 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAABC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:03:01 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so1319361wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z6feJLAoHUrDN/cNoVKWHChNpBG9zy+iccxkVz6KwXE=;
        b=VfS7rDSX+fod08IztcKJ+sCxqGyzF31bj0W2PhizjKBdBU/c18ibe3MpfhQnPa0Zeb
         I06fvbSn5dJP+Yoz993fiZj6dE7X+w57ATo6/Qt3DbEUZkTD9WYGJjky31BPvpOIZlXg
         ekClKziVsucCOAQLBavr740N/ndqTL4vEtiWaXKZt4fktBBnanKoUHmEgN7r+HEMiY8N
         h7GXLv5pXkkz3xOjbB9tpgWmE3uYK68JUOEc2bRKRxLbEQrD/f0onZ3l1QGVjixfzfqe
         bKJAbeq4/fbSXcuvTYHFCZRIBJjzLEd2XaUsXoIt09D7eSHTdUQJLtE5j4QLgYUyZnVc
         PmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z6feJLAoHUrDN/cNoVKWHChNpBG9zy+iccxkVz6KwXE=;
        b=SXV12GAVURhxQfraBtyZqYsqyl/cp8rPrqkjNpagacEJfNcRjiU9X3d2h4tz4CvSLq
         AtIzPGzhzeccVQ4KnmEVXk1oozVuhtZxWZEyRSa8pBfErdjipVsh6Cgf0FPL6/n+lfY5
         H3gcw3Hgscewj2kqclH9SPL9KlHOfgThvxSU5uBn4JoNzsJ0rnVlGSFLfbe2+QbOQiA0
         XfMJ4JZXAot8dJSCvfufZyCQj9e4m0XfEokam/PMT0fa/jibmbiETZWildiLWyP8bZhR
         Oi/gQPC8nHRLja/ns7wxnCx7joWtRsfbG+N+fX+743XyNAk+tl6HtzhSr472L5UXaYK/
         u9rA==
X-Gm-Message-State: AOAM530a0KEH9Dy06chfpkt2zJE1IPONr1ZmpGZKZPhTQ0+XMeHP2Hf1
        pL3nMPFVzTkT1oiAqAhALr9Zew==
X-Google-Smtp-Source: ABdhPJy++VWHbpQCd9Jz0mmTj4Mcxy5N7VBPHtJ5o0Ke2+dbAQoFgxNnIHzK5qKchPN8kE0DlVQRqw==
X-Received: by 2002:a1c:3c8b:: with SMTP id j133mr2264521wma.164.1615366980765;
        Wed, 10 Mar 2021 01:03:00 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id z1sm28409626wru.95.2021.03.10.01.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:03:00 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:02:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] mfd: remove ab3100 driver
Message-ID: <20210310090258.GH4931@dell>
References: <20210307202441.1955498-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210307202441.1955498-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Mar 2021, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ST-Ericsson U300 platform has been removed, so this driver is no
> longer needed.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/Kconfig        |  26 +-
>  drivers/mfd/Makefile       |   2 -
>  drivers/mfd/ab3100-core.c  | 929 -------------------------------------
>  drivers/mfd/ab3100-otp.c   | 240 ----------
>  include/linux/mfd/ab3100.h | 128 -----
>  5 files changed, 1 insertion(+), 1324 deletions(-)
>  delete mode 100644 drivers/mfd/ab3100-core.c
>  delete mode 100644 drivers/mfd/ab3100-otp.c
>  delete mode 100644 include/linux/mfd/ab3100.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
