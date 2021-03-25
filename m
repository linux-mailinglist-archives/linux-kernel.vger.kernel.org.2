Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D408348C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhCYJKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhCYJJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:09:48 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A071C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:09:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z8so2125722ljm.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fD+LIEu0R5nVhdUU26o6lqN6Fl7nr7Epf4Jg3Ov3Bwk=;
        b=jFjCK4vR+0lV25z9MhWSae1IQ3l5w5byPoP7RnRVDxpqkcQpXya7+X4rYaauQh9G6m
         L/or2pE45aRmR529pLpbAQGz0r5oKuw8gbBATaYxKFdQPrJ7wBfxKlIQsM0yTAljvusy
         Uj/+HskIg6/sv8uVIlcTV/yM9yYE3l9WuUfG24hqxk/H/WysW+p/3eaQE9+tppCG/+Cs
         0KPK0PdArhyc2VMPYi2S2bIM5ERIFAHGY4yrTX3bz1SU5evc0LeER/Ysslnsr6zVaQSp
         s6ot6LVTsXdz7km6Q6cc6Hm1+jSwoS2soeueswnatNuwkIEjtUENR/PW3Rd/XTgwws9u
         bcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fD+LIEu0R5nVhdUU26o6lqN6Fl7nr7Epf4Jg3Ov3Bwk=;
        b=iGlmJ1zBQMUQsXqZO7ZbFHu/g/JyIgmwrYpYwuqmgYRFgUWJ2fnnRJdrD+iDstI2L5
         esLl/w9EA66jGMVp9iQ2H+XmKuuo8mrP9NtunUIVMOpGeupzoFs+DSiU2Jtz3scXQhoW
         eIUh9jixCQEUa7fx5dr3eoIIokq7O5+AnOCozRdD+gkTrnOXiLoe5R5T4r+2FUwI7WYA
         hu3U1VYNjhKTNwfA0DsswyhqHH3Yx5OMIW+Mlt/U0QzQ4Hc3j3EPVqRx98VkyyR1ZNOg
         UV6GQ4//k5/JEbLyy+L/x6ooBUFVLyJxIgacHW4edSSihANdmGh+icfdnsy1clpQR+9V
         bogA==
X-Gm-Message-State: AOAM530bvxPW+zVgmipqCL5u/G0lkhBm34t0p8zFLpoDmiMVuQm+hMjX
        J2di6rAXanGeU+RwjErEqbTGJmwUM4qlwWYcyvaKxg==
X-Google-Smtp-Source: ABdhPJzZvpJeljwiXTFmZoV39CHRBO4V5vfjLvvojpJhktZa9a+pn7juDdzFkwRKwZ5KOSRPqScnn+GhL10yQKBWf1k=
X-Received: by 2002:a2e:9cb:: with SMTP id 194mr4896039ljj.438.1616663385773;
 Thu, 25 Mar 2021 02:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210208222203.22335-1-info@metux.net> <20210208222203.22335-8-info@metux.net>
 <CACRpkdb5R+VQrv0QuKa+EYmAMkodRpyv4fV1QCWQ+vcEyd0sZQ@mail.gmail.com>
 <acae5f9a-1cc8-46e1-2b3b-c806679ef062@metux.net> <CAHp75VeWW__18hwK+-uEibpzLpehD4h=QCnTbKOc-2GbkMB0TA@mail.gmail.com>
 <7b515409-1315-acd4-688a-c0eb4958d505@metux.net>
In-Reply-To: <7b515409-1315-acd4-688a-c0eb4958d505@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Mar 2021 10:09:34 +0100
Message-ID: <CACRpkdaM=rh2O5NHvnMfvcgGV36wUrcSbGpUwCMa8a2yjjOrvQ@mail.gmail.com>
Subject: Re: [RFC PATCH 07/12] gpio: amd-fch: add oftree probing support
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 9:00 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:

> Is there some compact notation for swnode's that's as small and simple
> as some piece of DTS ?

Yes it's really neat. It's all in <linux/property.h> and examples
in e.g. the testsuite:
drivers/base/test/property-entry-test.c

You can just grep for PROPERTY_ENTRY and you find some
examples of how we use it.

Yours,
Linus Walleij
