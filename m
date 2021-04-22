Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D5036893F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbhDVXJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 19:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhDVXJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 19:09:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF11C061574
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 16:09:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h20so24320066plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 16:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=I+ChA608q5PY2OZr5MkEs6pE5PCTHTer03gvn9b4wsk=;
        b=lftAUNTqFM1CixvAqF0/mXn2BtvZ8zs8b4UbV/ZoVc3MpnfmVQ1rzz78UrBE4iPPlk
         MkjlcDHV/7+vkzhw9DgvNrU6eh2/LJLyDJUecSH+gqXBStdHjzcoaucuOXj7rtG6v0Yi
         XQS2CU5y7uM5PKFFK8xaEjHvowH4P3oDz3DZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=I+ChA608q5PY2OZr5MkEs6pE5PCTHTer03gvn9b4wsk=;
        b=FgqDXfs3XpGcTRP2MHFi2pVDJV/67lx+IixMW3LSp3mDHlbDZdjfPLkKno+raHBNy8
         /5MKQFvitp6nERkSPrKZNyTkg5qWl09Mkxrz6jmTI78c8CS4/ZOLFgnxk8D2DNo81vwk
         qRZIdWQGXFEfLg/Vur63QA6h6LQpfTLx6p4W0pesIDpluXJkwx4rWiEQtENSTEEkK/se
         vUhYEZ/T9H1zvY7Ry10U+wG1Kz5PhkAGyqG6/kcdhW3QoIVJIy1JDIlq6DO0Au8hEjdI
         BJYoJ9PfycmFxJ5E9oHvFlAIBaZxkED1MWPJePE3Xg04PBHqDsIa0BxMKs9L/Pgl0mbE
         IC4w==
X-Gm-Message-State: AOAM533szUv+AoKGBazP2fjdu8QTWUVqAZpYMYd2UoClSt8Nqkb6AUG1
        D3gPeHzDIvr3U2jkQGrzCpJSQA==
X-Google-Smtp-Source: ABdhPJwCBaie9yuLL90yVwDtCXeYnxlBEOFwUMRH3KjeOBuPd80mSfqouLqOvdcMa/F/prJJgFlElw==
X-Received: by 2002:a17:902:e546:b029:ec:a7f5:2a88 with SMTP id n6-20020a170902e546b02900eca7f52a88mr1170687plf.21.1619132955742;
        Thu, 22 Apr 2021 16:09:15 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-587a-8af2-ee3d-5684.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:587a:8af2:ee3d:5684])
        by smtp.gmail.com with ESMTPSA id h24sm5755525pjv.50.2021.04.22.16.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 16:09:15 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/powernv/pci: remove dead code from !CONFIG_EEH
In-Reply-To: <20210422195405.4053917-1-ndesaulniers@google.com>
References: <20210422195405.4053917-1-ndesaulniers@google.com>
Date:   Fri, 23 Apr 2021 09:09:12 +1000
Message-ID: <87lf99zzl3.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

> While looking at -Wundef warnings, the #if CONFIG_EEH stood out as a
> possible candidate to convert to #ifdef CONFIG_EEH, but it seems that
> based on Kconfig dependencies it's not possible to build this file
> without CONFIG_EEH enabled.

This seemed odd to me, but I think you're right:

arch/powerpc/platforms/Kconfig contains:

config EEH
	bool
	depends on (PPC_POWERNV || PPC_PSERIES) && PCI
	default y

It's not configurable from e.g. make menuconfig because there's no prompt.
You can attempt to explicitly disable it with e.g. `scripts/config -d EEH`
but then something like `make oldconfig` will silently re-enable it for
you.

It's been forced on since commit e49f7a9997c6 ("powerpc/pseries: Rivet
CONFIG_EEH for pSeries platform") in 2012 which fixed it for
pseries. That moved out from pseries to pseries + powernv later on.

There are other cleanups in the same vein that could be made, from the
Makefile (which has files only built with CONFIG_EEH) through to other
source files. It looks like there's one `#ifdef CONFIG_EEH` in
arch/powerpc/platforms/powernv/pci-ioda.c that could be pulled out, for
example.

I think it's probably worth trying to rip out all of those in one patch?

Kind regards,
Daniel
