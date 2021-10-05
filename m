Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7448421B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhJEBNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhJEBNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:13:38 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94727C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 18:11:48 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so23897817otb.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=JF6vyOXESxtfPHWab3e07TTjv7Vg3ZVZyUb4GlwIoFs=;
        b=cXaB7P7U3MKxhY/Xzb3aCV3IQ1p/c/QFk7Fteow2gs0Zy+03BHtIgOGazJV5pmbDuL
         lDxZg/K+5T/PAT50O1qBp4EC4R46wrcpzlhiX6dC4siXKprLmNfWLB0uPBQyFd7Xv5/W
         Q/dD20j+haqagqa05pclC8RFHt7CeFFwwf5Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=JF6vyOXESxtfPHWab3e07TTjv7Vg3ZVZyUb4GlwIoFs=;
        b=oVPG4aH5UzmLmmCNvBEn9/UKaLYbQVn993jDqON5/pRTYY9Iazu5crD7rp14Nkx91j
         zfaKy0botmIZUvXWMbZcyhTVJdFgfMJKLXY7rphX9pvYcaP0N6Jk3pBWIFWa9r/VXUDO
         mWauLJzmzd36klghAtIvbfT/3asg6VSe4aMZV1sEJYLukgb/zz4jfQyAXeCDLu8RJhR9
         Yr8yB8iYO3l2PeztDbSBsGZ+4MOOVBkv0ANlDYSZvIRyaiVKQ2WnQOOEguRGVEb6OPE7
         AdJY2Y99b3NjmpB9Ucsh6eUodSmb3s2QcY36Isu3LikLk5a6U5wtIc8ZaGucoan8xnEt
         3ArA==
X-Gm-Message-State: AOAM5304Sq2sJqj5ytQH5ZPG/XQ7RyOLBHSEMnU0fvP02GxyzF0IpYlZ
        oUVd62S0YzcuHjB9615Q7q02HAVjdR0xEqftE5Nh8g==
X-Google-Smtp-Source: ABdhPJy6i+fPzH6N8khmOKxP7d2oPe0DSUpWQzfCTqacbniPOVIFqVrcjgwadOtNRRoIUW5BOUwS3sA0fBv8QXKRtQs=
X-Received: by 2002:a05:6830:358:: with SMTP id h24mr11416616ote.159.1633396308016;
 Mon, 04 Oct 2021 18:11:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 Oct 2021 21:11:47 -0400
MIME-Version: 1.0
In-Reply-To: <1633376488-545-3-git-send-email-pmaliset@codeaurora.org>
References: <1633376488-545-1-git-send-email-pmaliset@codeaurora.org> <1633376488-545-3-git-send-email-pmaliset@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 4 Oct 2021 21:11:47 -0400
Message-ID: <CAE-0n50CBhdq3fbtygfzb0m8+bz3244-mYwCtVPjs_CfNaK_NQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] arm64: dts: qcom: sc7280: Add PCIe and PHY
 related nodes
To:     Prasad Malisetty <pmaliset@codeaurora.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, svarbanov@mm-sol.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Prasad Malisetty (2021-10-04 12:41:25)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 39635da..e4bbf48 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2676,6 +2787,12 @@
>                         gpio-ranges = <&tlmm 0 0 175>;
>                         wakeup-parent = <&pdc>;
>
> +                       pcie1_default_state: pcie1-default-state {

Maybe call the node pcie1_clkreq_n: pcie1-clkreq-n as it's now only for
the clkreq function.

> +                               pins = "gpio79";
> +                               function = "pcie1_clkreqn";
> +                               bias-pull-up;
> +                       };
> +
