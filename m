Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FB9438C72
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 00:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhJXW6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 18:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhJXW6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 18:58:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7523FC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 15:55:53 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so7597137lfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 15:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8iPIAb2h7OaftOIwaaK8T359hTECc45IqlvoZ2xjVUw=;
        b=YxocF8NKY2oKo00KX4QpzIQQU7PQFOlGAmZZoQSVZidPw1RGIw+HtNfe2Jxg3imu4D
         d2alc24QJdH3I7Bx8F2jzSawbwfeKtLCktB95LBKGV8k2Xf8PwXGfj2wvkCDR6/rKA9z
         QJXotHUsQlYVSbsDKhMZReEGbxn5y1hmxODgAQ1IzJwMDAPV0ElrLMJ+Lpyf/QSJ0DKE
         hsJd+qZ3j4pcLm1NXTllJRzMA9ZpIO9OydhKslME86bOfIq70b1+9cdju8AXGkZMldGH
         7871uvDlVL9CY19NXZV0YwrBrPoRRbjC3zP5gTS3PrmR0H+mwYmaHeTQPfg2tBEyrcYT
         08TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8iPIAb2h7OaftOIwaaK8T359hTECc45IqlvoZ2xjVUw=;
        b=rrGvWwuDTpQV8rxpdYltzmGvQycPCs2BD4PtwFGckriUa+jku4R6nWqpNXMVeS7NCY
         uUCVdTV7+iM2BxKF3OiVwUMBmBEC3EP5UlIlnsU4tNOK6PFgbguo/+eBDaWsDQoWaaru
         3AbZJVgwgHnsYjzxkH7HX6BfCj+O6+9o/4TJawymDCh4MQx2xPtyYMM8MGd0zHhmW4ue
         SkYDV9dfsE56Q1az3AqFwmtTWt6uAHh05k5PWjNXpadk0RQdL6uYocpTGEwqUJQfh/Q0
         NjWOUd7Hy107XL/YtmfGlOaJ3wkNOgLjp6cZxXHR5zYLOz9wD38pQ2HkrRmmvJ0HbqzT
         jI7A==
X-Gm-Message-State: AOAM5336ShS3TrBDi6XRd7MU/JQ9mbf0ruISjMLtLngJv6kyxbXrNxPe
        WWRbLCqHASm7pPV3A8yKJcMbytp1Th0j5762EyK2MQ==
X-Google-Smtp-Source: ABdhPJwaI+UIp+fhpIMRcQ6tZotNx9Qpw/8KR5lnXFBnJ2wKLAAcdN+LxnMunGT++KoNcYwqVoujZqi8R2ej/IKm9bg=
X-Received: by 2002:a19:6717:: with SMTP id b23mr8645155lfc.95.1635116151869;
 Sun, 24 Oct 2021 15:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211019221127.1953001-1-f.fainelli@gmail.com>
In-Reply-To: <20211019221127.1953001-1-f.fainelli@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Oct 2021 00:55:40 +0200
Message-ID: <CACRpkdbE2nxaXCMb326pYiQwU+E+FphOb3rZV0Y7z_MZXdToEw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm2835: Allow building driver as a module
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Jason Wang <wangborong@cdjrlc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Phil Elwell <phil@raspberrypi.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:14 AM Florian Fainelli <f.fainelli@gmail.com> wrote:

> Update the pinctrl-bcm2835 driver to support being built as as a module
> by converting it to a module_platform_driver() with the appropriate
> module license, authors and description.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Why not!
Patch applied.

Yours,
Linus Walleij
