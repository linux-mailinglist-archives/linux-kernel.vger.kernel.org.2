Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40657416711
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243234AbhIWVHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243221AbhIWVHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:07:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3426C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:05:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p29so30949111lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1hcqV6Qzt0pQ9kEx1s6qRM+dwkJai1243cTRq4v7fsw=;
        b=bhCVDtDJ7G3jx+iEhZaAypYBuibBW9x4lfLkninPisvzsFJlfCr+7ZJPcxyVNBp39M
         3m1OY0hG8IQj/8ibPTkzr3l2I8zC4/AwbiRrJ27NVVGo5xIVfmR55MGi5mq03Vsk6O6V
         wiF4Mi4S5md7+bVLuqAzgA5PNbySvkFVhuzEExAJMt6YpypsR/EkHnWS3ht51G8sxnzb
         RXza7MbN6aV2LkHMqNbc0qS4I+GCT/ITFNd2dshYgqXVSx6j08veFZeSwCRQ4/CxYS2S
         v876tQz/SNvzX9AtVN9NVSio5m/AzUNHQN+dZT/TxwoypNgiX4wQKUJHdCEs5ftOgu7s
         Iyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1hcqV6Qzt0pQ9kEx1s6qRM+dwkJai1243cTRq4v7fsw=;
        b=r72aIX063jB5jecyFaHyudbKUBr1nBfcmKByGNf7H2u66gqJjAATXjMejK27D3TpFm
         rN7SL8Yqea3YxT21a3ilyW8ip4rR5qW2vom7jwHkcREp/VUzsb6GsPW7rf6pSvsXED7u
         Q2Pkq3fAjvJVX4tUqcp1DXQqZxSNmv8pGYAOvXjfjfKa7Xs7m3MjTzPsQ3YoaYZYyAiQ
         6O9QjbxLMMjiVnnmIFjLkezXd2qNVr0L4qmpICcDf1zc9LUaXURGp7t+YfxP3PdPmyLK
         bjVn0AU5e+RSA+5clHOEfl/g3D9sC/w/CobXVP0u/APkCVDWDgwp0o7zHqxYr0T7kfO4
         kAFg==
X-Gm-Message-State: AOAM530Be99YRRuaGoz5Bpp4CyBMIrPTIXpu9RKcAodtzT2hVg12/E5Z
        OzuAVZxCy+jz+nuDcWIxXKgpLeuY4KKfmcxJ7Rq0TQ==
X-Google-Smtp-Source: ABdhPJwRIeRla05ubM9eMdkjNtIMsq5xI5mQHmVr6z5mnvde0xid3DWklcEeU31OchbZm/AF+jkPUVOqFaB1aOaEnLg=
X-Received: by 2002:a05:6512:3c92:: with SMTP id h18mr6039663lfv.656.1632431126153;
 Thu, 23 Sep 2021 14:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210922195656.1822268-1-linus.walleij@linaro.org> <f183c017-7a60-bce5-a440-7010ea3d90b8@kaod.org>
In-Reply-To: <f183c017-7a60-bce5-a440-7010ea3d90b8@kaod.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Sep 2021 23:05:15 +0200
Message-ID: <CACRpkdareKNQndBDyPE_oHE0RgUcSfutAR9GZZhiNAWNQa8whA@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] clocksource/drivers/fttmr010: Be stricter on IRQs
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 10:11 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:

> I think we should start by dropping all the AST2600 code which
> is unused.

I don't see why, the hardware is there is it not?

In my experience it is unwise to try to system manage the kernel,
decide what hardware gets exposed to the frameworks and which
does not.

There have been instances in the past where we have first said we don't
need another timer on the system (so it is "dark silicon") and later brough=
t
it back because it has some upside.

For example for a while the Ux500 was using clksrc-dbx500-prcmu.c
exclusively because it was the only clocksource that would not stop
during sleep, and nomadik-mtu.c was unused. Then we invented a
way to grade the different clocksources and switch between them
before sleep, but tagging one of them with
CLOCK_SOURCE_SUSPEND_NONSTOP and giving them the right
rating, see commit bc0750e464d4.

This was good because nomadi-mtu.c has higher granularity and
higher frequency when the system is awake but clksrc-dbx500-prcmu.c
is always ticking, so each is used for different purposes.

Lesson learned: register all hardware with the timekeeping core and
let the kernel decide what timer to use at what point and for what.

Yours,
Linus Walleij
