Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99463DBA8D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbhG3O0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhG3O02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:26:28 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C20C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:26:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h9so12615993ljq.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oGSD96sNs3fe87T1syyoEjF/gXarcKaHn7imJsZ/wE=;
        b=B9ydlXTx9KHjIbQb/934UeJRtQlmjkfbDf4yiVi1GKeyPlWGSR1DeJEsbK6TcpIRWD
         HKTulJjdYnAeOKo4giQBx4ccFpzmqYVKeIWClW99gfsw9fHmX5nGrD4LnRe2yEVgnKgi
         GqPezmzlgv1ZVCDLB0+dPZRecoNc0/HFiRYR/DnrMWrQV93KCCBvx+zydMb91b8OSyvY
         0/IiM8Noz8DYh5xZpnOQHp+rii0YKIAbsXkFOfkDMfv0qSNkIIkp6qlw+9dLduM7L6Dg
         AN9dUJeC8JyfWd1bThscIeaOVPIlNpaD0KZKAPIIyhVpreGPDy/noXgcT/ESkx+ZjEjj
         D97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oGSD96sNs3fe87T1syyoEjF/gXarcKaHn7imJsZ/wE=;
        b=A3fSzRAD42EzpccruhVaWUU1Vcc5/oSxtU1GrQ04+UQF7VX0bMoAPobEXH3qfsB2Vp
         spQrNZvkBwkKdfjB7BO/QrzA6xo4yqIHe0SctwY21qfPQhEf2whHzBpwoqF0eseZiQYq
         8nmq7S4dRnWcko8k2XoqwQTB9NDTxL3OBGdRKwXQKCzqCfmP/0zgi7+1NDozkCr/Os1q
         V5skkatxZOtOvn8TIvUo/b9xxEZrHBEJQ/7qFW81+tc/6pRqFUvAF3sVztzecdpzsUy2
         HJjOCoGN4AJrYMwNpfrXMZc4oJPzzRtC8DKF6firlCXXKLFatHc8iEeiIOtD8yQjyDp3
         ukBw==
X-Gm-Message-State: AOAM533AqiuMpoGf9/P1xa421NpcJNLoSku/nFn8hLj4zRoO1NLzgB8C
        0UVj15unlIPJfgkHZX3OCVmEYyqmXWnu6fIysJNQ+Q==
X-Google-Smtp-Source: ABdhPJyXkDVghehLAHsT/bHp3R4sMxvHWJVGvcrXAo37QXvpkXPTqUtapaXCnDfhYmgE66Lq9qmwg0xmfjUAVpkwhew=
X-Received: by 2002:a2e:b04e:: with SMTP id d14mr1942283ljl.74.1627655182215;
 Fri, 30 Jul 2021 07:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210730134552.853350-1-bert@biot.com>
In-Reply-To: <20210730134552.853350-1-bert@biot.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 16:26:11 +0200
Message-ID: <CACRpkdbU_=GcX2Xem0QfK8bY9RGiyPCBhbxWEubxqtyN1W-xDQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add support for EcoNet EN7523 SoC
To:     Bert Vermeulen <bert@biot.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 3:48 PM Bert Vermeulen <bert@biot.com> wrote:

> This patchset adds support for the EcoNet EN7523 SoC, intended primarily
> for xPON/xDSL routers.
>
> John Crispin (4):
>   dt-bindings: Add vendor prefix for EcoNet
>   dt-bindings: arm: econet: Add binding for EN7523 SoC and EVB
>   ARM: dts: Add basic support for EcoNet EN7523
>   ARM: Add basic support for EcoNet EN7523 SoC

Given that this uses GIC v3 and so forth I recognize that this is brand new
ARM32 silicon. :O

All patches look good. Very interesting platform!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
