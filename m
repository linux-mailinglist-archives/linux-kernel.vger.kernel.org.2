Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC8140F069
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244028AbhIQDak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244023AbhIQDad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:30:33 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8B1C061574;
        Thu, 16 Sep 2021 20:29:12 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j66so12027398oih.12;
        Thu, 16 Sep 2021 20:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AdeVZSjrG7IvrvbVG4XVAJSYxI+HjrXZR/0kPB5tvaw=;
        b=PZFXkrRcykan46GtApxlURrlr2KBP7UHhbzi2vspWKoWbr/byysBEk8VKknm5co6f9
         YxhILlER+lZTnO3EBbX/KXsr4d4HnNOXbc72+ix9k6qqRB0/OVUnrCJLv+d+DWKx4+uh
         vdCSd/tg3lvEe93NExlrqaOfMD84iZs9IDkCeyO0HCZzNChzqyg4njcx3rVjnVdxlmks
         PBMDzGuO4nHs5efkJKPvJajBvhVe4H2tdsFMtVSiN0LrfK5HwQoO/r0zV6ZWBr/UrODI
         YOnKFOZuwpAMZYCusgLnyq1WYHABghaLUkobUPtrMLs71FjkZnXeUloPHZZ0aeZ6rU3c
         4HPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AdeVZSjrG7IvrvbVG4XVAJSYxI+HjrXZR/0kPB5tvaw=;
        b=uGOa0vv5y+ocQ4u6MyjYk0jilOwsC+abcEJwjnkvk4c9rbrVRfiTp7ix17s736pSKc
         ixGVyZSHmHmA8NyhRhMLeo1gIV4bHyNDpnYwTrL5DovboJP31BLIoJzu9tjx0/zQX9ag
         XJYCoEp1s8tiLGEcSz3EssXx0MdIkQX01sNisztNI2zzRKNj6rnMaEFM+LEryyALbSlZ
         47yI7KLvD3W3dPU76amyAI11zaIkjUygzeVS2a6k6DbnV6787zND9v8UVQcxLdbTnNyU
         mhgobLGxHIbAv2L5GeSGE73eAzN1kZucUzUXsJvSBTAn08UGcm0/wRycms/Qayx/nX7K
         l8LA==
X-Gm-Message-State: AOAM531/Frek8jCfjVVhDGxZVJwTl+KusUXupH/dnXriU/lqFz4zqMtB
        TRfBpSttILZx3V5Rb2yKGC4DaRKW+OE=
X-Google-Smtp-Source: ABdhPJwckS4yRBEsX+Yfx8zM50UamzYmmGpslXobWryHXp0za0SKqg+WeB6kbzkdCu2rE18DucV3eg==
X-Received: by 2002:a05:6808:cd:: with SMTP id t13mr11621576oic.111.1631849351505;
        Thu, 16 Sep 2021 20:29:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bj27sm1034356oib.58.2021.09.16.20.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 20:29:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Sep 2021 20:29:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oskar Senft <osk@google.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: hwmon: Add nct7802 bindings
Message-ID: <20210917032909.GB2520170@roeck-us.net>
References: <CABoTLcSdkmuBxd5Yh6z2Oqm1-_Vd4J5Ni1i1qq5s07mWu7Ndew@mail.gmail.com>
 <20210914150859.GB3457579@roeck-us.net>
 <CABoTLcQfS5-UL92NR9vbc2YrGJv3oQPYCqAm-diNoq-tkHP_hQ@mail.gmail.com>
 <c410eba9-f6cf-4dbf-797f-48afde9c1898@roeck-us.net>
 <CABoTLcQWXerMWPvWUqjykiNcx9oGoP8aEcuDwcQ36yu-CBc0pA@mail.gmail.com>
 <382858f5-e833-d4b9-f189-449671992ba5@roeck-us.net>
 <CABoTLcST=74wRbtMA2SdmeHd0WmU7id05ouSfw4PFw2nJt_gLw@mail.gmail.com>
 <9869ed19-b8ab-d9e5-e791-a02eeb2c5eed@roeck-us.net>
 <CABoTLcS6krUnqDU7=1+_wBPoGN==VfmZHDQ4rWVZUv7c3ExNkQ@mail.gmail.com>
 <CABoTLcTJgGCrMJc4cKczz=u-ZSLpf2JYZjrMpe6k6XAG+QbJdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABoTLcTJgGCrMJc4cKczz=u-ZSLpf2JYZjrMpe6k6XAG+QbJdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 11:09:16PM -0400, Oskar Senft wrote:
> Ok, I experimented with that and I think I'm starting to get an idea
> how the DT bindings YAML works.
> 
> > > Yes, let's do that. I'd like us to keep the "sensors" subnode to have a clear
> > > association and differentiator to other sub-nodes such as "regulators".
> > > Open is if we can use "temperature-sensor@0" or if it would have to be
> > > a chip specific "ltd", but I think we can sort that out after suggesting
> > > an initial set of bindings to Rob.
> 
> However, I found that when I use the name@x syntax, the schema
> validator also requires the use of a reg or ranges property. But then
> doing so requires to set the #address-cells and #size-cells
> properties, which - I think - makes things weird.
> 
> So these two examples are options that validate:
>     i2c {
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         nct7802@28 {
>             compatible = "nuvoton,nct7802";
>             reg = <0x28>;
> 
>             temperature-sensors {
>                 ltd {
>                   status = "disabled";
>                   label = "mainboard temperature";
>                 };
> 
>                 rtd1 {
>                   status = "okay";
>                   label = "inlet temperature";
>                   type = <4> /* thermistor */;
>                 };
>             };
>         };
>     };
> 
> or
> 
>     i2c {
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         nct7802@28 {
>             compatible = "nuvoton,nct7802";
>             reg = <0x28>;
> 
>             temperature-sensors {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 sensor@0 {
>                   reg = <0>;
>                   status = "disabled";
>                   label = "mainboard temperature";
>                 };
> 
>                 sensor@1 {
>                   reg = <1>;
>                   status = "okay";
>                   label = "inlet temperature";
>                   type = <4> /* thermistor */;
>                 };
>             };
>         };
>     };
> 
> In the second case we end up having to duplicate information, i.e.
> "sensor@1" and "reg = <1>". Also, I have not yet found a way to
> validate that the "@x" is identical to the "reg = <x>". I believe that
> this is just how it is in device trees, but I want to make sure this
> is what we want?
> 
> Thoughts?
> 
Comparing those two, I prefer the first option. Can you write that up
in a yaml file to present to Rob ? If he doesn't like it, we can still
suggest the second variant as an alternative.

Thanks,
Guenter
