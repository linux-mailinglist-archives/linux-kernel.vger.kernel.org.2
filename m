Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F343271BB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 10:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhB1JaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 04:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhB1JaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 04:30:02 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3587C06174A;
        Sun, 28 Feb 2021 01:29:21 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g20so7755715plo.2;
        Sun, 28 Feb 2021 01:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAazO+nBXMsT103snH4x5HkngEVfAp+qpt118APbvvQ=;
        b=pIlnhbit+gM35+aDuyaV5NeVvHNrbwwCD519PkxP2XwUrwEMWghbyMFj2G81Pemiya
         wlzNjlP+6QYBGITCINqjk5x/iXAReoRWjIsfEXuXFjT74VZ+AFjTWgfTN278mNbUb++G
         g780RJiEwZ73STzZ21Ik2Zi+8iTToUgEpapCgbASRnSpdvTD8pRhC160CeR/5ATUJgp+
         kqOvupwz6T3AxByYib9YrSN/44zOJbOD2dREGBrfkhmKOtwbs1ealfAV/F7oAkltP/BZ
         HX4X3DR/o1THm7otzSeLFrZLcpp3A9AK95tDeS9KDWIHhdd+BOUXJag4JvEphmqxlWoL
         BsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAazO+nBXMsT103snH4x5HkngEVfAp+qpt118APbvvQ=;
        b=dGTjgElEMzv+SNwQ1AqxA1xNMHCut3kRGeYRCemzMY82uA5MF6869TOALuIrJ3f+1V
         q/BOhLi2op98TfKLrB44OovQ9pV8rDFSIbZ7w2j6Jx3wAw5QTaRngJ114UsldxTdwqQo
         SwImZprATzl4JzDo9POeNDsEjRmok4SNoi3rOuZ/kYPSiYEURnJrnTeFqPlDfE8wQdZB
         phamKdcFlyhWK5uZrcyBg/OJjiwTcHF+6wPY0ERv3Bj8hl0rGb4U9/TiahoQFW6sGhDt
         0oMVeIPIiQIbOYXy16M84pd3E3Pg3wbD1QoIWo5EIXwJgsbcDvh+bqVXw/nVrEt5rsoB
         yIxw==
X-Gm-Message-State: AOAM530YuXwynqGQ98Mc+xWtwE3g15dHsA7KkwEEqBmy2Qj4tZDt1ZdO
        LRPHneCmAQlC4f6sGOs8icRUn1lHCQZ7jzzhKaM=
X-Google-Smtp-Source: ABdhPJypxMQC1yz70/Hvl5zwTafo+UQ9xLB4tEkstbtgsBQmBQThwJuOR5s0O5x+UIxDlfRP8+CuvUv18B18sZIQn5Q=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr12118165pjx.181.1614504561428;
 Sun, 28 Feb 2021 01:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
 <20210226141411.2517368-3-linux@rasmusvillemoes.dk> <CAHp75Vc8S2E0vWFcqK-jO9Nhd-Us_7t-aWNj-7k+fWDcqR1XkQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc8S2E0vWFcqK-jO9Nhd-Us_7t-aWNj-7k+fWDcqR1XkQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 28 Feb 2021 11:29:05 +0200
Message-ID: <CAHp75VfNHkJp-SMacKdaSuy3gDECs=u4BNMNe2KjYkrDiwb8jg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: misc: add ripple counter driver
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 11:07 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Friday, February 26, 2021, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>>
>> The only purpose of this driver is to serve as a consumer of the input
>> clock, to prevent it from being disabled by clk_disable_unused().
>
> We have a clock API to do the same (something like marking it used or so) why do you need a driver?

Example:
https://elixir.bootlin.com/linux/latest/source/drivers/platform/x86/pmc_atom.c#L365

If it's a DT based platform I think you can make it somehow work thru DT.

-- 
With Best Regards,
Andy Shevchenko
