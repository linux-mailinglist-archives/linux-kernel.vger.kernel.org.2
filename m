Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59040F033
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbhIQDK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243222AbhIQDKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:10:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DB5C061764
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:09:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b18so25305879lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7HDuE8Xcc6axVLUrlQgi6xb1XAmXpaeXnBoUKQk2Q8U=;
        b=Rb7GOZkjQQz+dXcST5zXciKF45mcQvvKM4oRiwn/w4mDZaMSburq48ENn+6lIQ8evT
         Z0IqROF+UxLOG4rDop2BTQcPzLHbl3EcqoPGNoIAmHRf6Wn7IDkhxZsQ6NbWR6EjOMNE
         9sJOHPfcUwVJ2isZhNoHj0ZBk/nP7jQDL/8/aHpGveAga/qS5fxCbya/Ea0FbyVeD36A
         Ug6/yaWe7HBXANywHNORVuxrE2VjUM+j40dBCHYZhAYLbeyodumE+wjBPr2yh+hQZ8tW
         cW2ZvypauuzBvNWUJAX8ovjsAPJJ8750x+RvRHvle2Gr38E6rvGv6Z/YGy8555DbppKu
         ZV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HDuE8Xcc6axVLUrlQgi6xb1XAmXpaeXnBoUKQk2Q8U=;
        b=NLFyLPtJx1Z9oTwVinH56YcqvWE3sLYKycmZuVsMAQcbrN7IvLcQmjlRvqhfH2/bmO
         8zPFZjJpxfcbFa5BxIPVvOJp/rh0XbTSZ8f+SjSwWhyBKwrHV41o+PJlBTPm4pLUXdW6
         D9ivPXdL52SVkPi6slmzNBF6OHFfw+zTDW9X07C7mgbWKv2JEs59YDueyb4vyvG8ozJC
         9AXTgnkstnfngwQcvJSBDrhRTwH22NIdlnJ+Ve0ffYxm8pYTZG0fKst7ymbeFAyCuUiv
         RuowykBLWowyPfF9YbYw4Y3WzxKByaAHT+qHxnlXdI63rYVtn6q4QPfcrwXeFV8o2Uoy
         EK9g==
X-Gm-Message-State: AOAM532n7Azrj6K2ljrKRy+7VrBEsUcoreG7c4tHRi2mxrzPiRgg8wU3
        EdL/YbgWOD97R0TjAi1TywHRtUm5832YR1LcBGKi+Q==
X-Google-Smtp-Source: ABdhPJzVECCm8xRK1jzQ1E35fKtYJ9xaCTZ8fp6jmiPAiIKDjMcUsOJ2CCfrg9yiCMf8MrCKu7/SRr9HZvihIDWTDqE=
X-Received: by 2002:a05:6512:750:: with SMTP id c16mr6725658lfs.21.1631848172252;
 Thu, 16 Sep 2021 20:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210910130337.2025426-1-osk@google.com> <71c17c47-ca9e-e9d2-7b89-cc25b512c06a@roeck-us.net>
 <CABoTLcRZ43EUVzbqWniu64PkB7Yx4RMYKjaBxaSihk+k0Ca-gA@mail.gmail.com>
 <722b27f6-4390-9b5b-f6f2-75ce9e967d12@roeck-us.net> <CABoTLcSdkmuBxd5Yh6z2Oqm1-_Vd4J5Ni1i1qq5s07mWu7Ndew@mail.gmail.com>
 <20210914150859.GB3457579@roeck-us.net> <CABoTLcQfS5-UL92NR9vbc2YrGJv3oQPYCqAm-diNoq-tkHP_hQ@mail.gmail.com>
 <c410eba9-f6cf-4dbf-797f-48afde9c1898@roeck-us.net> <CABoTLcQWXerMWPvWUqjykiNcx9oGoP8aEcuDwcQ36yu-CBc0pA@mail.gmail.com>
 <382858f5-e833-d4b9-f189-449671992ba5@roeck-us.net> <CABoTLcST=74wRbtMA2SdmeHd0WmU7id05ouSfw4PFw2nJt_gLw@mail.gmail.com>
 <9869ed19-b8ab-d9e5-e791-a02eeb2c5eed@roeck-us.net> <CABoTLcS6krUnqDU7=1+_wBPoGN==VfmZHDQ4rWVZUv7c3ExNkQ@mail.gmail.com>
In-Reply-To: <CABoTLcS6krUnqDU7=1+_wBPoGN==VfmZHDQ4rWVZUv7c3ExNkQ@mail.gmail.com>
From:   Oskar Senft <osk@google.com>
Date:   Thu, 16 Sep 2021 23:09:16 -0400
Message-ID: <CABoTLcTJgGCrMJc4cKczz=u-ZSLpf2JYZjrMpe6k6XAG+QbJdg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: hwmon: Add nct7802 bindings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I experimented with that and I think I'm starting to get an idea
how the DT bindings YAML works.

> > Yes, let's do that. I'd like us to keep the "sensors" subnode to have a clear
> > association and differentiator to other sub-nodes such as "regulators".
> > Open is if we can use "temperature-sensor@0" or if it would have to be
> > a chip specific "ltd", but I think we can sort that out after suggesting
> > an initial set of bindings to Rob.

However, I found that when I use the name@x syntax, the schema
validator also requires the use of a reg or ranges property. But then
doing so requires to set the #address-cells and #size-cells
properties, which - I think - makes things weird.

So these two examples are options that validate:
    i2c {
        #address-cells = <1>;
        #size-cells = <0>;

        nct7802@28 {
            compatible = "nuvoton,nct7802";
            reg = <0x28>;

            temperature-sensors {
                ltd {
                  status = "disabled";
                  label = "mainboard temperature";
                };

                rtd1 {
                  status = "okay";
                  label = "inlet temperature";
                  type = <4> /* thermistor */;
                };
            };
        };
    };

or

    i2c {
        #address-cells = <1>;
        #size-cells = <0>;

        nct7802@28 {
            compatible = "nuvoton,nct7802";
            reg = <0x28>;

            temperature-sensors {
                #address-cells = <1>;
                #size-cells = <0>;

                sensor@0 {
                  reg = <0>;
                  status = "disabled";
                  label = "mainboard temperature";
                };

                sensor@1 {
                  reg = <1>;
                  status = "okay";
                  label = "inlet temperature";
                  type = <4> /* thermistor */;
                };
            };
        };
    };

In the second case we end up having to duplicate information, i.e.
"sensor@1" and "reg = <1>". Also, I have not yet found a way to
validate that the "@x" is identical to the "reg = <x>". I believe that
this is just how it is in device trees, but I want to make sure this
is what we want?

Thoughts?

Thanks
Oskar.
