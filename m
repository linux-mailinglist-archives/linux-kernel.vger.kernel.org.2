Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DD145517C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 01:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbhKRALw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 19:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbhKRALa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:11:30 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E84C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:08:31 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id t83so4455817qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4C6L5TBbU4kgfmUFag70eO6fcEy2Yq/sVXvugLd598=;
        b=Tfvu4+IvmP30SYOhevoNp0pfuZqXmoANyJyTw+T9nQpXvP0OceU3JmPy2TwjEmmgnY
         YCnAsdsgIPlAbV/vLjYrLISDvJ7eHxeb+CmsOwts/OSleMg/kyr+VCdRUslQnSkseD+H
         5IHZY8PPytSBOX9mR3VwcxCvDaoDS+VPqd8n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4C6L5TBbU4kgfmUFag70eO6fcEy2Yq/sVXvugLd598=;
        b=LzqIaS+EAdYcXdRuv95ki3K4NkOBVSp8J19KFc4kKQhOZpGM7HuUfMI0ubWfI7662n
         iaXzjKjeO0kfNR/AB5YEnh8Nab4HWpWEK1Ozm+ksbQLhYkjOoBSH5o536f12LJTkaeo/
         pgBOYahsDJcOE6vft9wGROeIIrNCZhr+MSN5XOYQ3YbWfp0FvQMHzXz782vhgCvfFyR0
         BM+2gDaT2awiNchHjvG1lQ8O2SaXrTouREfS/TiWzsYtkfRakm6XeZq2OZQiAYcx1Xso
         evbXKETbcBpbEiAbH9C5ZzR8VaY8TkK1W3BfsGOlsqwNaxFfsOJVbHmzU6y2eyY7mWcF
         672Q==
X-Gm-Message-State: AOAM531UnbuepJSr5ZlPEDgO/5TH1YDSXcMTquzMY+uFxPWxYIlZoEUm
        Rr30Zki3nKxm0s+y7VlxecCngTW6k/cWUQ==
X-Google-Smtp-Source: ABdhPJyHr/xnoV3jZ1eCPall6RApRRcpbWbSdyF5KRJW1CO6mhnnr9iyKYWWXfQYn9jbBDsoaRXOWA==
X-Received: by 2002:a05:620a:c4a:: with SMTP id u10mr16754443qki.69.1637194110065;
        Wed, 17 Nov 2021 16:08:30 -0800 (PST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id u17sm835769qki.2.2021.11.17.16.08.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 16:08:29 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id m25so4368410qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:08:29 -0800 (PST)
X-Received: by 2002:a05:6638:2590:: with SMTP id s16mr17017643jat.93.1637193802654;
 Wed, 17 Nov 2021 16:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20211116200739.924401-1-mka@chromium.org> <20211116120642.v17.4.Ie0d2c1214b767bb5551dd4cad38398bd40e4466f@changeid>
In-Reply-To: <20211116120642.v17.4.Ie0d2c1214b767bb5551dd4cad38398bd40e4466f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Nov 2021 16:03:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WK3uHJTehMxWiA56L5Ly8UqjmCKnJtXBut2aOYEV6C4g@mail.gmail.com>
Message-ID: <CAD=FV=WK3uHJTehMxWiA56L5Ly8UqjmCKnJtXBut2aOYEV6C4g@mail.gmail.com>
Subject: Re: [PATCH v17 4/7] arm64: dts: qcom: sc7180-trogdor: Add nodes for
 onboard USB hub
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 16, 2021 at 12:07 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add nodes for the onboard USB hub on trogdor devices. Remove the
> 'always-on' property from the hub regulator, since the regulator
> is now managed by the onboard_usb_hub driver.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v17:
> - none
>
> Changes in v16:
> - none
>
> Changes in v15:
> - none
>
> Changes in v14:
> - none
>
> Changes in v13:
> - none
>
> Changes in v12:
> - none
>
> Changes in v11:
> - rebased on qcom/arm64-for-5.14 (with the rest of the series)
>
> Changes in v10:
> - keep 'regulator-boot-on' property
> - updated commit message
>
> Changes in v9:
> - none
>
> Changes in v8:
> - none
>
> Changes in v7:
> - rebased on qcom/arm64-for-5.13 (with the rest of the series)
>
> Changes in v6:
> - added 'companion-hub' entry to both USB devices
> - added 'vdd-supply' also to hub@2
>
> Changes in v5:
> - patch added to the series
>
>  .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts | 19 ++++++++-----------
>  .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts | 12 +++++-------
>  .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts | 19 ++++++++-----------
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 19 ++++++++++++++++++-
>  4 files changed, 39 insertions(+), 30 deletions(-)

sc7180-trogdor-pompom-r1.dts is missing? It seems to need similar
fixups to the early lazor/trogdor borads.

Other than that this looks good to me.

-Doug
