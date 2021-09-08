Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9464032F9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 05:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243962AbhIHDlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 23:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbhIHDlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 23:41:00 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE484C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 20:39:52 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id bd1so1359042oib.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 20:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=GZ0a+q1qXF7MfrjInrLnr5HFObJ3ogMjBmTjbogeVrw=;
        b=dX9mbpXkrmh1LTKr1u17bTeswHB33lW+3ok9Bgv+zTTgo6UDGp6SKIJhxNX2bOS042
         +1ue2wyoNZ9z4Z1lfeJCE3nRIJACi/onP6pdf/H8tGud4qRyk3Mflb3Axqqav7vVAP7B
         6fPs9wFc6pOED/0ZtVJwISqOuYyc6kwk8eEgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=GZ0a+q1qXF7MfrjInrLnr5HFObJ3ogMjBmTjbogeVrw=;
        b=4oB2uvELRs6JGU3Hbx15ULdXZxRQq2IhvroHxfh/mlnWwOvzMvUOlnrwhbbnhfM7kL
         XksxtAxpPoPbWu3lZC0rAqBD5GIPxtdaY46Wuga9MLUSHccOjD1ST9RmHDcoIIxOWfqx
         h83CjCYLw3SU8xwQWSckqDa8jm9f6sPuhCFRpETS+m3fYpIVyad3yWav6CK3CvbCEB6d
         u4E0R4L1DCR/x5251lOO0rQtMOk05zjlY43K0e97i3NUsdXnibQ3MIJCpSFMmraBN2ur
         kUuc23EaMxckKsuDI6+qsp82nA8KMorZhUaMDwkIW2IBTu9fQrK9IzWwi0iiHjSnq+0l
         gf+g==
X-Gm-Message-State: AOAM530D6Tu/fKurTsSHDcFRZ49v/JHuDP9SeLOyEvM8Pc7e2JBpOL4Z
        0uq1S5pkpDc0XVfexWYhBnK6AiFXnV3qH18qPMYicQ==
X-Google-Smtp-Source: ABdhPJxdiiGjJ10TgqGvBQ1/7Lm6AUVwtj/VpCWil2bU6pYVcRN9bsCnM/aq8sDCvKEppqWfKKHKcnIE0NCcnfAWF34=
X-Received: by 2002:a54:4419:: with SMTP id k25mr1090071oiw.32.1631072392333;
 Tue, 07 Sep 2021 20:39:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Sep 2021 03:39:51 +0000
MIME-Version: 1.0
In-Reply-To: <20210623035039.772660-1-bjorn.andersson@linaro.org>
References: <20210623035039.772660-1-bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 8 Sep 2021 03:39:51 +0000
Message-ID: <CAE-0n53SLqmXhJBPROeQj2HzShgYoFzDqsi-KCj3dgVHdDWUTA@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2021-06-22 20:50:38)
> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> new file mode 100644
> index 000000000000..10aee61a7ffc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> @@ -0,0 +1,164 @@
[....]
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    lpg {

Should the node name be led or leds?

> +      compatible = "qcom,pmi8994-lpg";

Shouldn't there be a reg property? I see the driver has them hardcoded
but if this is a child of the spmi node then it should have a reg
property (or many reg properties).
