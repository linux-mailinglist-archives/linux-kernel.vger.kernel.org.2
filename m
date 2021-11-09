Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC4144A5EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 05:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbhKIEzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 23:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242873AbhKIEzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 23:55:10 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67209C061766
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 20:52:25 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id m6so5687702oim.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 20:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIi/8rMsntaI+OsdfCjYQbsx+2Ak2wriMzRfxygR1FA=;
        b=YQj7Lj4xuXVPjaiPI91CCtrxG/QPQj2KuOiKL+6EOLjbFP+68Vxjn6VP2zgEb2WPng
         gttNnAewxd5Q/UnXavsCgAkGKGIEbb33rE4NhkJJwqkxwFRhuPZCRsRcTBkyg1ci6l+p
         44XDT98JjjfF2Fxepkrnx37rkhjKXElHvjzb/Gqhkszf6RfXX4y/0ob89EC2VrnNdSc/
         1nm23L7eBmUcFVVMMs/v7wWh4CWub/fbwqoWPo2N+7amnOteVZmuDAnDE9qWXU/pgWKI
         vyF86ekPDv40KLWl074BU5pae8QhuZ+dmVAIJewsWnmy1sT0cZ0QQfCqG1tw9GMURM91
         aDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIi/8rMsntaI+OsdfCjYQbsx+2Ak2wriMzRfxygR1FA=;
        b=qeBTitX1/vR+YojYGlTqdWIjLh018o6G3Z8tRltA2rArtqyxpTfaIaFAS8ZCLhkNKC
         8TlkhOn4VtvT7Kd/CW4NcapfNSOa9YwMtspIMt1WotTyJlt9+Q9hRvCKs9NerJItvLwh
         wBmpCNJ61ToijWkcFViB5IEG0vA76efI/ojaSyf5N4KmF0SIiqYZYknR4s38nq9n2P2j
         LaPgWtaykGDvmsloKYuXutgVj2rIOugcdq9Yn99XvrF4x48Qiwxc3uNQWtmWmex05ZU8
         AGIdwi23pdJWrb4ObIxUTvRbU/JvJ5E0mjqOFx5zKlMLB8sZAC5U5h6wUJBZckQjywGi
         v6QA==
X-Gm-Message-State: AOAM5321gTzs/9ydFkmKhxnhs5TNomyucQUXvhrd7BL32Ngj8f79ZLaA
        WwcLZwi20PnQHpXmeptoYsWNz7YZPMVmp9y3zxgsSw==
X-Google-Smtp-Source: ABdhPJw/PXJeyQlLBQdKl4Na77Zir0MpynV5/VfDEG0JbF81ciPHPaSAILPbfcUgMwRqhqiiszKinPesveK3xnr+A3A=
X-Received: by 2002:aca:120f:: with SMTP id 15mr3151848ois.132.1636433544821;
 Mon, 08 Nov 2021 20:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20211028141938.3530-1-lukas.bulwahn@gmail.com> <20211028141938.3530-14-lukas.bulwahn@gmail.com>
In-Reply-To: <20211028141938.3530-14-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 05:52:13 +0100
Message-ID: <CACRpkdYm2Da3W63T4KTnFzESNBrgvZGZsVZYqFN_16NGfpWm2w@mail.gmail.com>
Subject: Re: [PATCH 13/13] arm: pgtable: refer to intended CONFIG_ARM_LPAE in comment
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 4:20 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 5615f69bc209 ("ARM: 9016/2: Initialize the mapping of KASan shadow
> memory") adds some nested ifdef's in ./arch/arm/mm/pgd.c, and follows the
> good practice to annotate the endif's with a comment to indicate the
> corresponding ifdef condition.
>
> One comment annotation refers to CONFIG_LPAE, whereas the config is
> actually called CONFIG_ARM_LPAE. That imprecision in a comment is probably
> tolerable for all human readers.
>
> However, the script ./scripts/checkkconfigsymbols.py, which checks the
> kernel tree for references to non-existing Kconfig symbols, identifies and
> reports that the reference to CONFIG_LPAE is invalid.
>
> The script ./scripts/checkkconfigsymbols.py has been quite useful to
> identify a number of bugs with Kconfig symbols and deserves to be executed
> and checked regularly.
>
> So, repair the comment to reduce the reports from this script and simplify
> to use this script, as new issues are easier to spot when the list of
> reports is shorter.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this patch into Russell's patch tracker!

Yours,
Linus Walleij
