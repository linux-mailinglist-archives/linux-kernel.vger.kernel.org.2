Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC13E9B08
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 00:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhHKWqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 18:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhHKWq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:46:29 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2682C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:46:05 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r72so5757555iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjRZSg+FXeB6OVDD4blHXzlgwCr3hJcyHvFtKEVHOmM=;
        b=TzLuJ5rh2/btnG4ZbzYQCWePh2DQwoyJSunPxCznB6QmPW56nNHMa4K1tOj7b/wETx
         n8rjWB+JFzOzEL0t81K886ggn/GcAyuKaFifuSsweCUdMsEIiaHQf3K98dWztpgZsO5p
         TeZ/xgqM3JS0bjZGfL62ZwQJp0XFa88V0uuzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjRZSg+FXeB6OVDD4blHXzlgwCr3hJcyHvFtKEVHOmM=;
        b=hPyf2XWTohmpPBdgKudTIiprfuuXxkX5wgxsNiZzxNhPXm8zfvpEY5QSq+C0UL8/n4
         +AkbvYne3ivULqBqUv67EzELqBsjkztpB0RJgN1MlaWqv6KLx78QVB+8v5AfB61HPqK4
         7hiQFIt1MG94dy/ve29cMNcEtV2ue2fPUTZJARGGDfxAMzKqLSxGPn2cgjmllJPqgmoH
         5aggz8KiSOCeJX55t51EuGL1/orQGcPbHroeRxNIhuKQLGDYPwuReUw0ra/b6HcL8lFZ
         ojKHE4O325mDtGCCuzic4hUJbcuWLefJUmixhBgc9QAgaxB4K7ziR4fbwp+nWLzOFd8q
         BDRg==
X-Gm-Message-State: AOAM531vzxYkV/XQWnO6cHcvBvAnokGMQgDxh+Mdsf8wK/Pjxq5gTMxN
        HOa3Ucg+nw2sMJ1gGifMbQDzY9qyNieRAL8X
X-Google-Smtp-Source: ABdhPJxwihB2HbhfZLJMw/Fz5pYkafER9vmeQIKJBMFgffRybUbOXlbB9Xsm7XzSy3ld+GYidLhwjQ==
X-Received: by 2002:a05:6638:449:: with SMTP id r9mr955083jap.137.1628721965130;
        Wed, 11 Aug 2021 15:46:05 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id i3sm354046ilu.46.2021.08.11.15.46.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 15:46:04 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id f15so667161ilk.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:46:04 -0700 (PDT)
X-Received: by 2002:a92:cf4a:: with SMTP id c10mr559866ilr.269.1628721963809;
 Wed, 11 Aug 2021 15:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210811224141.1110495-1-swboyd@chromium.org>
In-Reply-To: <20210811224141.1110495-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Aug 2021 15:45:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XKrSfinnZjPPstY0jDX4cP7adAKtCcKFOo5q2=DH+d7w@mail.gmail.com>
Message-ID: <CAD=FV=XKrSfinnZjPPstY0jDX4cP7adAKtCcKFOo5q2=DH+d7w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180-trogdor: Fix lpass dai link
 for HDMI
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 11, 2021 at 3:41 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This should be the dai for display port. Without this set properly we
> fail to get audio routed through external displays on trogdor. It looks
> like we picked up v4[1] of this patch when there was a v7[2]. The v7
> patch still had the wrong sound-dai but at least we can fix all this up
> and audio works.
>
> Cc: Srinivasa Rao Mandadapu <srivasam@qti.qualcomm.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: b22d313e1772 ("arm64: dts: qcom: sc7180-trogdor: Add lpass dai link for HDMI")
> Link: https://lore.kernel.org/r/20210721080549.28822-3-srivasam@qti.qualcomm.com [1]
> Link: https://lore.kernel.org/r/20210726120910.20335-3-srivasam@codeaurora.org [2]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1:
>  - Drop sound-dai-cells
>  - Replace hdmi-primary with hdmi
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

I'm no audio expert, but this matches v7 except for the bugfix setting
the ID for the `sound-dai` to be LPASS_DP_RX instead of 2, which
matches downstream.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
