Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887B430CB41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbhBBTSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbhBBTQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:16:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53223C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 11:15:40 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id q12so29582760lfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 11:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7QquFjvRxPY0U7aF3eWrvZSM21MySROeK24YtU62q0=;
        b=KMxUnzUOqmD0gRF9g6XAj9MG52HyTdDUa5d/Bi/Vn4JioC4VtgrjT48qvz14nwsyTQ
         tZklwetTSy7v3cTQftpr10BzE0nVRi1EexypGHZ86NGTQydOExljc4FBj2PKLaTgnOLk
         HS5XkiJYqG7DnTQe2N/0MQlC9k2ZDQS8ygmgiGx/q3n2wMWCvtVAG1K/yTVRDunTgzCs
         8h7jU1AqxMjZFjUJtiKJehGd+0j8nZBVSWO+t6+AFR05GBLzoyUUQupb28Zh0R3q9RP1
         G4q4l1beHewGN74UoeooGBOVOs+WH/7W+f8ZF1xFo8yvb5vqroAyXJgUXfoZRee9uF1d
         AsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7QquFjvRxPY0U7aF3eWrvZSM21MySROeK24YtU62q0=;
        b=b2jTgbeFhaW1jTGzYbUn4F0fHRnPfXmdz38N6u8ov33h05faCbl62AOn4PEHUmRrDu
         YMLJ8y23yNvEnCav2H1Fn0Ue6dT0Ejj0CUy8Nh1SLbGkSmP5ZQh26EJlZsYRzoLmoVd6
         m1mbky1qV7ZTAvJP3cXUPBEkOT3ZJdTEbKFNBmJpdxdBZv8dlN3nmPU4YsRvjfZCVkfJ
         HfFnW2ctuqDVWPH4NkAP4Ybj2zxcthXANfd//WkEnPzAXXoLfwrosMxpa1E4F1Rtn2L3
         gJJoSAumTciwBJxU1rhixbydcpmEFafHA7UyS/WTVKq3auV3qDPKydgefsHvZ/f2o5x8
         DSMQ==
X-Gm-Message-State: AOAM530ykZG0HeewYhY0PCAFecNfEIF7HRLI9NQRvRvJ/jwz283tUyC8
        EFeFr8eMKl9+BzmlAwtISz7qLryTWJe5vgvQaInXfw==
X-Google-Smtp-Source: ABdhPJzV0Ns8BDjfiy5cULmWtU7+/Q7DEwfm2A+ng3fvCQIHmuXBUxuZVEji+2lLXBCPgA+O62NnK87WtnQKbUuQAug=
X-Received: by 2002:a19:b8e:: with SMTP id 136mr12406124lfl.29.1612293338259;
 Tue, 02 Feb 2021 11:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com> <20210120132717.395873-8-mohamed.mediouni@caramail.com>
In-Reply-To: <20210120132717.395873-8-mohamed.mediouni@caramail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Feb 2021 20:15:26 +0100
Message-ID: <CACRpkdaHJz+9FvAeuTbGPzMjosko-a5FKE2aXnenbNdPLYEbNw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mohamed,

just a small drive-by comment:

On Wed, Jan 20, 2021 at 2:32 PM Mohamed Mediouni
<mohamed.mediouni@caramail.com> wrote:

> +       for_each_cpu (cpu, mask) {
> +               smp_mb__before_atomic();
> +               atomic_or(1u << irqnr, per_cpu_ptr(&aic_ipi_mask, cpu));

Use:

#include <linux/bits.h>

atomic_or(BIT(irqnr), per_cpu_ptr(&aic_ipi_mask, cpu));

Yours,
Linus Walleij
