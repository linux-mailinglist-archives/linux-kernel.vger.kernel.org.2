Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9F53A8706
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhFORC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhFORC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:02:56 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2DEC0617AF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:00:51 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t140so18935881oih.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OrHpiQTn+IqOBIYO5Pq4UHsLozqCibN36fNoW8gNRD0=;
        b=w4V+qXiieefOcxwFgrf2VCnoMsgBVXMXyzgY8AURZ60wzDRJPA5ZnwPqtLaoxik+Bm
         8fnW4ktgfh9cmf77AhchNONIO460nlmJi998joD1MZiXXz+lBlSKrWuuh6cWa0VNUaKt
         cJo9nMufzTPQtClv0yJ6GGnfXW+Lvgf7eA+50GrQ9RaFKRB8CcvWvPGfrimQZMjCvIpg
         nd6LJ7BRNrhnS5LCuSvMmbkFwQpdZ0fqcKsMrJpENRAsYEXBvTZOfcFmIb9PlkTLLznc
         QtEQLqmr1Ywhf6CfQPYZt5aTGvs4fUbh+RRzbexCiMePG6hm9X+TzZoqJ93FFwndXj49
         HNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrHpiQTn+IqOBIYO5Pq4UHsLozqCibN36fNoW8gNRD0=;
        b=LUCoQ56qBCErn8+nhl7AdW8iVsfUdAHysyz4WRmdmGsQAVvvA6OnY+5jueSgfwQBoe
         pg7yRYDjszdk730+gQuI77qYO/59MdlF8NmJA6zE2g+t0ZyXWpQHhFsP8CuxsQ+Rm0Yf
         x9OfwzUO+DYx/9W+B6ngjVlcDEKg8h0oGlXoZzKCpIu9NSDS8EDiMwPGB4pS6I/mW33X
         OGwTNdGqwq4tIs71i+jp+9laup2uNEUbIYg+lr/jpsXd31FfIEQ3ZCYpfqpf6nh0hjr4
         7MvBzi3lQ810izcTuP1Y9d+liNa1udTho9t5sz5Gg/8lFUcU82KDgcyex7pP3z6nSsXV
         rIsA==
X-Gm-Message-State: AOAM533aJ1Zu8GyymfcUJbPDRz00BCeDhka/ETpmYVmhIYLciqwYMIA1
        q3ffMfAdwKIYN5nDrT3gpP4c+B8lK3weFNHpWXeC/g==
X-Google-Smtp-Source: ABdhPJxCnnNnCWSfH0VDaXkPF/u1L+nchxayekHp7hO0jMhZ49QfQK6sS4x7wI7zPaj50rP+V4rbyDHzeAJ3rdd9dHA=
X-Received: by 2002:aca:4bd7:: with SMTP id y206mr117111oia.40.1623776450766;
 Tue, 15 Jun 2021 10:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210615074543.26700-1-bhupesh.sharma@linaro.org>
 <20210615074543.26700-11-bhupesh.sharma@linaro.org> <0b012d77-8d61-f852-f455-8b6cceb03ebf@somainline.org>
In-Reply-To: <0b012d77-8d61-f852-f455-8b6cceb03ebf@somainline.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 15 Jun 2021 22:30:39 +0530
Message-ID: <CAH=2NtzOzA9HmxFUUuhX9Vy=KW3iRSx5HiuD9Cf11v+eijEWsQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] arm64: dts: qcom: sa8155p-adp: Add base dts file
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Thanks for the review.

On Tue, 15 Jun 2021 at 20:23, Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
> Hi,
>
>
> > +
> > +     reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
> > +
> > +     vcc-supply = <&vreg_l10a_2p96>;
> > +     vcc-max-microamp = <750000>;
> > +     vccq-supply = <&vreg_l5c_1p2>;
> > +     vccq-max-microamp = <700000>;
> > +     vccq2-supply = <&vreg_s4a_1p8>;
> > +     vccq2-max-microamp = <750000>;
>
> You need to add "regulator-allow-set-load;" to the mentioned supplies,
>
> as you're controlling the amperage here.

Ok, I will fix this in v3.

> > +};
> > +
> > +&ufs_mem_phy {
> > +     status = "okay";
> > +
> > +     vdda-phy-supply = <&vreg_l8c_1p2>;
> > +     vdda-max-microamp = <87100>;
> > +     vdda-pll-supply = <&vreg_l5a_0p88>;
> > +     vdda-pll-max-microamp = <18300>;
>
> Ditto

Sure, I will fix it in v3.

Thanks,
Bhupesh
