Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78E3413AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhIUTXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhIUTXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:23:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529F6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:21:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v24so558212eda.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CoizIjqkQkAgXO3NanmUI7a4z4Mg4O/HFwzVnIRa9bA=;
        b=L4Dq7fxn+T5CnRWjI2RzQxbBMPmM/uJPBGd1OH6JHrHqcDodPJRB7rVWREZn/NMDx5
         kvQ9wgp9tp4se1p5dxYmvfMC/rLxgofi19rrgBti+gXm3P6CGdUeRVDwQD+OCEVGzV/m
         HYyv+0K/E6P6shH08Di8bhjwK2q9p8yE/Vhuj50rkmEsNmPt6hTHfd4qVz7mXfpOJpNL
         18KdaM+jBKiPMmTWUuCOPxKsO1Ceqz3xW4v+/hLMij67QCFyseY3abu3zFf3n0boGNq7
         TVhHbbZOPCJpwkem989BAeTmUUBmweed4AH6fldPEAYXrTtl2PTaTTNfrm763ZLF729U
         Q2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CoizIjqkQkAgXO3NanmUI7a4z4Mg4O/HFwzVnIRa9bA=;
        b=2U5fzTZ/Wgp6zzwnp+Kxfvt/1MFWDEq+mKf1gNTl0xFUrFT45b55g+lN5yzUcKT2L0
         jPWbooL2o74wWRCuXE/LJm38biCA5KcYiV65McsODQ6w9/Mqvw5MH52oqV4JPZIJi7PZ
         5CBNt4SZtQW+awohl7mLL1gFDBPPVFYcyLtejJd6b4FErNIPWs7g7HENPBv5ohJOhegG
         0qOtghcgki5AAafiCwMhgx1VlB8jWNJANAnhQVbGBfbedhDtRJWJ+NaHqKzt4XL79k8Q
         /2lTMT5qNui6+CN77tQvrtp9XPxBOkrqdPsUZw1TqgSk0MT8I2WfK1zveqEj1IOrwTHv
         sDZg==
X-Gm-Message-State: AOAM533NYYMCO5D5UBR23W+mKhECGL5fkviMtkIBVpE8lWDgarKu5m0W
        gSZ6Ege1mcGC3ALf63yjCi4pXN+q4Wtu8RbIRYU=
X-Google-Smtp-Source: ABdhPJyjeX9akdEf/RuGH/Q17gt5cyRtdcyppYt3wLVuxPcQ1tZjaAft84WEeGuffcm8zyVLfvWSyMIRng0kLQAYcrs=
X-Received: by 2002:a17:906:85d8:: with SMTP id i24mr36091538ejy.451.1632252102971;
 Tue, 21 Sep 2021 12:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210920203735.675-1-linux.amoon@gmail.com> <CAFBinCB682kFB47=K5-Pod5cbrnNTtKdAj3i8PHrxj8VxOH8FA@mail.gmail.com>
In-Reply-To: <CAFBinCB682kFB47=K5-Pod5cbrnNTtKdAj3i8PHrxj8VxOH8FA@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 22 Sep 2021 00:51:32 +0530
Message-ID: <CANAwSgRtZoAmMO-WtRBX4W4pTkmzJKH1zc=6-99Py-d_4cOR0w@mail.gmail.com>
Subject: Re: [PATCHv2] regulator: pwm-regulator: Make use of the helper
 function dev_err_probe()
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, 21 Sept 2021 at 11:04, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Mon, Sep 20, 2021 at 10:38 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > devm_pwm_get() can return -EPROBE_DEFER if the pwm regulator is not
> > ready yet. Use dev_err_probe() for pwm regulator resources
> > to indicate the deferral reason when waiting for the
> > resource to come up.
> >
> > Fixes: 0cd71b9a43ad ("regulator: pwm: Don't warn on probe deferral")
> Personally I consider this as an improvement (having the deferral
> reason show up in debugfs), not a bugfix.
> Because of that I would drop the Fixes tag.
> Let's wait on other people's opinions though.
>
Ok will drop this in the next version.

> [...]
> > -                       dev_err(&pdev->dev, "Failed to get PWM: %d\n", ret);
> > -               return ret;
> > +               return dev_err_probe(&pdev->dev, PTR_ERR(drvdata->pwm),
> > +                                    "Failed to register regulator %s\n",
> The message here should still be similar to the original one since the
> actual problem is that we could not get a reference to the PWM
> controller. At this point we are not trying to register the
> pwm-regulator yet.
>

Yep, Typo I mixed up the logs completely.
it should be  "Failed to get PWM, deferring probe"

Thanks
-Anand
>
> Best regards,
> Martin
