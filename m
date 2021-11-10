Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15C444BCE4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhKJIdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhKJIdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:33:21 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3871C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:30:33 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id q124so3909362oig.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91gyfFyABZI22tOTUfX9cbK3XuReiLppo1ZP/0NVCe4=;
        b=AiPykoticmp0EuEr5zKNoopSVK9qqXzXTSWzYZdwl3tFL9GC2FnE3JAWAc2qN4tbP2
         wVkiqdBntuz3YBusAagAkek3K4H+hj8FlwsdRRTwzm780LDP7yaR+YEiQLzCO+wT9rE/
         qWwmDICiOeejWPXaQronfOVPMUEB3vuRm0OgpPZnD0Mn5Sv6mzATExKx8Gp3mPDF0ETq
         Rz2OBnNVdnL+/1pphrKf42yQmTJwGW751zjSc8wS18b/na0QAeT69IxCnsvbSo5Jc4+X
         21/8jO3w3nZ4vV2q5y9CVWKN122iMlsgOOYqm48C545jgdOn47vnuMoaj6hBS095ny1R
         Tveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91gyfFyABZI22tOTUfX9cbK3XuReiLppo1ZP/0NVCe4=;
        b=nTo4epqxaV+TzlLZBFSZbVepPzeBIy/pojMaUgtEOJvmRDQwaGTL9/rbC5e7A9a6zu
         1LEgoMMM42hH2pJnbnoAeG5LNaSM8mrc9DAEplRrLkUvGMafKGRhRlNcsVWl60AxUnxg
         UGh3HCQTDmUBbiuaGBKXhGhil0UVaCM+efElI4lmBe2j6CTTSmN2Q86h/hVJSuHbeX73
         WXooLXqKZPfwrXv516zB2mj7j5WVqxuqRfJygJu+6x7oRWM4V1zl8Ta6uCcif3WVyeZn
         VgzQ6NzaEmWXcA7ZttjQ3itIU7m8yJRQDNXTnH2x1f7JCI6LIHfMIaxyrI5OozUeTM1S
         5DeQ==
X-Gm-Message-State: AOAM531fydPWM3ymnX3rjHWl57CzJYII+4yoXysvm1VyKAwHr1hTeak/
        FsHAb3E440ByuFdqDeRuZH0lsFsrwVnzd850p1a5/g==
X-Google-Smtp-Source: ABdhPJxppPbkrGWBzZH57Qj0pH34cjt4aFBcKoWiX/olbU6p73nexapPecR6oMOnoZiLtRZx9k3V1T5GASbOTJZUn40=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr11721868oih.162.1636533033394;
 Wed, 10 Nov 2021 00:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20211102220203.940290-1-corbet@lwn.net> <20211102220203.940290-8-corbet@lwn.net>
In-Reply-To: <20211102220203.940290-8-corbet@lwn.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Nov 2021 09:30:22 +0100
Message-ID: <CACRpkdYsm1mr+aoMEzqmCw158izLHt++Rg0u0Ew7VOXaLwdfpw@mail.gmail.com>
Subject: Re: [PATCH 7/9] ARM: ixp4xx: remove unused header file pata_ixp4xx_cf.h
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 11:02 PM Jonathan Corbet <corbet@lwn.net> wrote:

> Commit b00ced38e317 ("ARM: ixp4xx: Delete Avila boardfiles") removed the
> last use of <linux/platform_data/pata_ixp4xx_cf.h> but left the header file
> in place.  Nothing uses this file, delete it now.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Patch applied to my IXP4xx tree!

Yours,
Linus Walleij
