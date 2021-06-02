Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD59399107
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhFBRB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:01:59 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:40661 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhFBRB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:01:56 -0400
Received: by mail-qk1-f182.google.com with SMTP id u30so3057530qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krdPBd6E7hUIUxi1Nz7QlKa3o1eOrT+mUsytvFlZevg=;
        b=U2j0n5Ddssabjjp0li32g/LWz+4f0D8lev5wNe2y7k+iTDXO0Np8412sKQ4hKlqrp3
         rmaStCsnD5f+Q0MCd3RxDfdsouDw+BPK800ob4up7LWuJP6bQGxLAzPFR7oaEVDaC6KW
         yYkxlTIqLZnX9X1s6kIDjUxZCvA5efeYXpE+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krdPBd6E7hUIUxi1Nz7QlKa3o1eOrT+mUsytvFlZevg=;
        b=JaIplTaEIG18izxOV98vN8RX+WFBypESUzNUgWRGrtaGCXgi5Qu0rPboDSqAW8FDrZ
         o0ahJ5AfkieDcpW/IUhP1XWA5lQh1lJYXAC+Jr2bt4BqjjJHyLF59S6XZy6jFcOWYE3e
         FUp/HIKWqEI8cRnGYBAoB9QSp/LnBNvkfcRR5VFZhlOpaF3f1uP0pikpw8ujbGqcy2G8
         A8F0eoYja4itK5tG/Bm0EkEPL9aI1RIIzgg9YEd+zSQPtA9jWtN0yQhnsb0LYwRoreG4
         H60OkbLVFV7ekML29z2MhTlYm1tgfgapSuvXCX4Ja4iMKhaF1fYtYfAxRoXGdp/sPq7I
         DGsQ==
X-Gm-Message-State: AOAM531L+BNwil1RnXOuvbbIDOjb9xEA161550Y+jUWa031vlnlvVvnT
        yUZG6/JmxrrM32NyxubeRk5uarAgRteILA==
X-Google-Smtp-Source: ABdhPJxH5d1woR673jS4Hkbvxs0LcdX0vmaH/IPn9Ix3jEBxUsqa6FjBb5RNyV0xVPxf1oay7chNyQ==
X-Received: by 2002:a37:a45:: with SMTP id 66mr28776075qkk.138.1622653152558;
        Wed, 02 Jun 2021 09:59:12 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id t139sm175730qka.85.2021.06.02.09.59.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 09:59:12 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 207so4822725ybd.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 09:59:11 -0700 (PDT)
X-Received: by 2002:a25:b801:: with SMTP id v1mr51811091ybj.32.1622653151565;
 Wed, 02 Jun 2021 09:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210601184417.3020834-1-swboyd@chromium.org>
In-Reply-To: <20210601184417.3020834-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Jun 2021 09:59:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X52FyU7F4itVjegwTdX9L40Qpb33sdSvi_=McH4KxVrA@mail.gmail.com>
Message-ID: <CAD=FV=X52FyU7F4itVjegwTdX9L40Qpb33sdSvi_=McH4KxVrA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Disable PON on Trogdor
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 1, 2021 at 11:44 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't use the PON module on Trogdor devices. Instead the reboot
> reason is sort of stored in the 'eventlog' and the bootloader figures
> out if the boot is abnormal and records that there. Disable the PON node
> and then drop the power key disabling because that's a child node that
> will no longer be enabled if the PON node is disabled.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Right. So essentially you're saying that the bootloader on trogdor
(coreboot / depthcharge) doesn't do anything with this and thus it
doesn't make sense on this board. That sounds right to me. Basically
there's no way in userspace to tell the bootloader to reboot into
recovery mode or developer mode. Those things need to be initiated
manually by the user.

It's possible that Qualcomm internally has some out-of-tree patches
where they use the PON for ramdump mode. +Rajendra as an FYI in case
there's somehow he should give a heads up to about this.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
