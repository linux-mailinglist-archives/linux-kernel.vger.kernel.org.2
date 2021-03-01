Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0A132807B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhCAOPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbhCAOO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:14:27 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5842C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:13:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p21so25677395lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjJd3o/MlwMe48ArU7+US4+TfCoWT+j2MUISNRkW3PY=;
        b=xZaiqKC8/BHsuXDDURaZ2P4M3vbSp6MdHNCMCRcuLEPg8MDpcstcTodGAGy0TocsWR
         lksnBx0mzoCsYf+ZobS/eJKm1ZrPRyywrPJPqForzJ+x6VZVcxzNE9JG6KDcRED+spYF
         3GH7bIef1SSv77A2ODR3EbELMPCMuVRK1Swz6EZlTCHdfKD/iUwY5DfwbGOEcAqmYoyI
         gAGQlCM5ouGlX3L7jC6BCBQQ6dSIuFKx6X9rJUYK+Jd1WT7xAj9IMw1JHKl0gikTAZZa
         dmE5MncqWWVyEVPZtxGX2aVoR8KQPYIa+nfR7Qc/ZMpvVvBaPHXuqFPS0tEAaYqBuJRn
         gnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjJd3o/MlwMe48ArU7+US4+TfCoWT+j2MUISNRkW3PY=;
        b=Zx4tqgS2aEziU/jgPTbGYeJ+zatvT3eAjvV1mUe4TbaESPrGL+nmmt1jYr07TcbJ0f
         cmKH4rXwgX3czGQ7hfdLcHeWQP1RXGkE/00vMKkD8t8u++OfGwGouH6FLc5Vc9Oma+cM
         pp0TBYDm8tvxFO24LGCSU4IthqdGg5yk4pRTzqw+GCHHUHuaQGW73e9AxU4bnamK3bov
         skMKNCaJ2D9ecPB7Y0x+tJTV6cx7QI60JjUgl1h5iwOkgTGsTgsPT1opzPyh5j7EK/Cb
         eJ53bhUt/qtHnvONCoHuIIm3pWlYrjQ9qVVV9onzMMgRR+gUxK/eD+3pq0bkNJCzW4Pt
         D9jg==
X-Gm-Message-State: AOAM531CVSPX4PPsd3V6KJUe2Wx7j84Riw3Oav83+maOaNAd2x1LZ4By
        DjLT+DPdLYVRDbzA7tg+5gk0WQ+9G/4LJGuWU7OGrA==
X-Google-Smtp-Source: ABdhPJy1c3S3yJJfQXyJI9V/D7vsc4oSehquPrNH4w/6UrIsJywXl0E1e6fwdaIIxsg8NkYtwlh1BnhKnhZCA24fQpA=
X-Received: by 2002:a05:6512:547:: with SMTP id h7mr9894150lfl.529.1614608024158;
 Mon, 01 Mar 2021 06:13:44 -0800 (PST)
MIME-Version: 1.0
References: <63d610ba-5f63-2be1-6215-f44bd88d94d2@xilinx.com>
 <CACRpkdZEYqPU6Zr+a6fivZiz-hKx6-KVdYVR7j--y+k2KXZaPw@mail.gmail.com> <45cea3bb-6e5d-4005-ef2a-67b08772e0d7@xilinx.com>
In-Reply-To: <45cea3bb-6e5d-4005-ef2a-67b08772e0d7@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Mar 2021 15:13:32 +0100
Message-ID: <CACRpkdY=17xTdByUMdKfqCPS0ZcwMPC4w5EBaPrHgnEmkKYc-g@mail.gmail.com>
Subject: Re: DT overlay applied via pinctrl description
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 10:31 AM Michal Simek <michal.simek@xilinx.com> wrote:
> On 3/1/21 10:19 AM, Linus Walleij wrote:

> Does this mean that you prefer to fix how dt overlay applying instead of
> fixing code to apply mux configs first before conf one?
>
> Something like this? (just c&p patch below)

I think your patch looks correct! Can you make a proper patch,
make sure it solves your problem and submit to the mailing
list for review?

Yours,
Linus Walleij
