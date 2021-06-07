Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2505F39D59A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhFGHLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:11:51 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:36809 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGHLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:11:50 -0400
Received: by mail-lf1-f42.google.com with SMTP id v22so23211018lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 00:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2sChFupNDISguJdQ93OuywrJgFnASQqUTk66QD3fheU=;
        b=jEdpGpSxxxc/JBejLPt2hZOkIv+v1lW0s2dtES7baLoyk8uE+J2fBiI78gXF1g2VV8
         sWn9RQE+J6fcHzxhHQiiGKf4pw9GkqkwLHFAbpXNUQSjEpRVq/KgDCHwaxhyQm1AbUw8
         7ZHPZf3VsTW/zc/7ZJU3FIoChYlNF0rAH/UW3hivtdq0i1+jth0eYLf+LnBczxwBtSQn
         VLK5LwPCSuEV7JU9bAF1lqn5Ft29DTFDkowoh1YIvR/+S9J1Q7++w3aFK+NOTs+isWJV
         9L5qbqSlsrqch+MhXomb/3BJI3vONZtF+dkksWjxjrI8jhSRcKvpbJclAZYPbdBBmKeX
         VcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sChFupNDISguJdQ93OuywrJgFnASQqUTk66QD3fheU=;
        b=tAFWhtJcAMvEVV3A3CRjuDza7j+ksEosdmpepBWS3A4lt8Qk8k2BoQJlxDzAbv+lm1
         QzBXSCeEyE2cFEPs1n3bL1UZhWZbHMko45F952s9O/ocrmWYa2GYclTMEbL7si3fbrv4
         z27XOmkPewRll06iAG50mttm+iI8ZnVI55AeZn9Dq78QrOgU3iNtlEjLq0j9HJ+Xks1f
         YAApTtz6F3eSOJhbSKquzdbeirNION8VmAXNZUXGNlX3oL8T4ZI+Pst3l76hHAzxKBkC
         YUaIebh+WL29Fh2gLKOuxnDeVisi6yn6O4/wnPOn0dpxPuaCA7XeeixbDo1TVhQnWnk+
         49dg==
X-Gm-Message-State: AOAM533EJ1YUc21l9/Mn5SvOQXUgEEaHLHAJub2QxdpUg8Nd1EomjC6p
        x1L9H2CplYh2rqUmTR0VM0x/95LaIQa5LosNE1rhtA==
X-Google-Smtp-Source: ABdhPJyi+8lO2eHOnf1EGT4R9C29fTCmfSZeXRtPWCzMV0LR8z1giBWDeA783U1aC4FGoaA9oN6Iint77xKwduKuttQ=
X-Received: by 2002:a05:6512:2105:: with SMTP id q5mr10699515lfr.649.1623049727938;
 Mon, 07 Jun 2021 00:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210604055337.20407-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20210604055337.20407-1-sergio.paracuellos@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Jun 2021 09:08:37 +0200
Message-ID: <CACRpkdYLwdgws+fDcb_hNz2=WD4+qkHiwWQgpgFNfWLU=PwSiw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ralink: pinctrl-rt2880: avoid to error in calls
 is pin is already enabled
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 7:53 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:

> In 'rt2880_pmx_group_enable' driver is printing an error and returning
> -EBUSY if a pin has been already enabled. This becomes in anoying messages
> in the caller when this happens like the following:
>
> rt2880-pinmux pinctrl: pcie is already enabled
> mt7621-pci 1e140000.pcie: Error applying setting, reverse things back
>
> To avoid this just print the already enabled message in the pinctrl
> driver and return 0 instead to don't confuse the user with a real
> bad problem.
>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Patch applied for fixes.

Yours,
Linus Walleij
