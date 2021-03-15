Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DF733BFF1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhCOPe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhCOPe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:34:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8110C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:34:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id n16so57568332lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJFHgQj3Rz5NWDR4XSLYMVinHkl1IuvWsJnnQR1mi3o=;
        b=J/c5I95b0Hba1H+HkbeBYx+R2Rk7dFsvCoVzEzi3+2GnM3eyQu3OpehyaAz+HW9hQe
         Ldn06hcbwYPP0+HMNIrrA1Dwdf5sS8vIWDJoDuw3QLvYFZLZT4LHlXcAwpdpLyt6ofD2
         jOktV+J4PoWD/g19bu5zgmCRZW6oqbDRwW8sw7w12XO5kZnMnG5qCCT+mubiCdHspL4a
         Q8JFZJuKLz4G/SuT3FdBtjMrF3feGMs4gOYvdNHhpN+gNizyWDDz+aJP1bbmWjCLzD1g
         EOsDiK7OlGGWVJhfYstvNy4xkocD0V6Cc75qOQN8FeDVp6zY3k4Ki2ZO+KobFthjaJtv
         8moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJFHgQj3Rz5NWDR4XSLYMVinHkl1IuvWsJnnQR1mi3o=;
        b=gK1tCG3joRpDxmTsLaEk7JzoTtwnuWBC1J3p47RetOU15IwpUWaXWWxgPWbiyoIeZV
         qOqte0YlZeyTlJZReKO/wBkFH7LiIC9cyb45R1gTQpeXScLzuKRSxQAC/7M7uEwIBOYy
         jJy8aseFgrObfoWACTnA96NWvOhvHwaFwSGU9N1MYXAZKemjvh0ZW11bCcGODiaWDcFr
         5rXir2nG35nv9x9bCW69pdtL0OWhHJHRVQZk/3bzH0Uf0CgxaQs88NqZqudkEP8QiWMY
         qE+BmUpZbktNvrejk3wV/35G/ylM7tT1i/E6FM73BjMNEipikzxUgjz/59MlWBf+WL8p
         vFyg==
X-Gm-Message-State: AOAM533419IPxMS+dRw9/SvgapF3T5xkCPqyqSguM2esR2IJwcTosZrf
        BKt89Ucbesk9Nb5DbNVoohn6cbG4GRv+r+OQA1g2LA==
X-Google-Smtp-Source: ABdhPJyjJ697DuzYBqPKGfRJQy1wCGsisSNBPedw8isfy+DeNQi4QyEJS57Qs7aQBPxaqr20Enm6gNFFos+br2ql1YU=
X-Received: by 2002:a19:548:: with SMTP id 69mr8249366lff.465.1615822465329;
 Mon, 15 Mar 2021 08:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210306125122.15043-1-baijiaju1990@gmail.com>
In-Reply-To: <20210306125122.15043-1-baijiaju1990@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 15 Mar 2021 16:34:14 +0100
Message-ID: <CACRpkdajavmT20-w0Bahj_AvJRXQnfSiwkY-Vevm_dXD6VLaaw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ti: fix error return code of ti_iodelay_probe()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 1:51 PM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> When ti_iodelay_pinconf_init_dev() fails, no error return code of
> ti_iodelay_probe() is assigned.
> To fix this bug, ret is assigned with the return value of
> ti_iodelay_pinconf_init_dev(), and then ret is checked.
>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Patch applied!

Yours,
Linus Walleij
