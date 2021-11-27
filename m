Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C8345F75E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 01:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbhK0AN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 19:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbhK0ALz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 19:11:55 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624E5C061759
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:07:29 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so16071227otl.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2HF76KcOCpHV3kuvi2/xR1KNm8Hz25hSAVb7rqNIgM=;
        b=PNsJQ/hzI80GS8ChdxrJ8rDSii7NuxrFjHBEyi4D8wfM7x1y62op6LIlJOYn6CKyRg
         R6HBK9B9H6EVnE05LEs/tp6P5pPeBP1RnHEM6Hiveib2IaYrv/6BWCV3WmwtqofKlR6V
         mgAw9MeZccGAkFa0yvk2eheL4uYQ1/6So/ubrcMjZol2HZjUN/OKgU+id2YTBGlmco3O
         Ue5BVOlddld4fLoAYVcOjx4AIHzKMIDZyJlY9AjF4Mw8Odcvb0Tf4cF6YuS0lbxZxtc0
         Jk/kEQdRZUQ4HbiHDvD4xYywrsH83AT7ARPN7UHoXYT5ReCM83TDvJG4sy1sOi+6gur7
         JY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2HF76KcOCpHV3kuvi2/xR1KNm8Hz25hSAVb7rqNIgM=;
        b=CqCKYxfg56i4PGOU5FuXuUFIBl1+sdC/RA51ZPrVzm0VgVKQBcfCI2TNXUXyuffMdQ
         +fI8xK3u+FMkXXrsG59zuPcRwFnvOliuQqaar+Ht7LFzbwPEDVYLLd7z8h6/NIjOb108
         pOpvNbIu87Hat1jtE5c9rEHbLSV3AqkwINfEigM/fx+B4HzUtYpCWneG8H0I5hDOYuKc
         qqq5ToUcltFKjdjgbb+fLVCKyTwhBb7VhECHwZR65xVPOvn2EOtedCcTy1OGHbc4O6fF
         udhZxs6RT5XgBUR1cWCi/HpDD8xkvDciGJnwFuzAnXe2HrP3hEdzCxe+Cszai7FZmg0u
         97SQ==
X-Gm-Message-State: AOAM531r7mkxegP+btee7xXEt3c8z8Wxlb8SKjSvliA/aNpPI33K+eB9
        3/3ZvWOxmZnnsIwc8y/eEqKLotlP1p/uYsontlatDw==
X-Google-Smtp-Source: ABdhPJwBhJSWOOSQy9TlF9sCXXA+cQsoSR4z9HhTWvjYkAmQ8zkutOBwqNSsdNKrRe5EYR6jLXQTtTJuVDqiPChO4bk=
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr30047235otl.237.1637971648785;
 Fri, 26 Nov 2021 16:07:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637048107.git.quic_vamslank@quicinc.com>
 <06234768890dc7572226f23d432e5a69a4d5b305.1637048107.git.quic_vamslank@quicinc.com>
 <YaFZTxDcTMqeA/42@robh.at.kernel.org>
In-Reply-To: <YaFZTxDcTMqeA/42@robh.at.kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 27 Nov 2021 01:07:16 +0100
Message-ID: <CACRpkdYpCmhXhJV1x42hu6QoncXX7eWcGPk22de19sSEC7B=oQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add SDX65 pinctrl bindings
To:     Rob Herring <robh@kernel.org>
Cc:     quic_vamslank@quicinc.com, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        manivannan.sadhasivam@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 11:01 PM Rob Herring <robh@kernel.org> wrote:
> On Mon, Nov 15, 2021 at 11:39:45PM -0800, quic_vamslank@quicinc.com wrote:
> > From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> >
> > Add device tree binding Documentation details for Qualcomm SDX65
> > pinctrl driver.
> >
> > Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  .../bindings/pinctrl/qcom,sdx65-pinctrl.yaml  | 195 ++++++++++++++++++
> >  1 file changed, 195 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
>
> This fails dt_binding_check:
>
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.example.dt.yaml: pinctrl@f100000: 'serial-pins', 'uart-w-subnodes-state' do not match any of the regexes: '$-state', 'pinctrl-[0-9]+'
>         From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
>
> The DT list was not Cc'ed so checks never ran nor was this reviewed.

OK that's annoying, I didn't notice it wasn't posted to the DT list.
I reverted the patch, Vamsi can you please reiterate the patch
and include devicetree@vger.kernel.org on subsequent postings.
I have kept the kernel code in place, optimistically assuming the
bindings will be fixed soon-ish.

Yours,
Linus Walleij
