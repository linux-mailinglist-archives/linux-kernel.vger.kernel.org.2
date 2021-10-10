Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF739427E7C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 05:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhJJDIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 23:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhJJDIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 23:08:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867E2C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 20:06:51 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z11so48484239lfj.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 20:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaeM4Um/Mm9c+IwBdlqDrAg0WdGnkz5I6n2M37I5Tuc=;
        b=Yp+4JR6Gtleh3VZFvcH+Q60V6yiJ+P41B/j8EVQpqs3oGWWBJzqBfkW2ENLoZaSd/r
         mNfJs8JfsXtZTnhLsxtZw42Xgfhwprjx01U6so0atizTDlesWw+MhH1ODiyIzlIU1Fme
         MvWOMVqKCQ+pazXZWJwjPqVK1WGmfzE43Xt8UOeLlqMC0PTLzvRylC84iZzikpWrTKpU
         fLUSdP7uFHx1w9929LBxcpi2Sxg4dSdTEGULG1zb20Jwhqc4XWGpiDzxdJxLcceRV1jT
         eWi0favmXM6PIxZW9MkXi1/2DbhqCe4Uqiem2Y3rjCuqf2kqaV7kjQ7Avu3fsEXcm2nd
         AgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaeM4Um/Mm9c+IwBdlqDrAg0WdGnkz5I6n2M37I5Tuc=;
        b=PDBR4xsSF7N2hQo+5K+UXIjY3gbWv/qmUxr34GGxkwkxrmlcIlzXlTLOQSuJnFqJMR
         +sLTKUaFYLYjIGEAkCPbtXtf5FJZv7yyknbtt1etZM1K00lA+RgLPsBepoVGNP093oyP
         pwDeMueLn3UXV7avm45MFrkavFLTj5vsvNCYjZ5txW3j3Xhg4yXTamKex6kTVVry+RSm
         XY/4Gv8q+ii4hn7wkv9oie6HAxdWv1rpmwZ5RsBrA/k0SM4ThSONTNR0/ez2DN8PeQqZ
         f7gS/PqBrAOWunCSktbtD1Ntl2pmKT+fyFGpfFH71gm6BfSaxql/VtyEHZ8WBhTSfIrO
         YHNg==
X-Gm-Message-State: AOAM531mHWl8rnKmaq6tp4acByq7OKSEaA/zGrICFI63q6DAio0jPi/s
        rITaXRm6QjIOd5pQk5aY01M0QlA4pZorR/1gSWyeVw==
X-Google-Smtp-Source: ABdhPJxMPKU+g0GbKcyP8SL1oUpbVUhYYy6KC4R/60Zbq5HadVP2j0SJXmpzWE48MJPKb/kDfrRp+zQJz0GYK065dF4=
X-Received: by 2002:a2e:9b87:: with SMTP id z7mr13516729lji.253.1633835209224;
 Sat, 09 Oct 2021 20:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211009185257.2230013-1-osk@google.com> <b73b638e-5a24-4960-354d-c8ab5d61c387@roeck-us.net>
In-Reply-To: <b73b638e-5a24-4960-354d-c8ab5d61c387@roeck-us.net>
From:   Oskar Senft <osk@google.com>
Date:   Sat, 9 Oct 2021 23:06:33 -0400
Message-ID: <CABoTLcQBjbW_wtQUo9jdbPbcJJcLaHEA+Oe17bWSCy+_GqOeLg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add nct7802 bindings
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter

Thanks again for your review!

> > Signed-off-by: Oskar Senft <osk@google.com>
> > ---
>
> change log goes here.
This might be a silly question: I'm using "git send-email", but I
don't think there's a way to edit the e-mail before it goes out. Do I
just add "---\n[Change log]" manually in the commit description?

> > +description: |
> > +  The NCT7802Y is a hardware monitor IC which supports one on-die and up to
> > +  5 remote temperature sensors with SMBus interface.
> > +
>
> Just noticed: 5 remote temperature sensors ? Shouldn't that be 3 ?
This includes 2 temperature sensors that are queried via PECI (i.e.
SMBus). I generated the description from the "general description"
section in the datasheet. I think the driver doesn't implement the 2
PECI sensors at this time, but the statement about the HW is still
true.

> > +      sensor-type:
> > +        items:
> > +          - enum:
> > +              - temperature
> > +              - voltage
> > +      temperature-mode:
> > +        items:
> > +          - enum:
> > +              - thermistor
> > +              - thermal-diode
> > +    required:
> > +      - reg
> > +      - sensor-type
>
> If I understand correctly, "temperature-mode" is implemented as mandatory
> for channels 1 and 2 if sensor-type is "temperature" (which makes sense).
> No idea though if it is possible to express that in yaml.
> If not, can it be mentioned as comment ?

After doing a bit more searching, I found the amazing "if: then:
else:" construct that allows to express this properly and eliminates
the code duplication. I'll follow up in PATCH v6.

Thanks
Oskar.



>
> > +
> > +  channel@2:
> > +    type: object
> > +    description: Remote Temperature Sensor or Voltage Sensor ("RTD2")
> > +    properties:
> > +      reg:
> > +        const: 2
> > +      sensor-type:
> > +        items:
> > +          - enum:
> > +              - temperature
> > +              - voltage
> > +      temperature-mode:
> > +        items:
> > +          - enum:
> > +              - thermistor
> > +              - thermal-diode
> > +    required:
> > +      - reg
> > +      - sensor-type
> > +
> > +  channel@3:
> > +    type: object
> > +    description: Remote Temperature Sensor or Voltage Sensor ("RTD3")
> > +    properties:
> > +      reg:
> > +        const: 3
> > +      sensor-type:
> > +        items:
> > +          - enum:
> > +              - temperature
> > +              - voltage
> > +    required:
> > +      - reg
> > +      - sensor-type
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        nct7802@28 {
> > +            compatible = "nuvoton,nct7802";
> > +            reg = <0x28>;
> > +
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            channel@0 { /* LTD */
> > +              reg = <0>;
> > +              status = "okay";
> > +            };
> > +
> > +            channel@1 { /* RTD1 */
> > +              reg = <1>;
> > +              status = "okay";
> > +              sensor-type = "temperature";
> > +              temperature-mode = "thermistor";
> > +            };
> > +
> > +            channel@2 { /* RTD2 */
> > +              reg = <2>;
> > +              status = "okay";
> > +              sensor-type = "temperature";
> > +              temperature-mode = "thermal-diode";
> > +            };
> > +
> > +            channel@3 { /* RTD3 */
> > +              reg = <3>;
> > +              status = "okay";
> > +              sensor-type = "voltage";
> > +            };
> > +        };
> > +    };
> >
>
