Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281D143662F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhJUP1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhJUP0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:26:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351CCC061224
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:24:15 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so56529wmz.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MuiEh406RA8ewbm/LRDAUTpTOz70UdaUTgVXuBltMqg=;
        b=tWzGEWNI5NsxKaFrEr3ZK3k1mIV1OKw0Jv/ZPSRn8Fx2ccegYfBUCegDkkYkT7/+gl
         amnYqDqRIP/Rw1CMRi/WxES4h3fzOTgzVI5IIGTaBjje/wYvDgRTXByRjx/jIgiUaPyi
         GejMwPA+QK0zdPrz2aOTDGeVxDQEGWOuTPQPvXdb8ucrqGphN0Q6stAsQcLItzTdPq2A
         JX75Kxwdvlu1yCDpOQyXZ1qTVVjdTHVYuQJ3+PGuhqKZt62Ke9Ghe2YujTyoZOtl3RuX
         BSAUDa0R+hmYfE52WvvEPZAc1k/19p/JcwHOskr7s2FlxdO8fgkNv2b6qrOW+GJRZIFf
         emNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MuiEh406RA8ewbm/LRDAUTpTOz70UdaUTgVXuBltMqg=;
        b=lIot7FonCz6hG51ybdzsnLVW2c3DQPrxKInXU22PO4sR+3bEZqbqu1Tq0sg8vBn5ff
         O3NENdky41k5tE1ZCV8pIWcOGeEseXqViIqLrmrzNkB3RQ2ZELvy/aTaI0OfNyCuZO5e
         0UhnZZB/TgpYwpCnc64H+sxbImzjMQG5bgUdhgfUu8RxIL7Z7rY3qsO2/fJdsyJQ+BRu
         4h6sZvE5LdD2lexNwjQA7xJJwAarEAOF88kLQWea3jXolKxq5jFhrzLVlHBFjch9eGDd
         kbTCWLw2mLPaJ+crc6iOubvOeIZy8IXMbO5IY0urV1miwJzpEdberWUFobSZtVMi1QlS
         9oXg==
X-Gm-Message-State: AOAM531aJDTvlGvYlaB8Zld//K8JX0cBqf300Ypr+U8YgdI7GSji4KFf
        Onh6Sia22JSLqMrllx4egZbwbtKvfgAn9g==
X-Google-Smtp-Source: ABdhPJxD1QL+iKWvkaXIhdIfmpHtBhSvVF5k70Ewb/GVQ+neD2JFHPyDgML6Z613LMMmaocc+4kPyw==
X-Received: by 2002:a05:600c:ac2:: with SMTP id c2mr21411612wmr.118.1634829854377;
        Thu, 21 Oct 2021 08:24:14 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id p25sm8124320wma.2.2021.10.21.08.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:24:13 -0700 (PDT)
Date:   Thu, 21 Oct 2021 16:24:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH] mfd: wcd934x: Replace legacy gpio interface for gpiod
Message-ID: <YXGGHL92hNs3dmNO@google.com>
References: <YXDEBCiSnXYRQPXt@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXDEBCiSnXYRQPXt@fedora>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021, Maíra Canal wrote:

> Considering the current transition of the GPIO subsystem, remove all
> dependencies of the legacy GPIO interface (linux/gpio.h and linux
> /of_gpio.h) and replace it with the descriptor-based GPIO approach.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---
>  drivers/mfd/wcd934x.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
