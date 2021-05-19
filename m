Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50F2389101
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347938AbhESOex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243352AbhESOev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:34:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A780FC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:33:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so3595746wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DCQ/kFDivgK7GQNYhLKETXZZY70HNicwNr4SprqTshM=;
        b=thuJugNL923dMzFnEsVGIaIZZZrP03SU5WUwFJ/UlId06Fx0wC6czVpNH8MRjBrVSH
         Fw8hYXX9gbUBKkxhZupMKfoUnEiSlS+eFGv6OO33TLzo37AfZaxLMXQyPvdaGVrPAEYl
         CP49oxYDuaVorakDyLwZExpae5Z2LY0E1rD+AlhDeq7o7KctgMKZn54BiGptgXqaaF2I
         sO54wDuqUU/+iFx+/PASGI7pk9Szld6LZf50aDCv/nlUIYbK3z60Mk4Y8270ZqAb5/JO
         a4zp2vBSKO8uZrejZTUQa+FKV58G5yoRd3C2teZ0nEdcxOzc24Momse6vpHa+yZ0de8r
         U0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DCQ/kFDivgK7GQNYhLKETXZZY70HNicwNr4SprqTshM=;
        b=sOdgBfpSZx3/qEaUPzhdUHb8VrgC6Up9SrBHm/FuHlW1E0Gi6b4a8tVuoqvUgJh3pu
         4vmCLJGv7csunYOBbNTIowF9lr13vuJU0qdWkPi5B93QdrLfIC27ZpMRjw+X6aB8uPky
         QfWBtw6sOUcBQuFmw+ZKZVgetITZkGCnNHgNrQYUV54GKw4YgXdNN99oCzeowWj/RCAz
         DeUKslXUkaNE3kjaHGwSmCcEjw6Ia0Y7Zeka/aIiUtCASq4tyTX+HfSwooOR1Nw7Bauf
         olPPb4tcXbZ8HLG6uXUvrJJcEfCBtt71RI7i6H4pgo+4Zepv8KtdAlsN26F2v2XUE/Lp
         NQXQ==
X-Gm-Message-State: AOAM532lRSlvRwzXvvAsyXhAPV/pwSTUpHahDhiZuAXfNOmFjnGJUyba
        5mU6hYvIaARPYxaMKFKnMlHqFw==
X-Google-Smtp-Source: ABdhPJx4JB1bRalzDlI4ShWWTZFpYU2OBLRYrTfkbbKxLsPeJCa1PyVKw840yKYR+zYU6HfFI6ZKhA==
X-Received: by 2002:a7b:c742:: with SMTP id w2mr11918923wmk.76.1621434809298;
        Wed, 19 May 2021 07:33:29 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id y3sm2894271wrh.28.2021.05.19.07.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:33:28 -0700 (PDT)
Date:   Wed, 19 May 2021 15:33:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v1 1/1] backlight: lm3630a_bl: Put fwnode in error case
 during ->probe()
Message-ID: <20210519143327.GE2415519@dell>
References: <20210510095716.3302910-1-andy.shevchenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210510095716.3302910-1-andy.shevchenko@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021, Andy Shevchenko wrote:

> device_for_each_child_node() bumps a reference counting of a returned variable.
> We have to balance it whenever we return to the caller.
> 
> Fixes: 8fbce8efe15cd ("backlight: lm3630a: Add firmware node support")
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/video/backlight/lm3630a_bl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
