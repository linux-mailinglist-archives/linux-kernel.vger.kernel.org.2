Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED34F32A389
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382216AbhCBJHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbhCBIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:51:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E132C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:42:36 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id jt13so33711077ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 00:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqj83OHH0uy6jXnn/6KBeppUvOHSpH1VsMfJDu/RtSk=;
        b=vFLsMKKiZvzx63grS8/bVXFdMNv4fOLL4c6hkZiljW/H7KUmXzXu0TblXaRgN7HH0X
         sRs278w+B9Rb9CUADc+tXJmc99YoEPc0ZR9rfxIxgMyQNt4y3G7x2aD67k/sNXjEZfhW
         SGFg3mWcj6hrBADdf8mpl54LZxCOv3zNiWvHoXdhJh1EMjvyFGpE8PaOby5gGpPuOYgE
         mZSyst99gu5zwfj7CGCF8sYoSrc6pocYzwx6R9208KKecfp4+/5tacG3ZkRyrpqFiHJa
         U2pRkeernB6y465khfgeXxt6r4PwcofdmInvJF4RE5YbGQXDsWNqbO0oSzM+SD+6Pa3p
         Se8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqj83OHH0uy6jXnn/6KBeppUvOHSpH1VsMfJDu/RtSk=;
        b=B9wKf7SoFKDDHo3mkAY7RXN33/BeRMNxuv8pLsRmJjgzM0tG7tyeg9Y7jHsXWx0uZ3
         jLK5kCm0VWAmrdH6LgtfOqcFXK5+N3CEMjWwUr0xjgjEzqnW59oOHISkSNNuPsSqHW7L
         wiSDZA/+6FJcVAjmAsp7i1ZdQfniRvSbVuM1X2LFcJF/17nGUFEASTYscPE632KoRhLw
         de4rIfSL9m2wq+ay6ZfiW5MN2wZ3GXBAB84fPyfwgPf8FIHlmgYw2gbat+Y9GZB1WPNH
         jk7aBux0/bVh2DEGiV/OnBtC7ge7a29zd0WfdMkXOsrREO83XatFEfdtCp8+QxH0hjNB
         jy2A==
X-Gm-Message-State: AOAM531TPXqKxY3JHmdyc6yrW8KeQySLlMJ0NQRXrVLOJasujjjy7JeR
        Mextm5vGbWXPI852JfC14kf7y15a55OVOKyb2Ay2iQ==
X-Google-Smtp-Source: ABdhPJzGPey4/zJAweoL7NIyiBWG5j+JHefetxzo+d4UB+dkYOkVHlCSa1ueXoWOLvYaTHqorLcuIeAd2yR+S+Tvt6o=
X-Received: by 2002:a17:906:ac6:: with SMTP id z6mr19121663ejf.505.1614674555172;
 Tue, 02 Mar 2021 00:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20210216113118.17484-1-kostap@marvell.com>
In-Reply-To: <20210216113118.17484-1-kostap@marvell.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 09:42:24 +0100
Message-ID: <CACRpkdb+ampUXg1qN6iH8aTagqvfJwosHD6c2WGLA3p_JCXa-g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix Marvell CP110 pin control finction names
To:     Kostya Porotchkin <kostap@marvell.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "(Exiting) Amit Kucheria" <amit.kucheria@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>, bpeled@marvell.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:31 PM <kostap@marvell.com> wrote:

> From: Konstantin Porotchkin <kostap@marvell.com>
>
> These patches are fixing the CP110 pin control driver and the related
> documentation.
> Current CP110 pin control driver uses two different MPP functions named
> the same (sdio) in MPP54 and MPP55 definitions.
> Since these names are used for the MPP functionality selection, all
> function names within single MPP group should be unique.
> This patches series fixes function names in MPP54 and MPP55 pin
> definitions.

Excellent fix, patches applied!

Yours,
Linus Walleij
