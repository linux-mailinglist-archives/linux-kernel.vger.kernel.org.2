Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247CC32BC62
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242452AbhCCNzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 08:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582441AbhCCKVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:21:54 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835CEC0698C4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:06:14 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y12so14740964ljj.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLNnFYjqNcTjokausBuyGfdJVlNmncxriqxX7udgA8w=;
        b=DpCnjlrpowOzfuGXvNFJt3KBxiB2US6k5s4AObRRVmnX9beVPN2unj79H3bXcRNrwb
         QHTKbpZn8me2BlpqVi2tyGufWgLOKYIFnej1/japvd31GO5W+9eWkeRlzjFfEZrCPeSh
         USKnYElb56T5YWG9vS9bkvUTg4LHfa3I+txOVxNL+29hSG74B+tYNwo6hK6mTgcRrkJt
         yH3E0jZsPF49MQRb5A7qEEcJuzqqFOshV6JNFuDFb46QZb4pYy4SRJnI4V3HhCrOFskH
         xSzVdmS5HuzjlH2rm53dcklA+kYg4QEVsapEZ6Pd9y9rIbiQDYzO1LyFUEi4FFuKhGnK
         N6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLNnFYjqNcTjokausBuyGfdJVlNmncxriqxX7udgA8w=;
        b=ENZ1KAchtmiEeu2QJPeKotsfHQtGSDsvv/cBcJydv8uh/PyFnhft6akJZ6tQgydsDE
         YCGYYze+pkAQFpG7pAjQo/MBODCXIspQ9NQWTOi33BXuIg7Bxu9OMq174sW4RMn4vz2d
         Y674u92MABfjyDmnkqWZ1NomOIUMSlNmFgo/Vz0a+0FURak394wpyysmZFZSQ5oA1InN
         MZiXFUdLnATxDVFLNawGWwzdnFY65p4RsZmarxsE1tkFasglGxMSuOJZCi/kL+rSCNO0
         JrQEJsmNDJ5lVHoRcs1l5U9SipmmoJ4QwtRNfaAEgN+eGTvwL6mHhTmxUXYF2ELhx8Cd
         ORIw==
X-Gm-Message-State: AOAM53381voGVJX+3Bpgdw67YrI0ZZlpPKI/8/8XJKPd/LWVMIsZdJCE
        ADJO6eTq4n05s29O2tfPEAfeFx1zFLf61quwRBWie0RG8MYVog==
X-Google-Smtp-Source: ABdhPJy29RaKWlRe4eI3SRdB4bhTj7JlRDbwJSaE2h81AQv3qsz44ugMuspKaO/GGMsjQIGM+4cSxi7AM97OjznnWP8=
X-Received: by 2002:a2e:9cb:: with SMTP id 194mr5435203ljj.438.1614762372970;
 Wed, 03 Mar 2021 01:06:12 -0800 (PST)
MIME-Version: 1.0
References: <1614244522-64464-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1614244522-64464-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Mar 2021 10:06:01 +0100
Message-ID: <CACRpkdY8OCkbQUa6tq-invLM14hMEXVuY0OVaT0kywF5xXS6Vg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ingenic: add missing call to of_node_put()
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:15 AM Yang Li <yang.lee@linux.alibaba.com> wrote:

> In one of the error paths of the for_each_child_of_node() loop in
> ingenic_gpio_probe, add missing call to of_node_put().
>
> Fix the following coccicheck warning:
> ./drivers/pinctrl/pinctrl-ingenic.c:2485:1-23: WARNING: Function
> "for_each_child_of_node" should have of_node_put() before return around
> line 2489.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Patch applied!

Yours,
Linus Walleij
