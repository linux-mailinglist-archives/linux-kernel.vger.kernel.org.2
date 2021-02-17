Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAB031DD63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbhBQQcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhBQQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:31:57 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C299C061756;
        Wed, 17 Feb 2021 08:31:17 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id v9so12889215edw.8;
        Wed, 17 Feb 2021 08:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnnspwTKhTOO7mL6UKmjSvy+MmM8VC79/Cfex+SBG1Y=;
        b=QQDYNRj1eLaPPGbCyF0Ix8EhvX35XdBwo/QGjMba7YIi5P5Fc8RwV7ChPHHJRIQ83f
         uO5QnNk86rbPW0IeMaX/ZN6EX/+EcKMn4CWdRHv+GE8jOu3DlEMguSmTEe0hsgNfG9FZ
         zD02Bw7OOLAdL4y1tDoxUsW00SrngG2bifBVsRHOUNeIezP1X54iVXr0kEPTvzg1alv5
         HB6EV76ZFDndrwodzBxGcb1Ra81EHWIdp8bH6eGrTSOBZCGdOE4Ghq8DbYuiGoHmXtoq
         NC7CYqUiKrKz7GGEWBV6xReMThEq4RX7xCvOtlaAv60hX+cNaUDbAXs0qhigGQP1T6ZU
         F/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnnspwTKhTOO7mL6UKmjSvy+MmM8VC79/Cfex+SBG1Y=;
        b=Qg5IDLNlvKEV6X/mRfVydxRPe+obwmiqzB33x8zuKKAQApRHcbYph/lJ6+wPERIZ3W
         CpdMm6mpdhaYywYzDnL14yvCfaPaG9Wy4PlRUZCEV/k32Opn54dAD8H4F+xg+pfqrEmi
         bawSkeC/iwozvc2U6FvnlEsjQ+/dI9/KXP0I0JRxp+vfja8c1Ghs08G/Ak3MZXa5rvC7
         mkbSqPhaO4IrQwWgWb5KT8PWM++gXvgs950nF+66TUz8pOC1k/z/26r3SYAfuOcIJ8eL
         TZCfMGT9wf0FSApimIQQTl+5LnY73sfcQZXes9/7crD5N/vJspcxE3+JiHFixMyckY1t
         OVAw==
X-Gm-Message-State: AOAM530X81FhokwefQ7RZPjDMWGbf37iohXO0JeClNtqihqLWxd6OzGL
        aBNADe6qwW2x8X84/f/jPs0g66V882Yql3fiqQ==
X-Google-Smtp-Source: ABdhPJwEuxqissJ0efefq4VYr+daKXouCEbnmbc2BRVFZpvGs1TmWnVI53MBXAl16fGmF3gjqT0ZSVdOHJjqHKr7WtI=
X-Received: by 2002:a05:6402:1a58:: with SMTP id bf24mr26801537edb.191.1613579476192;
 Wed, 17 Feb 2021 08:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20210217153038.1068170-1-rsalvaterra@gmail.com> <YC1CuWnLQju7wMl2@lunn.ch>
In-Reply-To: <YC1CuWnLQju7wMl2@lunn.ch>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 17 Feb 2021 16:31:04 +0000
Message-ID: <CALjTZvYJtjzN6kPGWfAG+3Cqc9VYR8M8Wo+mxGWCO+tx6P8xPQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: turris-omnia: fix hardware buffer management
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     gregory.clement@bootlin.com, kabel@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

On Wed, 17 Feb 2021 at 16:22, Andrew Lunn <andrew@lunn.ch> wrote:
>
> Hi Rui
>
> I don't know all the details for the MBus Windows...

Neither do I, I just followed the examples in other device trees
(namely armada-385-linksys.dtsi). I wanted to get hardware buffer
management working on my Omnia, in OpenWrt, so I started digging. :)

> Can this be set once in armada-385.dtsi ?

If all SoCs support it, I don't see why not. However, I have to defer
to someone with experience on these systems.

> Did you check the other dts files. Do any others have the same
> problem?

I did a cursory grep, yes. I see a lot of .dts files with the correct
declaration, so probably aren't that many missing (if any at all,
anymore).

Thanks,
Rui
