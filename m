Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1786739D58F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFGHGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:06:09 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:33612 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFGHGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:06:07 -0400
Received: by mail-lj1-f179.google.com with SMTP id o8so20782008ljp.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 00:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=byysuq31NqSJ/wEAfWvATOeFVnLZyU0dDvr6U4G7ixg=;
        b=Wie72tEOsYTmHR/0QEli2bJx5rwQj+1aaleOBHWQwtRfswtxcPhWeKH8ZcLEQjm/rL
         3W0YPHwk9EUC2xgALLXGB3mdjGsd0YkNGlf4ZxcdikYP3X0XfJWDROtxh+vUmuLAXsal
         H37vAr3qlgjFjOHsqWc/ElO4gzkorRWiDD5hgUq82zoCOlDeAPo4UEg1goNRB6JXnZmj
         0KYssOGzHy6H6YviXqocjnIhbcUZDGuJyMsLwO5G4JEJLursqP3AW1UbtLwIJB3O3Yrp
         kR9vk/Z6SV8/DL1AnUe9NVBSyE59BNVoel5OhJmyraDrYEvTUP2unhWbMZvtEwa6hiVw
         J9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byysuq31NqSJ/wEAfWvATOeFVnLZyU0dDvr6U4G7ixg=;
        b=jZnyNst4xVZqq4oRz4AZ80Zfddsr2rocBq21cHzO0nSinlNenpEmBKtSI48ntCqqjF
         XD/EA+sKY84V66zxI/X4sGWh7kTi6aPYD/FHEiHigDp2Ou+zswvW2oMBL50r7PTISAS8
         +Uq/9Ym/w3ohOSts3P33a9C3Y98Q7a38sN9Ka+bMew+oienoW4AW5nA9vJjOUvzOcRqX
         G2lA93Lb0iJWOCc8kClyOxKA/1WY7USebjXbUPM+I55SlrF7+J0DMBVG75I253oC4mTu
         3mtYPLu4iSfVF+aNPXUE+p7dr7pAvF67O/flsB+xPlv5Q1FrdCQ5f5dYJ3sSz4BwqpTH
         1uxA==
X-Gm-Message-State: AOAM530+UnFkgFcobrqwSK8qRAl/HJeACWo1uR0Nngbh5iLfG6WdF/OI
        Efvm3EgbTSfgW8UbQeWispD4ph+bPr2H72u4jvGSxQ==
X-Google-Smtp-Source: ABdhPJwGqQGTe/jVvXVpdtfh4ldNGqHyMFsr3xX2w/aRd0jDvuSNNY54PMchcbawxwh8sCOROuRyKq5JfAzFnY97i44=
X-Received: by 2002:a05:651c:1057:: with SMTP id x23mr13380683ljm.467.1623049388829;
 Mon, 07 Jun 2021 00:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210602150420.18202-1-dariobin@libero.it>
In-Reply-To: <20210602150420.18202-1-dariobin@libero.it>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Jun 2021 09:02:57 +0200
Message-ID: <CACRpkdaSYrrwwn+nXj5M+zvgxTBnspdMgQbbViAFV7TpaUPkAQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] pinctrl: single: config: enable the pin's input
To:     Dario Binacchi <dariobin@libero.it>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 5:04 PM Dario Binacchi <dariobin@libero.it> wrote:

> It enables / disables the input buffer. As explained in the description
> of 'enum pin_config_param' this does not affect the pin's ability to
> drive output.
>
> Signed-off-by: Dario Binacchi <dariobin@libero.it>

Patch applied!

Yours,
Linus Walleij
