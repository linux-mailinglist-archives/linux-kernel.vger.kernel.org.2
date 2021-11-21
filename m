Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4876D458745
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 00:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhKVAAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 19:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhKVAAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 19:00:01 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A5EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 15:56:55 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 7so34251344oip.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 15:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzbEXCra2fLzuFHKeeSSwMjHfMOaWeE3atUdu+3gu8o=;
        b=vLMLN1XgfZQV7YTTPrqfEm7QvqYJCmTgDtjWXHU91XFSFL7oQHT0m/IeS26DlKGw7F
         RAceTekpWZ2aNVpUEhvlcpgNKBZPE5AhE5yQ5+Nmi65EdKgpT/y7a3i7YWQSFRDx5qyX
         roc/g++HNEEB0Brux8dNCe8RI+EJ30CfsESBs3+VL/yNKlEMtW+cPQCOPk1isEp1rX6g
         OBivQzKtsxw0kFODQf1Lmy3g0rO//GZlEcM6rnAun/zcTlMqKQP04OOZ+ywqqMer0DGT
         wPlA0NPMpsAxwqFY2EogDIn4Uf5MIB32WDk6rYFRF0TwljaF8HqR0OipC2wcglfseKqq
         jViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzbEXCra2fLzuFHKeeSSwMjHfMOaWeE3atUdu+3gu8o=;
        b=pcTek7LzGfs4+K7DuxHEC14gnmHyJvv7pavIENwGPR4dRSQ5gUDyhnfadygteZN8uL
         +bns2s9zVB3FSl1WroidEL04HNpeN89DzzeXlYd3W5X+YDZnYEuTFjoFC/NfHIbdfCBM
         jbXqCFmJr32CyQl9iJXKgWkcL9YYNm1DPOBLiWuVWBaTtdLGmH7i5xu7Fjt36mpUv6oh
         kJ7Ffo1MR9S+eDJ+j+SD/iPDEjjsZrg4bDWQAhbR1KqyJTDEsVueb+Ilm0tkMK87AxZL
         tVtHS6+G1CL4XYBLEPY8fPHSo3EHOv22mFjQUILbMAQVpIU+Nu7wEakS/b7TLUUGU1dg
         DZXQ==
X-Gm-Message-State: AOAM530DuDMhhgh8jA5/uHGnFoHuc5lEeqMqOAbrrF0Fv0mxsgUclO6B
        wE/Go3v6P3O87aUkgTwBMb6gDHr/198aiNABdpRAlg==
X-Google-Smtp-Source: ABdhPJyTGoImZ9uJlXTMO6yPH+6/gwlRYX16UVj6ftXnbOgSxuJ1Q+oBW6tiPI7CgPtEk6VZnIA12irHDbjoqu1iPOs=
X-Received: by 2002:aca:120f:: with SMTP id 15mr17321547ois.132.1637539014756;
 Sun, 21 Nov 2021 15:56:54 -0800 (PST)
MIME-Version: 1.0
References: <1636416699-21033-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1636416699-21033-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Nov 2021 00:56:43 +0100
Message-ID: <CACRpkdY=2X4ntwGpbQ70iUc4cfQMqsjZK9PWR+Qo5e9oijc3ag@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: pinctrl: uniphier: Add child node
 definitions to describe pin mux and configuration
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 1:11 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:

> In arch/arm/boot/dts/uniphier-pinctrl.dtsi, there are child nodes of
> pinctrl that defines pinmux and pincfg, however, there are no rules about
> that in dt-bindings.
>
> 'make dtbs_check' results an error with the following message:
>
>    pinctrl: 'ain1', 'ain2', 'ainiec1', 'aout', 'aout1', 'aout2', ...
>    ... 'usb2', 'usb3' do not match any of the regexes: 'pinctrl-[0-9]+'
>
> To avoid the issue, add the rules of pinmux and pincfg in each child node
> and grandchild node.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Patch applied.

Yours,
Linus Walleij
