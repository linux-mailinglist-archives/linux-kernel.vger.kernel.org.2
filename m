Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ECC3E9B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 01:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhHKXzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 19:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhHKXy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 19:54:59 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D42C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:54:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k2so4839263plk.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Y4/3fSf/KmbpyyGbeX2xJ39stxqbAErUC/okq2TDDk=;
        b=L3rnIL1slWAx5Y0hA4TCkr+OsTOuLk/bFjLK9EkWCAEu5FLK9xCkU6IqxwBFvcA45O
         DoRehTlcd4qcd/Fy6DSG2E7MNx+G7lEVIj3/cuD33zPD7XCBhAZWzqt4ZOosP0xjjxIH
         peeF78xQT8tdIXZbwhUqmzDNInzRAl/5rCSI20/1t3/q5eMMpFCyrV6KcA2Q2FW0pDhV
         b5JnJ3Cn0G09+LOSvBJkQegO6rYJUm6sEib2kC8g+ybB7lvIrw3BXIMQxMGXF461ArLg
         Wf97Yu+wlMgAQQqkwGNeCLiL+X5CvbKDVqjvUl6noDaqmyVajp67+BF5PmpEtjwQF4Mi
         cHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Y4/3fSf/KmbpyyGbeX2xJ39stxqbAErUC/okq2TDDk=;
        b=JGGSDvg4zaOPDnyyuBYqv175GvYj0nAZV8efzaPVtrSRTm55Z8AuXVAmW/CDstWcgG
         4Az61Kr+Xu0cBzzbHkDov/HyDoAILKs9DZ+1t7ghxDsgEGp/8mApSKqqxyRI5QaDSjaw
         TpUX26S3ng4BSuzRHCELmxf+rumFP9+aNdIRJ1DLxG1pddaJIvmk32FYF/5YUeSI2q3N
         TGf4rCHM8tznCkkMTyNMTbo0LwVrF9h/R/r3xwSpKUHn/k5++3Fus13lCHHw5w8B6VVg
         C29zfecwxtUUDjJyW21l0J76bFITriDXo0NcehT6nJ2Ic67AUcni5EASTbZgyU4X3kqf
         ZswQ==
X-Gm-Message-State: AOAM533HE+TSuQWxSpucZS3z1HgP2Q0onydPNskfsH/LP7PwosJtpB6U
        GBMcy53PAQ2PGyJCRzXD/Q5PPDR1bQ5U6v16rv7FQQ==
X-Google-Smtp-Source: ABdhPJw4+nymE93DzmpNsy3fsXtqpKUg7uzbJ1hfJjgXx9prl+Z2EY4F0ODmxoroDl8DlW0pmalddj1/h5vKzOLFKOA=
X-Received: by 2002:a17:902:ac87:b029:12d:3e59:cb7d with SMTP id
 h7-20020a170902ac87b029012d3e59cb7dmr1257600plr.22.1628726075469; Wed, 11 Aug
 2021 16:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210811201450.31366-1-martin@kaiser.cx> <20210811201450.31366-5-martin@kaiser.cx>
In-Reply-To: <20210811201450.31366-5-martin@kaiser.cx>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Thu, 12 Aug 2021 00:54:24 +0100
Message-ID: <CAA=Fs0=2gSn8_gECcqLJtXSSzzbA5=92pU6TAyYQdmO+ggMOPA@mail.gmail.com>
Subject: Re: [PATCH 5/5] staging: r8188eu: remove CONFIG_USB_HCI from Makefile
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 21:15, Martin Kaiser <martin@kaiser.cx> wrote:
>
> We already depend on USB. There's no need to set CONFIG_USB_HCI in the
> Makefile.
>
> Some other Realtek drivers use #ifdef CONFIG_USB_HCI in their code, the
> r8188 driver doesn't.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
> index cca7a58c5f29..6bd3a0590aa3 100644
> --- a/drivers/staging/r8188eu/Makefile
> +++ b/drivers/staging/r8188eu/Makefile
> @@ -4,8 +4,6 @@ EXTRA_CFLAGS += -O1
>
>  ccflags-y += -D__CHECK_ENDIAN__
>
> -CONFIG_USB_HCI = y
> -
>  CONFIG_BT_COEXIST = n
>  CONFIG_WOWLAN = n
>
> --
> 2.20.1
>

Dear Martin,

Looks good.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
