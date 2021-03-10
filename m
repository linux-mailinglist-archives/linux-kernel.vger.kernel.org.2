Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AD0333811
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhCJJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhCJJBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:01:34 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FF2C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:01:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso10136159wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 01:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qaB16PQw24xlIFrYEulClcBoeMIlqgi74V6o4RBUIXM=;
        b=Pp6u8tAVpsFe8/arFtz1bS3nSi0dVbjy344v5rpc/CUdsUMHe5wi34NbTodqPpZlqo
         6KczB9cX1MA8i32QLBMhqWQ6OzNvTnZTVrwG85s1HW/8Gx/SGRm2zK1SR2IIEcUEob+6
         xIZCvj+mXPGCE+IugBH9B5CJ9K7CRiygxc2rfkm2GFI4PtWQfNc7OdZizid5LT32Efdu
         oWDu9T8vHDCZVv0XdQYnmds8iy+BEV8skMEaLeFMjlrSqONY0RKlv8oE4YAQS1n0X6Jd
         c4Q5Pz3ckZfO5fQN7Zsjcu96ySQ0DWnrQ4WfLnbwJzJs5fy0LQ5EMkNhsiljYt4VrNsR
         mVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qaB16PQw24xlIFrYEulClcBoeMIlqgi74V6o4RBUIXM=;
        b=VEOBzsgx6tBzQBxxBs5dGd/StmdtsMVB9gfJrIvx/AVvuaeVkO5d2K3qDukh1KRo6F
         vALR7A3YKNdihFGzguUhpHrD8A+UNju8RYfKFPoqHQ0Il2kqdb29ne8oFeVN/Ivjpiwx
         5qgYqRdWUJViVDEULlgp6eLcJtKC46Rh4PK4blA9YONLgMfN2d9Mh9aBZ3eIoPfijwuW
         AZk9h5orKL4ASOsLZKvrytGeKVr2bM6V8SI1b3QRf8yPzWF68kgZgVn+FIHq8j5r9oe4
         vXkSaSq+e2WaapF9CaNsO3j9F0OoitxHlOFWPM7dq2GoqKFauFe5/8/oVRznLEPlxGpI
         rW6g==
X-Gm-Message-State: AOAM530fy/1gXAAUIGdUtZiJp6KA6+VZ86r8uTMO7WtB0Ut4vELfRakB
        Fybp6iF17CC+xG9BwzvzTsprtA==
X-Google-Smtp-Source: ABdhPJzYn2Gyn+WDucH35Q3EsnautZCbL9NzqC3wo/UAfJQj6n2V7rLlHdXSC86jGR0pyfDeQ7ayHQ==
X-Received: by 2002:a1c:86:: with SMTP id 128mr2254273wma.41.1615366892195;
        Wed, 10 Mar 2021 01:01:32 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q25sm7699917wmq.15.2021.03.10.01.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 01:01:31 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:01:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: ab8500: Drop bm disable parameter
Message-ID: <20210310090129.GG4931@dell>
References: <20210306232227.2401176-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210306232227.2401176-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Mar 2021, Linus Walleij wrote:

> Nobody is passing the module parameter to disable the
> battery management portions so just drop this parameter.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rebased on v5.12-rc, seems to have been missed for v5.12
>   merge window.
> ---
>  drivers/mfd/ab8500-core.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
