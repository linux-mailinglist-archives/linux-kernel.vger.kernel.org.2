Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA1C3F3F03
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhHVLGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 07:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhHVLGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 07:06:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4121FC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:06:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bt14so30445056ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/K1zJt9K2vM4YNNzqxi4TbMv+urfoGymzw1sNlJiRY=;
        b=AX55T5qy7NO40os7OlBFpccap583qZZmZt4H4RNz41wp2sjxm0BQdKU8VJ1dyE21aM
         4l27B2JJsOt0eL+0Cie02TTqnEs1b0WGNPKLIgNM2j8FHDtLUV6m4729HjDbmcuNh2tT
         p/l+dqSYDPEUfRbC1Fp9QsQSwQ5mzWSXuvAD72/LzVDRrjBSoUQc7EXH3vUUfztNQYQk
         jx24P8gwXO5bT33pMIbCOD4TT8IlrZCxQbpXB9JTcKTS30zlRDOpuRzSbgbRmg0flqZk
         NbyHmVHONiTeNk1Hs4GMm9B0GXswMRdxoB7C5CIv6SqkFPzcdsAB1q3C9BuQLvaqSRTd
         MM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/K1zJt9K2vM4YNNzqxi4TbMv+urfoGymzw1sNlJiRY=;
        b=IeL0rnhfCkA6V9j4yNoE+/NLpkBfTcVyf0g1yMETkWeanANcp2AAwYUbSF2qy/487+
         vWVKDgbJa/xy8D5BGVHO7LI9+ORSZ2xp3ZiC1mMKeVmd3QskydseQjLzd/uxlPL8LdP6
         3LWZcp/yJVwFvUJYaxToye+iPAKkrcXilr7u+v7U1cqQoJgwsgSVIJ/z30IK8rcqYC5g
         aZOKESCNmkeaJdhLxldJNMcb8pBM1UXqVk1qNyYV+Iwvs7oJJ3bsxOgVvYdHinOCxSjI
         EMRD1oBkWeBXj2vjfQlIjXqKHR8nnt9Apoe8IZekvKBXozOHA/xKeURs9IwYJ65AqpZM
         dt/g==
X-Gm-Message-State: AOAM533qb6JR9iWG+0o7La9kBI20ED8Kdw/vGvynVcvRxbA/CYjKGGtP
        PxfYujFor903wuN5lezJ4Ic=
X-Google-Smtp-Source: ABdhPJwNyBU6A/Uc3oCrD+++ujwNXshWTb90/l4LeX9WrRGPjk2SOwIQsxCGb1MDnAtD10kk4CpyQQ==
X-Received: by 2002:a17:906:eb53:: with SMTP id mc19mr30478652ejb.22.1629630371782;
        Sun, 22 Aug 2021 04:06:11 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id g10sm5580146ejj.44.2021.08.22.04.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 04:06:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: core: remove condition with no effect
Date:   Sun, 22 Aug 2021 13:06:09 +0200
Message-ID: <1821445.fzUCeO1EU3@localhost.localdomain>
In-Reply-To: <CAA=Fs0kByg1NztU+Nf__RUzTHuVh_q2hvcyh+3JqXiVgn+_VeQ@mail.gmail.com>
References: <YSFgrLUfXzgcT6k4@user> <CAA=Fs0kByg1NztU+Nf__RUzTHuVh_q2hvcyh+3JqXiVgn+_VeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 22, 2021 1:58:10 AM CEST Phillip Potter wrote:
> On Sat, 21 Aug 2021 at 21:23, Saurav Girepunje
> 
> <saurav.girepunje@gmail.com> wrote:
> > Remove the condition with no effect (if == else) in rtw_led.c
> > file.
> > 
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > ---
> > 
> >  drivers/staging/r8188eu/core/rtw_led.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> Thanks for this, looks good.
> 
> Acked-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Regards,
> Phil

Dear Philip,

Before acking, please check at least if it applies to the current version of 
the tree and check if it compiles without adding warnings and / or errors. :-)

Thanks,

Fabio
 



