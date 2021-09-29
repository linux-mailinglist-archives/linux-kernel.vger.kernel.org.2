Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F149B41CC57
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346441AbhI2TKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346427AbhI2TKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:10:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A182C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:08:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y26so14972704lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VBYU8n7CLuL5ISZ7YVzVYftRMAh3jmE6h48MQAUZtSs=;
        b=dR94fBH+OLb1qKX+5HSy+etBw1vnPp1wSd0WJbc5T5gU6kPP6X+g5Nyh/r0fX++Jd6
         4y8q+Tue0RprXaCXMnQ2uv8ptG1DAcmXf/gWw5aBqqos0V2EAoX84o6PXn2FMzKADoA5
         Lqfb0iZQBG8lS4qByxA2M22N1yAw9Up8UyzbQeX4E8Nzl+bkyc7ekyLAsQiHbnqiscMq
         3G1ezN2Q3BIbwh2nK8WnBbt9qY7bnVsbH4EWDR6Q6wVuZauPKtfUOSbX3oLAaXf6XpAZ
         b03LrveKsiNy/HKZRCKXfonjwYz+LFbXOxXxi5BUvBvKmoUOzo3ZwCBelGcbSME5avVc
         AqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VBYU8n7CLuL5ISZ7YVzVYftRMAh3jmE6h48MQAUZtSs=;
        b=5l+5luJ7vyokir5wGgKJWWANu97eBYsf/oqp5vnWjLnsuVh62JWetEajZzae8sowW7
         tFniaObLnRj+MD177caUd95m+XPeGw606hbWV9mZZGNt8ndhWjyLyKPvlkv6sGapXUZV
         dL8PEDMG2ARwO6ObxzvKmlVnOEtwLaiCIiyzO3pMf1L7XBic4H6mE3DhxSQz/gyponqJ
         NKBRZ8Pn0hwVCksXmWrW1l8oHZzI2xFELx1HP9YXpjr2ykiJdcKhIYYyBYzkVMIb55nK
         peOV3vG5DDTICkl6coZjyWDUlIMEFTAg63ZUwV/sq/NcSA8b3Qutu76zj0fKYmV3Eh9j
         VKYg==
X-Gm-Message-State: AOAM533eAawvzHDKMoqxm2TnC4bM5Lin5DeWwKIUZPibohEVv0ZlZpo1
        5en1xDiJF7oUA1nUX3LdWPRgKACrMXAVv4LNg3N3AA==
X-Google-Smtp-Source: ABdhPJzEIuzGBUbnBRvR3xhvpFgrST4xl+MNgEA9NbIXIIbX5nfTtscUcl6Ifyt5DxQEfaSznEwV74+0uuYIc0FFgrk=
X-Received: by 2002:ac2:5d4a:: with SMTP id w10mr1330576lfd.584.1632942529419;
 Wed, 29 Sep 2021 12:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210929181645.21855-1-clabbe.montjoie@gmail.com>
In-Reply-To: <20210929181645.21855-1-clabbe.montjoie@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Sep 2021 21:08:38 +0200
Message-ID: <CACRpkdZgXW4HOTsiw30-oncfiU54Jr_nDvZL-ZznRp8Tym=TmQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: handle CONFIG_CPU_ENDIAN_BE32 in arch/arm/kernel/head.S
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 8:19 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:

> My intel-ixp42x-welltech-epbx100 no longer boot since 4.14.
> This is due to commit 463dbba4d189 ("ARM: 9104/2: Fix Keystone 2 kernel
> mapping regression")
> which forgot to handle CONFIG_CPU_ENDIAN_BE32 as possible BE config.
>
> Suggested-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>
> Fixes: 463dbba4d189 ("ARM: 9104/2: Fix Keystone 2 kernel mapping regressi=
on")
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russell's patch tracker.

Yours,
Linus Walleij
