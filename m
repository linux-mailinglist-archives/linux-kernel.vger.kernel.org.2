Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2475E337FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhCKVzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhCKVyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:54:51 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91573C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:54:51 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id x10so22328430qkm.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3NToVMb7SyOcWd/eqRyCe7U4wiYDLs06rM6zg487v4=;
        b=Tw9Mm5ufk7p20s+L3uY8+zldTGCWGuQ5SIj+9jnt2SEBW4xfZEXuh0LutMljZFvcFr
         SWCo+l6lbEvuANlvJebP3XvWPa+bidF0dXQcTWNPmOGWznQBcfcbA7HZk0J7lQHXsKPk
         drHNU+8qTah0QZPvPkeO6jKoxRr5gougXcu1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3NToVMb7SyOcWd/eqRyCe7U4wiYDLs06rM6zg487v4=;
        b=P0QXwBV22KFElyzvJ9sKToGz2jMjupXHbDo5NEibroWIhVFK1cq6tywqoUDIBtsDDy
         8iErkw58eRo6noh1sCdPWLcVrI74CKZslwtmsVs3g9xWUJCkc+SIdPL3AIH+gjVsgOKu
         2jHwVm//q1lx6A/qN8eUaMw6Se0bzJZ5ny1YqKaQy1cQyy9I0TBxHQhY3HxxNNqIYjzh
         J95cT9C5yOvrKfIas2TFywsYgbvlHY28m/AiHHaBb2Qq32daIP9Te9IFsrrtXu1eSnoI
         wy0hamjN7/C32cp0EmkZ84R9/3qdLvPJO5rxKGi6mHnuunI1nD0s6KfULEm3G2ahqEwS
         +sFQ==
X-Gm-Message-State: AOAM530ODsf+H2XZTvXPE/pH4mpjY5UYsDcryEcUTUzvTPJ/31dzHQaj
        o4tD7US14rvhn8s1JoUCCTI9IBXuh/sb7A==
X-Google-Smtp-Source: ABdhPJzXhc9Ew9Gi4P+1Epwk07nfJzvJmSqLkFQ8C+1l8T9r25NO6FU2mUoXeniaklVPDw0kvyI4cA==
X-Received: by 2002:a05:620a:c11:: with SMTP id l17mr9930329qki.487.1615499690479;
        Thu, 11 Mar 2021 13:54:50 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id z11sm3060521qkg.52.2021.03.11.13.54.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 13:54:49 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id b10so23300163ybn.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:54:49 -0800 (PST)
X-Received: by 2002:a25:9348:: with SMTP id g8mr11415895ybo.343.1615499689441;
 Thu, 11 Mar 2021 13:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20210311033957.8978-1-rojay@codeaurora.org>
In-Reply-To: <20210311033957.8978-1-rojay@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 Mar 2021 13:54:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VuGPvUY8edN+PEuZS_pO+=3WHeJ-4J5tHDAPRnXJs0QA@mail.gmail.com>
Message-ID: <CAD=FV=VuGPvUY8edN+PEuZS_pO+=3WHeJ-4J5tHDAPRnXJs0QA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sc7280: Add qspi, qupv3_0 and qupv3_1 nodes
To:     Roja Rani Yarubandi <rojay@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        msavaliy@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 10, 2021 at 7:41 PM Roja Rani Yarubandi
<rojay@codeaurora.org> wrote:
>
> +&qspi_cs0 {
> +       pinconf {
> +               pins = "gpio15";
> +               bias-disable;
> +       };

The "pinconf" / "pinmux" subnode shouldn't be used for new SoCs. See:

http://lore.kernel.org/r/CAD=FV=UY_AFRrAY0tef5jP698LEng6oN652LcX3B4nG=aWh0gA@mail.gmail.com

...same feedback for this whole patch.

> +                       qup_spi0_default: qup-spi0-default {
> +                               pinmux {
> +                                       pins = "gpio0", "gpio1",
> +                                              "gpio2", "gpio3";
> +                                       function = "qup00";
> +                               };
> +                       };

Please split these SPI nodes as per the thread above, like:

tlmm: pinctrl@... {
  qup_spi0_data_clk: qup-spi0-data-clk {
    pins = "gpio0", "gpio1", "gpio2";
    function = "qup0";
  };

  qup_spi0_cs: qup-spi0-cs {
    pins = "gpio3";
    function = "qup0";
  };

  qup_spi0_cs_gpio: qup-spi0-cs-gpio {
    pins = "gpio3";
    function = "gpio";
  };
};


> +                       qup_uart0_default: qup-uart0-default {
> +                               pinmux {
> +                                       pins = "gpio0", "gpio1",
> +                                              "gpio2", "gpio3";
> +                                       function = "qup00";
> +                               };
> +                       };

I suspect things would actually be cleaner if we broke the uart lines
up since the boards tend to have to adjust pulls differently for each
line. With the new "no pinconf / pinmux" world it's pretty clean. It's
obviously up to Bjorn, but if it were me I'd request this in the SoC
file:

qup_uart0_cts: qup-uart0-cts {
  pins = "...";
  function = "qup00";
};

qup_uart0_rts: qup-uart0-rts {
  pins = "...";
  function = "qup00";
};

qup_uart0_rx: qup-uart0-rx {
  pins = "...";
  function = "qup00";
};

qup_uart0_tx: qup-uart0-tx {
  pins = "...";
  function = "qup00";
};

...and now when the board file wants to adjust the pulls they can just
reference each one:

/*
 * Comments about why the UART0 pulls make sense.
 * Blah blah blah.
 */

&qup_uart0_cts {
  bias-pull-down;
};

&qup_uart0_rts {
  drive-strength = <2>;
  bias-disable;
};

&qup_uart0_rx {
  bias-pull-up;
};

&qup_uart0_tx {
  drive-strength = <2>;
  bias-disable;
};


> +               qspi: spi@88dc000 {

I believe the qspi node is sorted incorrectly. When I apply this to
the top of the Qualcomm tree it shows up after the "apps_smmu:
iommu@15000000" node. However:

0x088dc000 < 0x15000000

...which means it should be _before_.

-Doug
