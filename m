Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F9632A96D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835199AbhCBSXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448709AbhCBPeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:34:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D25C0611C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:29:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 18so23328308lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sWSzaWWbzyPyu6uykYAaJrqhSOJqXcp+xt3SDSKUiT4=;
        b=qCx1lcWswuw5DoTlpkHcllQN1I0UiiKbKHGIch77U8NidsjWcZ/WYscKhg+8gJQk7b
         A+Aw4T9iYXS+hD8ZWVr/ylo6w7TpxVpXDL0BVxQm8ZAAAifYYBKShIBeLghuVjbVE+MK
         zSSd1Yd0kiXBRNNyRc6X900oPd18UrslVtJ506N4CFYk+dG2ealuCagpqV8sPZ4X6/82
         oFgwvXoWtsRwzfksjLccHfJRHrLg5T9DpPZTfbQ8VtJgQAP8wAwK+fRRatbNxTzSTaid
         OPtWLlfw7G4PomP2Y9Mawa3+sCs8d5TrczolOh1FyTHeXrRdZXzthYBTmF31G7m4gg2r
         CyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sWSzaWWbzyPyu6uykYAaJrqhSOJqXcp+xt3SDSKUiT4=;
        b=IDh/qr4Eb+QN2QIhRJpbdhdqyqGecO3asmUU/De/LZpt84+VBieWkPhP3Ck2dV4868
         QLkRogvjN4TnddXjFlrqFQ0vrE5KfxdodlSadrmYgzSLB8CL+xgW0Ur5t0sEy80z09aF
         XUn4En0faHKExz6JafX54IOMw49NPBZYbEmkK6l3XKbmjc5d+EnK1z6Nw/TUHX2eDXeX
         3kF9Sbu90dLMl8Ga3ReSY+sbRAFReUI8gX4iuwG3nn4xZ//7bUsQSD8LL8QWY7ahXTJp
         ryCa4HR18l3G2QgHaJf2E2oS48xouQi/0U6/p1EzU2cI2evn4LVLwdXzkaLqsri0tq//
         YhoQ==
X-Gm-Message-State: AOAM531WbfaaZHDyERHojmSkPeUulvVt76z63pb0GHYuQmZVLx8uxwek
        fr+j9dM9yP5FwZDbxPeOBL9qSRvldAgdYxhHsEecNA==
X-Google-Smtp-Source: ABdhPJyaRDfvOXcbXwWIQg1BVpvxTAXseyBY7XMxnAuyhRJ/4QjBxTR7Kl6thFN4h7FWAkpFrwbEtu+nWwX56vMBeBI=
X-Received: by 2002:a05:6512:74a:: with SMTP id c10mr12813240lfs.586.1614698979488;
 Tue, 02 Mar 2021 07:29:39 -0800 (PST)
MIME-Version: 1.0
References: <20210225164216.21124-1-noltari@gmail.com> <20210225164216.21124-12-noltari@gmail.com>
In-Reply-To: <20210225164216.21124-12-noltari@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:29:28 +0100
Message-ID: <CACRpkdbnNEE_c5VHv=42rvKzYz9rMw6JpnbWqnK0mLeAy656=g@mail.gmail.com>
Subject: Re: [PATCH 11/12] Documentation: add BCM6318 pincontroller binding documentation
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 5:42 PM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:

> Add binding documentation for the pincontrol core found in BCM6318 SoCs.
>
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

> +  interrupts-extended:
> +    description:
> +      One interrupt per each of the 2 GPIO ports supported by the contro=
ller,
> +      sorted by port number ascending order.
> +    minItems: 2
> +    maxItems: 2

Same comment, hierarchical.

Yours,
Linus Walleij
