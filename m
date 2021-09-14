Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41FE40AE0F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhINMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhINMnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:43:12 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC966C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:41:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s3so23556314ljp.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4g2Wav+SkEq7UdYNbmRHcmC3tflY4E5NwVgSGxv7C8A=;
        b=qOHx8aC8BMjVfANULofMofo+Gn7EYmEyRD60TzkLTAglNPJTgUY6AhDhJDlsuNmUVP
         pXebtude00R9h0Np8DdVymybtPF6dYn5KcOfOMieN3ierydKjpSoQ3Ugm2L/Jv9GCMLG
         r8sWnElZ+XaBahtw2lCd+4w85Iy0b0x6lklsk926EE3SUMXZRh5zKDz7x73nYKXUbAdt
         oUkOddNJ6tJ15SieBfeBTGwdRHmoLxSp4LsdwD0hLo29Eze7Zk9SCmSoncJ0PNmbWJNq
         D0tjsH/QLcoS5vJdmTG4hztbNWnUBcOI1chBAFAO1tfCQvTAr+hRZNi1yBv838898FJr
         D/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4g2Wav+SkEq7UdYNbmRHcmC3tflY4E5NwVgSGxv7C8A=;
        b=5N2hrDqdITwFpCYklvIOs/IFINdru+PONcRslzU/JbA+nhs8ceWPny+5rTpH73Yq2J
         WHUTdDU9XuQcX3pHKNoYZYK6F1Ryaf1j0+pbn2l/ZCAjm/7k8ywjachcQaIZbMSMXenU
         FbwmxfneDbwTZta6LiZOwxN/B6m45H97ia5bjoqMomoUuAUf/SEnIBciT5lOrtqWe+xw
         egS5ZTp7YD1Nm+c3/+iF4hoCfXydui5k9lVhmQGPcXanWkYL+7NnYSCDA/0O/EQtK4K6
         xcLWLKHSC8OD4RUEqW4/CIZA6dPDg/15MesnZ8VonX4sMfOah8DeghInTFhviGx3Hn0s
         MXMg==
X-Gm-Message-State: AOAM5305ZrNDdQTnKBcOs2IPfeTnm2SgW3UpRv0Z39x+VGDRPoHWw9Ra
        VY1SFrXvBUGbvP16YjWYF6og5GKFhhN88rxYWdKEPNx0mFdBrVNx
X-Google-Smtp-Source: ABdhPJyCVc4mtRLHkSZpQgUbb2SW4fU+QPB5ugjn5OXSRgz/bPNeaI6YI6JPobEK5J+coeywBE3QAPCg1vCCKPGdf5E=
X-Received: by 2002:a05:651c:1505:: with SMTP id e5mr15210748ljf.9.1631623312789;
 Tue, 14 Sep 2021 05:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210910130337.2025426-1-osk@google.com> <71c17c47-ca9e-e9d2-7b89-cc25b512c06a@roeck-us.net>
 <CABoTLcRZ43EUVzbqWniu64PkB7Yx4RMYKjaBxaSihk+k0Ca-gA@mail.gmail.com> <722b27f6-4390-9b5b-f6f2-75ce9e967d12@roeck-us.net>
In-Reply-To: <722b27f6-4390-9b5b-f6f2-75ce9e967d12@roeck-us.net>
From:   Oskar Senft <osk@google.com>
Date:   Tue, 14 Sep 2021 08:41:36 -0400
Message-ID: <CABoTLcSdkmuBxd5Yh6z2Oqm1-_Vd4J5Ni1i1qq5s07mWu7Ndew@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: hwmon: Add nct7802 bindings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter

> https://lore.kernel.org/linux-hwmon/cover.1631021349.git.krzysztof.adamski@nokia.com/
>
> That specifically includes the ability to enable or disable channels
> using the standard 'status' property. While that series is primarily
> for the n-factor property supported by the tmp421, the same approach
> can be used for [temperature] sensor properties on other chips as well.

Good pointer! I should be able to replicate that for the LTD (@0) and
RTDs (1, 2, 3) in a similar way.

> I put [temperature] in [] because we'd need to find a means to express
> if the sub-nodes are for temperature, voltage, or something else, but
> I think the basic principle is sound.
Following the example from tmp421, this could then be like this:

i2c {
    #address-cells = <1>;
    #size-cells = <0>;

    nct7802@28 {
        compatible = "nuvoton,nct7802";
        reg = <0x28>;
        #address-cells = <1>;
        #size-cells = <0>;

        /* LTD */
        input@0 {
            reg = <0x0>;
            status = "okay";
            /* No "mode" attribute here*/
            label = "local temp";
        };

        /* RTD1 */
        input@1 {
            reg = <0x1>;
            mode = <0x2>; /* 3904 transistor */
            label = "voltage mode";
        };

        input@2 {
            reg = <0x2>;
            mode = <0x4>; /* thermistor */
            label = "thermistor mode";
        };

        /* RTD3 */
        input@3 {
            reg = <0x3>;
            mode = <0x3>; /* thermal diode */
            label = "current mode";
            status = "disabled";
        };
    };
};

I noticed that "nct7802_temp_is_visible" only allows the temperature
sensor to be visible for current and thermistor but not voltage. Is
that right?

Before I go and change the driver further, I'd like to make sure we
agree on the interface.

Also: Is nct7802_temp_is_visible called again after temp_type_store
was called (I didn't try it)?

Thanks
Oskar.
