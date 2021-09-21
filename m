Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB10A413E15
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 01:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhIUXio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 19:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhIUXin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 19:38:43 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F557C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 16:37:15 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id l17-20020a4ae391000000b00294ad0b1f52so245640oov.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 16:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HHox+3frYK/cj9vGMME461IJwFwRKnkRBeAwyaPFbck=;
        b=U99MTwQSaRGyP0snuEIpuuA7Nc9/RXbBjkz/V0svgvNlu+nBt72uTYR+ZQAM4EJiVq
         ey0t3gCUDwQzjqlxfw5eGPi35N2Zc3Tu28JjBqPydx0Q4VlP5SWegxfs6U9fpN4n6exs
         DY17Ms//tODSOQaTASuFzerKkFvgyuW2vKeRLOse2WAlGXZNkI86OcjxbxkVjnz/sHQi
         heMD5z3mFvuBXGG5/LblKDkfgvf8qzJzTfF8LnaRMYWAZvl3pR3Im9X+Murl22XbXgh+
         sCffEEWsfC3kHc3UWAaN2pry1PupZcA65wKf+3J3tfmnn65hvYgceYRyeJecSB5Eyxz4
         AG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HHox+3frYK/cj9vGMME461IJwFwRKnkRBeAwyaPFbck=;
        b=YEDP6z+WsVk14SwA652nqAtAugMICx19bAKLCqrF1ptGg7eGDQ5YFe6PixBCvFT806
         a+zr75e43+h8Dy7tt8prD4yfFLnbKWEzIMJasjcQWb8frdvXAEUMDreJ9v2vkvn3QmxT
         sc/o7kkKkppAjv8Ak2S1MX+Sn9wG6GsJ+ufl5ixoWTicfh98PcggQSkpHSMu+nuRBNgh
         vua7t0SsPGD7GPrjodEnzOMaNA/n5KSHhfX4Fzz3SEUhjK4dMtMrBJdt8VwAj5N6SNPL
         llSEIcrJXVuivG4x91gfCyikdneJx/bfvYxGFrinY082FPNlNJYgCtAloeDgx5e08O+B
         hc8w==
X-Gm-Message-State: AOAM5317/KVgOpKopOK6A92YtIIZBrhssu0yFu7Jl1GpGhXfLCVseGNd
        fygW7YhiAU+9KFTaoVh42+RN3Q==
X-Google-Smtp-Source: ABdhPJzyrewviRAr+CFCzHNmQfX8dxtRhAjh/vAi+gc7UBts/HmCcVxzPwTgCVpJbJU23PeDTX/bww==
X-Received: by 2002:a4a:a9ce:: with SMTP id h14mr26503391oon.89.1632267434421;
        Tue, 21 Sep 2021 16:37:14 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u12sm108081otq.20.2021.09.21.16.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 16:37:14 -0700 (PDT)
Date:   Tue, 21 Sep 2021 16:37:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rakesh Pillai <pillair@codeaurora.org>, agross@kernel.org,
        mathieu.poirier@linaro.org, ohad@wizery.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sibis@codeaurora.org,
        mpubbise@codeaurora.org, kuabhs@chromium.org
Subject: Re: [PATCH v3 2/3] dt-bindings: remoteproc: qcom: Add SC7280 WPSS
 support
Message-ID: <YUps1JfGtf6JdbCx@ripper>
References: <1631811353-503-1-git-send-email-pillair@codeaurora.org>
 <1631811353-503-3-git-send-email-pillair@codeaurora.org>
 <CAE-0n51KBYjZvwGNy06_okmEWjEfRLQO54CYaY6-JnbBk6kOhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n51KBYjZvwGNy06_okmEWjEfRLQO54CYaY6-JnbBk6kOhA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Sep 23:25 PDT 2021, Stephen Boyd wrote:

> Quoting Rakesh Pillai (2021-09-16 09:55:52)
> > @@ -78,6 +84,10 @@ properties:
> >        Phandle reference to a syscon representing TCSR followed by the
> >        three offsets within syscon for q6, modem and nc halt registers.
> >
> > +  qcom,qmp:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Reference to the AOSS side-channel message RAM.
> > +
> >    qcom,smem-states:
> >      $ref: /schemas/types.yaml#/definitions/phandle-array
> >      description: States used by the AP to signal the Hexagon core
> > @@ -117,6 +127,33 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > +              - qcom,sc7280-wpss-pil
> > +    then:
> 
> Honestly I find this if/else to be a huge tangle. Why not split the
> binding so that each compatible is a different file? Then it is easier
> to read and see what properties to set.
> 

Further more, the way we express the non-PAS properties in the PAS node
in the dtsi and then switch the compatible in the non-PAS devices means
that we're causing validation errors.

So we should explode this binding to get rid of the conditionals and to
describe the "superset" of the PAS and non-PAS compatibles, for
platforms where this is applicable.

Regards,
Bjorn

> > +      properties:
> > +        interrupts-extended:
> > +          maxItems: 6
> > +          items:
> > +            - description: Watchdog interrupt
> > +            - description: Fatal interrupt
> > +            - description: Ready interrupt
