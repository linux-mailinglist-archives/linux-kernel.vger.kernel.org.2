Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BE731DCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhBQPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhBQPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:45:50 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8801FC061574;
        Wed, 17 Feb 2021 07:45:10 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f14so22978520ejc.8;
        Wed, 17 Feb 2021 07:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JTQlVM4uXKEOAQPyXsr5kAcKMvA9e+zle4Kor02Y7h8=;
        b=Nuhy6hYzuAiQOnomYxdGYbrbWlYoW7/P4jQuK4BPBxQltQmj+9tGWXP1HuQuZlWXsV
         OvHLRdqqxon9FrSZbzvH7hS4tcFcc7XJKljDZzzH8BDyTKHun0erMJNpgcQi0FoK1mCF
         iW9/pedtnZGZ9lcuNNPXujGH1zHALMMLGyK4mD5JfqauTkiJV8p7RNhpqE/etvZUjY3W
         EERl1dqkRxr6CAXjUGo2KW3HZU1uT2880VhWHafyU1+ldqZngPwBcdvJwScyfyBP33nF
         MU65LgPtSd/UL0hbxAhrf+RlfAGfLQc5sfHiaxNujrB55+m2AEVfgCu9ohhxxE+6ZKmZ
         4JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JTQlVM4uXKEOAQPyXsr5kAcKMvA9e+zle4Kor02Y7h8=;
        b=qR2hjeZF+H5G5yUf9+LV/Twn4g2Sw55SQY8Gwa9mx6wKDoFICdkv67zE1nIg6hdLpY
         kOWy6MR+pvBZix5tNWeRnEEKfKJ+PhQYQrh80hkIwE2mIeeYNvttlW7Q20Y6zWXTFPbT
         MRs8WsBs4pQulKDtFlmpoBDsv9msDVAgJmk3qsar6st+o9VRMeEvJaw68+Ultj9uM0X7
         /HJn1B3ZvPM53B/OQBrbY7R9BQDXQ8ZSm2THkoXulQ6PEcllj6U++7I+es0FFXgU2kXw
         sgwRxx3BSesZYoTto4ym5/lyZ2kloyTyP1dcQ+Py/i5isw8e5aPni5qVqXy7a3F+XLiw
         rRWA==
X-Gm-Message-State: AOAM532+VvpLPYXQNu97psK/G5khjohM321R3QaKDBEOkDZLYUBh7pc4
        wVGu2jyLnCB285H6Rlgkt9Xt0zPLkgziq46Bx3EUFpJ3uv2S
X-Google-Smtp-Source: ABdhPJzdbvNfFEEPXUuuzV3Lxev7vgQL/8WBf/2UmefHgSzXMCW4dYDmV3jL0VZUhrSw879Q+fEQz1DG4EcceMUsknM=
X-Received: by 2002:a17:906:a948:: with SMTP id hh8mr26554611ejb.226.1613576709212;
 Wed, 17 Feb 2021 07:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20210217153038.1068170-1-rsalvaterra@gmail.com> <20210217164232.25a7765c@kernel.org>
In-Reply-To: <20210217164232.25a7765c@kernel.org>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 17 Feb 2021 15:44:58 +0000
Message-ID: <CALjTZvaZdvMU-gjF=h88A_yS-fiVVdHGL_iyYc30z0Qm82yjLA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: turris-omnia: fix hardware buffer management
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marek,

On Wed, 17 Feb 2021 at 15:42, Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>
> /o\ How did I manage to miss this?

Heh=E2=80=A6 it happens. :)

> Please wait a few minutes I am just going to do a fast compile and test.

No worries. I'm going to cook a backport for OpenWrt.

Cheers,
Rui
