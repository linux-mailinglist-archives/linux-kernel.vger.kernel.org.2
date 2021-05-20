Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A16E38B7A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbhETTfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbhETTfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:35:10 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AB2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:33:48 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h24so2255143qtm.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8G0uB0F2NEQKNMVrVQoid1N5+N7dmGBlMzWRHpJEjE=;
        b=kDONrh86vDKBFTcyz1CD3cz/Tb0aQ+GqykCRp/E8pJqPhug2KqL60svLYIqdu2WlFh
         kAcCc1V39WMLTg1+IEWvEGQ7tkkWqvTGsgSOq26jxTM5NjJ5JnfXihyBfEfa3S59ANBo
         lscZt3x58JxvHz52hU7MixzSVaR9ISakHYEJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8G0uB0F2NEQKNMVrVQoid1N5+N7dmGBlMzWRHpJEjE=;
        b=rBjSAWivDJfI0dH19qDKi30cNZ/9jjBNx/iUiM+5tgALsA1rk4nmyF+D4A8TWAapKJ
         mBixKKlANY+ktaywz0eoIjDfeSd/Amdi9+gL032+2l5PbLTkkwtaVy1l6YB2Oj38Bxwx
         65U33PIyi60nuyluq1LRqkDSOyaCuiIUVooAS4sp6xqrJXraABV6PY7003DTHnjbMfiC
         toMmQ/Ra/Sn/2XDUEPvPPpIp/mmYYQx0nXmelY+odGMlmEOhWuBnJiLxpCmJtFQy4vpl
         yH83OwUTBwn4ZLxv3RjPp58hvW8DTlduHDfSxPd2pbC6iSQRXjmbZ1N9PeUeZ6ezuwxd
         ivYw==
X-Gm-Message-State: AOAM533RhOJFMQbYHwlpqJwyV+7jQelRhpde2HhK07aEu9VR4wAbpt/m
        d9a+1iBSlXTHTHfOBi5jeKuMrx2C+4cUSg==
X-Google-Smtp-Source: ABdhPJwJgNY1RrIIMXrJG+2liIfJRjQKkU6123BGt8pBXJywMel/XdRYNen3sI8tmsrjUR1YcMMt/Q==
X-Received: by 2002:ac8:5a94:: with SMTP id c20mr6742372qtc.353.1621539227646;
        Thu, 20 May 2021 12:33:47 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id p10sm2842825qkg.74.2021.05.20.12.33.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 12:33:47 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id y36so7753925ybi.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:33:47 -0700 (PDT)
X-Received: by 2002:a25:4252:: with SMTP id p79mr9576627yba.276.1621539226800;
 Thu, 20 May 2021 12:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210520190105.3772683-1-lee.jones@linaro.org> <20210520190105.3772683-3-lee.jones@linaro.org>
In-Reply-To: <20210520190105.3772683-3-lee.jones@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 May 2021 12:33:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJQQpa2BedjrmPFBebVY1Ay6=CFLmBhFFCV5ZEaQsq3w@mail.gmail.com>
Message-ID: <CAD=FV=WJQQpa2BedjrmPFBebVY1Ay6=CFLmBhFFCV5ZEaQsq3w@mail.gmail.com>
Subject: Re: [PATCH 02/16] i2c: muxes: i2c-arb-gpio-challenge: Demote
 non-conformant kernel-doc headers
To:     Lee Jones <lee.jones@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Peter Rosin <peda@axentia.se>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 20, 2021 at 12:01 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/i2c/muxes/i2c-arb-gpio-challenge.c:43: warning: Function parameter or member 'muxc' not described in 'i2c_arbitrator_select'
>  drivers/i2c/muxes/i2c-arb-gpio-challenge.c:43: warning: Function parameter or member 'chan' not described in 'i2c_arbitrator_select'
>  drivers/i2c/muxes/i2c-arb-gpio-challenge.c:86: warning: Function parameter or member 'muxc' not described in 'i2c_arbitrator_deselect'
>  drivers/i2c/muxes/i2c-arb-gpio-challenge.c:86: warning: Function parameter or member 'chan' not described in 'i2c_arbitrator_deselect'
>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/i2c/muxes/i2c-arb-gpio-challenge.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

No objections from me.

Acked-by: Douglas Anderson <dianders@chromium.org>

-Doug
