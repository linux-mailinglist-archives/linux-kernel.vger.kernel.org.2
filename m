Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EF940EB27
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhIPTzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbhIPTzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:55:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15772C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:53:51 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c8so23252273lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yh4xn3/rW/bwCLVCLlCO6qRn/nkcJ2yPDnpPOwZoZFs=;
        b=jpWngZLjqx1L51/+NrKEbV0q/Ox7+6to9U0rZX+7qpyRHyI6ZUU86TynHBGsM9kfNl
         kTWTtT4UYuBQLchYJsUHAO9HUfeHODy4QrxrRInac2IhFYN+pcqn+Jy7c5De744Rifdl
         9Hg4mHyhlCx/dnU33Le9usPoH2Ofl1Vje8Q3QfscIvQfiK/c1Vq/Kp86TVBmcE1qy2B2
         V1FGWap1luIlBUmOoFY3mKWQFfxqA/3mzMD5f/aTEc+vqI07hff5sGwfIvnywECumXtp
         AEguCynqLJ86d/g++Lqcj69TFrojHt0uiShtZYuoGwztInZcBFIKfKV0GOte2HLguRRY
         oFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yh4xn3/rW/bwCLVCLlCO6qRn/nkcJ2yPDnpPOwZoZFs=;
        b=PPQ8RIOIaaTrLD/gQr5pGyohzUCWmGib884W7NjeOnNTk0EuqU9gbScGMHq8qdBSfH
         onXPt87S1JvmCLEf+G/egiWaxm0S34fdR/PFQG8hd1JR9y8JeqyZf9hoBmOkeicYQ7/w
         tNQf+A33jtUgngaql63QWWZI7bhB4Nyc3pxxtjhfyESFDyMMRN6RUaz5NV+fBt1vPblr
         2sS5uunqp4vpfNnYiSuB1SHp/2OpqEu0u7ZsT/zc2avZiUBKQYZh+d3DDpdrCcuyfTtI
         k4EDbzzvzhQIc1wgptQog0yFZkJIK1caCsy+t2M63rDT6C5BOpjo0LcKK+Y8sL8p4OQ4
         4hXQ==
X-Gm-Message-State: AOAM532tF0fwb052c9Drbt3mtJYfen0rAp5KoSbS+cpKd+JECC9Ey4OS
        GdTMwe43bEalFUN0guTnjhf4ZkjAq1GRLZ8bYgcIghNNnsbSJW9r
X-Google-Smtp-Source: ABdhPJy87a4xZsRffUvKwGSHxQ1gxEZIkcbaveflK+mzIu5LmemcCZUgkcoZdqxY8IuNGCZ3lJm+P29vBjzMQyhYqc8=
X-Received: by 2002:a05:651c:1505:: with SMTP id e5mr6349233ljf.9.1631822029114;
 Thu, 16 Sep 2021 12:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210910130337.2025426-1-osk@google.com> <71c17c47-ca9e-e9d2-7b89-cc25b512c06a@roeck-us.net>
 <CABoTLcRZ43EUVzbqWniu64PkB7Yx4RMYKjaBxaSihk+k0Ca-gA@mail.gmail.com>
 <722b27f6-4390-9b5b-f6f2-75ce9e967d12@roeck-us.net> <CABoTLcSdkmuBxd5Yh6z2Oqm1-_Vd4J5Ni1i1qq5s07mWu7Ndew@mail.gmail.com>
 <20210914150859.GB3457579@roeck-us.net> <CABoTLcQfS5-UL92NR9vbc2YrGJv3oQPYCqAm-diNoq-tkHP_hQ@mail.gmail.com>
 <c410eba9-f6cf-4dbf-797f-48afde9c1898@roeck-us.net> <CABoTLcQWXerMWPvWUqjykiNcx9oGoP8aEcuDwcQ36yu-CBc0pA@mail.gmail.com>
 <382858f5-e833-d4b9-f189-449671992ba5@roeck-us.net>
In-Reply-To: <382858f5-e833-d4b9-f189-449671992ba5@roeck-us.net>
From:   Oskar Senft <osk@google.com>
Date:   Thu, 16 Sep 2021 15:53:33 -0400
Message-ID: <CABoTLcST=74wRbtMA2SdmeHd0WmU7id05ouSfw4PFw2nJt_gLw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: hwmon: Add nct7802 bindings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, using the node name as indication for both sensor type and
> index ? SGTM, though we'd really need input from Rob.
> I guess one could also consider something more generic like
> "temperature-sensor@0", "voltage-sensor@0", and so on (instead
> of [mis-]using reg and a sensor-type field).

Hmm, in that case, maybe we should just remove the "sensors" section.

i2c {
    #address-cells = <1>;
    #size-cells = <0>;

    nct7802@28 {
        compatible = "nuvoton,nct7802";
        reg = <0x28>;
        #address-cells = <1>;
        #size-cells = <0>;

        temperature-sensor@0 { /* LTD */
            status = "okay";
            label = "my local temperature";
        };

        temperature-sensor@1 { /* RTD1 */
            status = "okay";
            mode = <0x2>; /* 3904 transistor */
            label = "other temperature";
        };

        temperature-sensor@3 { */ RTD3 */
            status = "okay";
            mode = <0x3>; /* thermal diode */
            label = "3rd temperature";
       };
   };
};

Now, with "sensors" removed and everything at "top-level", we'll need
to decide what to do if individual sensors are missing. I guess in
that case I would just leave the affected sensors alone, i.e. neither
configure nor disable them and instead read their status from HW. That
way prior uses of the nct7802 in device trees will continue to behave
as before as does the EEPROM-style configuration.

I would like to focus on the implementation of the temperature-sensor
entries for now (i.e. LTD, RTD1, RTD2, RTD3). Support for other sensor
types could be added in a separate change. Would that be acceptable?

Thanks
Oskar.
