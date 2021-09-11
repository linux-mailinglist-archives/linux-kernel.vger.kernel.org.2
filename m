Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B6C4074C8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 04:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhIKDAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 23:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKDAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 23:00:44 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BBAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 19:59:32 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 62so2571211qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 19:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLsl1b3NpV63ZgEOzfho19a1Y601LOSFY9by5dYQ2vk=;
        b=ZuJTyoJ2Az9c1Is3XTu1LV5/RcY65XnXmK9vMWCubV36heqTW7cF4yLUQU9PtDVMM0
         fnXovV3tnPfgC5oaX9jyX6JtQEEgHRvOt6pnEvvrOlUiNsbD9Vv3TJZrvF+S0kZyHHFS
         E98OaS1d0Tpyt77mNYlHPOHMmTywNyO4wZQ+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLsl1b3NpV63ZgEOzfho19a1Y601LOSFY9by5dYQ2vk=;
        b=A6pNRZhrbcXusoTaSbkNK6x3YN3+T/G+iKocbu3j/ZbsLOSjhyiPWeNPqvz3Danfej
         atoju+sPzKUuaYK7ZOC9zfmthpFQaouQsLegfsEWQGNlZpKtHYq5KFPe9rNbuuENHLpS
         92DDLqMM7bqWJLFaFQVVD5rls9i+Ufc4f6AHgdtn1XZjfrWC97dkuLfMZhfeV8ilgRXk
         Ariwz9/o5mfabAWmMNj/hGPYd1gk/bsWbxI+DheQAjP9u6pR1pttqYyQg6hT6uYOtGk7
         Of2I7tLHbFw4DMb4czdypc0117unkKygSZz6vBe5noZenb0KxLmKLoWGzh153r1MQQAJ
         V60A==
X-Gm-Message-State: AOAM530/3A+ygLH5pcuUA8iE9zLq9c2OGVi5rRQJX2lbEPIJibvNrrSi
        ryeB3koNvZNKMUBEJuCH2dE+dVUmBGyvnIlyWB+3nw==
X-Google-Smtp-Source: ABdhPJxlXs7FidNs06MWxVYHLmOrbib25biafBKZ0BHrdEoITRWXuaidDQ8sY+mPr9EqtO+a/mftg06B0puO2QvO5HU=
X-Received: by 2002:a0c:aac5:: with SMTP id g5mr666903qvb.23.1631329171737;
 Fri, 10 Sep 2021 19:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210910190322.27058-1-romain.perier@gmail.com> <20210910190322.27058-4-romain.perier@gmail.com>
In-Reply-To: <20210910190322.27058-4-romain.perier@gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sat, 11 Sep 2021 11:59:21 +0900
Message-ID: <CAFr9PXmwRDfXmDR9UOGoQ2+_LDaSGgmg7n=Ek4RtBdiC2kfuLA@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: add vendor prefix for Wireless Tag
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,
Sorry for sending this again. Gmail decided to switch to html email so
the first version bounced from the mailing lists.

On Sat, 11 Sept 2021 at 04:03, Romain Perier <romain.perier@gmail.com> wrote:
>
> This adds a vendor prefix for wireless tag boards and SOMs.
>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index a867f7102c35..b50d62dde7c5 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -517,6 +517,8 @@ patternProperties:
>      description: International Business Machines (IBM)
>    "^icplus,.*":
>      description: IC Plus Corp.
> +  "^wirelesstag,.*":
> +    description: Wireless Tag (qiming yunduan)
>    "^idt,.*":
>      description: Integrated Device Technologies, Inc.
>    "^ifi,.*":
> --
> 2.33.0
>

This should be in alphabetical order.
Also, this commit should be before adding the DT for the board I think.
The prefix should be in before something that uses it.

Thanks,

Daniel
