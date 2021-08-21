Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA23F384C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 05:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhHUDRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 23:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUDRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 23:17:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA0C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 20:17:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r19so16710148eds.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 20:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6aNbqcjBaOkaEzDaZcIjKX0J8PPqW1VZdnA1qoYZ9c=;
        b=CvsAh4Tjxw5cegoOAFt1jRtELr2hF3++2k44uvwDSISoO9zLdPL2wr94vEfsMhgpCy
         YxXxZbLLVdJsY8MWmcTizFelcKivz9VvMnmMW8WW/vkb1N1v+6nZOGJxaD7h87wPmTNj
         98G94A4AjhiA8jWg18hha9sLZDoUQhF9md9PwOa3/6EDrGXAV6fV5vqe2JWvz7yOieIv
         hYw9PBeL+SKmA+m6c1Iw1dni8Bf9f/cODr5I9lHpumpPWTaEfQCVLhLXXeuim79grnpG
         j3AkUaPRD3N6nFMM564wGpfQtkGoJuwnR5yHeFR3GnWLycmbtgPW9CBL6+8nyQM12qJ7
         +RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6aNbqcjBaOkaEzDaZcIjKX0J8PPqW1VZdnA1qoYZ9c=;
        b=j4n1vPxn5zhA+4mS8PxQUYsibAcKA5US3uY0nijTO+Jr9vU+O8EZ0U4C4ie7WQCBdc
         H3UX/jbsZg+TbfT270MDAMMeH048qEJuWQ5UiGaHPuHIknEihsABFXPzj6Pfk1c446U4
         u9BmsN62i/EcaBqbuxzDcILxwkuc65CTZOslNz7A4TZDuf33pqWGqMtWZfzfPdl/thIA
         D6Jkikw0eU2QOeYhCqTF3eBl9ErJpGIvKRnNRFnrIzgPjQVgKGaKpKNdVPWuCay/81hq
         W/qrQV8xUm1hLhGJCcW0bbYePjCHjtKUkEifS922o1d4tH2LeybVOoEj1kWk2SPtC4k5
         zFRw==
X-Gm-Message-State: AOAM533fWLTPx+mdf5vmc34mZ6oKlro3SaUbP0RxTJVfVUpytSKx9vdx
        YVsIlPJ3h6lV/ctBLmO2Tu0=
X-Google-Smtp-Source: ABdhPJxr4nLIZNsycWxdRZzc2pgtLQM1MFBdBIyL6aiGCJ4AkKpLeiLvmc3l6SLSRabCHCP+fcT64A==
X-Received: by 2002:aa7:c94c:: with SMTP id h12mr6878620edt.378.1629515828181;
        Fri, 20 Aug 2021 20:17:08 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id q6sm3596876ejm.106.2021.08.20.20.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 20:17:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: Re: [PATCH] staging: r8188eu: remove forward declaration of Efuse_Read1ByteFromFakeContent
Date:   Sat, 21 Aug 2021 05:17:06 +0200
Message-ID: <5110838.kRcMR4ARJC@localhost.localdomain>
In-Reply-To: <20210821000508.79422-1-phil@philpotter.co.uk>
References: <20210821000508.79422-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 21, 2021 2:05:08 AM CEST Phillip Potter wrote:
> Remove forward declaration of Efuse_Read1ByteFromFakeContent function
> from core/rtw_efuse.c, as the function is defined in full directly
> after this and therefore this forward declaration is redundant.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/r8188eu/core/rtw_efuse.c | 6 ------
>  1 file changed, 6 deletions(-)

Philip,

It's pretty clear that this function has only a translation unit visibility.
Why don't you make it clear by defining it with storage class "static"?

Thanks,

Fabio


