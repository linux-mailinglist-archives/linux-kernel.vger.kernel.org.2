Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC783E8BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhHKIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbhHKIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:23:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC45C061798
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:23:06 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x27so4007362lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VLTtyMmDGDzeJmduXV6qMoL0oSJQa7XeVXUnu5F9xhw=;
        b=HDGk1fId7KbzdQVPCRZyRCmG6dLn3wcHt9IncviPIvRV693NxWhT/l47Cv417wx4r3
         MbrOh9r1OxZsgDqZVWBmzY6q49QXuXg7JT0ZpSMaf9MZzZCDsYFoutOLEIIs+nJ/Mb/C
         FLus4CHORu+cOoZmBlwSTxaxFifcBTexkVeeelKS7H4ti+v1hqPTlo6+piCWFLMi3Kv8
         cYKDXTD/FrXr/+SMEQM4WYPUCZTrQeWFKWaC3GapTcfvrkb5uWpL/+lVEYXKqQG0ApMw
         j2CMdbexfaeCprtLrflmZue1znqqsIVpXgoPzZDfBk2ijQfWutDCy6uv80VyByNlGvk2
         rZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VLTtyMmDGDzeJmduXV6qMoL0oSJQa7XeVXUnu5F9xhw=;
        b=P6Nqwqj479vtNAq5KN1KlHNSoqDl0yW0ZYGHrXhfYu1U/A+7M3ufFsPmZRFbqkQa8V
         62JmZs0mXO7WT9J7XPznp4ufSGIr70pt7hDdYTjgzrafmun51OKRFkTwsSkvUv8/O+Ta
         2JgfmnkwlfupVCVzJdcTwJOFX3etjAr5a56EHC6ao1QW+cHHFd3JAE+4VnKPstepc+dp
         XpxhQGHhfeIzndulRemkDkOryMMvJR+HoJysSXkFjuLteE5tA+w0+j+DdwrhC17Jbsc4
         I1ywN3KrxaYsCaN4vhHH2iPgM1AyNrJjkfSzASPRlGGQRx5PWdvkg4ApeD3r4EegV1hE
         f3zQ==
X-Gm-Message-State: AOAM5300xUEoHizyPNYGIBbKbzPiw+EIDi24x4yAVbh0weovKaEA82O9
        AGbcXSGRJLeh7/eXeVBoNPDxnQ5CQ0QNci8PZRY6haOPJME=
X-Google-Smtp-Source: ABdhPJwxR7J7CWgtxQ9zR8UiucjVpB8YXeg3uQTR6CcylRP3Ow10t/9bkiil8nl37QrHQ+6BQYXbvMb7F5VU3KhcwzA=
X-Received: by 2002:a19:c7cd:: with SMTP id x196mr24351162lff.465.1628670184894;
 Wed, 11 Aug 2021 01:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <1627108604-91304-1-git-send-email-zhouyanjie@wanyeetech.com>
In-Reply-To: <1627108604-91304-1-git-send-email-zhouyanjie@wanyeetech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 10:22:54 +0200
Message-ID: <CACRpkdaEL46NzPOk=fU4jAZpf-0aV1gQyPjjLzrNYJUY3Xm73w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Improve Ingenic pinctrl support.
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sihui.liu@ingenic.com,
        jun.jiang@ingenic.com, sernia.zhou@foxmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 8:37 AM =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)
<zhouyanjie@wanyeetech.com> wrote:

> 1.Improve the code to avoid misunderstandings.
> 2.Add missing SSI pins for JZ4755 and JZ4760.
> 3.Add support for the X2100 SoC.
>
> =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) (4):
>   pinctrl: Ingenic: Improve the code.
>   pinctrl: Ingenic: Add SSI pins support for JZ4755 and JZ4760.
>   dt-bindings: pinctrl: Add bindings for Ingenic X2100.
>   pinctrl: Ingenic: Add pinctrl driver for X2100.

Patches applied!

Yours,
Linus Walleij
