Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013C634852B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhCXXTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239024AbhCXXTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:19:00 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3E2C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:19:00 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j7so400399qtx.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOQ7esl90KWEmnjDE6UGjHvYuLkknu4oxnEsJM3fbxk=;
        b=I8LLHJTXiSFwWG08KpCjmbhYHB4+bJ5Jr1PMvkhPb9guXt4kPXwXSDBb5w3pW6YKP+
         Y3MXDdkhlUigcRn9Soo3y9HjPiYeIjslYj/gs3Qu595nmPh/ErNtubV8ayh2yO3Z4/6B
         tB6bIdWPlgC++IeivTg9oL6lj9EFP1EHRtvFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOQ7esl90KWEmnjDE6UGjHvYuLkknu4oxnEsJM3fbxk=;
        b=nos1PAx9095g4slYm0JMYGZUj+rAfhE6GzDIADsrTEIdkoxs/US/8vjrqhbtp5vRFt
         V7d1jJ8AA1S+Tq1bl3B9u1ZZNe21wppzxigk1C23jPFSCnDhiDENIUwiUXOgERyX0Dxu
         A4NWui3iIj3amC1bMVoxFDOSFLorqw1dS6GyIY+CrJdiYlnO1fTUmNKpStkj3GNtUwgX
         fZQQ5RgskwMTJDunZDlzqBpm+/AGQZKzuo4jYkfqbii316z8XnZL/mf6orjPx/jVXric
         Fd/n2kpCzkd4h0Nw4txx+fb4roWJ7mD/t4cl6XrgOBWgYj5a1O+2jQ8VM6fDXh1ZaYvl
         aZ+w==
X-Gm-Message-State: AOAM530XY5t/Ibew4kIqdBW+b45bnUWoy8RaqjCJyUbQd8DodZNfPEUt
        N6Jt5ZLY9zaR6+JnwVzieGbcbm9nyI1JEQ==
X-Google-Smtp-Source: ABdhPJzUN6oNwo/qjUNOl0WFiWDqUz/zzESIDSSoi++D62OPkON38KxbsZ6ST8tWC9pOOdMpiKPuHw==
X-Received: by 2002:ac8:70d3:: with SMTP id g19mr5110977qtp.227.1616627939437;
        Wed, 24 Mar 2021 16:18:59 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id v6sm2725030qkf.132.2021.03.24.16.18.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 16:18:59 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id o66so320202ybg.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:18:58 -0700 (PDT)
X-Received: by 2002:a25:ab54:: with SMTP id u78mr8405375ybi.276.1616627938513;
 Wed, 24 Mar 2021 16:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210324231424.2890039-1-swboyd@chromium.org>
In-Reply-To: <20210324231424.2890039-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Mar 2021 16:18:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VQSzanPn03-98L5KT89rkz4D1CcNLrtz2pXOHW8XOORw@mail.gmail.com>
Message-ID: <CAD=FV=VQSzanPn03-98L5KT89rkz4D1CcNLrtz2pXOHW8XOORw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: c630: Add no-hpd to DSI bridge node
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 24, 2021 at 4:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We should indicate that we're not using the HPD pin on this device, per
> the binding document. Otherwise if code in the future wants to enable
> HPD in the bridge when this property is absent we'll be enabling HPD
> when it isn't supposed to be used. Presumably this board isn't using hpd
> on the bridge.
>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Steev Klimaszewski <steev@kali.org>
> Fixes: 956e9c85f47b ("arm64: dts: qcom: c630: Define eDP bridge and panel")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
