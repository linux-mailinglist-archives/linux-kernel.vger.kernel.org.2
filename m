Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B1941C823
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbhI2PTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345127AbhI2PS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:18:59 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C70DC061760
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 08:17:18 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n71so3667862iod.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8yIlNe1wteWFB7lp9PoXm9bRdu16IElht81lO++2aM=;
        b=Y49oozr3mkIPyTvRc+zx4f6Oq3JfSFzuGoKqU5eJszrBT58SW2xZBdmA0vn8dzZgaX
         soKRG8eLnTsuy2M944uVoxGtEJpgZTHU1Jez+9TKBDP8+ILHfoWnOdQVpPC/wsCbv0Am
         KPJu/6jRnbTO3MEw5fq/wp6gUFSEmTvKBrQkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8yIlNe1wteWFB7lp9PoXm9bRdu16IElht81lO++2aM=;
        b=PQi91S1KxNsL+DZLD9UF1LH3xFrnDb+SBJpIN+H5SLKypgTLpm6iKqUyggBcoVKg+X
         Ya8dqyKGay69Ue5iS2fTAQVygg06KZ60cMDB4OKwOrrCwQ18kyOvK1tuD7S0Hu8xdoxy
         NW19JwzuoCBRRA4NMf0wSB0lH9fZOr5A4EYuElIQVZyVLOl27xansg2rQfp6az3iN3aw
         gPlvVLsb2t2LR11ZEfMm2eH9QOFogQf+WbBjcjQhjBozyM917M9/VBmnj5Ni+bE5ol8v
         SiZ6rv5R2re8MAztiYWpAbw2lKtQsskqWrmFM6awmUP0++Qc4YOBgpN5u/1arEEJesc3
         CdXA==
X-Gm-Message-State: AOAM532LpLYSfDKPe/MNydgPRtv3Vx6pXsCrGt0Csj34yAQ6BuTGofs9
        5qCfeoSs186sKx5yNtFAQ0ecD1QuaSWqPg==
X-Google-Smtp-Source: ABdhPJzlNb9DKE1sKxTjMvIQwp7fxXsorLUSd6s4takX74AzN6U5GUguic2G6O7167N+d+rQnNdLkQ==
X-Received: by 2002:a5d:9813:: with SMTP id a19mr290589iol.74.1632928637671;
        Wed, 29 Sep 2021 08:17:17 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id v17sm77449ilh.67.2021.09.29.08.17.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 08:17:17 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id d18so3545162iof.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 08:17:17 -0700 (PDT)
X-Received: by 2002:a05:6e02:19cb:: with SMTP id r11mr151712ill.120.1632928288363;
 Wed, 29 Sep 2021 08:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <1632892123-11006-1-git-send-email-rajpat@codeaurora.org>
In-Reply-To: <1632892123-11006-1-git-send-email-rajpat@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 29 Sep 2021 08:11:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XHaf-EQ9Uonr=B6QYp+wXcdasmdu=v-bdwWniveN-Asw@mail.gmail.com>
Message-ID: <CAD=FV=XHaf-EQ9Uonr=B6QYp+wXcdasmdu=v-bdwWniveN-Asw@mail.gmail.com>
Subject: Re: [PATCH V1] arm64: dts: qcom: sc7280: Add 200MHz in qspi_opp_table
To:     Rajesh Patil <rajpat@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        msavaliy@qti.qualcomm.com, satya priya <skakit@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 28, 2021 at 10:10 PM Rajesh Patil <rajpat@codeaurora.org> wrote:
>
> Add 200MHz OPP in qspi_opp_table
>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)

Looks fine to me, thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
