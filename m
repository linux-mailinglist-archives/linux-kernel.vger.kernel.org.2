Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC5534D342
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhC2PET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhC2PDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:03:51 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11202C061574;
        Mon, 29 Mar 2021 08:03:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id n138so18948800lfa.3;
        Mon, 29 Mar 2021 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50i/6vm6fwmnn7wcgvH81eY5FvT08NpnqhTvt5R4tYY=;
        b=cZKgPuRSpMMu+T12m1VGG5+5GxYj8GG9zn4X5VGZcqg3xjWcjimifBZiPeoW+Y7A6H
         /vsThmTwbF0FKRM5MF9ZVyE337FSMUZjyzNwSnIPkIpyEHeR4gpP4MTFz2Sf1QBySeFj
         D2jcdq9UhFY7qsDQwC9rpn5fM1wA/sLQW6LV4l1yW4gM07+Ut8Ic4i+v5AnBACmohLBe
         pBo3XtQEJkWRJ4hcNgX63aDaSsWAEfOwM0HHsn2KEd9+dCF1u4N0mrvqzfFtrJ4zK+D1
         iIUp4ZVq2De1RwGga7l0xR+pUxyrH+/fibM4Ull28IH+B6gSndstQGS9ZP7ClEGArRou
         3QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50i/6vm6fwmnn7wcgvH81eY5FvT08NpnqhTvt5R4tYY=;
        b=J/6C6rUQsqvlXj2+vmdB89TjcC5hBIZiJCwqYzjvopCRA9iTZA6isgqvOnXaRrpl8c
         FdLkekImevI37QkBI1qHJk8w1sC/I/9Lh4JJRzPjLarI95PRMGBdy1U7HaWmhzlH1+OA
         srsRuDKnChXNZQ3qTmLc6lpf1mOWoyTUp/shS9Opu272tGovqlowvVnPyyiayaMLQjNR
         DjlnueT3eXfSunV02rx7qC6c1VtzZINPseslVuVQZi+grHdyxKFOg0kcjUpUosn0aosG
         FRjy/2VhEJKx51uOZb6SaHvm42HJGWeX059URQC3YzYi0aYFqT/dxjIWCkDtR5oYAX4y
         tdaA==
X-Gm-Message-State: AOAM5333q/apQ87qJB3r8n8Tajg+3N7Xix51NI17e5bl+Y5IlMYUqZoH
        HjfoYue/HVVDGVwPRJTvpRtqu0g0hDxCm0KjB3c=
X-Google-Smtp-Source: ABdhPJzmrhOVB8oB8x0Md2MlAR6MpClJP1671nQ0UbEFwNGOvfn9yM8Z4SsDwBwta6rlkcnCmTFI7gH8ExwWx3U/9lQ=
X-Received: by 2002:a19:4147:: with SMTP id o68mr17999005lfa.295.1617030229622;
 Mon, 29 Mar 2021 08:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210329130103.65857-1-s.riedmueller@phytec.de>
In-Reply-To: <20210329130103.65857-1-s.riedmueller@phytec.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Mar 2021 12:03:38 -0300
Message-ID: <CAOMZO5DXqEmRq=SZw_N6KEs-me+gAfB_htaLhhkwDUZ6+7QP4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: imx6: pfla02: Fix USB vbus enable pinmuxing
To:     Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Mon, Mar 29, 2021 at 10:01 AM Stefan Riedmueller
<s.riedmueller@phytec.de> wrote:
>
> The pinmuxing for the enable pin of the usbh1 node is wrong. It needs to
> be muxed as GPIO. While at it, move the pinctrl to the vbus regulator
> since it is actually the regulator enable pin.
>
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>

Thanks for the respin:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
