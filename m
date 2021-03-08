Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C6D331065
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhCHOID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhCHOHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:07:32 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CA9C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 06:07:31 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id e23so6127255wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 06:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=M7jM+0OrLB6QVDekXKRCuxohSVO4XVKq9e2g8QLuZEk=;
        b=JKj9LoZRxAfQh7cEqSLhIKQh/UA1UElKuo8gXh9cdrgdlqG7SRxWSmc8HrJjFa3ZbI
         kBQo6E30YZQ71/IGFjckY+/grHawNmWlCn0d9nRQ3PRyGtxSX5OU3EQ60Vl58DFHvMob
         6Ao78f0qkPNCRSU1U/7k2eMqkBaIhqnLEHwh8wMfWEqRV2KFkpZml7Zz9e/Db2414CuW
         Z+S3USY6kEQHFezV8HtuQiajbOogXx/OyDwBQp5rJQDh99WllmgdcPE0v3MLYt1N1ohp
         q/E340akbnY2t4IZmkycncvaePMiJJgqAlusSBYhgkZjvWcHw3Ulx0JQ9ed6zkTp7oFB
         Y96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=M7jM+0OrLB6QVDekXKRCuxohSVO4XVKq9e2g8QLuZEk=;
        b=p8IR8bPOhJ/ZoPQRF723R/CUv3JTGBEuaFzG+MjLlKlNFbwaFY7vMU1rCnJbyl5BAc
         BNgCujJR+CowBN4ur5knYUVZJEmr0l+SgwHZQw+utfIJPcrwoCfSt4aTuVJXyXcnQXRy
         T5zFkoxpPpEoznR8DdGU4m/eQj/wiq2/7MpPHRUVvWhvg9arCIPUF+Tpar+lk7elXJCK
         VMWVv+TOuc6maB9pqz0EBLAJzzQYd8OF8CwVmev0qS/rTO3rXAs/3/SlKTYxJHpDGR6D
         PQGedVUlbOakr+KZtWLWymQwYQHuQW1VbU1Quy3F2CkwjbNPpcqA8g3UIbPHg8M/CQd+
         1Jng==
X-Gm-Message-State: AOAM533Ti476XTiVhFYFON6PKwEG/aJgLozdCDtR1K25oSToHUwQHMMx
        OpUEc+pxJLdl9PvwLSzdHCBfJg==
X-Google-Smtp-Source: ABdhPJwrfpHBVYwqwNBazvKTeYv7H+uCi1xwvL7RQyspYP5YQia6RfoUlYer3crNxyAHHHRkl2Tb9Q==
X-Received: by 2002:a05:600c:22cd:: with SMTP id 13mr22002039wmg.90.1615212450276;
        Mon, 08 Mar 2021 06:07:30 -0800 (PST)
Received: from dell ([91.110.221.130])
        by smtp.gmail.com with ESMTPSA id i8sm20864325wry.90.2021.03.08.06.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:07:29 -0800 (PST)
Date:   Mon, 8 Mar 2021 14:07:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mfd: lp87565: remove unused define
Message-ID: <20210308140728.GI4931@dell>
References: <20210219223910.1831-1-luca@lucaceresoli.net>
 <20210219223910.1831-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210219223910.1831-2-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Feb 2021, Luca Ceresoli wrote:

> This define appears incorrect, but it is completely unused so it can be
> removed.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  include/linux/mfd/lp87565.h | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
