Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E04C3A3B61
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 07:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhFKF3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 01:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFKF3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 01:29:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A01AC061768
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 22:27:31 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r198so6748348lff.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 22:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5gXsKjQ+2+2284C7oSdijmBbkdjN+0NbjWEbQpWHs0=;
        b=x+D4hIAty3oWf9qpo//b+wT4NFnC/7Z+GH0sd5q0MbdyLgyp/+EG8f2KxBMIT5FgC4
         wMPT9mRU3seonnJ+6lrKTRNdPFQA59UJ3C5FsPJW2ddb/BsxkfcSIxIwLEmQgJXrnvKb
         a7+oqJEDwBtaP1NogddNoP1Pr8dJyyCwCiu4KMdV0KDS1tnMjlSCHJ7HjKjOA229pd5X
         q/PsEG1+ncaCra591SGqkQLGJv2fixOpL5CNE02wSCrHzLgr9k+HnN8uSC5NW56oRgiC
         JUi/ONCB04hlpkBa+GSQCTnj46h3FADmHbh/32Hd/I7sVvkaaFbzRUXZrjOxMolj1QMN
         s2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5gXsKjQ+2+2284C7oSdijmBbkdjN+0NbjWEbQpWHs0=;
        b=XYIMZb0qTYCTSyeRis832vT9Tw4qEEP6H7oyIltSKpEhFOcb5rcrUjwK6VkD9OrqRS
         HHfsHuW6Yx8jfu05S0W3bcIWw5W9e8GhnK6AsWpmUCSzMaWpNsPJCMDIFV48yVEfdX48
         TBmWYnrfkHfJPaeZUJIEaq6yvP9gNNGtsmoS/SPe56s3DPAFEwjct+YZbQzTMjKOuHQp
         HqrEGCLtqgRDjWWeAFbk8SqxmIIKsmBi4dVdmFevsF1uV1eGlJ1mPA178D4lRgd3XX5F
         rfAX1u0FEv2bj3vrq3AEpuSTj7JOQRe8wD8ZMcJK58+FpfYfcft+bfeZtzwZ1R8KjVcA
         J9LQ==
X-Gm-Message-State: AOAM530SZimNtwPcfKBgBRcd3yDcO74m0WQPxE7hSeHBMApdaP0mBGXm
        2cituJjnETqBsQgT1KYIBIoLKyKSsIbSi7+x3lUvpA==
X-Google-Smtp-Source: ABdhPJyZKyGtiOfPRcMJrZvtA9TUzOVyTDzCtTLxsHXMG9F/620ulxn/5HTE5T/itY0AbUbfS5C2fqnKM289cctkk60=
X-Received: by 2002:a05:6512:3a84:: with SMTP id q4mr1491503lfu.626.1623389248682;
 Thu, 10 Jun 2021 22:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210611050808.2554431-1-vkoul@kernel.org>
In-Reply-To: <20210611050808.2554431-1-vkoul@kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 10 Jun 2021 22:27:16 -0700
Message-ID: <CALAqxLW4n8ijkD6hw_xqa2tzkttmXS_LFn_yJo6cP+iYYt-+=A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm8350-mtp: Use mdt files for firmware
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:08 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> As discussed in [1], it makes it easy for everyone to use mdt firmware file
> name instead of mbn ones, so changes this for SM8350
>
> [1]: http://lore.kernel.org/r/CALAqxLXn6wFBAxRkThxWg5RvTuFEX80kHPt8BVja1CpAB-qzGA@mail.gmail.com
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350-mtp.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
> index 93740444dd1e..d859305f1f75 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8350-mtp.dts
> @@ -40,7 +40,7 @@ vph_pwr: vph-pwr-regulator {
>
>  &adsp {
>         status = "okay";
> -       firmware-name = "qcom/sm8350/adsp.mbn";
> +       irmware-name = "qcom/sm8350/adsp.mdt";
>  };

Uhh, isn't this the opposite of [1]?  My apologies for butting in, and
I'd stay out of the discussion, except for my mail being linked as
justification :)

In [1] the case was db845c was switched from older mdt files to using
the upstream linux-firmware mbn files. This was a bit of a pain, as it
broke on our userland with mdt files, and since we use both old and
new kernels we had to have both filenames on the disk (via symlink) to
keep it working everywhere.

My argument in [1] was for new boards, go with the new conventions,
but we should avoid breaking those conventions casually on existing
devices.  That said, I know it's more complex, and I graciously defer
to Bjorn and RobC on the decision.

But your patch above seems to be switching from mbn (what I understand
to be the new convention) to mdt (what I thought was the old way). And
from the git blame, it looks like it was introduced as mbn (new board,
new convention - so all good, right?).

So is this really the right change? Or maybe just more exposition in
the commit message is needed (rather than pointing to my mail, which
seems to be arguing the opposite) to explain it?

thanks
-john
