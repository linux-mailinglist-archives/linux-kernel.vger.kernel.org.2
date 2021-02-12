Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE01C319AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 08:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhBLHvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 02:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBLHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 02:51:36 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F2BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 23:50:55 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id v24so11837399lfr.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 23:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcYBOTOTtM/fD05ORuEKGods9zXoh8CDnQEGXlPlh3I=;
        b=fxgD7GASpgLTqeJwS4fg2RtRYUKSrlc8VbpU+zoaKG0lW2Jj29H6n/7ucLhDYUJUfb
         SeLrXVIOWrpjE7OaWUROE1ZRbBL/mHf5ygAM+6wuzIAOUd4MPde2tV5l6EGNxtvCF201
         o10gLbViG4Xj+CRCJvC/GZWhUm2c4EiNErY3ZZymU7ltFtEEqgC5bIp6YF0sll+hONWo
         6afIB7EeH9Dzp8usBzft0rPwY2Tvi1Ro/I0wjQKyftc2XiJy5B4Qdz/IxA32StXOqsvt
         tOeQkP3g3K4vZSXWCXHE4K0tQLnFq4uGMdli1Ck7CqgWPIt5Bg5K+61IwYu9ZeMwLn5C
         seAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcYBOTOTtM/fD05ORuEKGods9zXoh8CDnQEGXlPlh3I=;
        b=eTjyztQo2Dn337dm0742qicMcODyq8HiKGuY6mX8Pgj1Gl8wjXQHhx9iD0r+VbU/oe
         4Sl5Ah3ZSmfbrThJiVAdVz2U5POQlSXqOTpsFxfRkFQ7iB7sYPncSILIgugzK8bg9aEL
         3xomA96Y3Vo0H7D+8fxMR7VISiv1Z9Bw5N9+DVyvC1VDekvN/YmEcfvI4El64cmdBtDt
         Y3RlU18w4P/YWrShb2jOFn6OgX8olYvt2dKaL6jlEtUrLMuE1G1Gj4Jw4s9t78c4Frmb
         5CNwZYlhccKyiTtnHno1QTJrL1VOUoaarYjg/FW0Q6MARC0CW4GWYpbDH9on9f62d0J/
         hpdg==
X-Gm-Message-State: AOAM533dKrIPZgfsxk6sVU3r+A5qTzsj80akMgU7Cpx9cZhCXwFNL3Kj
        A3RHQgK5dPYevyN1rbLNZVAE0YjlHiQI95OGmCx9UQ==
X-Google-Smtp-Source: ABdhPJy6hy0DafG+RP/hCnhT3D81OmDjB4+p69zTidYbeLYX6fKxq6ptiW7znBA9tupHQJ/1Y90M1Is2a5r+DyQAAu0=
X-Received: by 2002:a19:6b06:: with SMTP id d6mr1005706lfa.29.1613116254456;
 Thu, 11 Feb 2021 23:50:54 -0800 (PST)
MIME-Version: 1.0
References: <20210205140132.274242-1-vkoul@kernel.org>
In-Reply-To: <20210205140132.274242-1-vkoul@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Feb 2021 08:50:43 +0100
Message-ID: <CACRpkdY393_LUDUQxVuv9JEY=hkkfs=u2OziwzxZsL52QxqusA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] pinctrl: qcom: Add SM8350 pinctrl support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 3:01 PM Vinod Koul <vkoul@kernel.org> wrote:

> This adds binding and driver for TLMM block found in SM8350 SoC
>
> The binding is dependent on TLMM common binding from Bjorn:
>  https://lore.kernel.org/linux-arm-msm/20210126042650.1725176-1-bjorn.andersson@linaro.org
>
> Changes in v6:
>  - Add rob and bjorn r-b
>  - removed quotes around 'defs' and drop the phandle for binding

Patches applied!

Thanks!
Linus Walleij
