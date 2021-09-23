Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069CC4167C6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243414AbhIWV6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbhIWV6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:58:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202DEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:57:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i4so31904528lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7hRdGiC021i/g7N4xWzjVg/GPI6/GDzT+9QzDnFO8Y=;
        b=Pua8W3Kgg6VG8BrtF7eBDdmp5plahxHNaoseKra0+kYMbYVYY3rwpH6/WAxVOiNNx0
         Mg6a4bGR1oeSkG/0r02Rni4fhLjkRb78indwzpQWLYaAO20lJhu9RYu4SpBX7oHILKp+
         wFYgZyFTSwWAUfUwtsjPMXe/ynjeq5jrl+N58kQXfTIa6Ra5kVCVajeFcmcrgTBycnRs
         J5kY8dSxW+zdqMUXkcfcsFKxqZ7Mk3PYuRRW8ViSfbsBc1ZQPMeQmS+iWyfLVFddGqV0
         kdTE450ztbCr81eskwmycMh8ZTtW8Xeh2BrXzmKhUqpXf+6bXpE6EYTVtYpQ0mnzh01W
         9/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7hRdGiC021i/g7N4xWzjVg/GPI6/GDzT+9QzDnFO8Y=;
        b=pdwM1YmGvE0FZtQy7tsD485+o4/4DPESZW1DAKI6t7QndSte48GLOR7iZDp2HqRr3a
         KFMVnkztauMpcpv2xY5xVuwqtaCJ6z6yobDfCiVcPQTRTaYwK6p8Iy3ThZ3OunBY8aSZ
         a/kPyL0gJ9pck5SmBzJv8wNnEXTfxJ/Yd9AGxtB/9ei2yKN0qEPcicDhgsb9ncUWSE80
         vcH0hanjCc5k8SngFnt7NH+Aw8D/vTrcfr7S9JJSXBgx+t2rtG5Z4RSWSoj/pFtLmuMe
         zb5SBwCl9x6rLJ6JetfcuNw4kYpOj7jnAwswiKJmQy5utnNuPjqpVQ/oFA/GG+MptIPY
         LXeA==
X-Gm-Message-State: AOAM531vuv9oL+qqI6TmkxkgbyYz5650Z8HYoli/r0TrGlsNql4x8s4w
        bPlSJz4uw1/Srhcy5ygjXvjYjOQfai1dnXKCvpzG2UkHs6U=
X-Google-Smtp-Source: ABdhPJzBmuDlnoQWR8jcwCyn+uco4wztn+4HuUBoIiiu9XwVf6gmiepKevdbI0TsquhWmZ4kHEvRUPUak2Zm26FnVM4=
X-Received: by 2002:a05:6512:e82:: with SMTP id bi2mr6233660lfb.95.1632434229490;
 Thu, 23 Sep 2021 14:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210918054630.18544-1-caihuoqing@baidu.com>
In-Reply-To: <20210918054630.18544-1-caihuoqing@baidu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Sep 2021 23:56:58 +0200
Message-ID: <CACRpkdY+AmyhSDMM2hgcnv16+reLJornsQMemd+=8b-jSd8AKg@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: intel: Kconfig: Add configuration menu to
 Intel pin control
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 7:46 AM Cai Huoqing <caihuoqing@baidu.com> wrote:

> Adding a configuration menu to hold many Intel pin control drivers
> helps to make the display more concise.
>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v1->v2: Revert to "select PINCTRL_INTE" for PINCTRL_TIGERLAKE config.
> v2->v3: Update commit message.

Looks good to me, I expect Andy to queue this and send it to me.

Yours,
Linus Walleij
