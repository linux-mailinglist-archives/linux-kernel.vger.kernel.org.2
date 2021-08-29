Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BB13FAB7B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 14:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhH2MtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 08:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbhH2MtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:49:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FD9C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 05:48:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lc21so24786749ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7r+jlTTOw/kHZNfLJXUEqsdPJdmMql3Pod1m4pzmZ5Q=;
        b=NRYojbaVZwoneKyzCwC4PqTG1+R+i6CMjPgxQN4zp7oLu5efi7GBF0kdnVe8vn/rnm
         VA8NtjT/l3cXlSe1YgXVvDktDo6CUPIYiuBHMVDdm5F3t/sD9H+sBG+1ZutNhajav9aW
         rCrWVB+BchQswaX3oB2Cm2S9SDlGPs/IYpwyG7oxG+HdURvWnkuBhQ85Zk/3/D9UBFda
         IeFoVeDnL6T1bVfpAvoP0fQez5UFmqhQOpSGujQiCjNtWcyxvqWuiiJiW4KpoDvE23Dx
         ytEwVdRpSoK483LtWZ1QpG9asrmYB5RYsxZ5kjTvbw55fgtlaChHxggXkepprW/ioxOj
         TjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7r+jlTTOw/kHZNfLJXUEqsdPJdmMql3Pod1m4pzmZ5Q=;
        b=TIRbXAmxx9/GCcFq+pkyK7HkGKEsMTmgtY5LDi2WaCxzKfAZSnNIdG/+tJMI+43iOD
         47MLEiC7eOCeDSjgxzMxtn9su6y8wobsjryhNcU2hOnvaaahTQMR6VKoBeUmjd69MGJ0
         o9eMIYl27dXuH/or8+RI9uPVATPxkx+MyBvDc/Ew2+6DJZda9VP+tg14H0SjZxaLVzsw
         crWbUWdWfOULosABdJsA8uZsgT8VfC1JIMLK3NGv59WWRSjAqnibWDQmMjaDvOQIJZ74
         VQ52w79B25E+YiZoQPNy/WUmSZO7sLvuBYS1eMfLqxhdD9E1V5L1pDwxPwSt7zDNKLSa
         O3ZA==
X-Gm-Message-State: AOAM531R90mA9FB56+/YawUjaUFpAbNjwsdJqd0VYxl6ejwRFLwbC+O0
        6bJctAKvgK1EIPkPRT2UAuV+68VlP24=
X-Google-Smtp-Source: ABdhPJwj/2aMWbl1wJy3iIdg6yMQrhoVdgxo312L9xENDD3XFzIXP8QDHVw5pDWB1Dchk2mk2Y0bbQ==
X-Received: by 2002:a17:907:75d0:: with SMTP id jl16mr20538725ejc.166.1630241293123;
        Sun, 29 Aug 2021 05:48:13 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id n2sm6273410edi.32.2021.08.29.05.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 05:48:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, Phillip Potter <phil@philpotter.co.uk>
Cc:     straube.linux@gmail.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: r8188eu: cleanup c2h_handler code
Date:   Sun, 29 Aug 2021 14:48:11 +0200
Message-ID: <3884124.htuf3bXTbR@localhost.localdomain>
In-Reply-To: <20210828212453.898-1-phil@philpotter.co.uk>
References: <20210828212453.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 28, 2021 11:24:50 PM CEST Phillip Potter wrote:
> This small patch set cleans up the c2h_handler code in the HAL layer
> of the driver. In r8188eu, this field of struct hal_ops, is not even
> used, so dependent code has always returned _FAIL. For this reason, we
> should remove this function pointer field, and the wrapper function
> which checks it. This is done in stages by this set, and helps get
> the driver closer to the pointer where the HAL layer is
> deleted/integrated as necessary and no longer a separate entity.
> 
> Phillip Potter (3):
>   staging: r8188eu: remove c2h_handler field from struct hal_ops
>   staging: r8188eu: simplify c2h_evt_hdl function
>   staging: r8188eu: remove rtw_hal_c2h_handler function
> 
>  drivers/staging/r8188eu/core/rtw_cmd.c     | 23 +++-------------------
>  drivers/staging/r8188eu/hal/hal_intf.c     |  9 ---------
>  drivers/staging/r8188eu/include/hal_intf.h |  4 ----
>  3 files changed, 3 insertions(+), 33 deletions(-)
> 
> -- 
> 2.31.1
> 
Dear Philip,

You work looks good (especially after having clarified a couple of minor doubts 
I had expressed in another message). So, the entire series is...

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Regards,

Fabio





