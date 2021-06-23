Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3633B23AB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 00:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFWWtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 18:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFWWtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 18:49:16 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4859DC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 15:46:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g12so3431527qtb.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=baLWTJJOD9KKn4tbADk0l8SSVLIOO1E6adwsQz9cQtk=;
        b=2P0QI+RvSARusDodtiS4LFDZvpm98ftfqZzlAvFmDeDEsWTR/41vPw2g5Li9BurLDS
         KwtT+bk42gIoYWMCp6i2fLUoA7jI5XzJ0AGqnE/GtiO6/pXG+cxm0cCSXaa2xqH5sJkW
         AzeSidNkqXfR4TdG0IL0yPw3nX/RyN7EjBZxCifIUKVJTFQeE+3tPkq9BBau39uHPrqp
         tNQ93P1uB0t6SJjoMcFYIZxxTtZlmEJzXl2NUlZDA5nO0XiAwULd5DuKO2SXdOqWYk1v
         rADERDLB7AWdggMHeLv6rediDUNjHjVoNQ13YpBJLtVJrYHiRIinfWB+4U0Zk2YhB4WO
         cGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=baLWTJJOD9KKn4tbADk0l8SSVLIOO1E6adwsQz9cQtk=;
        b=W3yOEoVkF+5zReDdifvBZrkQUmi4YDTbVxC+bSPeBoVRfAozj2bM+63rxAjVR3J2zo
         ARQeGjOyf+3SvVg1zTh1tYsLtiAZO+yoTbNsMK4WOwmA8mi0jsDbYjz7836Oc4ZVec1a
         pPb2IVqxjiX9NGcFUA1ts9elBsesMtuWl07dvN2llEjZfEnC7eYF2wJPiUFqIVFAxNqU
         GCRoeL2fnYYXzENe1Bf1LXcYskZuc7u1ipeoPaNq2yGZ9ZQw9ooUmeaInPMmIdQ6G2ZI
         hubMrmxAIUvTPYxRO/jAs1wr0ZlJ0wKFG6JkQ6DlDtSm8hPqu9ktsgFEE8LYtsvGewGp
         lhjg==
X-Gm-Message-State: AOAM532H6OnzOzjFb9WNx0XbDZ1o73QSWZyEBkdJGUONYio4AQ63Xshz
        eiTK26kUa5RqTVfHLpvdp+r4mYn8F9KUebqqAiUuOxF834xJCQ==
X-Google-Smtp-Source: ABdhPJyDaVuIlMDJXtFMt64IfujIqi5BMZ+bhCdX3D/i+ZNuIXsAQQjFbyaLX2q5i1c7no1NEFTYdQt0F/BZmf/DLJc=
X-Received: by 2002:ac8:57d2:: with SMTP id w18mr2192305qta.306.1624488417307;
 Wed, 23 Jun 2021 15:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210624082911.5d013e8c@canb.auug.org.au>
In-Reply-To: <20210624082911.5d013e8c@canb.auug.org.au>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 24 Jun 2021 00:46:48 +0200
Message-ID: <CAPv3WKfiL+sR+iK_BjGKDhtNgjoxKEPv49bU1X9_7+v+ytdR1w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

czw., 24 cze 2021 o 00:29 Stephen Rothwell <sfr@canb.auug.org.au> napisa=C5=
=82(a):
>
> Hi all,
>
> Today's linux-next build (x86_64 modules_install) failed like this:
>
> depmod: ../tools/depmod.c:1792: depmod_report_cycles_from_root: Assertion=
 `is < stack_size' failed.
>
> Caused by commit
>
> 62a6ef6a996f ("net: mdiobus: Introduce fwnode_mdbiobus_register()")
>
> (I bisected to there and tested the commit before.)
>
> The actual build is an x86_64 allmodconfig, followed by a
> modules_install.  This happens in my cross build environment as well as
> a native build.
>
> $ gcc --version
> gcc (Debian 10.2.1-6) 10.2.1 20210110
> $ ld --version
> GNU ld (GNU Binutils for Debian) 2.35.2
> $ /sbin/depmod --version
> kmod version 28
> -ZSTD +XZ -ZLIB +LIBCRYPTO -EXPERIMENTAL
>
> I have no idea why that commit should caused this failure.

Thank you for letting us know. Not sure if related, but I just found
out that this code won't compile for the !CONFIG_FWNODE_MDIO. Below
one-liner fixes it:

--- a/include/linux/fwnode_mdio.h
+++ b/include/linux/fwnode_mdio.h
@@ -40,7 +40,7 @@ static inline int fwnode_mdiobus_register(struct mii_bus =
*bus,
         * This way, we don't have to keep compat bits around in drivers.
         */

-       return mdiobus_register(mdio);
+       return mdiobus_register(bus);
 }
 #endif

I'm curious if this is the case. Tomorrow I'll resubmit with above, so
I'd appreciate recheck.

Thanks,
Marcin
