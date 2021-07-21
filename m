Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27053D125C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbhGUOqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbhGUOqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:46:39 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD10FC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 08:27:14 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id a22so1645934vso.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+G3Vv4B1XazSc4gX4wiFgRgrHQ34F/awuea1pT1nKk=;
        b=FTb1NMduBfSAFMwVExJiFCVoQxRqCQcCQW6kpI0C7rpfB/MokLphIaTraL/H+IG1Pu
         0983bvNl5MZU6WHpzdrOGHl2rGyZf7kerto33svOS8jHphkEFisuAiUNgFyp4DwF7wCh
         r5d4XsJPVY8bkYvgYUxbmfLrVIMQNQwDYCc1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+G3Vv4B1XazSc4gX4wiFgRgrHQ34F/awuea1pT1nKk=;
        b=tRFhnyCdYY04TP7IJkCT7dp6XrZbKr9PvDR1nmJiOg7/xikfk8JfrmLbDa3btPm7Je
         aEp+c3SQFasiQ4OrXoaW6MUtReOw6DIA8XmWiEraBFmqSTuTKSal2xtvpvI5wDtFSwtZ
         nUNAr1K41bN0Aa6RUqPh2jwvZYHNvqMEH7EDFe3uuppbCqkjInpYfHGRU0LLQzhTko1i
         /Hvgb63z2PCs/D7GPt2VCIio9axuAnIC4OWJeu1D+bMHKWu3X1rD2lHn4wdsdc90Rz2T
         y24JXXkUdamuHqGK4mua1Z5v1VV///TYZP/RrgeAYP+GLZGbseZSsOMEKdjdqNZBG7Md
         1Smg==
X-Gm-Message-State: AOAM531CmEEi5Z3PQarEPKFuAqDsxxuZNendYK7VXbHxqQTAOB/cwXxd
        coMTdXGmCoWCxJZoVoiM4Rxi6aPoLC+eOg==
X-Google-Smtp-Source: ABdhPJzgDCJVwubaOIvoZB/xkdTPRn09OyOmxyHm1H/jmyfVXwTBdUtu4U0Hfh6zGEseriQzLVPlsg==
X-Received: by 2002:a67:5e42:: with SMTP id s63mr13579871vsb.21.1626881234090;
        Wed, 21 Jul 2021 08:27:14 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id n7sm3388692vso.4.2021.07.21.08.27.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 08:27:14 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id f11so970922uan.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 08:27:12 -0700 (PDT)
X-Received: by 2002:ab0:c07:: with SMTP id a7mr37239648uak.120.1626881232268;
 Wed, 21 Jul 2021 08:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210625045010.2914289-1-judyhsiao@chromium.org>
In-Reply-To: <20210625045010.2914289-1-judyhsiao@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 21 Jul 2021 08:27:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VXULSZXqt-wjMWC4YqehGJsoeC0G=Kuut0xPPKo9AEWQ@mail.gmail.com>
Message-ID: <CAD=FV=VXULSZXqt-wjMWC4YqehGJsoeC0G=Kuut0xPPKo9AEWQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: trogdor: Update audio codec to Max98360A
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Dylan Reid <dgreid@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Judy Hsiao <judyhsiao@google.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Judy Hsiao <judyhsiao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Thu, Jun 24, 2021 at 9:50 PM Judy Hsiao <judyhsiao@chromium.org> wrote:
>
> Use max98360a dts node to correctly describe the hardware.
>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I noticed that you landed several dts changes recently (thanks!) but I
didn't see this one. Was there a problem with it, or did it just slip
through the cracks?

Thanks!

-Doug
