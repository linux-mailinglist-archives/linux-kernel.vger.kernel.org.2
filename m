Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7AE373126
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhEDUDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhEDUDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:03:38 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A25AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 13:02:43 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 76so8070966qkn.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQZCBZa+DL4hkqaW8G2In/CkuXl76YVF2oGiLQ+6dDI=;
        b=Wpq5ejVrP9YM1gsTemrlmMP7Q2mn0VOB7h7YsWC+mn5e4Jr4jHi1ngCnhAIF1BYNNR
         Zk+DJuuRFBwEGDQs1HwsXKWJVLDV6goV8+IRs7tBG6I2okLDGOHw+33AEGkaf8rEy3lM
         NZIOE/q+miK4dIRqYiD5L0RLPiT3NDL1+4MKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQZCBZa+DL4hkqaW8G2In/CkuXl76YVF2oGiLQ+6dDI=;
        b=VcrxWJmv0cIknxQfuo1J2GX/DgHBX8/76n9MBpd1FETaXMfD8QutJ/W1DTBqxbBoe+
         UC0UqMrNCcmnU34zQiwJq6uth89PXgpvH+rNRRu+xiCeix5hKgqGdChM6h+/2cF0b9Ng
         8QCHtwi5zZEZh+SVSsFGC2zSO8FpvmzzW6m5b5Yu1DZ+wovubO3CQnqwysP4WNhLXqwm
         23Ctl05j8fUv/koy68Olo8dVA1+pZrFqXUwayrsg0UpoG/P//9T6BDZdISJBIl89vdWG
         pW9/9AsRSV/FjivKtsAye2zuFmLpokMQ9pC7XY7FZqa6Y5sHuc++UPe2uwzle4GWPGI7
         Q9ig==
X-Gm-Message-State: AOAM532yMbms9054jH679YXkDwx2w8VqiK9sE1FaxKvsTUXtVVkFbkHB
        5sMbnkqseUnTq8CZPluaqqGWaNPMcg/Z3g==
X-Google-Smtp-Source: ABdhPJw2xMNg6JUNk6Atz9tQJVPQOwK/sqNbEzfmqfhOcacGcnXo00hHo7uusBaeg9r9t5uS22vNIg==
X-Received: by 2002:a37:c202:: with SMTP id i2mr25725332qkm.296.1620158561653;
        Tue, 04 May 2021 13:02:41 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id l71sm11817828qke.27.2021.05.04.13.02.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 13:02:41 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id v188so3719538ybe.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:02:40 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr34873607ybp.476.1620158560412;
 Tue, 04 May 2021 13:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <1620111510-31455-1-git-send-email-sibis@codeaurora.org> <1620111510-31455-3-git-send-email-sibis@codeaurora.org>
In-Reply-To: <1620111510-31455-3-git-send-email-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 May 2021 13:02:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vng40b05F2_i7qqXC+yN=ZBgRXsio-86sBA+QdoMMGaw@mail.gmail.com>
Message-ID: <CAD=FV=Vng40b05F2_i7qqXC+yN=ZBgRXsio-86sBA+QdoMMGaw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 3, 2021 at 11:59 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> +       cpu0_opp_table: cpu0_opp_table {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               cpu0_opp1: opp-300000000 {

It seems like it might be nicer to give the node labels a less
arbitrary name. How about?

cpu0_opp_300mhz: opp-300000000

That has advantes:

* If, for some reason, you have to mess with some operating point in
another dts it'll be less fragile.

* It'll make diffing easier between SoCs.

* If you end up putting a new operating point in the middle you don't
need to rename everything below.

Other than that, I can't say that I'm a huge expert on the
interconnect stuff and whether those make sense, but I'm still OK
with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
