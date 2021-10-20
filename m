Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6D6435280
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhJTSTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhJTSS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:18:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B0CC06161C;
        Wed, 20 Oct 2021 11:16:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y30so295877edi.0;
        Wed, 20 Oct 2021 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Jn7WfTLu8jwkYeAj+iAPqeRaBH+HlGXHIsBLIJGA0w=;
        b=l5Yp4jOV8szTGfylg2ypOzkihdNd0JdPDwuRrgRvQ0UeaaqS+v699603BDGKO04VpU
         54pyLP19VJL8QATcdVqcQrIb8veUCHvxIaUQpTyv6rM3jys8kvaaUADch1PMcXXFlAP/
         vzZL4/vqsidX45IZn4mhpGae11IxaphvXsBKdlEs0WUybA+2HDL/iwCg7gcvQFWcrBIn
         xq0TExqOLZoQizipb86+q/50cQTDEPRQFI7Yss+qWPDrC88aeIDS74uA2gQIdjYUAjiS
         oW3Ux2/Y/F3LvJ8gUqRQ7CnxOggbgk/nrYnbyqX3lusPCZN25TGi8ev6D2HfNBwbRBls
         nNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Jn7WfTLu8jwkYeAj+iAPqeRaBH+HlGXHIsBLIJGA0w=;
        b=PXpVAIbToG0hOGgAnBrVOaTlMvOB9ojiJ1lAVImJFDSG1aAOY81/odm3slZiyIZopx
         7sPedpPflQDr02l1xK8tsPzDUWvZHONRoDoKjfKvfgqwBZXapqHYWRbQ9r6mFMBce2L2
         ABvw791k3x7bJJBzhKf2jrItyybHiaxDHD4Or2TGv1TpxF67KwtcpQpcKFaMbSzwztBK
         MFcduCHZLJUaBqygeTJ3bJAo+pBMZuB2K6oeHuAJQvOkEW3xYMuH1FxBLqT6fO4ZxCvg
         xhjiF3pYIlrRHZ3MnsawwrGhlWIYb1unSqGK63uvXyU/sfKAAsMcHcndo0419r+eYzYu
         lBKw==
X-Gm-Message-State: AOAM530rS5k7+mzVF2BzHoFpxeTclShrFqSQzATsZmYW/tDnsVfXvC/5
        DEydHbAnrHekRPMrmGuu86iNFblNIgZdM2GKeN1kdugwekc=
X-Google-Smtp-Source: ABdhPJyMGVsnf3QU6/teL21jshD1FVHfAlbBDN7+Ikc/9F0vhYqmSUmw7uXsudjF0O7XdetHc3yt4e40gU9EQaMKYDw=
X-Received: by 2002:a17:906:f2cd:: with SMTP id gz13mr1093501ejb.278.1634753800493;
 Wed, 20 Oct 2021 11:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211016145939.15643-1-martin.blumenstingl@googlemail.com>
 <1j5ytuvdmw.fsf@starbuckisacylon.baylibre.com> <CAFBinCBGZi3MRqTRshyCkq8AAaqHi2NkZVV80ppZr4Lx=xWOWA@mail.gmail.com>
 <1jmtn6tu99.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jmtn6tu99.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 20 Oct 2021 20:16:29 +0200
Message-ID: <CAFBinCCRWS6j=6hDo_sOBmQZw5X8L4GYP=rHQVqHd04keCrbuQ@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: gxbb: Add the spread spectrum bit for MPLL0
 on GXBB
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, Oct 18, 2021 at 2:03 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
[...]
> > The difference here is BIT(14). un-setting BIT(14) (documented as
> > EN_DDS0) did not change anything according to Christian's test.
> > That also means that SDM, SDM_EN and N2 have the expected values.
> > I manually did the maths:
> > (2000000000Hz * 16384) / ((16384 * 6) + 12808) = 294909640.7Hz
> > which matches what clk_summary sees:
> > 294909641Hz
>
>  ... and (2000000000Hz * 16384) / ((16384 * 6) = 333MHz which is fairly close
>  to what you get w/o flipping the bit
This is actually a great hint. So far MPLL clocks have "just worked"
for me and I didn't have to work with this.
With your explanation it makes sense that SDM_EN makes the hardware
use or ignore the SDM value.

[...]
> For example yes. I am asking check a bit more what this bit does and
> what it does not:
>  - I need confirmation whether or not it does spread spectrum. Yes this
>  needs to be observed on a SoC pin, like MCLK with a fairly low divider
>  to the averaging effect which could partially mask spread spectrum.
I did some more tests with Christian. It turns out that on GXBB
HHI_MPLL_CNTL7[15] has no impact on the rate seen by meson-clk-msr.
On the other hand, HHI_MPLL_CNTL[25] makes MPLL0 use or ignore the SDM
value (again, verified through meson-clk-msr).

>  - Get an idea what it actually does. The 2 calculations above are an
>  hint. (Spread spectrum does not change the rate mean value)
Indeed!
My conclusion is that on GXBB:
1) HHI_MPLL_CNTL[25] doesn't control the spread spectrum setting of
MPLL0 - just like you thought
2) HHI_MPLL_CNTL[25] is actually SDM_EN (and HHI_MPLL_CNTL7[15]
doesn't seem to have any impact on MPLL0's output rate)

Please let me know if there's anything else we can test.
Else I'll send a patch for making HHI_MPLL_CNTL[25] the SDM_EN bit of
MPLL0 on GXBB.


Best regards,
Martin
