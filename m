Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357754072AE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhIJUqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhIJUqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:46:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A90C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:45:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id l11so6565297lfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHZ3QYaJRANd6Qj4KQO6L3SGyASMHRspLs55AF3AwWE=;
        b=oWtIVPgv1HwE7IY8decgYe+XXsapaK71IYNwqcUpFV/X30cjslrTpA8ZgbGCPucza5
         DoEpBPO5b7fToKSGi7M2O5K5ck/8zJ9zMbM8zzQBlmjyg/O1hmf2/F/BuxqOdCo9RLX5
         CN44zjCWc2H/woem3/Q5Enn77Bu4aroRtduOwkTyHn2xqj8t//BWWJoqF8+C8GsCWQ0N
         PVxQ6ZfiGKbDhasUfzDG01Pu1kyyKYvA2u+JyT4cBD3NnOR0GmeyFVCGOIMo540r6DJU
         ebX0YfaIK2l61i263jvT3xncvy4oky11uHJv1kksY766rN8WOxgOF3VD82mhsOnWIslA
         DxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHZ3QYaJRANd6Qj4KQO6L3SGyASMHRspLs55AF3AwWE=;
        b=AusE6SqmbgMPKtbOl4PMr1YeSu7TqU7dFXf2C9M4n8mdmsSUGOiOXdRJGIq4jvCMY/
         +av8VYzRZNBfSqv0XKBfRGFGo6fqaB7Y76hm62sc/l7LEq7CIfojp07gdWtIYA5sc89k
         tM66jOBGbG9r92FsjhtUdPsPReP06DX2JBxabbDtSgEQZdieV3icH7YqHN823g38jgxH
         xD5YaGnpSnjgkaiboFzHKr6MJwfq/ePbm5eEUatlGxWUpaPF7h+kWo8dPhdXW0tdblXu
         XCyMwgeSvmQ3vLuqXc8iZPDJb2HIUbZCu01glkN5pplkMnuYsQtBBpa/X7GgDtaKTUIj
         riVQ==
X-Gm-Message-State: AOAM531UiUN5ljmzhKTdk095O4JsNusmPYdp5G2ANQVNWyI06Pv83nwd
        95CLzzp9mNG0CdKuZuadK5eU3bXm8+E6KT6YqBnRCQ==
X-Google-Smtp-Source: ABdhPJxan8X8Nq4KBVtpwoPScw7hKKIccMMRyL8tlUisClLY1DY/Kev1VSP82ziuaLs5oTPMbmOIOba1m7PhZJMnhTE=
X-Received: by 2002:a05:6512:3e15:: with SMTP id i21mr5186718lfv.273.1631306710387;
 Fri, 10 Sep 2021 13:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210910130337.2025426-1-osk@google.com> <71c17c47-ca9e-e9d2-7b89-cc25b512c06a@roeck-us.net>
In-Reply-To: <71c17c47-ca9e-e9d2-7b89-cc25b512c06a@roeck-us.net>
From:   Oskar Senft <osk@google.com>
Date:   Fri, 10 Sep 2021 16:44:54 -0400
Message-ID: <CABoTLcRZ43EUVzbqWniu64PkB7Yx4RMYKjaBxaSihk+k0Ca-gA@mail.gmail.com>
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

Thanks for the quick feedback!

> > +  nuvoton,rtd-modes:
> > +    description: |
> > +      Select modes for the three RTDs.
> > +
> At the very least, "RTD" should be defined. The datasheet doesn't say explicitly,
> but I suspect it means "Remote Temperature Diode".
Ha, good point. As I understand, RTD means "Resistance Temperature
Detector". But TBH, I'm not sure how that squares with Nuvoton's use
of "LTD" for the local sensor ... sigh.

> > +      Valid values for RTD1 and RTD2 are:
> > +        "closed",
> > +        "current",
> > +        "thermistor",
> > +        "voltage"
> I am not sure what "closed" means (the datasheet doesn't say), but I suspect it means
> that the sensor is disabled (?). For the other modes, the translation to the standard
> ABI is:
Thanks for that pointer, I now found that in
Documentation/hwmon/sysfs-interface. Given that there's no definition
for "disabled", I guess I'll just leave that out of the device tree
binding for now? That way we'll stay consistent with the sysfs ABI.

That gives us the following mapping for sysfs / device tree -> nct7802 HW:
2 (3904 transistor) -> 3 (voltage)
3 (thermal diode) -> 1 (current)
4 (thermistor) -> 2 (thermistor)

I'll update the device tree binding to be an array then. I also update
the temp_type functions to support all 3 values.

Oskar.
